
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA1M.sql =========***
PROMPT ===================================================================================== 

Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�����',10,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. ��������� ������',20,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� �������� ����������',30,'1005',null,'C','#(020)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ������:',40,'1010',null,'C','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �������',50,'1011',null,'C','#(031)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����',60,'1012',null,'C','#(032)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������� ������',70,'1020',null,'C','#(035)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ �������� ����������',80,'1030',null,'C','#(040) + #(045)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� ������',90,'1090',null,'C','#(050) + #(055) + #(060) + #(065) + #(070) + #(075)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� I',100,'1095',null,'C','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. ������� ������',110,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������:',120,'1100',null,'C','#(100) + #(130) + #(140) + #(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ���� ���� ������ ���������',130,'1103',null,'C','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ������� ������',140,'1110',null,'C','#(110)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������������� �� ������, ������, �������',150,'1125',null,'C','#(160)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������������� �� ������������ � ��������',160,'1135',null,'C','#(170)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ���� ���� � ������� �� ��������',170,'1136',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� ���������� �������������',180,'1155',null,'C','#(210)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� ����������',190,'1160',null,'C','#(220)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� �� �� ����������',200,'1165',null,'C','#(230) + #(240)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �������� ������',210,'1170',null,'C','#(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� ������',220,'1190',null,'C','#(250) + #(200) + #(190)  + #(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� II',230,'1195',null,'C','#(260) + #(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. ��������� ������, ��������� ��� �������, �� ����� �������',240,'1200',null,'C','#(275)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������',250,'1300',null,'C','#(280)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. ������� ������',260,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������� (�������) ������',270,'1400',null,'C','#(300) + #(310)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������',280,'1410',null,'C','#(320) + #(330)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������� ������',290,'1415',null,'C','#(340)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������� �������� (���������� ������)',300,'1420',null,'C','#(350)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����������� ������',310,'1425',null,'C','#(360) + #(370) + #(375)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������',318,'1490',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� I',320,'1495',null,'C','#(380)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �� �����������',322,'1510',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. ������������ �����''������, ������� ������������ �� ������������',330,'1595',null,'C','#(430) + #(480)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. ������ �����''������',340,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�������������� ������� �����',350,'1600',null,'C','#(500)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� ������������ ������������� ��:',360,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������������� �����''��������',370,'1610',null,'C','#(510)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������, ������, �������',380,'1615',null,'C','#(530)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ � ��������',390,'1620',null,'C','#(550)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('  � ���� ���� � ������� �� ��������',400,'1621',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ � �����������',410,'1625',null,'C','#(570)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ � ������ �����',420,'1630',null,'C','#(580)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� ������',430,'1665',null,'C','#(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������ �����''������',440,'1690',null,'C','#(610) + #(600) + #(590) + #(540) + #(520)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� III',450,'1695',null,'C','#(620) + #(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. �����''������, ���''���� � ������������ ��������, ������������ ��� ',460,'1700',null,'C','#(605)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������',470,'1900',null,'C','#(640)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�����',0,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. ��������� ������',8,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����������� ������:',9,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������� �������',10,'010',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �������',11,'011',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ����������� ',12,'012',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� �������� ����������',20,'020',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ������:',29,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������� �������',30,'030',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �������',31,'031',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����',32,'032',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������� ������:',34,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����������� (���������) �������',35,'035',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �������',36,'036',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� �����������',37,'037',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ �������� ����������:',39,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�� ������������ �� ������� ����� � ������ ����� ���������',40,'040',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� �������� ����������',45,'045',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������� ���������� �������������',50,'050',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����������� (���������) ������� ������������ ����������',55,'055',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� ������� ������������ ����������',56,'056',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������������ ����������',57,'057',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('³�������� �������� ������',60,'060',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�����',65,'065',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� ������',70,'070',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ��� �����������',75,'075',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� I',80,'080',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. ������� ������',98,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������� ������',100,'100',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ������� ������',110,'110',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����������� �����������',120,'120',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ���������',130,'130',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������',140,'140',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������',150,'150',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������������� �� ������, ������, �������:',159,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ����������� �������',160,'160',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �������',161,'161',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� �����',162,'162',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������������� �� ������������:',169,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ��������',170,'170',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�� �������� ��������',180,'180',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ����������� ������',190,'190',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�� �������� ����������',200,'200',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� ���������� �������������',210,'210',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� ����������',220,'220',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ����� �� �� ����������:',229,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ����������� �����',230,'230',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ���� ���� � ���',231,'231',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� �������� �����',240,'240',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� ������',250,'250',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� II',260,'260',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. ������� �������� ������',270,'270',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. ��������� ������ �� ����� �������',275,'275',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������',280,'280',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�����',298,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. ������� ������',299,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������� ������',300,'300',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� ������',310,'310',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ��������� ������',320,'320',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� ���������� ������',330,'330',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������� ������',340,'340',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������� �������� (���������� ������)',350,'350',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����������� ������',360,'360',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������� ������ ',370,'370',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������� ������',375,'375',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� I',380,'380',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������',385,'385',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. ������������ �������� ������ � �������',399,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������ ���������',400,'400',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������������',410,'410',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� �������',415,'415',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������ �������������� � ��������� �������� ',416,'416',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� ������������ ��������� �����, �� ������ ������ ���������� �',417,'417',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� ������������ ������� �� ������� ����-����, �� ������������� ��',418,'418',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ֳ����� ������������',420,'420',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� II',430,'430',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. ������������ �����''������',439,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������� �����',440,'440',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������������ �������� �����''������',450,'450',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('³�������� �������� �����''������',460,'460',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������������ �����''������',470,'470',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� III',480,'480',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. ������ �����''������',499,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�������������� ������� �����',500,'500',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� ������������� �� ��������������� �����''��������',510,'510',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �����',520,'520',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������������� �� ������, ������, �������',530,'530',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �����''������ �� ������������:',539,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ��������� ������',540,'540',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ��������',550,'550',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ������������� �������',560,'560',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� �����������',570,'570',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ������ �����',580,'580',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ����������',590,'590',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�� �������� ����������',600,'600',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�����''������, ���''���� � ������������ �������� �� ������� �������, ��',605,'605',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������ �����''������',610,'610',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� IV',620,'620',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('V. ������ �������� ������',630,'630',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������',640,'640',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�����',10,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. ��������� ������',20,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� �������� ����������',30,'1005',null,'R','#(020)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ������:',40,'1010',null,'R','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �������',50,'1011',null,'R','#(031)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����',60,'1012',null,'R','#(032)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������� ������',70,'1020',null,'R','#(035)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ �������� ����������',80,'1030',null,'R','#(040) + #(045)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ��������� ������',90,'1090',null,'R','#(050) + #(055) + #(060) + #(065) + #(070) + #(075)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� I',100,'1095',null,'R','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. ������� ������',110,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������:',120,'1100',null,'R','#(100) + #(130) + #(140) + #(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ���� ���� ������ ���������',130,'1103',null,'R','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ ������� ������',140,'1110',null,'R','#(110)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������������� �� ������, ������, �������',150,'1125',null,'R','#(160)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������������� �� ������������ � ��������',160,'1135',null,'R','#(170)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('� ���� ���� � ������� �� ��������',170,'1136',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� ���������� �������������',180,'1155',null,'R','#(210)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� ����������',190,'1160',null,'R','#(220)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����� �� �� ����������',200,'1165',null,'R','#(230) + #(240)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �������� ������',210,'1170',null,'R','#(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������� ������',220,'1190',null,'R','#(250) + #(200) + #(190)  + #(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� II',230,'1195',null,'R','#(260) + #(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. ��������� ������, ��������� ��� �������, �� ����� �������',240,'1200',null,'R','#(275)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������',250,'1300',null,'R','#(280)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. ������� ������',260,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������� (�������) ������',270,'1400',null,'R','#(300) + #(310)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���������� ������',280,'1410',null,'R','#(320) + #(330)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������� ������',290,'1415',null,'R','#(340)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������� �������� (���������� ������)',300,'1420',null,'R','#(350)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('����������� ������',310,'1425',null,'R','#(360) + #(370) + #(375)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ ������',318,'1490',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� I',320,'1495',null,'R','#(380)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� �� �����������',322,'1510',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. ������������ �����''������, ������� ������������ �� ������������',330,'1595',null,'R','#(430) + #(480)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. ������ �����''������',340,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('�������������� ������� �����',350,'1600',null,'R','#(500)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������� ������������ ������������� ��:',360,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('��������������� �����''��������',370,'1610',null,'R','#(510)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������, ������, �������',380,'1615',null,'R','#(530)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ � ��������',390,'1620',null,'R','#(550)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('  � ���� ���� � ������� �� ��������',400,'1621',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ � �����������',410,'1625',null,'R','#(570)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������������ � ������ �����',420,'1630',null,'R','#(580)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �������� ������',430,'1665',null,'R','#(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('���� ������ �����''������',440,'1690',null,'R','#(610) + #(600) + #(590) + #(540) + #(520)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������ �� ������� III',450,'1695',null,'R','#(620) + #(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. �����''������, ���''���� � ������������ ��������, ������������ ��� ',460,'1700',null,'R','#(605)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('������',470,'1900',null,'R','#(640)');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA1M.sql =========***
PROMPT ===================================================================================== 
