begin    execute immediate ' CREATE TABLE BARS.TMP_XOZ16( isp int, nd number NOT NULL,  S  NUMBER ) ';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;

/

begin    execute immediate ' alter TABLE BARS.TMP_XOZ16 add (NPP int ) ' ;
exception when others then   if SQLCODE = - 01430  then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/

COMMENT ON TABLE  BARS.TMP_XOZ16     IS '��������� ���� ��� ���������� ��� ��� �������� �� ����-16 ';

COMMENT ON COLUMN BARS.TMP_XOZ16.nd  IS '�������� ���';
COMMENT ON COLUMN BARS.TMP_XOZ16.S   IS '����-���� ';
COMMENT ON COLUMN BARS.TMP_XOZ16.ISP IS '����������';
/*.
1.1)�Ѳ.�������� ������:4600/**=>3615/04*����.������
1.2)�Ѳ.�������� ������:4600/**=>3519/26*�����.������
1.3)�Ѳ.�������� ������:4600/**=>3500/04*������� ����
2.1)�Ѳ.����������� ������ �� �����:7028/01=>3618/01
3.1)�Ѳ.�������� ���� �� ��� ������.:3615/04=>3519/26
3.2)�Ѳ.�������� ���.������ �� ��� ������.:3618/01=>3519/26
3.3)�Ѳ.�������� ��� ������. � ���: 7410*09 => 3519/26
*/

GRANT  SELECT on BARS.tmp_XOZ16 TO BARS_ACCESS_DEFROLE;

begin    execute immediate '  ALTER TABLE BARS.TMP_XOZ16 ADD (  CONSTRAINT PK_tmpxoz16  PRIMARY KEY  (nd)) ';
exception when others then   if SQLCODE = - 02260 then null;   else raise; end if; --ORA-02260: table can have only one primary key
end;
/

