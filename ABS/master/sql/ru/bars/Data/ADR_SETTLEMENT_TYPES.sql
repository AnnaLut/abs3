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
    ( 1, '����', '�����','�.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '����',
           SETTLEMENT_TP_NM_RU = '�����',
		   SETTLEMENT_TP_CODE='�.'
     where SETTLEMENT_TP_ID = 1;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 2, '���', '���' ,'���.');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '���',
           SETTLEMENT_TP_NM_RU = '���',
		   SETTLEMENT_TP_CODE='���.'
     where SETTLEMENT_TP_ID = 2;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 3, '������', '�������' ,'���.');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '������',
           SETTLEMENT_TP_NM_RU = '�������',
		   SETTLEMENT_TP_CODE='���.'
     where SETTLEMENT_TP_ID = 3;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 4, '����', '����','�.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '����',
           SETTLEMENT_TP_NM_RU = '����',
		   SETTLEMENT_TP_CODE='�.'
     where SETTLEMENT_TP_ID = 4;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 5, '����', '�����','����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '����',
           SETTLEMENT_TP_NM_RU = '�����',
		   SETTLEMENT_TP_CODE='����'
     where SETTLEMENT_TP_ID = 5;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 6, '��.', '��.','��.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '��.',
           SETTLEMENT_TP_NM_RU = '��.',
		   SETTLEMENT_TP_CODE='��.'
     where SETTLEMENT_TP_ID = 6;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 7, '�����.', '�����.' ,'�����.');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '�����.',
           SETTLEMENT_TP_NM_RU = '�����.',
		   SETTLEMENT_TP_CODE='�����.'
     where SETTLEMENT_TP_ID = 7;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 8, '�������', '������','�������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '�������',
           SETTLEMENT_TP_NM_RU = '������',
		  SETTLEMENT_TP_CODE='�������'
     where SETTLEMENT_TP_ID = 8;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 9, '������', '������','������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '������',
           SETTLEMENT_TP_NM_RU = '������',
		   SETTLEMENT_TP_CODE='������'
     where SETTLEMENT_TP_ID = 9;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 10, '��������', '�����������' ,'��������');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '��������',
           SETTLEMENT_TP_NM_RU = '�����������',
		   SETTLEMENT_TP_CODE='��������'
     where SETTLEMENT_TP_ID = 10;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 11, '���', '���','���' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '���',
           SETTLEMENT_TP_NM_RU = '���',
		   SETTLEMENT_TP_CODE='���'
     where SETTLEMENT_TP_ID = 11;
end;
/

begin
  Insert into BARS.ADR_SETTLEMENT_TYPES
    ( SETTLEMENT_TP_ID,SETTLEMENT_TP_NM,SETTLEMENT_TP_NM_RU ,SETTLEMENT_TP_CODE)
  Values
    ( 12, '���������', '���������' ,'���������');
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_SETTLEMENT_TYPES
       set SETTLEMENT_TP_NM = '���������',
           SETTLEMENT_TP_NM_RU = '���������',
		   SETTLEMENT_TP_CODE='���������'
     where SETTLEMENT_TP_ID = 12;
end;
/
commit;
