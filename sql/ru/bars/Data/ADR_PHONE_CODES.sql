-- ======================================================================================
-- Module :
-- Author : BAA
-- Date   : date
-- ===================================== <Comments> =====================================
-- Script for insert or update table "ADR_PHONE_CODES"
-- ======================================================================================



begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 1, '0312', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0312',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 1;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 2, '0312', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0312',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 2;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 3, '03131', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03131',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 3;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 4, '03132', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03132',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 4;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 5, '03133', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03133',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 5;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 6, '03134', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03134',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 6;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 7, '03135', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03135',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 7;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 8, '03136', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03136',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 8;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 9, '03137', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03137',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 9;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 10, '03141', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03141',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 10;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 11, '03142', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03142',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 11;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 12, '03143', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03143',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 12;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 13, '03144', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03144',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 13;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 14, '03145', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03145',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 14;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 15, '03146', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03146',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 15;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 16, '032', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '032',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 16;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 17, '03230', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03230',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 17;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 18, '03231', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03231',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 18;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 19, '03234', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03234',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 19;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 20, '03236', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03236',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 20;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 21, '03238', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03238',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 21;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 22, '03239', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03239',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 22;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 23, '03241', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03241',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 23;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 24, '03244', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03244',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 24;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 25, '03245', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03245',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 25;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 26, '03247', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03247',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 26;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 27, '03248', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03248',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 27;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 28, '03249', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03249',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 28;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 29, '03251', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03251',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 29;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 30, '03252', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03252',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 30;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 31, '03254', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03254',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 31;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 32, '03255', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03255',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 32;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 33, '03256', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03256',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 33;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 34, '03257', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03257',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 34;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 35, '03259', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03259',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 35;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 36, '03260', '6' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03260',
           PHONE_ADD_NUM = '6'
     where PHONE_CODE_ID = 36;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 37, '03261', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03261',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 37;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 38, '03263', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03263',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 38;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 39, '03264', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03264',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 39;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 40, '03265', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03265',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 40;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 41, '03266', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03266',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 41;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 42, '03269', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03269',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 42;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 43, '03310', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03310',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 43;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 44, '0332', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0332',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 44;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 45, '03342', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03342',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 45;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 46, '03344', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03344',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 46;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 47, '03346', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03346',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 47;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 48, '03348', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03348',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 48;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 49, '03352', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03352',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 49;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 50, '03355', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03355',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 50;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 51, '03357', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03357',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 51;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 52, '03362', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03362',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 52;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 53, '03363', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03363',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 53;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 54, '03365', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03365',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 54;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 55, '03366', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03366',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 55;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 56, '03368', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03368',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 56;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 57, '03372', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03372',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 57;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 58, '03374', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03374',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 58;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 59, '03376', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03376',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 59;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 60, '03377', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03377',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 60;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 61, '03379', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03379',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 61;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 62, '0342', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0342',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 62;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 63, '03430', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03430',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 63;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 64, '03431', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03431',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 64;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 65, '03432', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03432',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 65;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 66, '03433', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03433',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 66;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 67, '03434', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03434',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 67;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 68, '03435', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03435',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 68;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 69, '03436', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03436',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 69;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 70, '03437', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03437',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 70;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 71, '03438', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03438',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 71;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 72, '03471', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03471',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 72;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 73, '03472', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03472',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 73;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 74, '03474', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03474',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 74;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 75, '03475', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03475',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 75;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 76, '03476', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03476',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 76;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 77, '03477', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03477',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 77;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 78, '03478', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03478',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 78;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 79, '03479', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03479',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 79;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 80, '0352', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0352',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 80;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 81, '03540', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03540',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 81;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 82, '03541', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03541',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 82;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 83, '03542', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03542',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 83;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 84, '03543', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03543',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 84;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 85, '03544', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03544',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 85;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 86, '03546', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03546',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 86;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 87, '03547', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03547',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 87;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 88, '03548', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03548',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 88;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 89, '03549', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03549',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 89;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 90, '03550', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03550',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 90;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 91, '03551', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03551',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 91;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 92, '03552', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03552',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 92;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 93, '03554', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03554',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 93;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 94, '03555', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03555',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 94;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 95, '03557', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03557',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 95;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 96, '03558', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03558',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 96;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 97, '0362', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0362',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 97;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 98, '03632', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03632',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 98;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 99, '03633', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03633',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 99;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 100, '03634', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03634',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 100;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 101, '03635', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03635',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 101;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 102, '03636', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03636',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 102;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 103, '03637', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03637',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 103;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 104, '03650', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03650',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 104;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 105, '03651', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03651',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 105;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 106, '03652', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03652',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 106;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 107, '03653', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03653',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 107;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 108, '03654', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03654',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 108;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 109, '03655', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03655',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 109;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 110, '03656', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03656',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 110;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 111, '03657', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03657',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 111;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 112, '03658', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03658',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 112;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 113, '03659', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03659',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 113;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 114, '0372', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0372',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 114;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 115, '03730', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03730',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 115;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 116, '037312', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '037312',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 116;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 117, '03732', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03732',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 117;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 118, '03733', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03733',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 118;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 119, '03734', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03734',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 119;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 120, '03735', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03735',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 120;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 121, '03736', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03736',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 121;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 122, '03737', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03737',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 122;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 123, '03738', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03738',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 123;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 124, '03739', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03739',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 124;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 125, '03740', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03740',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 125;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 126, '03741', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03741',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 126;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 127, '0382', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0382',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 127;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 128, '03840', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03840',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 128;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 129, '03841', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03841',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 129;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 130, '03842', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03842',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 130;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 131, '03843', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03843',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 131;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 132, '03844', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03844',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 132;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 133, '03845', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03845',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 133;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 134, '03846', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03846',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 134;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 135, '03847', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03847',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 135;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 136, '03848', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03848',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 136;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 137, '03849', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03849',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 137;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 138, '03850', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03850',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 138;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 139, '03851', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03851',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 139;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 140, '03852', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03852',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 140;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 141, '03853', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03853',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 141;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 142, '03854', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03854',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 142;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 143, '03855', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03855',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 143;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 144, '03856', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03856',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 144;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 145, '03857', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03857',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 145;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 146, '03858', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03858',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 146;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 147, '03859', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '03859',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 147;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 148, '0412', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0412',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 148;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 149, '0412', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0412',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 149;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 150, '04130', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04130',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 150;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 151, '04131', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04131',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 151;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 152, '04132', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04132',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 152;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 153, '04133', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04133',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 153;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 154, '04134', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04134',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 154;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 155, '04135', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04135',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 155;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 156, '04136', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04136',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 156;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 157, '04137', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04137',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 157;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 158, '04138', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04138',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 158;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 159, '04139', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04139',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 159;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 160, '04140', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04140',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 160;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 161, '04141', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04141',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 161;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 162, '04142', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04142',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 162;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 163, '04143', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04143',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 163;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 164, '04144', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04144',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 164;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 165, '04145', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04145',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 165;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 166, '04146', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04146',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 166;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 167, '04147', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04147',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 167;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 168, '04148', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04148',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 168;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 169, '04149', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04149',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 169;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 170, '04161', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04161',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 170;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 171, '04162', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04162',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 171;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 172, '0432', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0432',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 172;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 173, '04330', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04330',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 173;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 174, '04331', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04331',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 174;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 175, '04332', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04332',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 175;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 176, '04333', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04333',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 176;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 177, '04334', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04334',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 177;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 178, '04335', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04335',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 178;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 179, '04336', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04336',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 179;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 180, '04337', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04337',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 180;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 181, '043388', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '043388',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 181;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 182, '04340', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04340',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 182;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 183, '04341', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04341',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 183;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 184, '043410', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '043410',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 184;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 185, '04342', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04342',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 185;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 186, '04343', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04343',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 186;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 187, '04344', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04344',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 187;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 188, '04345', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04345',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 188;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 189, '04346', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04346',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 189;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 190, '04347', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04347',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 190;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 191, '04348', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04348',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 191;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 192, '04349', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04349',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 192;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 193, '04350', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04350',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 193;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 194, '04351', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04351',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 194;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 195, '04352', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04352',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 195;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 196, '04353', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04353',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 196;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 197, '04355', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04355',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 197;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 198, '04356', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04356',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 198;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 199, '04357', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04357',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 199;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 200, '04358', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04358',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 200;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 201, '044', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '044',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 201;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 202, '045', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '045',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 202;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 203, '04560', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04560',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 203;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 204, '04561', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04561',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 204;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 205, '04562', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04562',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 205;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 206, '04563', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04563',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 206;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 207, '04564', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04564',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 207;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 208, '04565', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04565',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 208;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 209, '04566', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04566',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 209;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 210, '04567', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04567',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 210;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 211, '04568', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04568',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 211;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 212, '04569', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04569',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 212;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 213, '04570', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04570',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 213;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 214, '04571', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04571',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 214;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 215, '04572', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04572',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 215;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 216, '04573', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04573',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 216;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 217, '04574', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04574',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 217;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 218, '04575', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04575',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 218;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 219, '04576', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04576',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 219;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 220, '04577', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04577',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 220;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 221, '04578', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04578',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 221;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 222, '04579', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04579',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 222;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 223, '04591', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04591',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 223;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 224, '04592', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04592',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 224;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 225, '04593', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04593',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 225;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 226, '04594', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04594',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 226;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 227, '04595', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04595',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 227;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 228, '04596', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04596',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 228;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 229, '04597', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04597',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 229;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 230, '04598', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04598',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 230;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 231, '0462', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0462',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 231;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 232, '04631', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04631',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 232;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 233, '04632', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04632',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 233;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 234, '04633', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04633',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 234;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 235, '04634', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04634',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 235;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 236, '04635', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04635',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 236;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 237, '04636', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04636',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 237;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 238, '04637', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04637',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 238;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 239, '04639', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04639',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 239;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 240, '04641', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04641',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 240;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 241, '04642', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04642',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 241;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 242, '04643', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04643',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 242;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 243, '04644', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04644',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 243;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 244, '04645', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04645',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 244;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 245, '04646', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04646',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 245;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 246, '04653', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04653',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 246;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 247, '04654', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04654',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 247;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 248, '04655', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04655',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 248;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 249, '04656', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04656',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 249;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 250, '04657', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04657',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 250;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 251, '04658', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04658',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 251;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 252, '04659', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04659',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 252;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 253, '0472', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0472',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 253;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 254, '04730', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04730',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 254;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 255, '04731', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04731',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 255;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 256, '04732', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04732',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 256;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 257, '04733', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04733',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 257;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 258, '04734', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04734',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 258;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 259, '04735', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04735',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 259;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 260, '04736', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04736',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 260;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 261, '04737', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04737',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 261;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 262, '04738', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04738',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 262;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 263, '04739', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04739',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 263;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 264, '04740', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04740',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 264;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 265, '04741', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04741',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 265;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 266, '04742', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04742',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 266;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 267, '04744', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04744',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 267;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 268, '04745', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04745',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 268;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 269, '04746', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04746',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 269;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 270, '04747', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04747',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 270;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 271, '04748', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04748',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 271;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 272, '04749', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04749',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 272;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 273, '048', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '048',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 273;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 274, '04840', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04840',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 274;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 275, '04841', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04841',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 275;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 276, '04842', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04842',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 276;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 277, '04843', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04843',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 277;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 278, '04844', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04844',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 278;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 279, '04845', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04845',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 279;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 280, '04846', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04846',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 280;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 281, '04847', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04847',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 281;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 282, '04848', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04848',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 282;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 283, '04849', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04849',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 283;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 284, '04850', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04850',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 284;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 285, '04851', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04851',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 285;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 286, '04852', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04852',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 286;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 287, '04853', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04853',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 287;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 288, '04854', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04854',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 288;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 289, '04855', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04855',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 289;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 290, '04856', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04856',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 290;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 291, '04857', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04857',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 291;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 292, '04858', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04858',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 292;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 293, '04859', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04859',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 293;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 294, '04860', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04860',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 294;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 295, '04861', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04861',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 295;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 296, '04862', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04862',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 296;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 297, '04863', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04863',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 297;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 298, '04864', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04864',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 298;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 299, '04865', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04865',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 299;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 300, '04866', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04866',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 300;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 301, '04867', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04867',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 301;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 302, '04868', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '04868',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 302;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 303, '0512', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0512',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 303;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 304, '05131', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05131',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 304;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 305, '05132', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05132',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 305;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 306, '05133', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05133',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 306;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 307, '05134', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05134',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 307;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 308, '05135', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05135',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 308;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 309, '05136', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05136',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 309;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 310, '05151', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05151',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 310;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 311, '05152', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05152',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 311;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 312, '05153', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05153',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 312;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 313, '05154', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05154',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 313;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 314, '05158', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05158',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 314;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 315, '05159', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05159',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 315;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 316, '05161', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05161',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 316;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 317, '05162', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05162',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 317;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 318, '05163', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05163',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 318;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 319, '05164', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05164',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 319;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 320, '05167', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05167',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 320;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 321, '05168', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05168',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 321;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 322, '0522', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0522',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 322;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 323, '05233', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05233',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 323;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 324, '05234', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05234',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 324;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 325, '05235', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05235',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 325;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 326, '05236', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05236',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 326;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 327, '05237', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05237',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 327;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 328, '05238', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05238',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 328;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 329, '05239', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05239',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 329;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 330, '05240', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05240',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 330;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 331, '05241', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05241',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 331;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 332, '05242', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05242',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 332;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 333, '05250', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05250',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 333;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 334, '05251', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05251',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 334;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 335, '05252', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05252',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 335;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 336, '05253', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05253',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 336;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 337, '05254', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05254',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 337;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 338, '05255', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05255',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 338;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 339, '05256', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05256',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 339;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 340, '05257', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05257',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 340;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 341, '05258', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05258',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 341;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 342, '05259', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05259',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 342;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 343, '0532', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0532',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 343;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 344, '05340', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05340',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 344;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 345, '05341', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05341',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 345;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 346, '05342', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05342',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 346;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 347, '05343', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05343',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 347;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 348, '05344', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05344',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 348;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 349, '05345', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05345',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 349;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 350, '05346', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05346',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 350;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 351, '05347', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05347',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 351;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 352, '05348', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05348',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 352;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 353, '05350', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05350',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 353;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 354, '05351', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05351',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 354;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 355, '05352', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05352',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 355;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 356, '05353', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05353',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 356;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 357, '05354', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05354',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 357;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 358, '05355', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05355',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 358;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 359, '05356', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05356',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 359;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 360, '05357', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05357',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 360;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 361, '05358', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05358',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 361;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 362, '05359', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05359',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 362;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 363, '0536', '6' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0536',
           PHONE_ADD_NUM = '6'
     where PHONE_CODE_ID = 363;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 364, '05361', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05361',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 364;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 365, '05362', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05362',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 365;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 366, '05363', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05363',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 366;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 367, '05364', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05364',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 367;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 368, '05365', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05365',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 368;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 369, '0542', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0542',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 369;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 370, '05442', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05442',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 370;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 371, '05443', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05443',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 371;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 372, '05444', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05444',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 372;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 373, '05445', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05445',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 373;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 374, '05446', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05446',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 374;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 375, '05447', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05447',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 375;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 376, '05448', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05448',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 376;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 377, '05449', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05449',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 377;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 378, '05451', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05451',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 378;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 379, '05452', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05452',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 379;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 380, '05453', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05453',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 380;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 381, '05454', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05454',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 381;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 382, '05455', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05455',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 382;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 383, '05456', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05456',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 383;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 384, '05457', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05457',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 384;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 385, '05458', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05458',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 385;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 386, '05459', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05459',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 386;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 387, '0552', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0552',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 387;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 388, '05530', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05530',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 388;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 389, '05531', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05531',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 389;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 390, '05532', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05532',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 390;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 391, '05533', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05533',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 391;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 392, '05534', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05534',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 392;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 393, '05535', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05535',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 393;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 394, '05536', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05536',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 394;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 395, '05537', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05537',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 395;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 396, '05538', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05538',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 396;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 397, '05539', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05539',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 397;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 398, '05540', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05540',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 398;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 399, '05542', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05542',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 399;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 400, '05543', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05543',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 400;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 401, '05544', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05544',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 401;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 402, '05545', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05545',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 402;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 403, '05546', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05546',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 403;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 404, '05547', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05547',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 404;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 405, '05548', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05548',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 405;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 406, '05549', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05549',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 406;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 407, '056', '4' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '056',
           PHONE_ADD_NUM = '4'
     where PHONE_CODE_ID = 407;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 408, '056', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '056',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 408;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 409, '05611', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05611',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 409;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 410, '05612', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05612',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 410;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 411, '05615', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05615',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 411;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 412, '05617', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05617',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 412;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 413, '05618', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05618',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 413;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 414, '0563', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0563',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 414;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 415, '05630', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05630',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 415;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 416, '05633', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05633',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 416;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 417, '05634', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05634',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 417;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 418, '05635', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05635',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 418;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 419, '05636', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05636',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 419;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 420, '05638', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05638',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 420;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 421, '05639', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05639',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 421;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 422, '0564', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0564',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 422;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 423, '05650', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05650',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 423;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 424, '05651', '0' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05651',
           PHONE_ADD_NUM = '0'
     where PHONE_CODE_ID = 424;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 425, '05652', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05652',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 425;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 426, '05653', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05653',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 426;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 427, '05655', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05655',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 427;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 428, '05656', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05656',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 428;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 429, '05657', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05657',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 429;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 430, '05658', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05658',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 430;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 431, '0566', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0566',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 431;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 432, '05663', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05663',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 432;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 433, '05665', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05665',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 433;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 434, '05667', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05667',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 434;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 435, '05668', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05668',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 435;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 436, '05669', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05669',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 436;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 437, '0567', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0567',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 437;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 438, '05671', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05671',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 438;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 439, '0569', '3' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0569',
           PHONE_ADD_NUM = '3'
     where PHONE_CODE_ID = 439;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 440, '0569', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0569',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 440;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 441, '05690', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05690',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 441;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 442, '057', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '057',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 442;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 443, '05740', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05740',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 443;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 444, '05741', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05741',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 444;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 445, '05742', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05742',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 445;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 446, '05743', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05743',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 446;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 447, '05744', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05744',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 447;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 448, '05745', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05745',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 448;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 449, '05746', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05746',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 449;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 450, '05747', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05747',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 450;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 451, '05748', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05748',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 451;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 452, '05749', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05749',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 452;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 453, '05750', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05750',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 453;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 454, '05751', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05751',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 454;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 455, '05752', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05752',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 455;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 456, '05753', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05753',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 456;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 457, '05754', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05754',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 457;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 458, '05755', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05755',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 458;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 459, '05756', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05756',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 459;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 460, '05757', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05757',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 460;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 461, '05758', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05758',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 461;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 462, '05759', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05759',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 462;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 463, '05761', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05761',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 463;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 464, '05762', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05762',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 464;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 465, '05763', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05763',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 465;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 466, '05764', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05764',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 466;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 467, '05765', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05765',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 467;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 468, '05766', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '05766',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 468;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 469, '061', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '061',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 469;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 470, '06131', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06131',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 470;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 471, '06132', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06132',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 471;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 472, '06133', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06133',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 472;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 473, '06136', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06136',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 473;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 474, '06137', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06137',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 474;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 475, '06138', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06138',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 475;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 476, '06139', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06139',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 476;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 477, '06140', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06140',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 477;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 478, '06141', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06141',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 478;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 479, '06142', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06142',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 479;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 480, '06143', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06143',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 480;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 481, '06144', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06144',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 481;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 482, '06145', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06145',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 482;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 483, '06147', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06147',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 483;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 484, '06153', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06153',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 484;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 485, '06156', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06156',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 485;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 486, '06162', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06162',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 486;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 487, '06165', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06165',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 487;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 488, '06175', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06175',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 488;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 489, '06178', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06178',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 489;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 490, '0619', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0619',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 490;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 491, '062', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '062',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 491;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 492, '06212', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06212',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 492;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 493, '06214', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06214',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 493;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 494, '06217', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06217',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 494;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 495, '0623', '9' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0623',
           PHONE_ADD_NUM = '9'
     where PHONE_CODE_ID = 495;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 496, '0623', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0623',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 496;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 497, '06236', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06236',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 497;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 498, '06237', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06237',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 498;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 499, '0624', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0624',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 499;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 500, '06243', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06243',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 500;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 501, '06244', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06244',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 501;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 502, '06246', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06246',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 502;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 503, '06247', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06247',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 503;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 504, '06249', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06249',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 504;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 505, '06250', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06250',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 505;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 506, '06252', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06252',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 506;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 507, '06253', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06253',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 507;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 508, '06254', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06254',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 508;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 509, '06255', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06255',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 509;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 510, '06256', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06256',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 510;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 511, '06257', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06257',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 511;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 512, '06259', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06259',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 512;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 513, '0626', '4' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0626',
           PHONE_ADD_NUM = '4'
     where PHONE_CODE_ID = 513;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 514, '0626', '2' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0626',
           PHONE_ADD_NUM = '2'
     where PHONE_CODE_ID = 514;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 515, '06261', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06261',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 515;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 516, '06267', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06267',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 516;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 517, '06269', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06269',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 517;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 518, '0627', '4' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0627',
           PHONE_ADD_NUM = '4'
     where PHONE_CODE_ID = 518;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 519, '06272', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06272',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 519;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 520, '06273', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06273',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 520;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 521, '06275', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06275',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 521;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 522, '06277', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06277',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 522;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 523, '06278', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06278',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 523;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 524, '06279', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06279',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 524;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 525, '0629', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0629',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 525;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 526, '06296', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06296',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 526;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 527, '06297', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06297',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 527;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 528, '0642', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0642',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 528;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 529, '06431', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06431',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 529;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 530, '06432', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06432',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 530;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 531, '06433', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06433',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 531;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 532, '06434', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06434',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 532;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 533, '06435', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06435',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 533;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 534, '06436', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06436',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 534;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 535, '06441', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06441',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 535;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 536, '06442', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06442',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 536;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 537, '06443', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06443',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 537;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 538, '06444', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06444',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 538;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 539, '06445', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06445',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 539;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 540, '06446', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06446',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 540;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 541, '06451', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06451',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 541;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 542, '06452', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06452',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 542;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 543, '06453', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06453',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 543;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 544, '06454', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06454',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 544;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 545, '06455', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06455',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 545;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 546, '06456', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06456',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 546;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 547, '06461', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06461',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 547;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 548, '06462', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06462',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 548;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 549, '06463', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06463',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 549;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 550, '06464', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06464',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 550;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 551, '06465', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06465',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 551;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 552, '06466', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06466',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 552;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 553, '06471', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06471',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 553;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 554, '06472', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06472',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 554;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 555, '06473', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06473',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 555;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 556, '06474', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06474',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 556;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 557, '0652', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0652',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 557;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 558, '0654', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0654',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 558;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 559, '06550', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06550',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 559;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 560, '06551', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06551',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 560;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 561, '06552', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06552',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 561;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 562, '06553', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06553',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 562;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 563, '06554', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06554',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 563;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 564, '06555', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06555',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 564;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 565, '06556', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06556',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 565;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 566, '06557', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06557',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 566;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 567, '06558', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06558',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 567;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 568, '06559', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06559',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 568;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 569, '06560', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06560',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 569;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 570, '06561', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06561',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 570;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 571, '06562', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06562',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 571;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 572, '06563', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06563',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 572;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 573, '06564', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06564',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 573;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 574, '06565', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06565',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 574;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 575, '06566', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06566',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 575;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 576, '06567', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06567',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 576;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 577, '06569', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '06569',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 577;
end;
/

begin
  Insert into BARS.ADR_PHONE_CODES
    ( PHONE_CODE_ID,PHONE_CODE,PHONE_ADD_NUM )
  Values
    ( 578, '0692', null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_PHONE_CODES
       set PHONE_CODE = '0692',
           PHONE_ADD_NUM = null
     where PHONE_CODE_ID = 578;
end;
/


commit;
