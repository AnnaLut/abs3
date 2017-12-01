
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA2M.sql =========***
PROMPT ===================================================================================== 

Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Բ�����² ����������',10,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ����� (�������) �� ��������� ��������� (������, ����, �����',20,'2000',null,'C','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� ������ (��� 2160 ����� 2-��)',30,'2120',null,'C','#(040)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������',40,'2240',null,'C','#(050)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ������ (2000 + 2120 + 2240)',50,'2280',null,'C','#(070)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ���������� ��������� (������, ����, ������)',60,'2050',null,'C','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� �������',70,'2180',null,'C','#(090)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Գ������ �������',75,'2250',null,'C','#(3001)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� (��� 2165 ����� 2-��)',80,'2270',null,'C','#(100)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ������� (2050 + 2180 + 2270)',90,'2285',null,'C','#(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Գ�������� ��������� �� ������������� (2280 - 2285)',100,'2290',null,'C','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �� ��������',110,'2300',null,'C','#(140)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� (������), �� ��������� (���������) ���������� ��������� ���',120,'2310',null,'C','#(145)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� (������) (2290 - 2300)',130,'2350',null,'C','#(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�������� ��������� � ����������� ��������',3000,'',3,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Գ������ �������',3001,'3001',4,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Բ�����² ����������',1,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� (�������) �� ��������� ��������� (������, ����, ������)',10,'010',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ������� �� ���� ����������� � ������',20,'020',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ����� (�������) �� ��������� ��������� (������, ����, �����',30,'030',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� ������',40,'040',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������',50,'050',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ���� ������ (030 + 040 + 050)',70,'070',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ���������� ��������� (������, ����, ������)',80,'080',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� �������',90,'090',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('   � ���� ����:',91,'091',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('',92,'092',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� �������',100,'100',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ������� (080 + 090 + 100)',120,'120',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Գ�������� ��������� �� ������������� (070 - 120)',130,'130',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �� ��������',140,'140',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����/���., �� �����/�����. ���������� ��������� ���� �������������',145,'145',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('150) ������ �������� (������) (130�140(-/+) 145)',150,'150',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������������ ����������',160,'160',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� �� ��������� �������� ��������� ������ � �����������������',201,'201',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �� ��������� �������� ��������� ������ � ���������������',202,'202',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Բ�����² ����������',10,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ����� (�������) �� ��������� ��������� (������, ����, �����',20,'2000',null,'R','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� ������ (��� 2160 ����� 2-��)',30,'2120',null,'R','#(040)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������',40,'2240',null,'R','#(050)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ������ (2000 + 2120 + 2240)',50,'2280',null,'R','#(070)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ���������� ��������� (������, ����, ������)',60,'2050',null,'R','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� �������',70,'2180',null,'R','#(090)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Գ������ �������',75,'2250',null,'R','#(3001)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� (��� 2165 ����� 2-��)',80,'2270',null,'R','#(100)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ������� (2050 + 2180 + 2270)',90,'2285',null,'R','#(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Գ�������� ��������� �� ������������� (2280 - 2285)',100,'2290',null,'R','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �� ��������',110,'2300',null,'R','#(140)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� (������), �� ��������� (���������) ���������� ��������� ���',120,'2310',null,'R','#(145)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� (������) (2290 - 2300)',130,'2350',null,'R','#(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
  delete from  FIN_FORMA2M where ORD=3000;
end;
/
Begin
  delete from  FIN_FORMA2M where ORD=3001;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA2M.sql =========***
PROMPT ===================================================================================== 
