-- ======================================================================================
-- Module :
-- Author : BAA
-- Date   :
-- ===================================== <Comments> =====================================
-- Script for insert or update table "ADR_AREAS"
-- ======================================================================================

SET FEEDBACK     OFF

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 1, 1, '������������ �-�', '������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 1,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 1;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 2, 2, '������������ �-�', '����������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 2,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 2;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 3, 3, '������������� �-�', '������������ �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 3,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 3;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 4, 4, '�������������� �-�', '�������������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 4,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 4;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 5, 5, '������������� �-�', '������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 5,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 5;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 6, 6, '������������ �-�', '����������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 6,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 6;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 7, 7, '����������� �-�', '����������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 7,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 7;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 8, 8, '��������� �-�', '��������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 8,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 8;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 9, 9, '������������ �-�', '������������ �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 9,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 9;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 10, 10, '��������� �-�', '�������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 10,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 10;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 11, 11, '����������� �-�', '����������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 11,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 11;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 12, 12, '������������ �-�', '������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 12,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 12;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 13, 13, '������������ �-�', '����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 13,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 13;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 14, 14, '�������� �-�', '������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 14,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 14;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 15, 15, '���������� �-�', '���������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 15,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 15;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 16, 16, '��������������� �-�', '�������������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 16,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 16;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 17, 17, '����������� �-�', '���������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 17,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 17;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 18, 18, '������������� �-�', '������������ �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 18,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 18;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 19, 19, '����������� �-�', '���������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 19,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 19;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 20, 20, '����������� �-�', '����������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 20,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 20;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 21, 21, '������������ �-�', '����������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 21,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 21;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 22, 22, '������������ �-�', '����������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 22,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 22;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 23, 23, '����������� �-�', '����������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 23,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 23;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 24, 24, '����������������� �-�', '���������������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 24,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 24;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 25, 25, '������������ �-�', '������������ �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 25,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 25;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 26, 26, '������������� �-�', '������������ �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 26,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 26;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 27, 27, '����������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 27,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 27;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 28, 28, '��������-������������ �-�', '��������-������������ �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 28,
           AREA_NAME = '��������-������������ �-�',
           AREA_NAME_RU = '��������-������������ �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 28;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 29, 29, '������������ �-�', '����������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 29,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 29;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 30, 30, '����������� �-�', '����������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 30,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 30;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 31, 30, '����������� �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 30,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 31;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 32, 31, '������������ �-�', '����������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 31,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 32;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 33, 32, '���������������� �-�', '��������������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 32,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 33;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 34, 33, '������������ �-�', '������������ �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 33,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 34;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 35, 34, '�������������� �-�', '�������������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 34,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 35;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 36, 35, '����������� �-�', '���������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 35,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 36;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 37, 36, '������������� �-�', '������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 36,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 37;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 38, 37, '������������ �-�', '����������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 37,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 38;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 39, 38, '������������ �-�', '����������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 38,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 39;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 40, 39, '�������������� �-�', '������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 39,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 40;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 41, 40, '��������������� �-�', '�������������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 40,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 41;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 42, 41, '������������� �-�', '������������ �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 41,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 42;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 43, 42, '������������ �-�', '����������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 42,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 43;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 44, 44, '������������ �-�', '����������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 44,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 44;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 45, 45, '������������� �-�', '������������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 45,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 45;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 46, 46, '��������� �-�', '��������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 46,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 46;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 47, 47, '������������ �-�', '����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 47,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 47;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 48, 48, '����������� �-�', '���������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 48,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 48;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 49, 49, '��������� �-�', '�������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 49,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 49;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 50, 50, '����������� �-�', '���������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 50,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 50;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 51, 51, '���������� �-�', '���������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 51,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 51;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 52, 52, '������������ �-�', '������������ �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 52,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 52;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 53, 53, '���������� �-�', '��������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 53,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 53;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 54, 54, '������� �-�', '������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 54,
           AREA_NAME = '������� �-�',
           AREA_NAME_RU = '������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 54;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 55, 55, '��������� �-�', '��������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 55,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 55;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 56, 56, '���������� �-�', '���������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 56,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 56;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 57, 57, '����������� �-�', '���������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 57,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 57;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 58, 58, '����������� �-�', '������������ �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 58,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 58;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 59, 59, '������������� �-�', '������������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 59,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 59;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 60, 59, '������������� �-�', '������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 59,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 60;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 61, 60, '������������������ �-�', '����������������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 60,
           AREA_NAME = '������������������ �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 61;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 62, 61, '������������������� �-�', '������������������ �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 61,
           AREA_NAME = '������������������� �-�',
           AREA_NAME_RU = '������������������ �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 62;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 63, 62, '����������������� �-�', '����������������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 62,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 63;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 64, 63, '���������������� �-�', '���������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 63,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 64;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 65, 64, '����������������� �-�', '����������������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 64,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 65;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 66, 65, '������������������ �-�', '������������������ �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 65,
           AREA_NAME = '������������������ �-�',
           AREA_NAME_RU = '������������������ �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 66;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 67, 66, '������������������� �-�', '�������������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 66,
           AREA_NAME = '������������������� �-�',
           AREA_NAME_RU = '�������������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 67;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 68, 67, '��������������������� �-�', '��������������������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 67,
           AREA_NAME = '��������������������� �-�',
           AREA_NAME_RU = '��������������������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 68;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 69, 68, '����������������� �-�', '����������������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 68,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 69;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 70, 69, '������������������ �-�', '����������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 69,
           AREA_NAME = '������������������ �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 70;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 71, 70, '������������������ �-�', '����������������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 70,
           AREA_NAME = '������������������ �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 71;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 72, 71, '������������� �-�', '������������ �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 71,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 72;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 73, 72, '������������� �-�', '������������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 72,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 73;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 74, 73, '����������� �-�', '����������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 73,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 74;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 75, 74, '���������� �-�', '��������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 74,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 75;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 76, 75, '�������������� �-�', '�������������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 75,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 76;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 77, 76, '�������������� �-�', '�������������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 76,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 77;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 78, 77, '������������� �-�', '������������ �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 77,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 78;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 79, 78, '³���������� �-�', '����������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 78,
           AREA_NAME = '³���������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 79;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 80, 79, '³���������� �-�', '���������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 79,
           AREA_NAME = '³���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 80;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 81, 80, '³�������� �-�', '��������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 80,
           AREA_NAME = '³�������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 81;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 82, 81, '³����������� �-�', '������������ �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 81,
           AREA_NAME = '³����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 82;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 83, 82, '����������� �-�', '���������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 82,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 83;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 84, 83, '������������� �-�', '������������ �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 83,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 84;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 85, 84, '������������ �-�', '������������ �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 84,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 85;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 86, 85, '����������� �-�', '���������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 85,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 86;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 87, 86, '������������ �-�', '����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 86,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 87;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 88, 86, '������������ �-�', '����������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 86,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 88;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 89, 87, '�����������-���������� �-�', '����������-��������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 87,
           AREA_NAME = '�����������-���������� �-�',
           AREA_NAME_RU = '����������-��������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 89;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 90, 88, '���������-���������� �-�', '��������-��������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 88,
           AREA_NAME = '���������-���������� �-�',
           AREA_NAME_RU = '��������-��������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 90;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 91, 89, '��������������� �-�', '������������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 89,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 91;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 92, 90, '����������� �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 90,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 92;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 93, 91, '���䳿������ �-�', '����������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 91,
           AREA_NAME = '���䳿������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 93;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 94, 92, '��������� �-�', '��������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 92,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 94;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 95, 93, '������������� �-�', '������������ �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 93,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 95;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 96, 94, '����������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 94,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 96;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 97, 95, '��������� �-�', '��������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 95,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 97;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 98, 96, '���������� �-�', '���������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 96,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 98;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 99, 97, '����������� �-�', '����������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 97,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 99;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 100, 98, '���������� �-�', '���������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 98,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 100;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 101, 99, '����������� �-�', '���������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 99,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 101;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 102, 100, '����������� �-�', '���������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 100,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 102;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 103, 101, '������������� �-�', '������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 101,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 103;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 104, 102, '���������������� �-�', '��������������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 102,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 104;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 105, 103, '�������������� �-�', '�������������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 103,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 105;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 106, 104, '�������������� �-�', '�������������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 104,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 106;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 107, 105, '�������������� �-�', '������������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 105,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 107;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 108, 106, '������������� �-�', '������������ �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 106,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 108;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 109, 107, '����������� �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 107,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 109;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 110, 107, '����������� �-�', '����������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 107,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 110;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 111, 108, '������������ �-�', '����������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 108,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 111;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 112, 109, '���������� �-�', '��������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 109,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 112;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 113, 110, '������������ �-�', '������������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 110,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 113;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 114, 111, '������������� �-�', '������������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 111,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 114;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 115, 112, '������������ �-�', '����������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 112,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 115;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 116, 113, '������������ �-�', '������������ �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 113,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 116;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 117, 114, '����������� �-�', '����������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 114,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 117;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 118, 115, '������������� �-�', '������������ �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 115,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 118;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 119, 116, '������������� �-�', '������������ �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 116,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 119;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 120, 117, '������������ �-�', '����������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 117,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 120;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 121, 118, '���������� �-�', '���������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 118,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 121;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 122, 119, '���������������� �-�', '���������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 119,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 122;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 123, 120, '����������������� �-�', '����������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 120,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 123;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 124, 121, '������������� �-�', '������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 121,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 124;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 125, 122, '���������� �-�', '��������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 122,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 125;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 126, 122, '���������� �-�', '��������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 122,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 126;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 127, 123, '����������� �-�', '����������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 123,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 127;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 128, 124, '���������� �-�', '���������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 124,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 128;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 129, 125, '������������ �-�', '������������ �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 125,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 129;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 130, 126, '���������� �-�', '��������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 126,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 130;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 131, 127, '������������ �-�', '����������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 127,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 131;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 132, 128, '����������� �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 128,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 132;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 133, 129, '���������� �-�', '��������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 129,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 133;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 134, 130, '������������ �-�', '������������ �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 130,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 134;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 135, 131, '���������� �-�', '���������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 131,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 135;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 136, 132, '������������ �-�', '����������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 132,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 136;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 137, 133, '������������ �-�', '����������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 133,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 137;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 138, 134, '����������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 134,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 138;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 139, 135, '���������� �-�', '���������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 135,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 139;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 140, 136, '��������� �-�', '��������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 136,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 140;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 141, 137, '���������� �-�', '���������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 137,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 141;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 142, 138, '���������� �-�', '����������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 138,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 142;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 143, 139, '������������ �-�', '������������ �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 139,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 143;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 144, 140, '������������� �-�', '������������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 140,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 144;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 145, 141, '������������� �-�', '������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 141,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 145;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 146, 142, '���������� �-�', '���������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 142,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 146;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 147, 143, '���������� �-�', '���������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 143,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 147;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 148, 144, '��������������� �-�', '�������������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 144,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 148;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 149, 145, '���������� �-�', '���������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 145,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 149;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 150, 146, '������������� �-�', '������������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 146,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 150;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 151, 147, 'ǳ��������� �-�', '����������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 147,
           AREA_NAME = 'ǳ��������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 151;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 152, 148, '�쳿������ �-�', '��������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 148,
           AREA_NAME = '�쳿������ �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 152;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 153, 149, '����������� �-�', '���������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 149,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 153;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 154, 150, '������������ �-�', '������������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 150,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 154;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 155, 151, '������������ �-�', '����������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 151,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 155;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 156, 151, '������������ �-�', '����������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 151,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 156;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 157, 152, '������������� �-�', '������������ �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 152,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 157;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 158, 153, '���������� �-�', '���������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 153,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 158;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 159, 153, '���������� �-�', '���������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 153,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 159;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 160, 154, '����������� �-�', '����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 154,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 160;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 161, 155, '����������� �-�', '����������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 155,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 161;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 162, 156, '��������� �-�', '�������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 156,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 162;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 163, 157, '������������ �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 157,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 163;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 164, 158, '���������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 158,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 164;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 165, 159, '���������� �-�', '��������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 159,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 165;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 166, 160, '���������� �-�', '��������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 160,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 166;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 167, 161, '������������ �-�', '������������ �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 161,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 167;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 168, 162, '������������ �-�', '������������ �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 162,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 168;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 169, 163, '������������ �-�', '������������ �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 163,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 169;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 170, 164, '����������� �-�', '����������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 164,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 170;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 171, 165, '��������� �-�', '��������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 165,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 171;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 172, 166, '��������-���������� �-�', '�������-���������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 166,
           AREA_NAME = '��������-���������� �-�',
           AREA_NAME_RU = '�������-���������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 172;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 173, 167, '�������-������� �-�', '�������-������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 167,
           AREA_NAME = '�������-������� �-�',
           AREA_NAME_RU = '�������-������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 173;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 174, 168, '���������� �-�', '��������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 168,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 174;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 175, 169, '���������-����������� �-�', '��������-����������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 169,
           AREA_NAME = '���������-����������� �-�',
           AREA_NAME_RU = '��������-����������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 175;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 176, 170, '�����-���������� �-�', '������-��������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 170,
           AREA_NAME = '�����-���������� �-�',
           AREA_NAME_RU = '������-��������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 176;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 177, 171, '��������� �-�', '��������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 171,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 177;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 178, 172, '���������� �-�', '���������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 172,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 178;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 179, 173, '���������������� �-�', '���������������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 173,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 179;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 180, 174, '���������� �-�', '��������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 174,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 180;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 181, 175, '������������ �-�', '����������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 175,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 181;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 182, 176, '������������� �-�', '������������ �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 176,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 182;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 183, 177, '����-������������� �-�', '�����-C����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 177,
           AREA_NAME = '����-������������� �-�',
           AREA_NAME_RU = '�����-C����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 183;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 184, 178, 'ʳ����������� �-�', '������������ �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 178,
           AREA_NAME = 'ʳ����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 184;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 185, 179, 'ʳ������� �-�', '��������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 179,
           AREA_NAME = 'ʳ������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 185;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 186, 180, 'ʳ������������� �-�', '�������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 180,
           AREA_NAME = 'ʳ������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 186;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 187, 181, 'ʳ�������� �-�', '��������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 181,
           AREA_NAME = 'ʳ�������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 187;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 188, 182, 'ʳ��������� �-�', '���������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 182,
           AREA_NAME = 'ʳ��������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 188;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 189, 183, '����������� �-�', '����������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 183,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 189;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 190, 184, '����������� �-�', '���������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 184,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 190;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 191, 185, '���������� �-�', '��������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 185,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 191;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 192, 186, '����������� �-�', '���������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 186,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 192;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 193, 187, '�������������� �-�', '������������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 187,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 193;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 194, 188, '��������� �-�', '��������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 188,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 194;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 195, 189, '������������ �-�', '����������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 189,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 195;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 196, 190, '����������� �-�', '����������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 190,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 196;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 197, 191, '������������ �-�', '����������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 191,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 197;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 198, 192, '�������������� �-�', '��������������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 192,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 198;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 199, 193, '������������ �-�', '������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 193,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 199;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 200, 194, '������������ �-�', '����������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 194,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 200;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 201, 195, '��������� �-�', '�������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 195,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 201;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 202, 196, '���������� �-�', '��������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 196,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 202;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 203, 197, '������������� �-�', '������������ �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 197,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 203;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 204, 198, '��������������� �-�', '�������������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 198,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 204;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 205, 199, '�������-������������� �-�', '�������-������������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 199,
           AREA_NAME = '�������-������������� �-�',
           AREA_NAME_RU = '�������-������������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 205;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 206, 200, '����������� �-�', '����������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 200,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 206;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 207, 201, '��������� �-�', '��������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 201,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 207;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 208, 202, '������������� �-�', '������������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 202,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 208;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 209, 203, '��������������� �-�', '���������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 203,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 209;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 210, 204, '������������ �-�', '����������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 204,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 210;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 211, 205, '���������� �-�', '��������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 205,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 211;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 212, 206, '������������ �-�', '������������ �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 206,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 212;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 213, 207, '��������������� �-�', '��������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 207,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 213;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 214, 208, '����������������� �-�', '����������������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 208,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 214;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 215, 209, '��������������� �-�', '�������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 209,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 215;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 216, 210, '�������������� �-�', '������������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 210,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 216;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 217, 211, '�������������� �-�', '������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 211,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 217;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 218, 212, '���������������� �-�', '��������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 212,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 218;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 219, 213, '���������������� �-�', '��������������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 213,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 219;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 220, 214, '������������������ �-�', '����������������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 214,
           AREA_NAME = '������������������ �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 220;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 221, 215, '�������������� �-�', '�������������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 215,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 221;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 222, 216, '������������ �-�', '����������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 216,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 222;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 223, 217, '������������� �-�', '������������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 217,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 223;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 224, 218, '���������� �-�', '���������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 218,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 224;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 225, 219, '�������������� �-�', '������������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 219,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 225;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 226, 220, '����������� �-�', '������������ �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 220,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 226;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 227, 221, '������������� �-�', '������������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 221,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 227;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 228, 222, '������������� �-�', '������������ �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 222,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 228;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 229, 223, '������������ �-�', '����������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 223,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 229;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 230, 224, '������������� �-�', '������������ �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 224,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 230;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 231, 225, '����������� �-�', '����������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 225,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 231;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 232, 226, '���������� �-�', '��������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 226,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 232;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 233, 227, '����������� �-�', '���������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 227,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 233;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 234, 228, '������������ �-�', '����������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 228,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 234;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 235, 229, '��������� �-�', '��������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 229,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 235;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 236, 230, '������������ �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 230,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 236;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 237, 231, '����������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 231,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 237;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 238, 232, '���������������� �-�', '��������������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 232,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 238;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 239, 233, '���������� �-�', '��������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 233,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 239;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 240, 234, '˳�������� �-�', '��������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 234,
           AREA_NAME = '˳�������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 240;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 241, 235, '��������� �-�', '��������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 235,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 241;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 242, 236, '������������ �-�', '����������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 236,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 242;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 243, 237, '���������� �-�', '��������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 237,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 243;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 244, 238, '���������� �-�', '��������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 238,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 244;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 245, 239, '���������� �-�', '��������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 239,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 245;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 246, 240, '������������ �-�', '����������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 240,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 246;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 247, 241, '������� �-�', '������ �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 241,
           AREA_NAME = '������� �-�',
           AREA_NAME_RU = '������ �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 247;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 248, 242, '���������� �-�', '��������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 242,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 248;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 249, 243, '������������ �-�', '����������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 243,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 249;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 250, 244, '������������ �-�', '����������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 244,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 250;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 251, 245, '������������ �-�', '����������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 245,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 251;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 252, 246, '�������������� �-�', '�������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 246,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 252;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 253, 247, '����������� �-�', '����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 247,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 253;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 254, 248, '���������� �-�', '��������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 248,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 254;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 255, 249, '�������������� �-�', '�������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 249,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 255;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 256, 250, '����������� �-�', '����������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 250,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 256;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 257, 251, '����������� �-�', '����������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 251,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 257;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 258, 252, '��������� �-�', '���������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 252,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 258;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 259, 253, '���������� �-�', '���������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 253,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 259;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 260, 254, '���������� �-�', '��������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 254,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 260;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 261, 255, '��������� �-�', '��������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 255,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 261;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 262, 256, '�������������� �-�', '�������������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 256,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 262;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 263, 257, '�������� �-�', '������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 257,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 263;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 264, 258, '������������ �-�', '������������ �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 258,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 264;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 265, 258, '������������ �-�', '������������ �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 258,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 265;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 266, 258, '������������ �-�', '������������ �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 258,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 266;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 267, 259, '������������� �-�', '������������ �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 259,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 267;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 268, 260, '����������� �-�', '����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 260,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 268;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 269, 261, '������������ �-�', '������������ �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 261,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 269;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 270, 262, '̳�������� �-�', '���������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 262,
           AREA_NAME = '̳�������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 270;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 271, 263, '̳�������� �-�', '��������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 263,
           AREA_NAME = '̳�������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 271;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 272, 264, '���������� �-�', '���������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 264,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 272;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 273, 265, '������-���������� �-�', '�������-���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 265,
           AREA_NAME = '������-���������� �-�',
           AREA_NAME_RU = '�������-���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 273;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 274, 266, '�������������� �-�', '������������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 266,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 274;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 275, 267, '����������������� �-�', '���������������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 267,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 275;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 276, 268, '���������� �-�', '���������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 268,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 276;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 277, 269, '������������ �-�', '����������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 269,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 277;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 278, 270, '��������������������� �-�', '�������������������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 270,
           AREA_NAME = '��������������������� �-�',
           AREA_NAME_RU = '�������������������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 278;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 279, 271, '������������� �-�', '������������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 271,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 279;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 280, 272, '����������� �-�', '����������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 272,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 280;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 281, 273, '��������������� �-�', '��������������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 273,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 281;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 282, 274, '����������� �-�', '����������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 274,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 282;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 283, 275, '������������� �-�', '������������ �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 275,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 283;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 284, 276, '���������������� �-�', '���������������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 276,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 284;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 285, 277, 'ͳ�������� �-�', '��������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 277,
           AREA_NAME = 'ͳ�������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 285;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 286, 278, 'ͳ����������� �-�', '������������ �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 278,
           AREA_NAME = 'ͳ����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 286;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 287, 279, '��������������� �-�', '��������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 279,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 287;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 288, 280, '��������-ѳ�������� �-�', '��������-��������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 280,
           AREA_NAME = '��������-ѳ�������� �-�',
           AREA_NAME_RU = '��������-��������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 288;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 289, 281, '������������� �-�', '������������ �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 281,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 289;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 290, 282, '�������������� �-�', '������������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 282,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 290;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 291, 283, '������������������ �-�', '����������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 283,
           AREA_NAME = '������������������ �-�',
           AREA_NAME_RU = '����������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 291;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 292, 284, '����������� �-�', '����������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 284,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 292;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 293, 285, '��������������� �-�', '��������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 285,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 293;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 294, 286, '����������������� �-�', '���������������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 286,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 294;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 295, 287, '��������-���������� �-�', '��������-��������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 287,
           AREA_NAME = '��������-���������� �-�',
           AREA_NAME_RU = '��������-��������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 295;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 296, 288, '���������������� �-�', '���������������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 288,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 296;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 297, 289, '����������������� �-�', '���������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 289,
           AREA_NAME = '����������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 297;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 298, 290, '��������������� �-�', '�������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 290,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 298;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 299, 291, '������������ �-�', '������������ �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 291,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 299;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 300, 292, '�������������� �-�', '������������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 292,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 300;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 301, 293, '��������������� �-�', '�������������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 293,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 301;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 302, 294, '������������� �-�', '������������ �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 294,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 302;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 303, 295, '������������ �-�', '������������ �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 295,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 303;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 304, 296, '�������������� �-�', '�������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 296,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 304;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 305, 297, '������������ �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 297,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 305;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 306, 298, '��������� �-�', '��������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 298,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 306;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 307, 299, '����������� �-�', '���������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 299,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 307;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 308, 300, '������������� �-�', '�������������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 300,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 308;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 309, 301, '��������� �-�', '��������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 301,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 309;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 310, 302, '��������� �-�', '�������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 302,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 310;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 311, 303, '��������������� �-�', '��������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 303,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 311;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 312, 303, '��������������� �-�', '��������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 303,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 312;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 313, 304, '��������������� �-�', '��������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 304,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 313;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 314, 305, '����������� �-�', '������������ �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 305,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 314;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 315, 306, '���������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 306,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 315;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 316, 307, '��������� �-�', '�������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 307,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 316;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 317, 308, '���������� �-�', '���������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 308,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 317;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 318, 309, '���������� �-�', '���������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 309,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 318;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 319, 310, '���������� �-�', '��������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 310,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 319;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 320, 311, '���������� �-�', '���������� �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 311,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 320;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 321, 312, 'ϒ����������� �-�', '����������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 312,
           AREA_NAME = 'ϒ����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 321;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 322, 313, '�������������� �-�', '������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 313,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 322;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 323, 314, '������������� �-�', '������������ �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 314,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 323;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 324, 314, '������������� �-�', '������������ �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 314,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 324;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 325, 314, '������������� �-�', '������������ �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 314,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 325;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 326, 315, '������������� �-�', '������������ �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 315,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 326;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 327, 316, '��������������� �-�', '�������������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 316,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 327;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 328, 317, '������������ �-�', '����������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 317,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 328;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 329, 318, '���������-������������ �-�', '���������-����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 318,
           AREA_NAME = '���������-������������ �-�',
           AREA_NAME_RU = '���������-����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 329;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 330, 319, '�������������� �-�', '������������ �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 319,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 330;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 331, 320, '������������ �-�', '������������ �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 320,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 331;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 332, 321, '���������� �-�', '���������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 321,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 332;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 333, 322, '��������������� �-�', '��������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 322,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 333;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 334, 323, '���������� �-�', '����������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 323,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 334;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 335, 324, '������������ �-�', '����������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 324,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 335;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 336, 325, 'ϳ������������ �-�', '������������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 325,
           AREA_NAME = 'ϳ������������ �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 336;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 337, 326, 'ϳ�������� �-�', '���������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 326,
           AREA_NAME = 'ϳ�������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 337;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 338, 327, 'ϳ�������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 327,
           AREA_NAME = 'ϳ�������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 338;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 339, 328, '��������������� �-�', '�������������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 328,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 339;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 340, 329, '����������� �-�', '���������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 329,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 340;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 341, 330, '�������� �-�', '��������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 330,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 341;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 342, 331, '����������� �-�', '����������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 331,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 342;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 343, 332, '���������� �-�', '��������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 332,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 343;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 344, 333, '����������� �-�', '���������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 333,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 344;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 345, 334, '������������� �-�', '������������ �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 334,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 345;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 346, 335, '������������� �-�', '������������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 335,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 346;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 347, 336, '������������ �-�', '����������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 336,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 347;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 348, 337, '���������� �-�', '���������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 337,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 348;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 349, 338, '����������� �-�', '���������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 338,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 349;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 350, 339, '�������������� �-�', '�������������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 339,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 350;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 351, 340, '������������ �-�', '����������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 340,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 351;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 352, 341, '����������� �-�', '���������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 341,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 352;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 353, 342, '������������ �-�', '����������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 342,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 353;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 354, 343, '������������� �-�', '������������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 343,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 354;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 355, 344, '�������������� �-�', '������������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 344,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 355;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 356, 345, '���������� �-�', '���������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 345,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 356;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 357, 346, '���������� �-�', '��������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 346,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 357;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 358, 347, '��������� �-�', '��������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 347,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 358;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 359, 348, '������������� �-�', '������������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 348,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 359;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 360, 349, 'г��������� �-�', '��������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 349,
           AREA_NAME = 'г��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 360;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 361, 350, 'г��������� �-�', '���������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 350,
           AREA_NAME = 'г��������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 361;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 362, 351, '������������ �-�', '����������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 351,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 362;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 363, 352, '������������ �-�', '����������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 352,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 363;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 364, 353, '������������ �-�', '������������ �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 353,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 364;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 365, 354, '�������������� �-�', '�������������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 354,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 365;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 366, 355, '��������������� �-�', '�������������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 355,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 366;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 367, 356, '��������� �-�', '��������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 356,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 367;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 368, 357, '������������ �-�', '������������ �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 357,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 368;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 369, 358, '������������� �-�', '������������ �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 358,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 369;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 370, 359, '����������� �-�', '����������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 359,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 370;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 371, 360, '���������� �-�', '��������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 360,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 371;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 372, 361, '���������� �-�', '��������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 361,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 372;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 373, 362, '����������� �-�', '���������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 362,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 373;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 374, 363, '�������� �-�', '������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 363,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 374;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 375, 364, '���������� �-�', '���������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 364,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 375;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 376, 365, '���������� �-�', '��������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 365,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 376;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 377, 366, '����������� �-�', '���������� �-�', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 366,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 377;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 378, 367, '�������������� �-�', '������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 367,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 378;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 379, 368, '����������� �-�', '���������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 368,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 379;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 380, 369, '���������� �-�', '���������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 369,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 380;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 381, 370, '������������� �-�', '������������ �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 370,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 381;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 382, 371, '������������� �-�', '������������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 371,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 382;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 383, 372, '����������� �-�', '����������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 372,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 383;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 384, 372, '����������� �-�', '����������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 372,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 384;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 385, 373, '��������-�������� �-�', '��������-������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 373,
           AREA_NAME = '��������-�������� �-�',
           AREA_NAME_RU = '��������-������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 385;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 386, 374, '��������������� �-�', '��������������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 374,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 386;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 387, 375, 'ѳ�������������� �-�', '��������������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 375,
           AREA_NAME = 'ѳ�������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 387;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 388, 376, '����������� �-�', '���������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 376,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 388;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 389, 377, '���������� �-�', '��������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 377,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 389;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 390, 378, '���������� �-�', '���������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 378,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 390;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 391, 379, '����������� �-�', '���������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 379,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 391;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 392, 380, '���������������� �-�', '��������������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 380,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 392;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 393, 381, '����������� �-�', '���������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 381,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 393;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 394, 382, '���������� �-�', '���������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 382,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 394;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 395, 383, '����������� �-�', '������������ �-�', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 383,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 395;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 396, 384, '����������� �-�', '���������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 384,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 396;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 397, 385, '��������� �-�', '��������� �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 385,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 397;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 398, 386, '����������� �-�', '���������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 386,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 398;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 399, 387, '������������ �-�', '����������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 387,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 399;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 400, 388, '������������ �-�', '����������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 388,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 400;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 401, 389, '���������� �-�', '��������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 389,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 401;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 402, 390, '����������� �-�', '���������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 390,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 402;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 403, 391, '����������� �-�', '����������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 391,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 403;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 404, 392, '������������� �-�', '������������ �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 392,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 404;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 405, 393, '��������-���������� �-�', '��������-��������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 393,
           AREA_NAME = '��������-���������� �-�',
           AREA_NAME_RU = '��������-��������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 405;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 406, 394, '��������������� �-�', '�������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 394,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 406;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 407, 395, '������������� �-�', '������������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 395,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 407;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 408, 396, '�������������� �-�', '�������������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 396,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 408;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 409, 397, '�������������������� �-�', '��������������������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 397,
           AREA_NAME = '�������������������� �-�',
           AREA_NAME_RU = '��������������������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 409;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 410, 398, '��������������� �-�', '��������������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 398,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '��������������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 410;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 411, 399, '��������������� �-�', '�������������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 399,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 411;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 412, 400, '�������������� �-�', '������������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 400,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 412;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 413, 401, '���������� �-�', '��������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 401,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 413;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 414, 402, '�������� �-�', '������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 402,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 414;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 415, 403, '������������ �-�', '������������ �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 403,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 415;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 416, 404, '����������� �-�', '����������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 404,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 416;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 417, 405, '������������ �-�', '����������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 405,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 417;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 418, 406, '������������ �-�', '����������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 406,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 418;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 419, 407, '��������������� �-�', '�������������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 407,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 419;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 420, 408, '������������� �-�', '������������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 408,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 420;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 421, 409, '�������������� �-�', '������������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 409,
           AREA_NAME = '�������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 421;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 422, 410, '���������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 410,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 422;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 423, 411, '��������������� �-�', '�������������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 411,
           AREA_NAME = '��������������� �-�',
           AREA_NAME_RU = '�������������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 423;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 424, 412, '������������� �-�', '������������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 412,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 424;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 425, 413, '��������� �-�', '���������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 413,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 425;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 426, 414, '���������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 414,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 426;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 427, 415, '������������ �-�', '����������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 415,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 427;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 428, 416, '���������� �-�', '���������� �-�', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 416,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 428;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 429, 417, '���������� �-�', '���������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 417,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 429;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 430, 418, '����������� �-�', '����������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 418,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 430;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 431, 419, '������������� �-�', '������������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 419,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 431;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 432, 420, '�������� �-�', '�������� �-�', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 420,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 432;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 433, 421, '������������� �-�', '������������ �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 421,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 433;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 434, 421, '������������� �-�', '������������ �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 421,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 434;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 435, 422, '������������ �-�', '����������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 422,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 435;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 436, 423, '��������� �-�', '��������� �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 423,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 436;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 437, 424, '���������� �-�', '���������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 424,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 437;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 438, 425, '���������� �-�', '��������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 425,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 438;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 439, 426, '������������ �-�', '����������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 426,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 439;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 440, 427, '������������ �-�', '����������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 427,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 440;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 441, 428, '��������� �-�', '�������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 428,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 441;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 442, 429, '����������� �-�', '����������� �-�', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 429,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 442;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 443, 430, '���������� �-�', '���������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 430,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 443;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 444, 431, '����������� �-�', '����������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 431,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 444;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 445, 432, '���������� �-�', '����������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 432,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 445;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 446, 433, '������������ �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 433,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 446;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 447, 434, '����������� �-�', '����������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 434,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 447;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 448, 435, '����������� �-�', '���������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 435,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 448;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 449, 436, '���������� �-�', '��������� �-�', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 436,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 449;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 450, 437, '������������� �-�', '������������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 437,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 450;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 451, 438, '��������� �-�', '�������� �-�', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 438,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 451;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 452, 439, '������������ �-�', '����������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 439,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 452;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 453, 440, '������������ �-�', '����������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 440,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 453;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 454, 441, '����������� �-�', '���������� �-�', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 441,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 454;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 455, 442, '������������� �-�', '������������ �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 442,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 455;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 456, 443, '���������������� �-�', '���������������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 443,
           AREA_NAME = '���������������� �-�',
           AREA_NAME_RU = '���������������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 456;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 457, 444, '���������� �-�', '���������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 444,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 457;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 458, 445, '����������� �-�', '����������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 445,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 458;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 459, 446, '����������� �-�', '������������ �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 446,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 459;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 460, 446, '����������� �-�', '������������ �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 446,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 460;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 461, 447, '������������� �-�', '������������ �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 447,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 461;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 462, 448, '������������� �-�', '������������ �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 448,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 462;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 463, 449, '������������ �-�', '����������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 449,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 463;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 464, 450, '������������� �-�', '������������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 450,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 464;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 465, 451, '������������� �-�', '������������ �-�', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 451,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 465;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 466, 452, '������������� �-�', '������������ �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 452,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 466;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 467, 453, '����������� �-�', '����������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 453,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 467;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 468, 454, '���������� �-�', '���������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 454,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 468;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 469, 455, '���������� �-�', '���������� �-�', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 455,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 469;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 470, 456, '��������� �-�', '��������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 456,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 470;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 471, 457, '������������� �-�', '������������ �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 457,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 471;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 472, 458, '����������� �-�', '���������� �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 458,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 472;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 473, 459, '������� �-�', '������ �-�', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 459,
           AREA_NAME = '������� �-�',
           AREA_NAME_RU = '������ �-�',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 473;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 474, 460, '������������� �-�', '������������� �-�', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 460,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������� �-�',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 474;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 475, 461, '����������� �-�', '����������� �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 461,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 475;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 476, 462, '����������� �-�', '����������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 462,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 476;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 477, 463, '����������� �-�', '���������� �-�', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 463,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 477;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 478, 464, '��������� �-�', '�������� �-�', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 464,
           AREA_NAME = '��������� �-�',
           AREA_NAME_RU = '�������� �-�',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 478;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 479, 465, '������������ �-�', '����������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 465,
           AREA_NAME = '������������ �-�',
           AREA_NAME_RU = '����������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 479;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 480, 466, '����������� �-�', '���������� �-�', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 466,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 480;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 481, 467, '�������� �-�', '������� �-�', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 467,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '������� �-�',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 481;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 482, 468, '�������� �-�', '������� �-�', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 468,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '������� �-�',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 482;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 483, 469, '�������� �-�', '��������� �-�', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 469,
           AREA_NAME = '�������� �-�',
           AREA_NAME_RU = '��������� �-�',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 483;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 484, 470, '���������� �-�', '���������� �-�', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 470,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 484;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 485, 471, '����������� �-�', '���������� �-�', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 471,
           AREA_NAME = '����������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 485;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 486, 472, '���������� �-�', '���������� �-�', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 472,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 486;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 487, 473, '���������� �-�', '���������� �-�', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 473,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 487;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 488, 473, '���������� �-�', '���������� �-�', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 473,
           AREA_NAME = '���������� �-�',
           AREA_NAME_RU = '���������� �-�',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 488;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 489, 474, '������������� �-�', '������������ �-�', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 474,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 489;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 490, 475, '������������� �-�', '������������ �-�', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 475,
           AREA_NAME = '������������� �-�',
           AREA_NAME_RU = '������������ �-�',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 490;
end;
/


commit;
