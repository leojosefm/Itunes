#!/usr/bin/python
# Parses itunes library xml file and load data to csv files and Oracle RDBMS table
import pandas as pd
import csv, re, os, logging,sys
from sys import argv
import xml.etree.ElementTree as ET ## XML parsing
import time
import codecs
import cx_Oracle as cx ## connecting to oracle database
import hashlib   ## for checking file hash value
import dateutil.parser ## for pariseing date
start_time=time.time()

########################
######## Log information ##########
def md5(fname):
    hash_md5 = hashlib.md5()
    with open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

cwd = os.getcwd()
timestr=time.strftime("%Y%m%d%H%M%S")
logfile=cwd+'\logs\\'+timestr+'_itunes'
logging.basicConfig(filename=logfile+'.log',format='%(levelname)s ; %(asctime)s ; %(message)s',level=20) ### Log file
logging.info('Process started')
#####################################

######### Step 1: Argument passing, Getting the root element of the xml############
#script,lib=argv
schema = 'itunes'
password = 'itunes'
### Moving itunes library from source path to working directory############
source_path = 'C:\\Users\\Leo\\Music\\iTunes' ## This is the path where Itunes library file will be present
copying = "copy "+source_path+"\\"+"\"iTunes Music Library.xml\""+" "+cwd+"\\"+"Library.xml" 
os.system(copying)   
lib='Library.xml'
tree = ET.parse(lib)
root = tree.getroot()
file_name_pc='itunes_podcast_library.csv'
file_name_ad='itunes_audio_library.csv'
file_name_vd='itunes_video_library.csv'
file_name_pd='itunes_purchased_library.csv'
file_name_rt='itunes_ringtones_library.csv'
file_name_as='itunes_apple_music_library.csv'
### Library export date##############
main_dict=root.findall('dict')
for item in main_dict[0].getchildren():
    if item.tag=="date":
        export_date_ts = item.text
        export_date = dateutil.parser.parse(export_date_ts)

#### exit the current process and do the workaround for pending files############
##### Step 1 : Connect to Oracle Database#########
conn_str='{0}/{1}@DESKTOP-T9TNRHD:1530/XE'.format(schema,password)
conn= cx.connect(conn_str)
cur=conn.cursor()
############################################
sql_pending= "Select count(*) from batch_mylib where status!='SUCCESS'"
cur.execute(sql_pending)
cnt_pending=cur.fetchone()
if cnt_pending[0] >0:
    logging.critical(' Exiting the process as there are previous files failed to process ; Please check table itunes.batch_mylib')
    conn.commit()
    exit()

######################################################
### Checking hash value of input file ##############  
hash_md5=hashlib.md5()
hash_md5.update(lib.encode('utf-8'))
filehash=hash_md5.hexdigest()
filehash=md5(lib)
logging.info('hash value of input file: '+ filehash)    
logging.info('Checking if file with same hash value processed previously')
cur.execute("select count(*) as cnt from batch_mylib where file_hash='{0}'".format(filehash))
cksum=cur.fetchone()[0]
if cksum > 0:
    logging.warning('file with file hash : '+filehash+' export date : '+str(export_date)+' already processed')
    conn.commit()
    exit()
conn.commit()  

############## End of Step 1##############################
##### Step 2 : List of all elements##########################

#print(main_dict)  #[<Element 'dict' at 0x041EC1B0>]
#### Generator function to get all the tags to the list######
def find_keys(main_dict):
    for item in main_dict:
        if item.tag=="array":
            break
        yield item
        for child in find_keys(item):
            yield child       
###############################################################
#####Calling Generator function to create a list of all tags###
#### Find checksum ###############################
def md5(fname):
    hash_md5 = hashlib.md5()
    with open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()
###################################################            
            
tag_list=list(find_keys(main_dict))
#############################################################
########End of Step 2##########################################
#print (tag_list[0:10])
#### Step 3 : Find list of types of files in the library#######
kind_list=[]
genre_list=[]
for i in range(len(tag_list)):
    if tag_list[i].text=="Kind":
        kind_list.append(tag_list[i+1].text)
    elif tag_list[i].text=="Genre":
        genre_list.append(tag_list[i+1].text)
kind_list=sorted(set(kind_list))
genre_list=sorted(set(genre_list))
###############End of Step 3################################
 
### Step 4: Calculate total track count##################
for item in main_dict[0].getchildren():
    if item.tag=="dict":
        tracks_dict=item
        break

tracklist=list(tracks_dict.findall('dict'))
track_count=len(tracklist)
#################End of Step 4#######################

