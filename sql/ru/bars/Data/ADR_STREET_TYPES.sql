-- ======================================================================================
-- Module :
-- Author : BAA
-- Date   :
-- ===================================== <Comments> =====================================
-- Script for insert or update table "ADR_STREET_TYPES"
-- ======================================================================================
SET FEEDBACK     OFF

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 1, '����', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 1;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 2, '���.', '���.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '���.',
           STR_TP_NM_RU = '���.'
     where STR_TP_ID = 2;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 3, 'Ⓙ��', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'Ⓙ��',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 3;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 4, '���.', '��.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '���.',
           STR_TP_NM_RU = '��.'
     where STR_TP_ID = 4;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 5, '���', '����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '���',
           STR_TP_NM_RU = '����'
     where STR_TP_ID = 5;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 6, '������', '������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '������',
           STR_TP_NM_RU = '������'
     where STR_TP_ID = 6;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 7, '�/�', '�/�' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�/�',
           STR_TP_NM_RU = '�/�'
     where STR_TP_ID = 7;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 9, '��.', '��.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '��.',
           STR_TP_NM_RU = '��.'
     where STR_TP_ID = 9;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 10, '���', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '���',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 10;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 11, '����.', '��.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����.',
           STR_TP_NM_RU = '��.'
     where STR_TP_ID = 11;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 12, '���.', '����.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '���.',
           STR_TP_NM_RU = '����.'
     where STR_TP_ID = 12;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 13, '���.', '���.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '���.',
           STR_TP_NM_RU = '���.'
     where STR_TP_ID = 13;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 15, '����.', '����.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����.',
           STR_TP_NM_RU = '����.'
     where STR_TP_ID = 15;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 16, '����.', '����.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����.',
           STR_TP_NM_RU = '����.'
     where STR_TP_ID = 16;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 17, '����', '����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����',
           STR_TP_NM_RU = '����'
     where STR_TP_ID = 17;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 18, '���.', '���.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '���.',
           STR_TP_NM_RU = '���.'
     where STR_TP_ID = 18;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 19, '��.', '��.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '��.',
           STR_TP_NM_RU = '��.'
     where STR_TP_ID = 19;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 20, '����.', '���.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����.',
           STR_TP_NM_RU = '���.'
     where STR_TP_ID = 20;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 21, '�����', '������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�����',
           STR_TP_NM_RU = '������'
     where STR_TP_ID = 21;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 22, '�����.', '�����.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�����.',
           STR_TP_NM_RU = '�����.'
     where STR_TP_ID = 22;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 23, '������', '������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '������',
           STR_TP_NM_RU = '������'
     where STR_TP_ID = 23;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 24, '����.', '����.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����.',
           STR_TP_NM_RU = '����.'
     where STR_TP_ID = 24;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 25, '��璿��', '�������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '��璿��',
           STR_TP_NM_RU = '�������'
     where STR_TP_ID = 25;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 26, '��������', '��������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '��������',
           STR_TP_NM_RU = '��������'
     where STR_TP_ID = 26;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 27, '�����.', '�����.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�����.',
           STR_TP_NM_RU = '�����.'
     where STR_TP_ID = 27;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 28, '������', '�������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '������',
           STR_TP_NM_RU = '�������'
     where STR_TP_ID = 28;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 29, '�����', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�����',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 29;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 30, '��.', '��.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '��.',
           STR_TP_NM_RU = '��.'
     where STR_TP_ID = 30;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 32, '�����', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�����',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 32;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 33, '�����', '������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�����',
           STR_TP_NM_RU = '������'
     where STR_TP_ID = 33;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 34, '�����', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�����',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 34;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 35, '����', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 35;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 36, '�������', '�������' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�������',
           STR_TP_NM_RU = '�������'
     where STR_TP_ID = 36;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 37, '��.', '��.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '��.',
           STR_TP_NM_RU = '��.'
     where STR_TP_ID = 37;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 38, '����', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 38;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 39, '�����', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '�����',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 39;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 40, '����', '����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����',
           STR_TP_NM_RU = '����'
     where STR_TP_ID = 40;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 41, '����', '�����' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = '����',
           STR_TP_NM_RU = '�����'
     where STR_TP_ID = 41;
end;
/


commit;
