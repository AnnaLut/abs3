
begin 
  execute immediate 'ALTER TABLE BARS.REZ_DEB DROP PRIMARY KEY CASCADE';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/


begin 
  execute immediate 'DROP TABLE BARS.REZ_DEB CASCADE CONSTRAINTS';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/

begin

  if getglobaloption('HAVETOBO') = 2 then   

     execute immediate 'begin bpa.alter_policy_info(''REZ_DEB'', ''WHOLE'' , null , null, null, null ); end;'; 
     execute immediate 'begin bpa.alter_policy_info(''REZ_DEB'', ''FILIAL'', null , null, null, null ); end;';

     EXECUTE IMMEDIATE 'create table BARS.REZ_DEB'||
      '(nbs     varchar2(4),
        deb     integer,
        pr      integer,
        pr2     INTEGER,  
        txt     varchar2(200)
        )';

  end if;

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/

begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''REZ_DEB''); end;'; 
   end if;
end;
/
commit;
-------------------------------------------------------------
COMMENT ON TABLE  BARS.REZ_DEB         IS '��������� ����� 351';
COMMENT ON COLUMN BARS.REZ_DEB.nbs     IS '���.���.';
COMMENT ON COLUMN BARS.REZ_DEB.deb     IS '��� ��������';

begin
 execute immediate   'alter table REZ_DEB add (tipa  INTEGER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_DEB.tipa  IS '��� ������ (�� REZ_TIPA)';

begin
 execute immediate   'alter table REZ_DEB add (tipa_FV INTEGER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_DEB.tipa_FV  IS '��� ������ ��� ������� �� FV';

begin
  EXECUTE IMMEDIATE 
 'ALTER TABLE REZ_DEB ADD (CONSTRAINT PK_REZ_DEB PRIMARY KEY (NBS))';
exception when others then
  -- ORA-02260: table can have only one primary key
  if SQLCODE = -02260 then null;   else raise; end if; 
end;
/

begin
   execute immediate 'CREATE INDEX I1_REZ_DEB ON REZ_DEB (nbs,deb)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_DEB', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null); 
exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_DEB', p_policy_group => 'FILIAL', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');   
exec bars_policy_adm.alter_policies(p_table_name => 'REZ_DEB');

GRANT SELECT ON BARS.REZ_DEB TO RCC_DEAL;
GRANT SELECT ON BARS.REZ_DEB TO START1;
GRANT SELECT ON BARS.REZ_DEB TO BARS_ACCESS_DEFROLE;