####################### Step 5: Calculate no of tracks in differen kinds######
podcast=[]
purchased=[]
audio=[]
video=[]
ringtone=[]
apple=[]
for item in tracklist:
    x=item.getchildren()
    for i in range(len(x)):
        if x[i].text=="Genre" and x[i+1].text=="Podcast":    #
            podcast.append(item.getchildren())
        if x[i].text=="Kind" and x[i+1].text=="Purchased AAC audio file":
            purchased.append(item.getchildren())
        if x[i].text=="Kind" and (x[i+1].text=="MPEG audio file" or x[i+1].text=="MPEG audio stream"):
            audio.append(item.getchildren())
        if x[i].text=="Kind" and x[i+1].text=="MPEG-4 video file":
            video.append(item.getchildren())
        if x[i].text=="Kind" and x[i+1].text=="Ringtone":
            ringtone.append(item.getchildren())
        if x[i].text=="Kind" and x[i+1].text=="Apple Music AAC audio file":
            apple.append(item.getchildren())   
            

#### Delete podcasts from audio  & video list as podcast will be present in both podcast &audio list###########
audio = [row for row in audio if not any(item.text == "Podcast" for item in row)]
video = [row for row in video if not any(item.text == "Podcast" for item in row)]
##################################################################################################
##########################End of Step 5#############################################
#### Function to return the column list of all kinds#################
def cols(kind):
    cols=[]
    for i in range(len(kind)):
        for j in range(len(kind[i])):
            if kind[i][j].tag=="key":
                cols.append(kind[i][j].text)
    return set(cols)
#######################################################################
############# Function to create the dataFrame########################
def df_creation(kind,cols):
    df=pd.DataFrame(columns=cols)
    dict1={}
    for i in range(len(kind)):
        for j in range(len(kind[i])):
            if kind[i][j].tag=="key":
                dict1[kind[i][j].text]=kind[i][j+1].text
        list_values=[i for i in dict1.values()]
        list_keys=[j for j in dict1.keys()]
        df_temp=pd.DataFrame([list_values],columns=list_keys)
        df=pd.concat([df,df_temp],axis=0,ignore_index=True)
    return df

def writetoOracle(data,table_name,engine):
    data.to_sql(name=table_name,con=engine ,if_exists = 'append', index=False)
    
#####  Calling functions col and dataframe createion#####################
podcast_cols=cols(podcast)
purchased_cols=cols(purchased)
audio_cols=cols(audio)
video_cols=cols(video)
ringtone_cols=cols(ringtone)
apple_cols=cols(apple)
###############################################################################
#############################################################################
start_podcast_csv=time.time()
df_apple = df_creation(apple,apple_cols)
df_apple.to_csv(file_name_as, sep=',', encoding='utf-8',index=False)

df_podcast = df_creation(podcast,podcast_cols)
df_podcast.to_csv(file_name_pc, sep=',', encoding='utf-8',index=False)

df_audio = df_creation(audio,audio_cols)
df_audio.to_csv(file_name_ad, sep=',', encoding='utf-8',index=False)

df_purchased = df_creation(purchased,purchased_cols)
df_purchased.to_csv(file_name_pd, sep=',', encoding='utf-8',index=False)

df_video = df_creation(video,video_cols)
df_video.to_csv(file_name_vd, sep=',', encoding='utf-8',index=False)

df_ringtone = df_creation(ringtone,ringtone_cols)
df_ringtone.to_csv(file_name_rt, sep=',', encoding='utf-8',index=False)

logging.info('CSV File written')


columns=['track_id','song_name','play_count','skip_count','album','artist' \
         ,'genre','kind','persistent_id','year_of_release','play_date','skip_date',\
          'release_date','date_modified']
temp_apple = df_apple.loc[:,['Track ID','Name','Play Count','Skip Count','Album',\
                             'Artist','Genre','Kind','Persistent ID','Year','Play Date UTC',\
                             'Skip Date','Release Date','Date Modified']]
temp_purchased = df_purchased.loc[:,['Track ID','Name','Play Count','Skip Count', \
                                     'Album','Artist','Genre','Kind','Persistent ID','Year',\
                                     'Play Date UTC','Skip Date','Release Date','Date Modified']]

df_songs = pd.concat([temp_purchased,temp_apple],axis = 0)
df_songs.columns = columns



## Datatype conversion
df_songs[['track_id','play_count','skip_count','year_of_release']] = df_songs[['track_id',\
        'play_count','skip_count','year_of_release']].apply(pd.to_numeric)
df_songs[['play_date','skip_date','release_date','date_modified']] = df_songs[['play_date',\
        'skip_date','release_date','date_modified']].apply(pd.to_datetime)

