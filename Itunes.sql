--------------------------------------------------------
--  File created - Monday-July-09-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SEQ_MYALBUM
--------------------------------------------------------

   CREATE SEQUENCE  "ITUNES"."SEQ_MYALBUM"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1161 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_MYARTIST
--------------------------------------------------------

   CREATE SEQUENCE  "ITUNES"."SEQ_MYARTIST"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1921 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_MYGENRE
--------------------------------------------------------

   CREATE SEQUENCE  "ITUNES"."SEQ_MYGENRE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BATCH_MYLIB
--------------------------------------------------------

  CREATE TABLE "ITUNES"."BATCH_MYLIB" 
   (	"BATCH_NO" NUMBER, 
	"RECORD_SOURCE_SOURCE" NUMBER, 
	"RECORD_COUNT_LOADED" NUMBER, 
	"STATUS" VARCHAR2(7 BYTE), 
	"LOAD_DATE" TIMESTAMP (6), 
	"FILE_HASH" VARCHAR2(100 BYTE), 
	"LIBRARY_DATE" TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table BKP_MYARTISTS
--------------------------------------------------------

  CREATE TABLE "ITUNES"."BKP_MYARTISTS" 
   (	"ARTIST_SID" NUMBER, 
	"ARTIST" VARCHAR2(500 BYTE), 
	"ARTIST_ID" NUMBER, 
	"PRIMARY_GENRE" VARCHAR2(500 BYTE), 
	"URL" VARCHAR2(500 BYTE), 
	"TYPE" VARCHAR2(500 BYTE), 
	"LATEST_ALBUM" VARCHAR2(500 BYTE), 
	"RELEASE_DATE" TIMESTAMP (6), 
	"ITUNES_ALBUM_COUNT" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table MYALBUM
--------------------------------------------------------

  CREATE TABLE "ITUNES"."MYALBUM" 
   (	"ALBUM_ID" NUMBER, 
	"ALBUM_NAME" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table MYARTISTS
--------------------------------------------------------

  CREATE TABLE "ITUNES"."MYARTISTS" 
   (	"ARTIST_SID" NUMBER, 
	"ARTIST" VARCHAR2(500 BYTE), 
	"ARTIST_ID" NUMBER, 
	"PRIMARY_GENRE" VARCHAR2(500 BYTE), 
	"URL" VARCHAR2(500 BYTE), 
	"TYPE" VARCHAR2(500 BYTE), 
	"LATEST_ALBUM" VARCHAR2(500 BYTE), 
	"RELEASE_DATE" TIMESTAMP (6), 
	"ITUNES_ALBUM_COUNT" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table MYGENRE
--------------------------------------------------------

  CREATE TABLE "ITUNES"."MYGENRE" 
   (	"GENRE_ID" NUMBER, 
	"GENRE" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table MYGENRE_ARTIST
--------------------------------------------------------

  CREATE TABLE "ITUNES"."MYGENRE_ARTIST" 
   (	"GENRE_ID" NUMBER, 
	"ARTIST_SID" NUMBER, 
	"GENRE" VARCHAR2(100 BYTE), 
	"ARTIST" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table MYLIBRARY
--------------------------------------------------------

  CREATE TABLE "ITUNES"."MYLIBRARY" 
   (	"TRACK_ID" NUMBER, 
	"SONG_NAME" VARCHAR2(200 BYTE), 
	"PLAY_COUNT" NUMBER, 
	"SKIP_COUNT" NUMBER, 
	"ALBUM" VARCHAR2(200 BYTE), 
	"ARTIST" VARCHAR2(200 BYTE), 
	"GENRE" VARCHAR2(200 BYTE), 
	"KIND" VARCHAR2(500 BYTE), 
	"PERSISTENT_ID" VARCHAR2(200 BYTE), 
	"YEAR_OF_RELEASE" NUMBER, 
	"PLAY_DATE" TIMESTAMP (6), 
	"SKIP_DATE" TIMESTAMP (6), 
	"RELEASE_DATE" TIMESTAMP (6), 
	"DATE_MODIFIED" TIMESTAMP (6), 
	"BATCH_NO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table MYLIBRARY_PIT
--------------------------------------------------------

  CREATE TABLE "ITUNES"."MYLIBRARY_PIT" 
   (	"TRACK_ID" NUMBER, 
	"SONG_NAME" VARCHAR2(200 BYTE), 
	"PLAY_COUNT" NUMBER, 
	"SKIP_COUNT" NUMBER, 
	"ALBUM" VARCHAR2(200 BYTE), 
	"ARTIST" VARCHAR2(200 BYTE), 
	"GENRE" VARCHAR2(200 BYTE), 
	"KIND" VARCHAR2(500 BYTE), 
	"PERSISTENT_ID" VARCHAR2(200 BYTE), 
	"YEAR_OF_RELEASE" NUMBER, 
	"PLAY_DATE" TIMESTAMP (6), 
	"SKIP_DATE" TIMESTAMP (6), 
	"RELEASE_DATE" TIMESTAMP (6), 
	"DATE_MODIFIED" TIMESTAMP (6), 
	"BATCH_NO" NUMBER, 
	"LOAD_DATE" TIMESTAMP (6) WITH TIME ZONE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table STAGING_ARTISTS
--------------------------------------------------------

  CREATE TABLE "ITUNES"."STAGING_ARTISTS" 
   (	"ARTIST" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TMP_ARTISTS
--------------------------------------------------------

  CREATE TABLE "ITUNES"."TMP_ARTISTS" 
   (	"ARTIST" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TMP_MYARTISTS
--------------------------------------------------------

  CREATE TABLE "ITUNES"."TMP_MYARTISTS" 
   (	"ARTIST" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TMP_MYARTISTS_1
--------------------------------------------------------

  CREATE TABLE "ITUNES"."TMP_MYARTISTS_1" 
   (	"ARTIST" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TMP_MYARTISTS_2
--------------------------------------------------------

  CREATE TABLE "ITUNES"."TMP_MYARTISTS_2" 
   (	"ARTIST" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for View VIEW_DAYS_NOT_PLAYED
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ITUNES"."VIEW_DAYS_NOT_PLAYED" ("ARTIST", "SONG_NAME", "PLAY_COUNT", "GENRE", "PLAY_DATE", "DAYS_NOT_PLAYED", "RANK") AS 
  SELECT "ARTIST","SONG_NAME","PLAY_COUNT","GENRE","PLAY_DATE","DAYS_NOT_PLAYED","RANK" FROM (
SELECT ARTIST,SONG_NAME,PLAY_COUNT,GENRE,PLAY_DATE,
EXTRACT(DAY FROM (SYSDATE - PLAY_DATE)) DAYS_NOT_PLAYED,
ROW_NUMBER() OVER(ORDER BY PLAY_DATE ASC) RANK
FROM MYLIBRARY ) WHERE RANK <=25;
--------------------------------------------------------
--  DDL for View VIEW_LEAST_SKIPPED
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ITUNES"."VIEW_LEAST_SKIPPED" ("ARTIST", "SONG_NAME", "PLAY_COUNT", "SKIP_COUNT", "PLAY_DATE", "GENRE", "RANK") AS 
  SELECT "ARTIST","SONG_NAME","PLAY_COUNT","SKIP_COUNT","PLAY_DATE","GENRE","RANK" FROM (
SELECT 
ARTIST, SONG_NAME, PLAY_COUNT, SKIP_COUNT, PLAY_DATE , GENRE
,ROW_NUMBER() OVER(ORDER BY (play_COUNT - SKIP_COUNT) DESC) RANK
FROM mylibrary
) WHERE RANK <=25;
--------------------------------------------------------
--  DDL for View VIEW_MOST_RECENTLY_PLAYED
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ITUNES"."VIEW_MOST_RECENTLY_PLAYED" ("SONG_NAME", "ARTIST", "GENRE", "TOTAL_PLAY_COUNT", "RECENT_PLAY_COUNT") AS 
  SELECT SONG_NAME, artist,genre,TOTAL_PLAY_COUNT, RECENT_PLAY_COUNT FROM (
select t1.*, row_number() over(order by RECENT_PLAY_COUNT desc) rank 
from (
SELECT SONG_NAME,PLAY_COUNT AS TOTAL_PLAY_COUNT, LOAD_DATE, artist,
ROW_NUMBER() OVER (PARTITION BY SONG_NAME,album,artist ORDER BY LOAD_DATE DESC) LOAD_ORDER, genre,
first_value(PLAY_COUNT) over (partition by SONG_NAME,album,artist order by load_date asc) initial_count,
(PLAY_COUNT - first_value(PLAY_COUNT) over (partition by SONG_NAME,album,artist order by load_date asc)) RECENT_PLAY_COUNT
FROM mylibrary_pit ) t1 where load_order = 1 )
WHERE rank <=25;
--------------------------------------------------------
--  DDL for View VIEW_MOST_SKIPPED
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ITUNES"."VIEW_MOST_SKIPPED" ("ARTIST", "SONG_NAME", "PLAY_COUNT", "SKIP_COUNT", "PLAY_DATE", "GENRE", "RANK") AS 
  SELECT "ARTIST","SONG_NAME","PLAY_COUNT","SKIP_COUNT","PLAY_DATE","GENRE","RANK" FROM (
SELECT 
ARTIST, SONG_NAME, PLAY_COUNT, SKIP_COUNT, PLAY_DATE , GENRE
,ROW_NUMBER() OVER(ORDER BY (SKIP_COUNT - PLAY_COUNT) DESC) RANK
FROM mylibrary
) WHERE RANK <=25;
--------------------------------------------------------
--  DDL for View VIEW_PLAY_COUNT_DISTRIBUTION
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ITUNES"."VIEW_PLAY_COUNT_DISTRIBUTION" ("GENRE", "PLAY_COUNT", "SONG_COUNT", "AVG_PLAY_PER_SONG", "TOTAL_PLAY_COUNT") AS 
  SELECT GENRE ,PLAY_COUNT, SONG_COUNT ,AVG_PLAY_PER_SONG, total_play_count FROM (
SELECT GENRE ,PLAY_COUNT, SONG_COUNT,AVG_PLAY_PER_SONG, sum(play_count) over() total_play_count,
ROW_NUMBER() OVER(ORDER BY play_count DESC) RANK 
FROM (
select genre, sum(play_count) as play_count, count(song_name) as song_count
,ROUND(AVG(PLAY_COUNT)) AS AVG_PLAY_PER_SONG
from mylibrary
group by genre  ) )WHERE RANK <=15;
--------------------------------------------------------
--  DDL for View VIEW_TIME_BUCKET
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ITUNES"."VIEW_TIME_BUCKET" ("BUCKET_START", "BUCKET_END", "AVG_PLAYS_PER_SONG", "NO_OF_SONGS", "ERA") AS 
  SELECT 
SUBSTR(TO_CHAR(RELEASE_DATE,'YYYY-MM-DD'),1,3)||'0-01-01' AS BUCKET_START,
SUBSTR(TO_CHAR(RELEASE_DATE,'YYYY-MM-DD'),1,3)||'9-12-31' AS BUCKET_END,
ROUND(AVG(play_count)) AVG_PLAYS_PER_SONG, COUNT(1) AS NO_OF_SONGS,
SUBSTR( TO_CHAR(RELEASE_DATE,'YYYY-MM-DD'),1,3)||'0' AS ERA
FROM 
MYLIBRARY
group by SUBSTR(TO_CHAR(RELEASE_DATE,'YYYY-MM-DD'),1,3);
--------------------------------------------------------
--  DDL for View VIEW_TOP_15_ARTISTS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ITUNES"."VIEW_TOP_15_ARTISTS" ("ARTIST", "TOTAL_PLAY_COUNT", "MOST_PLAYED_SONG", "SONG_PLAY_COUNT", "GENRE", "ARTITST_SONG_COUNT", "TOTAL_SONGS_LIBRARY", "SONG_PERCENTAGE") AS 
  SELECT ARTIST,TOTAL_PLAY_COUNT ,SONG_NAME AS MOST_PLAYED_SONG, SONG_PLAY_COUNT, GENRE,
ARTITST_SONG_COUNT, TOTAL_SONGS_LIBRARY, SONG_PERCENTAGE
FROM (
SELECT T.*,ROW_NUMBER() OVER(ORDER BY TOTAL_PLAY_COUNT DESC) ARTIST_RANK FROM (
SELECT ARTIST , SONG_NAME , GENRE,PLAY_COUNT AS SONG_PLAY_COUNT,
SUM(PLAY_COUNT) OVER(PARTITION BY ARTIST) TOTAL_PLAY_COUNT,
ROW_NUMBER() OVER(PARTITION BY ARTIST ORDER BY PLAY_COUNT DESC) TOP_SONG_FLAG,
COUNT(SONG_NAME) OVER(PARTITION BY ARTIST) ARTITST_SONG_COUNT,
COUNT(*) OVER() TOTAL_SONGS_LIBRARY,
cast((COUNT(SONG_NAME) OVER(PARTITION BY ARTIST) / COUNT(*) OVER())*100 as decimal (3,2))  AS SONG_PERCENTAGE
FROM mylibrary ) T WHERE  TOP_SONG_FLAG = 1
) WHERE ARTIST_RANK <=15;
--------------------------------------------------------
--  DDL for View VIEW_TOP_25_SONGS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ITUNES"."VIEW_TOP_25_SONGS" ("ARTIST", "SONG_NAME", "PLAY_COUNT", "SKIP_COUNT", "PLAY_DATE", "GENRE", "RANK") AS 
  SELECT "ARTIST","SONG_NAME","PLAY_COUNT","SKIP_COUNT","PLAY_DATE","GENRE","RANK" FROM (
SELECT 
ARTIST, SONG_NAME, PLAY_COUNT, SKIP_COUNT, PLAY_DATE , GENRE
,ROW_NUMBER() OVER(ORDER BY PLAY_COUNT DESC) RANK
FROM mylibrary
) WHERE RANK <=25;
--------------------------------------------------------
--  DDL for Trigger TRIG_MYALBUM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ITUNES"."TRIG_MYALBUM" 
before insert on myalbum
for each row
begin
select seq_myalbum.nextval into :new.album_id from dual;
end;
/
ALTER TRIGGER "ITUNES"."TRIG_MYALBUM" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRIG_MYARTIST
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ITUNES"."TRIG_MYARTIST" 
before insert on myartists
for each row
begin
select seq_myartist.nextval into :new.artist_sid from dual;
end;
/
ALTER TRIGGER "ITUNES"."TRIG_MYARTIST" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRIG_MYGENRE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ITUNES"."TRIG_MYGENRE" 
before insert on mygenre
for each row
begin
select seq_mygenre.nextval into :new.genre_id from dual;
end;
/
ALTER TRIGGER "ITUNES"."TRIG_MYGENRE" ENABLE;
--------------------------------------------------------
--  DDL for Procedure SP_ARTSITS_NORMALIZATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ITUNES"."SP_ARTSITS_NORMALIZATION" 
IS
BEGIN
EXECUTE IMMEDIATE 'DELETE FROM tmp_myartists_1' ;
declare
cursor C1 is
SELECT trim(artist) as artist FROM mylibrary_pit;
v_artist varchar2(100);
v_art varchar2(100);
v_colon_pos integer;
begin
for r1 in C1
loop
v_artist:=r1.artist;
while  instr(v_artist,'&', 1, 1) > 0  
loop
v_colon_pos:=instr(v_artist, '&', 1, 1);
v_art:=trim(SUBSTR(v_artist, 1, v_colon_pos-1));
insert into tmp_myartists_1 values (v_art);
v_artist:=SUBSTR(v_artist, v_colon_pos+1);
end loop;
insert into tmp_myartists_1 values (v_art);
commit;
end loop;
end;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_ARTSITS_NORMALIZATION_1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ITUNES"."SP_ARTSITS_NORMALIZATION_1" 
IS
BEGIN
EXECUTE IMMEDIATE 'DELETE FROM tmp_myartists_1' ;
declare
cursor C1 is
SELECT trim(artist) as artist FROM mylibrary_pit;
v_artist varchar2(100);
v_art varchar2(100);
v_colon_pos integer;
begin
for r1 in C1
loop
v_artist:=r1.artist;
while  instr(v_artist,'&', 1, 1) > 0  
loop
v_colon_pos:=instr(v_artist, '&', 1, 1);
v_art:=trim(SUBSTR(v_artist, 1, v_colon_pos-1));
insert into tmp_myartists_1 values (v_art);
v_artist:=SUBSTR(v_artist, v_colon_pos+1);
end loop;
insert into tmp_myartists_1 values (v_art);
commit;
end loop;
end;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_ARTSITS_NORMALIZATION_2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ITUNES"."SP_ARTSITS_NORMALIZATION_2" 
IS
BEGIN
-- THIS function is to remove , from the artist name

EXECUTE IMMEDIATE 'DELETE FROM tmp_myartists';
EXECUTE IMMEDIATE 'DELETE FROM tmp_myartists_2';
 
 
declare
cursor C1 is
SELECT trim(artist) as artist FROM tmp_myartists_1;
v_artist varchar2(100);
v_art varchar2(100);
v_colon_pos integer;
begin
for r1 in C1
loop
v_artist:=r1.artist;
while  instr(v_artist,',', 1, 1) > 0  
loop
v_colon_pos:=instr(v_artist, ',', 1, 1);
v_art:=trim(SUBSTR(v_artist, 1, v_colon_pos-1));
insert into tmp_myartists_2 values (v_art);
v_artist:=SUBSTR(v_artist, v_colon_pos+1);
end loop;
insert into tmp_myartists_2 values (v_art);
commit;
end loop;



commit;
end;
END;

/