COMMIT;

Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('1200', '����������������� ������� ����� � ������������� ����� ������', 12, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('1203', '����� ����''������� ������i� ����� � ���i��������� ����� ������', 12, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('1207', '��������������� ������� ����� � ������������� ����� ������', 12, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('1208', '��������� ������ �� ������� �� ������ � ������������� ����� ������', 12, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('1211', '�����, �� ����� ������������� ����� ������ �� ���������� ����', 12, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('1212', '�������������� ������ (��������) � ������������� ����� ������', 12, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT, TIPA, 
    TIPA_FV)
 Values
   ('1218', 1, 14, '��������� ������ �� ���������� �������� (����������) � ������������� ����� ������', 12, 
    3);
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1400', 14, '�������� ��������� �������� ������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1401', 14, '�������� �������� �������� ������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1402', 14, '������ �i��i ������ �����i� �������� ����� �� �������� ��������������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1403', 14, '������ �i��i ������, ������� ������� �� ������������� ����������� ����������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1404', 14, '������ �i��i ������ ������������ ���������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1405', 14, '���������� �������� �i���� ������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1406', 14, '��������������� ������� �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1407', 14, '�������������� ����� �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1408', 1, 14, '��������� ������ �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � ��������� �������i �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1410', 14, '�������� ��������� �������� ������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1411', 14, '�������� �������� �������� ������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1412', 14, '������ �i��i ������ �����i� �������� ����� �� �������� ��������������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1413', 14, '������ �i��i ������, ������� ������� �� ������������� ����������� ����������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1414', 14, '������ �i��i ������ ������������ ���������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1415', 14, '���������� �������� �i���� ������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1416', 14, '��������������� ������� �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1417', 14, '�������������� ����� �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1418', 1, 14, '��������� ������ �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1419', 2, 14, '���������� ��������� ������ �� ��������� �i����� ��������,�� �������������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1420', 14, '�������� ��������� �������� ������, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1421', 14, '�������� �������� �������� ������, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1422', 14, '������ �i��i ������ �����i� �������� ����� �� �������� ��������������, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1423', 14, '������ �i��i ������, ������� ������� �� ������������� ����������� ����������, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1424', 14, '������ �i��i ������ ������������ ���������, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1426', 14, '��������������� ������� �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1427', 14, '�������������� ����� �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1428', 1, 14, '��������� ������ �� ��������� �i����� ��������, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1429', 2, 14, '���������� ��������� ������ �� ��������� �i����� ��������,�� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1430', 14, '������ �i��i ������, ��i�����i ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1435', 14, '���������� �������� �i���� ������, ��i������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1436', 14, '��������������� ������� �� ��������� �i����� ��������, ��i�������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1437', 14, '�������������� ����i� �� ��������� �i����� ��������, ��i�������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1438', 1, 14, '���������i ������ �� ��������� �i����� ��������, ��i�������� ������������ ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1440', 14, '������ �i��i ������, ��i�����i ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1446', 14, '��������������� ������� �� ��������� �i����� ��������, ��i�������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1447', 14, '�������������� ����i� �� ��������� �i����� ��������, ��i�������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1448', 1, 14, '���������i ������ �� ��������� �i����� ��������, ��i�������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1490', 14, '������� �i� ����i����� �������� �i���� �����i�, �� ���i���������� ���i�������� ������ ������, � �������i ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1491', 14, '������� �i� ����i����� �������� �i���� �����i�, �� �������������� ������������ ������ ������, � �������i ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1507', 1, 14, '��������� ������� �� ���������� ��������� ��������� �� ����� �����');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1508', 1, 1, '��������� ������ �� ������� �� ������ � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1509', 2, 1, '���������� ��������� ������ �� ������� �� ������ � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1510', 1, '�������� ��������, �� ������� � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1512', 1, '�������������� ������ (��������), �� ������� � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1513', 1, '������������ ������ (��������), �� ������� � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1514', 1, '������������ ������ (��������), �� ������� �� ������ ��������������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1515', 1, '�������������� ����� �� ���������� �������� (����������), �� ������� � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1516', 1, '��������������� ������� �� ���������� �������� (����������), �� ������� � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1517', 1, '����������� ������������� �� ���������� �������� (����������), �� ������� � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1518', 1, 1, '��������� ������ �� ���������� �������� (����������), �� ������� � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1519', 2, 1, '���������� ��������� ������ �� ���������� �������� (����������), �� ������� � ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1520', 1, 'Գ�������� ����� (������), �� ������� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1521', 1, '������� ��������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1522', 1, '�������, �� ����� ����� ������ �� ���������� ����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1523', 1, 'I��� �������������� �������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1524', 1, '������������ �������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1525', 1, '�������������� ����� �� ���������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1526', 1, '��������������� ������� �� ���������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('1527', 1, '����������� ������������� �� ���������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1528', 1, 1, '��������� ������ �� ���������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1529', 2, 1, '���������� ��������� ������ �� ���������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('1607', 1, 1, '��������� ������ �� ��������� ���������, �� ����� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('1811', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('1812', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('1819', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2008', 1, 2, '��������� ������ �� �����������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2018', 1, 2, '��������� ������ �� ���������, �� ����� �� ���������� ���� ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2028', 1, 2, '��������� ������ �� ���������, �� �����i �� ����������� ��������� ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2029', 2, 2, '���������� ��������� ������ �� ���������, �� �����i �� ����������� ��������� ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2038', 1, 2, '��������� ������ �� ��������, �� ������� �� ���������� ���������� i� ���''������ ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2039', 2, 2, '���������� ��������� ������ �� ��������, �� ������� �� ���������� ���������� i� ���''������ ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2048', 1, 2, '��������� ������ �� ��������� ���''����� ������������ �������� �� ��������� ������������� ����������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2049', 2, 2, '���������� ��������� ������ �� ��������� ���''����� ������������ �������� �� ��������� ������������� ����������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2058', 1, 2, '��������� ������ �� ��������� ���''����� ������������ �������� �� ���������-���������� ����������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2059', 2, 2, '���������� ��������� ������ �� ��������� ���''����� ������������ �������� �� ���������-���������� ����������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2068', 1, 2, '��������� ������ �� ��������� � ������� ��������, �� ����� ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2069', 2, 2, '���������� ��������� ������ �� ��������� � ������� ��������, �� ����� ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2078', 1, 2, '��������� ������ �� ���������� �������, �� ������� ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2079', 2, 2, '���������� ��������� ������ �� ���������� �������, �� ������� ���''����� ������������ ��������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2088', 1, 2, '���������i ������ �� i��������� ���������, �� �����i ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2089', 2, 2, '����������i ���������i ������ �� i��������� ���������, �� �����i ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2102', 4, '��������������i �������, �� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2103', 4, '������������ �������, �� ����� ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2105', 4, '�������������� ����� �� ���������, �� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2106', 4, '��������������� ������� �� ���������, �� ����� ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2107', 4, '����������� ������������� �� ���������, �� ����� ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2108', 1, 4, '��������� ������ �� ���������, �� ����� ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2109', 2, 4, '���������� ��������� ������ �� ���������, �� ����� ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2112', 4, '��������������i �������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2113', 4, '������������i �������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2115', 4, '�������������� ����� �� ���������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2116', 4, '��������������� ������� �� ���������, �� ����� ������� �������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2117', 4, '����������� ������������� �� ���������, �� ����� ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2118', 1, 4, '��������� ������ �� ���������, �� ����� ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2119', 2, 4, '���������� ��������� ������ �� ���������, �� ����� ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2122', 4, '��������������i i������i �������, �� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2123', 4, '������������i i������i �������, �� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2125', 4, '�������������� ����i� �� i��������� ���������, �� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2126', 4, '��������������� ������� �� i��������� ���������,�� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2127', 4, '����������� ����������i��� �� i��������� ���������, �� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2128', 1, 4, '��������� ������ �� i��������� ���������, �� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2129', 2, 4, '���������� ��������� ������ �� i��������� ���������, �� �����i ������� �������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2132', 4, '��������������i i������i �������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2133', 4, '������������i i������i �������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2135', 4, '�������������� ����i� �� i��������� ���������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2136', 4, '��������������� ������� �� i��������� ���������,�� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('2137', 4, '����������� ����������i��� �� i��������� ���������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2138', 1, 4, '���������i ������ �� i��������� ���������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2139', 2, 4, '����������i ���������i ������ �� i��������� ���������, �� �����i ������� �i������� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2208', 1, 3, '��������� ������ �� ��������� �� ������ �������, �� ����� �������� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2209', 2, 3, '���������� ��������� ������ �� ��������� �� ������ �������, �� ����� �������� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2218', 1, 3, '���������i ������ �� �i�������� �i������, �� ������� �i������ ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2219', 2, 3, '����������i ���������i ������ �� �i�������� �i������, �� ������� �i������ ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2228', 1, 3, '��������� ������ �� ���������, �� ����� �� ����������� ��������� �������� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2229', 2, 3, '���������� ��������� ������ �� ���������, �� ����� �� ����������� ��������� �������� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2238', 1, 3, '���������i ������ �� i��������� ���������, �� �����i �i������ ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2239', 2, 3, '����������i ���������i ������ �� i��������� ���������, �� �����i �i������ ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2607', 1, 2, '��������� ������ �� ��������� ���������, �� ����� ���''����� ��������������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2627', 1, 3, '��������� ������ �� ��������� ���������, �� ����� �������� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('2657', 1, 2, '��������� ������ �� ��������� ���������, �� ����� ������������ ���������� ���������');
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('2800', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('2801', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('2802', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('2805', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('2806', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('2809', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3002', 30, '����� �� ���� ���� ������ � ������������ ���������, �� ������� �������, � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3003', 30, '����� �� ���� ���� ������ � ������������ ���������,�� ������� ������������� ����������� ����������, � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3005', 30, '���� ����� �� ���� ������ � ������������ ��������� � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3006', 30, '���� �������� ����������, �� ������������ �� ������������ ������� ����� �������� ��� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3007', 30, '���������� ����� �� ����� ���������� ����������, �� ������������ �� ������������ ������� ����� �������� ��� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3008', 1, 30, '��������� ������ �� ������� �� ������ ����������� ������������, �� ������������ �� ������������ ������� ����� �������� ��� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3010', 30, '������ ���� ������ ������ �������� ����� � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3011', 30, '������ ���� ������ ������ �i������� �������������� � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3012', 30, '������ ���� ������, ������� �������, � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3013', 30, '������ ���� ������, ������� ������������� ����������� ����������, � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3014', 30, '������ ���� ������ ������������ ��������� � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3015', 30, '���������� �������� ������ ������ � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3016', 30, '��������������� ������� �� ��������� ������� �������� � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3017', 30, '�������������� ����� �� ��������� ������� �������� � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3018', 1, 30, '��������� ������ �� ��������� ������� �������� � ��������� ������� �����');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT, TIPA, TIPA_FV)
 Values
   ('3040', 304, '������ �� ���������� ���������� ����������� � ��������� ������� �����', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT, TIPA, TIPA_FV)
 Values
   ('3041', 304, '������ �� ����������� ����������� � ��������� ������� �����', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT, TIPA, TIPA_FV)
 Values
   ('3042', 304, '������ �� �''��������� ����������� � ��������� ������� �����', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('3043', '������ �� ��������� ����-�����������, �� ���������� �� ������������ ������� ����� ��������/������', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('3044', '������ �� ����������� ����-�����������, �� ���������� �� ������������ ������� ����� ��������/������', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('3049', '������ �� ������ ��������� ����������� �������������, �� ���������� �� ������������ ������� ����� ��������/������', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3102', 310, '����� �� ���� ���� ������ � ������������ ���������, �� ������� �������,� ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3103', 310, '����� �� ���� ���� ������ � ������������ ���������, �� ������� ������������� ����������� ���������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3105', 310, 'I��� ����� �� ���� ������ � ������������ ��������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3106', 310, '���� �������� ���������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3107', 310, '���������� ����� �� ����� ���������� ���������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3108', 1, 310, '��������� ������ �� ������� �� ������ ����������� ������������ � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3110', 311, '������ ���� ������ �����i� �������� ����� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3111', 311, '������ ���� ������ �����i� �i������� �������������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3112', 311, '������ ���� ������, ������� �������, � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3113', 311, '������ ���� ������, ������� ������������� ����������� ����������, � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3114', 311, '������ ���� ������ ������������ �i�������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3115', 311, '���������� �������� ������ ������ � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3116', 311, '��������������� ������� �� ��������� ������� �������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3117', 311, '�������������� ����� �� ��������� ������� �������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3118', 1, 311, '��������� ������ �� ��������� ������� �������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3119', 2, 311, '���������� ��������� ������ �� ��������� ������� �������� � ������� ����� �� ������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3120', 312, '����� ����� ����� � ������� �� ������, �������� � ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3122', 312, 'I�������i� � ����i�����i �����, �� ����������� � ����� �������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3123', 312, 'I�������i� � ����i�����i ������i����i �i������i ��������, �� ����������� � ����� �������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3125', 312, 'I�������i� � i��i ����i�����i ������i�, �� ����������� � ����� �������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3128', 1, 312, '��������� ������ �� i�������i��� � ����i�����i ������i�, �� ����������� � ����� �������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3132', 312, 'I�������i� � ���i��i �����, �� ����������� � ����� �������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3133', 312, 'I�������i� � ���i��i ������i����i �i������i ��������, �� ����������� � ����� �������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3135', 312, 'I�������i� � i��i ���i��i ������i�, �� ����������� � ����� �������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3138', 1, 312, '��������� ������ �� i�������i��� � ���i��i ������i�, �� ����������� � ����� �������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT, TIPA, TIPA_FV)
 Values
   ('3140', 31, '������ �� ���������� ���������� �����������, �� ��������� ��� ����� ����������', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT, TIPA, TIPA_FV)
 Values
   ('3141', 31, '������ �� ����������� �����������, �� ������������ ����� ����������', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT, TIPA, TIPA_FV)
 Values
   ('3142', 31, '������ �� �''��������� �����������, �� ������������ ����� ����������', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('3143', '������ �� ��������� ����-�����������, �� ��������� ��� ����� ����������', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('3144', '������ �� ����������� ����-�����������, �� ��������� ��� ����� ����������', 30, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3208', 1, 320, '��������� ������ �� ������� �� ������ ����������� � ������������ ��������� � ������� ����� �� ����������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3210', 32, '������ ���� ������ �����i� �������� ����� � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3211', 32, '������ ���� ������ ������ �i������� �������������� � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3212', 32, '������ ���� ������, ������� �������, � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3213', 32, '������ ���� ������, ������� ������������� ����������� ����������, � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3214', 32, '������ ���� ������ ������������ ��������� � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3216', 32, '��������������� ������� �� ��������� ������� �������� � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR2, TXT)
 Values
   ('3217', 32, '�������������� ����� �� ��������� ������� �������� � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3218', 1, 32, '��������� ������ �� ��������� ������� �������� � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('3219', 2, 32, '���������� ��������� ������ �� ��������� ������� �������� � ������� ����� �� ���������');
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3510', 2, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3519', 2, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3540', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3541', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3548', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3550', 2, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3551', 2, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3552', 2, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3559', 2, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3570', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3578', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3579', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, DEB, PR2)
 Values
   ('3710', 1, 17);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT)
 Values
   ('4108', 1, '��������� ������ �� ������������ � ���������� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, TXT)
 Values
   ('4208', 1, '��������� ������ �� i�������i��� � ���i��i ������i�');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('9000', 9, 1, '������, �� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2)
 Values
   ('9001', 9, 1);
Insert into BARS.REZ_DEB
   (NBS, PR, PR2)
 Values
   ('9002', 9, 1);
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('9003', 9, 1, '����i, �� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, TXT)
 Values
   ('9020', 9, '������, �� ����� �볺����');
Insert into BARS.REZ_DEB
   (NBS, PR, TXT)
 Values
   ('9023', 9, '����i, �� ����� �볺����');
Insert into BARS.REZ_DEB
   (NBS, PR, PR2, TXT)
 Values
   ('9100', 9, 1, '�����''������ � ������������, �� ����� ������');
Insert into BARS.REZ_DEB
   (NBS, PR, TXT)
 Values
   ('9122', 9, '�������� ����������');
Insert into BARS.REZ_DEB
   (NBS, PR, TXT)
 Values
   ('9129', 9, 'I��� �����''������ � ������������, �� ����� �볺����');
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9200', 9, '������ �� �������� ������ �� ��������� �� ������� ����', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9201', 9, '������ �� �������� ������ �� ��������� �� ����������� �����������, �� ��������� ��� ����� ����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9202', 9, '������ �� �������� ������ �� ��������� �� ����������� ����������� � ��������� ������� �����', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9203', 9, '������ �� �������� ������ �� ��������� �� ���i������ �����������, �� ��������� ��� ����� ����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9204', 9, '������ �� �������� ������ �� ��������� �� ���i������ ����������� � ��������� ������� �����', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9206', 9, '������ �� �������� ������ �� ��������� �� �''��������� �����������, �� ��������� ��� ����� ����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9207', 9, '������ �� �������� ������ �� ��������� �� �''��������� ����������� � ��������� ������� �����', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('9208', '������ ���� �� ��������� ������ �� ��������� ����-�����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9300', 9, '������ �� �������������� �i���� �����i�', 93, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9350', 9, '������ �� ��������� �� �������� �� ����i����� �� ��������� �����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9351', 9, '������ �� ��������� �� ����������� �����������, �� ��������� ��� ����� ����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9352', 9, '������ �� ��������� �� ����������� ����������� � ��������� ������� �����', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9353', 9, '������ �� ��������� �� ���i������ �����������, �� ��������� ��� ����� ����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9354', 9, '������ �� ��������� �� ���i������ ����������� � ��������� ������� �����', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9356', 9, '������ �� ��������� �� �''��������� �����������, �� ��������� ��� ����� ����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, PR, TXT, TIPA, TIPA_FV)
 Values
   ('9357', 9, '������ �� ��������� �� �''��������� ����������� � ��������� ������� �����', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('9358', '������ ������ �� ��������� �� ����������� ����-�����������', 92, 3);
Insert into BARS.REZ_DEB
   (NBS, TXT, TIPA, TIPA_FV)
 Values
   ('9359', '������ �� ��������� �� ������ ��������� ����������� �������������, �� ���������� �� ������������ ������� ����� ��������/������', 92, 3);
COMMIT;
/
