PROMPT *** Run *** ========== Scripts SQL\Data\fin_forma2m.sql  =========*** Run *** =====
truncate table FIN_FORMA2M;

Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Բ�����² ����������', 1, '', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('����� (�������) �� ��������� ��������� (������, ����, ������)', 10, '010', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������ ������� �� ���� ����������� � ������', 20, '020', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������ ����� (�������) �� ��������� ��������� (������, ����, �����', 30, '030', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���� ��������� ������', 40, '040', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���� ������', 50, '050', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('����� ���� ������ (030 + 040 + 050)', 70, '070', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���������� ���������� ��������� (������, ����, ������)', 80, '080', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���� ��������� �������', 90, '090', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('   � ���� ����:', 91, '091', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('', 92, '092', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���� �������', 100, '100', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('����� ������� (080 + 090 + 100)', 120, '120', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Գ�������� ��������� �� ������������� (070 - 120)', 130, '130', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������� �� ��������', 140, '140', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('����/���., �� �����/�����. ���������� ��������� ���� �������������', 145, '145', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('150) ������ �������� (������) (130�140(-/+) 145)', 150, '150', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������������ ������������ ����������', 160, '160', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('����� �� ��������� �������� ��������� ������ � �����������������', 201, '201', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������� �� ��������� �������� ��������� ������ � ���������������', 202, '202', 'M', '');


Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Բ�����² ����������', 10, '', 'R', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������ ����� (�������) �� ��������� ��������� (������, ����, �����', 20, '2000', 'R', '#(030)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���� ��������� ������ (��� 2160 ����� 2-��)', 30, '2120', 'R', '#(040)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���� ������', 40, '2240', 'R', '#(050)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('����� ������ (2000 + 2120 + 2240)', 50, '2280', 'R', '#(070)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���������� ���������� ��������� (������, ����, ������)', 60, '2050', 'R', '#(080)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���� ��������� �������', 70, '2180', 'R', '#(090)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('���� ������� (��� 2165 ����� 2-��)', 80, '2270', 'R', '#(100)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('����� ������� (2050 + 2180 + 2270)', 90, '2285', 'R', '#(120)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Գ�������� ��������� �� ������������� (2280 - 2285)', 100, '2290', 'R', '#(130)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������� �� ��������', 110, '2300', 'R', '#(140)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������� (������), �� ��������� (���������) ���������� ��������� ���', 120, '2310', 'R', '#(145)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('������ �������� (������) (2290 - 2300)', 130, '2350', 'R', '#(150)');

-- �������� ��������� � ����������� ��������
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, pob, FM, KOD_OLD)  Values ('�������� ��������� � ����������� ��������', 3000, null, 3, 'R', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, pob, FM, KOD_OLD)  Values ('Գ������ �������', 3001, '3001', 4, 'R', '');


INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� (��� 2165 ����� 2-��)',80,'2270',null,'C','#(100)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������',40,'2240',null,'C','#(050)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� �������',70,'2180',null,'C','#(090)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� ������ (��� 2160 ����� 2-��)',30,'2120',null,'C','#(040)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� (������), �� ��������� (���������) ���������� ��������� ���',120,'2310',null,'C','#(145)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �� ��������',110,'2300',null,'C','#(140)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ������� (2050 + 2180 + 2270)',90,'2285',null,'C','#(120)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ������ (2000 + 2120 + 2240)',50,'2280',null,'C','#(070)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ���������� ��������� (������, ����, ������)',60,'2050',null,'C','#(080)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Բ�����² ����������',10,'',null,'C','');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Գ�������� ��������� �� ������������� (2280 - 2285)',100,'2290',null,'C','#(130)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ����� (�������) �� ��������� ��������� (������, ����, �����',20,'2000',null,'C','#(030)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� (������) (2290 - 2300)',130,'2350',null,'C','#(150)');

-- �������� ��������� � ����������� ��������
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, pob, FM, KOD_OLD)  Values ('�������� ��������� � ����������� ��������', 3000, null, 3, 'C', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, pob, FM, KOD_OLD)  Values ('Գ������ �������', 3001, '3001', 4, 'C', '');



commit;