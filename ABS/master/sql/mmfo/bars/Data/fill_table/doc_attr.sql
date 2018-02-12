PROMPT =====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/doc_attr_cust.sql ==========*** Run ***
PROMPT =====================================================================================

Begin
  INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL)
  VALUES ('CUST_FMPOS','������ ��: �������� ���� �����.� ��-�� ������. �� ����. ���.����.��� ������. ����.','',
  'select nvl(trim(substr(f_get_custw_h(:ND,''FMPOS'',f_get_cust_fmdat(:ADDS)),1,2000)),''�i����i��'') from dual');
exception
  when dup_val_on_index then
    null;
end;
/

COMMIT;

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_NLS', '����� ��������������� �������'
         , 'select SubStr(a.NLS,1,14) into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select SubStr(a.NLS,1,14) into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:ND'
         , NAME = '����� ��������������� �������'
     where ID   = 'RSRV_ACC_NLS';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_KV', '������ ��������������� �������'
         , 'select t.NAME into :sValue from ACCOUNTS_RSRV a, TABVAL$GLOBAL t where a.RSRV_ID=:ND and t.KV=a.KV' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select t.NAME into :sValue from ACCOUNTS_RSRV a, TABVAL$GLOBAL t where a.RSRV_ID=:ND and t.KV=a.KV'
         , NAME = '������ ��������������� �������'
     where ID   = 'RSRV_ACC_KV';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_NBS', '����� ���. ���. ��������������� �������'
         , 'select SubStr(a.NLS,1,4) into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select SubStr(a.NLS,1,4) into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:ND'
         , NAME = '����� ���. ���. ��������������� �������'
     where ID   = 'RSRV_ACC_NBS';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_OPN_DT', '���� �i������� ��������������� ������� (�������)'
         , 'select to_char(a.CRT_DT,''DD/MM/YYYY'') into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:nd' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select to_char(a.CRT_DT,''DD/MM/YYYY'') into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:nd'
         , NAME = '���� �i������� ��������������� �������'
     where ID   = 'RSRV_ACC_OPN_DT';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_VID_NM', '��� ��������������� �������'
         , 'select Substr(v.NAME,1,16) into :sValue from VIDS v where v.VID=3' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select Substr(v.NAME,1,16) into :sValue from VIDS v where v.VID=3'
         , NAME = '��� ��������������� �������'
     where ID   = 'RSRV_ACC_VID_NM';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_CODE', '���� �������� ��������������� �������'
         , 'select c.OKPO into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RNK=c.RNK AND a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select c.OKPO into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RNK=c.RNK AND a.RSRV_ID=:ND'
         , NAME = '���� �������� ��������������� �������'
     where ID   = 'RSRV_CST_CODE';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_NM', '����� �������� ��������������� �������'
         , 'select c.NMK into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RNK=c.RNK AND a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select c.NMK into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RNK=c.RNK AND a.RSRV_ID=:ND'
         , NAME = '����� �������� ��������������� �������'
     where ID   = 'RSRV_CST_NM';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_VED', '��� ��������� �������� ��i����'
         , 'select Substr(c.VED,1,5) into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RSRV_ID=:ND and a.RNK=c.RNK' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select Substr(c.VED,1,5) into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RSRV_ID=:ND and a.RNK=c.RNK'
         , NAME = '��� ��������� �������� ��i����'
     where ID   = 'RSRV_CST_VED';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_VED_NM', '����� ��������� �������� ��i����'
         , 'select SubStr(trim(v.NAME),1,144) into :sValue from ACCOUNTS_RSRV a, CUSTOMER c, VED v where a.RSRV_ID=:ND and a.RNK=c.RNK and c.VED=v.VED' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select SubStr(trim(v.NAME),1,144) into :sValue from ACCOUNTS_RSRV a, CUSTOMER c, VED v where a.RSRV_ID=:ND and a.RNK=c.RNK and c.VED=v.VED'
         , NAME = '����� ��������� �������� ��i����'
     where ID   = 'RSRV_CST_VED_NM';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_DBO_AGRM_NUM', '����� ��� ��i����'
         , 'select w.VALUE into :sValue from CUSTOMERW w, ACCOUNTS_RSRV a where a.RSRV_ID=:ND and w.RNK=a.RNK and w.TAG=''NDBO''' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select w.VALUE into :sValue from CUSTOMERW w, ACCOUNTS_RSRV a where a.RSRV_ID=:ND and w.RNK=a.RNK and w.TAG=''NDBO'''
         , NAME = '����� ��� ��i����'
     where ID   = 'RSRV_CST_DBO_AGRM_NUM';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_DBO_AGRM_DT', '���� ��� ��i����'
         , 'select F_DAT_LIT(to_date(w.VALUE,''dd.mm.yyyy'')) into :sValue from CUSTOMERW w, ACCOUNTS_RSRV a where a.RSRV_ID=:ND and w.RNK=a.RNK and w.TAG=''DDBO''' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select F_DAT_LIT(to_date(w.VALUE,''dd.mm.yyyy'')) into :sValue from CUSTOMERW w, ACCOUNTS_RSRV a where a.RSRV_ID=:ND and w.RNK=a.RNK and w.TAG=''DDBO'''
         , NAME = '���� ��� ��i����'
     where ID   = 'RSRV_CST_DBO_AGRM_DT';
end;
/

COMMIT;