## Replace unicodecharacteres
df_songs['song_name'] = df_songs['song_name'].str.replace(r'[^\x00-\x7F]+',' ')
df_songs['artist'] = df_songs['artist'].str.replace(r'[^\x00-\x7F]+',' ')
df_songs['album'] = df_songs['album'].str.replace(r'[^\x00-\x7F]+',' ')



## Write to Oracle
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
engine = create_engine('oracle+cx_oracle://{0}:{1}@DESKTOP-T9TNRHD:1530/xe?charset=utf8'.format(schema,password), encoding = 'utf-8', echo=False)
Session = sessionmaker(bind=engine)
connection = engine.connect()
session = Session()

record_count_df = len(df_songs)

result=session.execute('SELECT NVL(max(batch_no),0)+1 as batchno from batch_mylib')
for row in result:
    batchno = row['batchno']
result.close()

try:
    session.execute("insert into batch_mylib values({0},{1},NULL,\
                                                    'STARTED',CURRENT_TIMESTAMP,'{2}',\
                                                    to_timestamp(substr('{3}',1,instr('{3}',\
                                                    '+',1,1)-1),'yyyy-mm-dd hh24:mi:ss') )".format(batchno,record_count_df,filehash,export_date))
except:
    session.rollback()
    logging.warning('Batch table insert failed')
    raise
session.commit()

session.execute('TRUNCATE TABLE mylibrary')

writetoOracle(df_songs,'mylibrary',engine)

session.execute('update mylibrary set batch_no={0}'.format(batchno))

try:
    session.execute('insert into mylibrary_pit select t.*,current_timestamp as load_date from mylibrary t ')
except:
    session.rollback()
    logging.warning('library point in time table insert failed')
    raise
session.commit()


session.execute('call SP_ARTSITS_NORMALIZATION_1()')
session.execute('call SP_ARTSITS_NORMALIZATION_2()')

session.execute("insert into tmp_myartists \
select distinct trim(artist) from mylibrary_pit where artist not like '%&%' and artist not like '%,%' ")


session.execute("insert into tmp_myartists \
select distinct trim(artist) from tmp_myartists_1 where artist not like '%,%'")

session.execute("insert into tmp_myartists \
select distinct trim(artist) from tmp_myartists_2")

session.commit()

session.execute('merge into myartists t1 using (select distinct artist from tmp_myartists where artist is not null) t2 \
on (t1.artist = t2.artist) when not matched then insert (t1.artist) values (t2.artist)')

session.execute('merge into mygenre t1 using (select distinct genre from mylibrary_pit ) t2 \
on (t1.genre = t2.genre) when not matched then insert (t1.genre) values (t2.genre)')

session.execute('merge into myalbum t1 using (select distinct album from mylibrary_pit ) \
                t2 on (t1.album_name = t2.album)\
                when not matched then insert (t1.album_name) values( t2.album)')

session.execute('merge into mygenre_artist t1 using (select  \
distinct a.artist,a.artist_sid,g.genre,g.genre_id \
from mylibrary_pit l join myartists a on a.artist=l.artist \
join mygenre g on g.genre = l.genre ) t2 \
on (t2.genre = t1.genre and t2.artist = t1.artist) \
when matched then update set t1.genre_id = t2.genre_id, t1.artist_sid = t2.artist_sid \
when not matched then insert (t1.genre_id,t1.artist_sid,t1.genre,t1.artist) values \
(t2.genre_id,t2.artist_sid,t2.genre,t2.artist)')

result=session.execute('select count(*) as record_count from mylibrary')
for row in result:
    record_count_tgt = row['record_count']
    if record_count_df != record_count_tgt:
        logging.error('Source record count and loaded record count does not match')
        session.commit()
        session.close()
        exit()
result.close()
       
try:
    session.execute("update batch_mylib set record_count_loaded={0},status='SUCCESS' where batch_no={1}".format(record_count_tgt,batchno))
except:
    session.rollback()
    logging.warning('Batch table update failed')
    session.execute("update batch_mylib set record_count_loaded={0},status='FAILED' where batch_no={1}".format(record_count_tgt,batchno))
    raise

session.commit()
session.close()

#Archiving files
timestr=export_date.strftime("%Y%m%d%H%M%S")
renaming = "ren "+"\""+lib+"\" "+"\""+timestr+"_"+lib+"\""
archiving="move "+cwd+"\\"+timestr+"_"+lib+" "+ cwd+"/inbound/"
try:
    os.system(renaming)
    os.system(archiving)
except:
    logging.exception("Oops: Archiving failed")
    raise
exit()




