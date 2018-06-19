##### Library imports
# Fetch data from itunes api (information about artist, albums etc) and update oracle table
import requests , json,csv , time,os,logging,re
import pandas as pd
from pandas import DataFrame
from sys import argv
import xml.etree.ElementTree as ET
from pandas.io.json import json_normalize
import cx_Oracle as cx
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import dateutil.parser ## for pariseing date


cwd = os.getcwd()
timestr = time.strftime("%Y%m%d%H%M%S")
logfile = cwd+'\logs\\'+timestr+'_itunes_api.log'

logging.basicConfig(filename=logfile+'.log',format='%(levelname)s ; %(asctime)s ; %(message)s',level=20) ### Log file
logging.info('Process started')

##### Step 1 : Connect to Oracle Database#########
user = 'itunes'
password = 'itunes'
conn_str = "{0}/{1}@DESKTOP-T9TNRHD:1530/XE".format(user,password)
conn = cx.connect(conn_str)
cur = conn.cursor()
logging.info('Connected to Oracle')
entity='music'
############################################

###############
def itunes_webservice(url):
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        dataset = json_normalize(data['results'])
        return dataset

def writetoOracle(data,table_name,engine):
    data.to_sql(name=table_name,con=engine ,if_exists = 'append', index=False)
#################

#### Fetching atrist name from myartist table to lookup itunes api to get other information####
resoverall = cur.execute("select replace(artist,' ','+') as term ,artist from myartists \
                         where artist_id is null")
df_artists = DataFrame(resoverall.fetchall())
df_artists.columns = ['term','artist']


for index, row in df_artists.iterrows():
    term = row['term']
    artist = row['artist']
    url = 'https://itunes.apple.com/search?term={0}&entity[]={1}&limit=50'.format(term,entity)
    data = itunes_webservice(url)
    try:
        if not data.empty:
            df = data
            try:
                artist_id = df[df['artistName']==artist].head(1)['artistId'].values[0].astype(int)
                artist_url = "https://itunes.apple.com/lookup?id={0}".format(artist_id)
                album_url = "https://itunes.apple.com/lookup?id={0}&entity=album".format(artist_id)
                logging.info('Calling artist lookup webservice for artist_id: '+str(artist_id)+ ' Atrist :'+artist)
                artist_data = itunes_webservice(artist_url)
                if artist_data.empty:
                    logging.warningn('Data set for artist id is empty '+str(artist_id)+ ' Atrist :'+artist)
                    continue
                artist_url = artist_data['artistLinkUrl'][0]
                primary_genre = artist_data['primaryGenreName'][0]
                wtype = artist_data['wrapperType'][0]
                logging.info('Calling album lookup webservice for artist_id: '+str(artist_id)+ ' Atrist :'+artist)
                album_data = itunes_webservice(album_url)
                if artist_data.empty:
                    logging.warningn('Data set for  artist id is empty '+str(artist_id)+ ' Atrist :'+artist)
                    continue
                album_count=len(album_data)
                try:
                    album_data['releaseDate'].apply(pd.to_datetime)
                    latest_album = album_data.sort_values(by=['releaseDate'],ascending=False).head(1)['collectionCensoredName'].values[0]
                    release_date = album_data.sort_values(by=['releaseDate'],ascending=False).head(1)['releaseDate'].values[0]
                    release_date = dateutil.parser.parse(release_date)
                    query = "update myartists set artist_id={0},url='{1}',type='{2}' \
                            ,primary_genre='{3}', release_date=to_timestamp(substr('{4}',1,instr('{4}','+',1,1)-1),'yyyy-mm-dd hh24:mi:ss')  \
                            ,latest_album={5},itunes_album_count={6} where artist={7}".format(artist_id,artist_url,wtype,primary_genre,release_date,"q\'["+re.sub(r'[^\x00-\x7F]+',' ', latest_album)+"]'",album_count,"q\'["+re.sub(r'[^\x00-\x7F]+',' ', artist)+"]'")
                    cur.execute(query)
                    conn.commit() 
                except KeyError:
                    logging.warning('Key error artist '+str(artist_id)+ ' Atrist :'+artist)
                    query="update myartists set artist_id={0},url='{1}',type='{2}' \
                            ,primary_genre='{3}' where artist={4}".format(artist_id,artist_url,wtype,primary_genre,"q\'["+re.sub(r'[^\x00-\x7F]+',' ', artist)+"]'")
                    cur.execute(query)
                    conn.commit()
        
            except IndexError:
                logging.warning('Artist : '+artist+' not found from itunes search')
                cur.execute("update myartists set artist_id=NULL where artist={0}".format("q\'["+artist+"]'"))
                conn.commit()        
        else:
            continue
    except AttributeError:
        logging.warning('No results for artist : ' + artist)
        cur.execute("update myartists set artist_id=-1 where artist={0}".format("q\'["+artist+"]'"))
        conn.commit()
        
conn.commit()          
        





  
    