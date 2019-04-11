begin    execute immediate 
' CREATE TABLE BARS.TMP_XOZ16_XLS ( KF varchar2(6), dat01 date, cc_ID varchar2 (50), sdate date, nls_3519 varchar2(14),   RNKX number, RNKA number, nd  number,
s11 number,s12 number,
s21 number,s22 number,
s31 number,s32 number, s33 number) ';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

begin    execute immediate ' alter TABLE BARS.TMP_XOZ16_XLS add (NPP int, PROD varchar2(6) ) ' ;
exception when others then   if SQLCODE = - 01430  then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/

begin    execute immediate ' alter TABLE BARS.TMP_XOZ16_XLS add (NLS_3519_OLD varchar2(14) ) ' ;
exception when others then   if SQLCODE = - 01430  then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/

COMMENT ON TABLE  BARS.TMP_XOZ16_XLS          IS '�������� XLS-���� ��� ���������� ��� ��� �������� �� ����-16 ';
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.KF       IS 'MFO ��' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.DAT01    IS '�����~����   ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.CC_ID    IS '�����~��������~B' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.SDATE    IS '����~��������~C' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.NLS_3519 IS '�������~3519*26~G' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.NPP      IS '� ������ � XLS' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.RNKA     IS '���(���)~�볺���' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.ND       IS '���.���~� ���' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.PROD     IS '4600.**' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.s11  IS '1.1)�Ѳ.�������� ������:4600/**=>3615/04*����.������       ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S12  IS '1.2)�Ѳ.�������� ������:4600/**=>3519/26*�����.������      ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S21  IS '2.1)�Ѳ.����������� ������ �� �����:7028/01=>3618/01      ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S22  IS '2.2)�Ѳ.���������� ������ �� �����:3615=>4600      ' ;

COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.s31  IS '3.1)�Ѳ.�������� ���� �� ��� ������.:3615/04=>3519/26      ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S32  IS '3.2)�Ѳ.�������� ���.������ �� ��� ������.:3618/01=>3519/26' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.s33  IS '3.3)�Ѳ.�������� ��� ������. � ���: 7410*09 => 3519/26     ' ;

GRANT  SELECT on BARS.tmp_XOZ16_XLS TO BARS_ACCESS_DEFROLE;
