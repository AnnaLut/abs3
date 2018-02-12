-- ======================================================================================
-- Module :
-- Author : BAA
-- Date   :
-- ===================================== <Comments> =====================================
-- Script for insert or update table "ADR_REGIONS"
-- ======================================================================================
SET FEEDBACK     OFF

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 1, '³������� ���.', '��������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '³������� ���.',
           REGION_NAME_RU = '��������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 1;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 2, '��������� ���.', '��������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '��������� ���.',
           REGION_NAME_RU = '��������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 2;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 3, '��������������� ���.', '���������������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '��������������� ���.',
           REGION_NAME_RU = '���������������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 3;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 4, '�������� ���.', '�������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '�������� ���.',
           REGION_NAME_RU = '�������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 4;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 5, '����������� ���.', '����������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '����������� ���.',
           REGION_NAME_RU = '����������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 5;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 6, '������������ ���.', '������������ ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '������������ ���.',
           REGION_NAME_RU = '������������ ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 6;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 7, '��������� ���.', '����������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '��������� ���.',
           REGION_NAME_RU = '����������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 7;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 8, '�����-���������� ���.', '�����-����������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '�����-���������� ���.',
           REGION_NAME_RU = '�����-����������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 8;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 9, '���', '����', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '���',
           REGION_NAME_RU = '����',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 9;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 10, '������� ���.', '�������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '������� ���.',
           REGION_NAME_RU = '�������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 10;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 11, 'ʳ������������ ���.', '�������������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'ʳ������������ ���.',
           REGION_NAME_RU = '�������������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 11;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 12, '����', '����', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '����',
           REGION_NAME_RU = '����',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 12;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 13, '��������� ���.', '��������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '��������� ���.',
           REGION_NAME_RU = '��������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 13;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 14, '�������� ���.', '��������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '�������� ���.',
           REGION_NAME_RU = '��������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 14;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 15, '����������� ���.', '������������ ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '����������� ���.',
           REGION_NAME_RU = '������������ ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 15;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 16, '������� ���.', '�������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '������� ���.',
           REGION_NAME_RU = '�������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 16;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 17, '���������� ���.', '���������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '���������� ���.',
           REGION_NAME_RU = '���������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 17;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 18, 'г�������� ���.', '��������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'г�������� ���.',
           REGION_NAME_RU = '��������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 18;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 19, '�����������', '�����������', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '�����������',
           REGION_NAME_RU = '�����������',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 19;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 20, '������� ���.', '������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '������� ���.',
           REGION_NAME_RU = '������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 20;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 21, '������������ ���.', '������������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '������������ ���.',
           REGION_NAME_RU = '������������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 21;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 22, '��������� ���.', '����������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '��������� ���.',
           REGION_NAME_RU = '����������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 22;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 23, '���������� ���.', '���������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '���������� ���.',
           REGION_NAME_RU = '���������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 23;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 24, '����������� ���.', '����������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '����������� ���.',
           REGION_NAME_RU = '����������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 24;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 25, '��������� ���.', '���������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '��������� ���.',
           REGION_NAME_RU = '���������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 25;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 26, '���������� ���.', '����������� ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '���������� ���.',
           REGION_NAME_RU = '����������� ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 26;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 27, '���������� ���.', '������������ ���.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = '���������� ���.',
           REGION_NAME_RU = '������������ ���.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 27;
end;
/


commit;
