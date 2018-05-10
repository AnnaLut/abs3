-- ======================================================================================
-- Module :
-- Author : BAA
-- Date   : 12.04.2016
-- ===================================== <Comments> =====================================
-- Script for insert or update table "ADR_SETTLEMENT_TYPES"
-- ======================================================================================
SET FEEDBACK     OFF

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 1, 'місто', 'город','м.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'місто',
           SETTLEMENT_TP_NM_RU = 'город',
		   SETTLEMENT_TP_CODE='м.'
     where SETTLEMENT_TP_ID = 1;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 2, 'смт', 'пгт' ,'смт.');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'смт',
           SETTLEMENT_TP_NM_RU = 'пгт',
		   SETTLEMENT_TP_CODE='смт.'
     where SETTLEMENT_TP_ID = 2;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 3, 'селище', 'поселок' ,'сел.');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'селище',
           SETTLEMENT_TP_NM_RU = 'поселок',
		   SETTLEMENT_TP_CODE='сел.'
     where SETTLEMENT_TP_ID = 3;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 4, 'село', 'село','с.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'село',
           SETTLEMENT_TP_NM_RU = 'село',
		   SETTLEMENT_TP_CODE='с.'
     where SETTLEMENT_TP_ID = 4;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 5, 'хутір', 'хутор','хутір' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'хутір',
           SETTLEMENT_TP_NM_RU = 'хутор',
		   SETTLEMENT_TP_CODE='хутір'
     where SETTLEMENT_TP_ID = 5;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 6, 'ст.', 'ст.','ст.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'ст.',
           SETTLEMENT_TP_NM_RU = 'ст.',
		   SETTLEMENT_TP_CODE='ст.'
     where SETTLEMENT_TP_ID = 6;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 7, 'санат.', 'санат.' ,'санат.');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'санат.',
           SETTLEMENT_TP_NM_RU = 'санат.',
		   SETTLEMENT_TP_CODE='санат.'
     where SETTLEMENT_TP_ID = 7;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 8, 'радгосп', 'совхоз','радгосп' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'радгосп',
           SETTLEMENT_TP_NM_RU = 'совхоз',
		  SETTLEMENT_TP_CODE='радгосп'
     where SETTLEMENT_TP_ID = 8;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 9, 'вокзал', 'вокзал','вокзал' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'вокзал',
           SETTLEMENT_TP_NM_RU = 'вокзал',
		   SETTLEMENT_TP_CODE='вокзал'
     where SETTLEMENT_TP_ID = 9;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 10, 'лісництво', 'лесничество' ,'лісництво');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'лісництво',
           SETTLEMENT_TP_NM_RU = 'лесничество',
		   SETTLEMENT_TP_CODE='лісництво'
     where SETTLEMENT_TP_ID = 10;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 11, 'док', 'док','док' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'док',
           SETTLEMENT_TP_NM_RU = 'док',
		   SETTLEMENT_TP_CODE='док'
     where SETTLEMENT_TP_ID = 11;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 12, 'поселення', 'поселение' ,'поселення');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = 'поселення',
           SETTLEMENT_TP_NM_RU = 'поселение',
		   SETTLEMENT_TP_CODE='поселення'
     where SETTLEMENT_TP_ID = 12;
end;
/
commit;
