
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_FIN_KOD.sql =========*** Run
PROMPT ===================================================================================== 

declare
l_FIN_KOD  FIN_KOD%rowtype;

procedure p_merge(p_FIN_KOD FIN_KOD%rowtype) 
as
Begin
   insert into FIN_KOD
      values p_FIN_KOD; 
 exception when dup_val_on_index then  
   update FIN_KOD
      set row = p_FIN_KOD
    where KOD = p_FIN_KOD.KOD
      and IDF = p_FIN_KOD.IDF
      and FM = p_FIN_KOD.FM;
End;
Begin


delete from fin_kod  where idf = 6 and kod like 'PK%' and fm = '0';
delete from fin_kod  where idf in (11,12,13)  and fm = '0';



l_FIN_KOD.NAME :='K10, �K10 � ���������� ������. �����. ���.�� ������-�� �� �������� �������� (EBITDA) ';
l_FIN_KOD.ORD :=10;
l_FIN_KOD.KOD :='K10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K12 � �������� ���������� �������� �������';
l_FIN_KOD.ORD :=112;
l_FIN_KOD.KOD :='PK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K2, �K2 � �������� ���������� ��������';
l_FIN_KOD.ORD :=2;
l_FIN_KOD.KOD :='K2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K3, �K3 � ���������� ��������� ���������-�� ';
l_FIN_KOD.ORD :=3;
l_FIN_KOD.KOD :='K3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K4, �K4 ����������� �������� ��������-��� ������ ������� �������� ';
l_FIN_KOD.ORD :=4;
l_FIN_KOD.KOD :='K4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K5, �K5 � ���������� ���������-���� �������� ������� / ���������� ���������� ������������ ��- ����������� ';
l_FIN_KOD.ORD :=5;
l_FIN_KOD.KOD :='K5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K6, �K6 ����������� ���������-���� ������� �� ������. �� ��������-�� �������� (EBIT) ';
l_FIN_KOD.ORD :=6;
l_FIN_KOD.KOD :='K6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K7, �K7 ����������� ���������-���� ������� �� ������. �� �������� �������� (EBITDA)';
l_FIN_KOD.ORD :=7;
l_FIN_KOD.KOD :='K7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K8, �K8 ����������� ���������-���� ������ �� ������ ���������';
l_FIN_KOD.ORD :=8;
l_FIN_KOD.KOD :='K8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K9, �K9 ����������� ���������-� ������-��� ������';
l_FIN_KOD.ORD :=9;
l_FIN_KOD.KOD :='K9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK10 � �������� ���������� �������� �������';
l_FIN_KOD.ORD :=210;
l_FIN_KOD.KOD :='PK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK10 � �������� ���������� �������� �������';
l_FIN_KOD.ORD :=310;
l_FIN_KOD.KOD :='PK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK13 � �������� ������� �������� �� �������������';
l_FIN_KOD.ORD :=313;
l_FIN_KOD.KOD :='PK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK13 � �������� ������� �������� �� �������������';
l_FIN_KOD.ORD :=213;
l_FIN_KOD.KOD :='PK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK4 �  ��������� �������';
l_FIN_KOD.ORD :=304;
l_FIN_KOD.KOD :='PK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK4 �  ��������� �������';
l_FIN_KOD.ORD :=204;
l_FIN_KOD.KOD :='PK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK5 � ��������� ����������� �������� �������';
l_FIN_KOD.ORD :=305;
l_FIN_KOD.KOD :='PK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK5 � ��������� ����������� �������� �������';
l_FIN_KOD.ORD :=205;
l_FIN_KOD.KOD :='PK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='M�11 � �������� �������� ����� ����������� ���������';
l_FIN_KOD.ORD :=211;
l_FIN_KOD.KOD :='PK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='M�11 � �������� �������� ����� ����������� ���������';
l_FIN_KOD.ORD :=311;
l_FIN_KOD.KOD :='PK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ �������� �������� ';
l_FIN_KOD.ORD :=11;
l_FIN_KOD.KOD :='IPB';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� �������';
l_FIN_KOD.ORD :=13;
l_FIN_KOD.KOD :='AZ13';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ������������ �����''������';
l_FIN_KOD.ORD :=11;
l_FIN_KOD.KOD :='AP11';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ������';
l_FIN_KOD.ORD :=12;
l_FIN_KOD.KOD :='AZ12';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ��������� ������';
l_FIN_KOD.ORD :=6;
l_FIN_KOD.KOD :='AB6';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ������� ������';
l_FIN_KOD.ORD :=12;
l_FIN_KOD.KOD :='AB12';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ��������� �������';
l_FIN_KOD.ORD :=7;
l_FIN_KOD.KOD :='AZ7';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ��������� ������';
l_FIN_KOD.ORD :=4;
l_FIN_KOD.KOD :='AZ4';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ������ �����''������';
l_FIN_KOD.ORD :=16;
l_FIN_KOD.KOD :='AP16';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ �������';
l_FIN_KOD.ORD :=5;
l_FIN_KOD.KOD :='AZ5';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ ';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='AB1';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�����������';
l_FIN_KOD.ORD :=18;
l_FIN_KOD.KOD :='AZ18';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='³������� �������� ������';
l_FIN_KOD.ORD :=5;
l_FIN_KOD.KOD :='AB5';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='³������� �������� �����''������';
l_FIN_KOD.ORD :=10;
l_FIN_KOD.KOD :='AP10';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� �������� / ������';
l_FIN_KOD.ORD :=3;
l_FIN_KOD.KOD :='AZ3';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='����� ����������� 0 - ���� �������, 1 ���� � ������ ���� �����, 2 - ���� � ���� ���� ����� ';
l_FIN_KOD.ORD :=623;
l_FIN_KOD.KOD :='XXXX';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� �� ��������� ���������';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='AZ1';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� �� ����';
l_FIN_KOD.ORD :=6;
l_FIN_KOD.KOD :='AZ6';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� ������';
l_FIN_KOD.ORD :=6;
l_FIN_KOD.KOD :='AP6';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ �����';
l_FIN_KOD.ORD :=11;
l_FIN_KOD.KOD :='AB11';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='����� ���� ��������� ��������';
l_FIN_KOD.ORD :=500;
l_FIN_KOD.KOD :='GVED';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ���������� ���������������� ';
l_FIN_KOD.ORD :=604;
l_FIN_KOD.KOD :='DRES';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ �����''������';
l_FIN_KOD.ORD :=12;
l_FIN_KOD.KOD :='AP12';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������';
l_FIN_KOD.ORD :=8;
l_FIN_KOD.KOD :='AB8';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ ���� � ����������� ����������';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='CLSP';
l_FIN_KOD.IDF :=60;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ ���� ������������';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='CLS';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ ���� ������������';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='CLS';
l_FIN_KOD.IDF :=60;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ ���� ������������ ����������� ����� ��������� ���������������';
l_FIN_KOD.ORD :=613;
l_FIN_KOD.KOD :='CLS2';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ ���� ������������ ����������� ����� �� ������� ���������';
l_FIN_KOD.ORD :=614;
l_FIN_KOD.KOD :='KKDP';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ ���� ������������ ����������� ����� �� ������� ���������';
l_FIN_KOD.ORD :=612;
l_FIN_KOD.KOD :='CLS1';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ ���� ������������ � ����������� ������� ��� ����������';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='CLSP';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� ������������� ���������';
l_FIN_KOD.ORD :=501;
l_FIN_KOD.KOD :='PIPB';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� ����������� PD (������������)';
l_FIN_KOD.ORD :=611;
l_FIN_KOD.KOD :='PD';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� ����������� PD (������������)';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='PD8D';
l_FIN_KOD.IDF :=53;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�1 � ��������� �������� �����  ';
l_FIN_KOD.ORD :=101;
l_FIN_KOD.KOD :='PK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�1, ��1 ����������� �������� (����-���� �������� �������)';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='K1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�10  ��������� �������� �������� ';
l_FIN_KOD.ORD :=110;
l_FIN_KOD.KOD :='PK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�10 � �������� ����������� �������� ������� (������ ��������� ������, ���������� ��������� ���������-����)';
l_FIN_KOD.ORD :=610;
l_FIN_KOD.KOD :='LK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�11, ��11 � ��������� �������� ����� ������ ������� (����������� �������������� ����� �������� �� ��������� ���� ��������)';
l_FIN_KOD.ORD :=611;
l_FIN_KOD.KOD :='LK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�11- �������� �������� �������������� �����';
l_FIN_KOD.ORD :=111;
l_FIN_KOD.KOD :='PK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�12 � �������� �������� ����� ��������� �� ����������� �� ������������� (����������� �������������� ����� ��������� �� ������������� �� �����������)';
l_FIN_KOD.ORD :=612;
l_FIN_KOD.KOD :='LK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�13 � �������� ������ ������������� �������� ������� (������ ������, ��� �� �� ������� ��������� �� ���������� �������� ����������)';
l_FIN_KOD.ORD :=613;
l_FIN_KOD.KOD :='LK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�13� �������� ���������� ���������� �������������';
l_FIN_KOD.ORD :=113;
l_FIN_KOD.KOD :='PK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�14 � �������� ���������� ������������ �������������';
l_FIN_KOD.ORD :=114;
l_FIN_KOD.KOD :='PK14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�14 � ��������� ���������� �������� ������ (����� ������� ������� �������� ������)';
l_FIN_KOD.ORD :=614;
l_FIN_KOD.KOD :='LK14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�15 � �������� �������� ���������� ������ ��������� �� ������������� �� ����������� (����������� ������������ ������������� ������ ����������� ��������� �� ���';
l_FIN_KOD.ORD :=615;
l_FIN_KOD.KOD :='LK15';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�15 � �������� ������ ������������� �������� �������';
l_FIN_KOD.ORD :=115;
l_FIN_KOD.KOD :='PK15';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�16 � �������� ������������ �������� �� ����������� ����������� ';
l_FIN_KOD.ORD :=116;
l_FIN_KOD.KOD :='PK16';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�16 � �������� ������������� �� ������������� (����������� �������� ���������� �� �������������)';
l_FIN_KOD.ORD :=616;
l_FIN_KOD.KOD :='LK16';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�17 � �������� �������� ���������� ������ ������� (����������� ������������ ������������� ������ ������� ���������)';
l_FIN_KOD.ORD :=617;
l_FIN_KOD.KOD :='LK17';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�18 � ��������� ������������� (������ ����� ���������� �� ������)';
l_FIN_KOD.ORD :=618;
l_FIN_KOD.KOD :='LK18';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�1� ��������� �������  (������ ������� � ������ ����������)';
l_FIN_KOD.ORD :=601;
l_FIN_KOD.KOD :='LK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�2  � ��������� ������������� ������   ';
l_FIN_KOD.ORD :=102;
l_FIN_KOD.KOD :='PK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�2 � ��������� �������� �������� (����������� ���������� ��������� �������������-� ����������� �� ������� ��������� ������)';
l_FIN_KOD.ORD :=602;
l_FIN_KOD.KOD :='LK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�3 � ��������� �������� ����� ��������� �� ������������� (����������� �������������� ����� ��������� �� �������������)';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='LK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�3 ��������� �������� ���������� ������ �� ������������  ���������� ��������';
l_FIN_KOD.ORD :=103;
l_FIN_KOD.KOD :='PK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�4  �  ��������� �������';
l_FIN_KOD.ORD :=104;
l_FIN_KOD.KOD :='PK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�4 � ��������� ���������� ������������� ������ ( ����������� ������������ ������ ���������� � ���������� �������� )';
l_FIN_KOD.ORD :=604;
l_FIN_KOD.KOD :='LK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�5 � ��������� ����������� �������� �������';
l_FIN_KOD.ORD :=105;
l_FIN_KOD.KOD :='PK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�5 � ��������� ���������� ������ ( ����� ������� ������� ������ )';
l_FIN_KOD.ORD :=605;
l_FIN_KOD.KOD :='LK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�6 � ��������� �������� ����� ������� ��������� ( ����������� �������������� ����� ������� ��������� )';
l_FIN_KOD.ORD :=606;
l_FIN_KOD.KOD :='LK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�6 � ��������� �������� �������� ����� ';
l_FIN_KOD.ORD :=106;
l_FIN_KOD.KOD :='PK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�7 � ��������� �������� ������ ���������� ������ ����������� ��������� (����������� ������������ ������ ������������� ������ �� ������������ ���������� �';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='LK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�7 � ��������� ������ ��������';
l_FIN_KOD.ORD :=107;
l_FIN_KOD.KOD :='PK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�8 � ��������� ���������� ������ ';
l_FIN_KOD.ORD :=108;
l_FIN_KOD.KOD :='PK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�8 � ��������� ���������� ������������ ������������� ( ����� ������� ������� ������������ ������������� )';
l_FIN_KOD.ORD :=608;
l_FIN_KOD.KOD :='LK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�9 � ��������� ���������� ���������� ������������� (����� ������� ������� ���������� �������������)';
l_FIN_KOD.ORD :=609;
l_FIN_KOD.KOD :='LK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�9 ���������� ���������� �������� ������ ';
l_FIN_KOD.ORD :=109;
l_FIN_KOD.KOD :='PK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='ʳ������ ��� ���������� �� ���� ����������������';
l_FIN_KOD.ORD :=606;
l_FIN_KOD.KOD :='PRES';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='ʳ������ ���������������� �� ���� �������';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='KRES';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='ʳ������ ���������������� �� ���� �������';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='KRES';
l_FIN_KOD.IDF :=71;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������';
l_FIN_KOD.ORD :=8;
l_FIN_KOD.KOD :='AP8';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ���������� � ������������� ���������';
l_FIN_KOD.ORD :=503;
l_FIN_KOD.KOD :='CLAS';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� �� ���� ����������������';
l_FIN_KOD.ORD :=605;
l_FIN_KOD.KOD :='CRES';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ������ �� ';
l_FIN_KOD.ORD :=619;
l_FIN_KOD.KOD :='CLS+';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��� ����� ��������� ���';
l_FIN_KOD.ORD :=610;
l_FIN_KOD.KOD :='NUMG';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���������� PD';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='PD';
l_FIN_KOD.IDF :=60;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� �� �����������';
l_FIN_KOD.ORD :=9;
l_FIN_KOD.KOD :='AP9';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��1 � ��������� �������  (������ ������� � ������ ����������)';
l_FIN_KOD.ORD :=601;
l_FIN_KOD.KOD :='LK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��1 � ��������� �������  (������ ������� � ������ ����������)';
l_FIN_KOD.ORD :=601;
l_FIN_KOD.KOD :='LK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��1 � ��������� �������� �����  ';
l_FIN_KOD.ORD :=201;
l_FIN_KOD.KOD :='PK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��1 � ��������� �������� �����  ';
l_FIN_KOD.ORD :=301;
l_FIN_KOD.KOD :='PK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��10 � �������� ���������� �������� �������  (����������-�� ��������� ������, ���������� ��������� ���������-����, �� ������� ������)';
l_FIN_KOD.ORD :=610;
l_FIN_KOD.KOD :='LK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��10 � �������� ���������� �������� �������  (����������-�� ��������� ������, ���������� ��������� ���������-����, �� ������� ������)';
l_FIN_KOD.ORD :=610;
l_FIN_KOD.KOD :='LK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��11 � ��������� �������� ����� ������ ������� (����������� �������������� ����� �������� �� ��������� ���� ��������)';
l_FIN_KOD.ORD :=611;
l_FIN_KOD.KOD :='LK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��11 � ��������� �������� ����� ������ ������� (����������� �������������� ����� �������� �� ��������� ���� ��������)';
l_FIN_KOD.ORD :=611;
l_FIN_KOD.KOD :='LK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��12 � �������� ���������� �������� ������ ';
l_FIN_KOD.ORD :=212;
l_FIN_KOD.KOD :='PK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��12 � �������� ���������� �������� ������ ';
l_FIN_KOD.ORD :=312;
l_FIN_KOD.KOD :='PK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��12 � �������� ������������� ������ �� ������������� (����������� ������������ ������ ����������)';
l_FIN_KOD.ORD :=612;
l_FIN_KOD.KOD :='LK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��12 � �������� ������������� ������ �� ������������� (����������� ������������ ������ ����������)';
l_FIN_KOD.ORD :=612;
l_FIN_KOD.KOD :='LK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��13 � �������� �������� ���������� ������ ����������� ��������� (����������� ������������ ������������� ������ ����������� ���������)';
l_FIN_KOD.ORD :=613;
l_FIN_KOD.KOD :='LK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��13 � �������� �������� ���������� ������ ����������� ��������� (����������� ������������ ������������� ������ ����������� ���������)';
l_FIN_KOD.ORD :=613;
l_FIN_KOD.KOD :='LK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��14 � ��������� ���������� �������� ������ (����� ������� ������� �������� ������)';
l_FIN_KOD.ORD :=614;
l_FIN_KOD.KOD :='LK14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��14 � ��������� ���������� �������� ������ (����� ������� ������� �������� ������)';
l_FIN_KOD.ORD :=614;
l_FIN_KOD.KOD :='LK14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��17 � �������� ������ ������������� (����������� ������� �������� ����������)';
l_FIN_KOD.ORD :=617;
l_FIN_KOD.KOD :='LK17';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��17 � �������� ������ ������������� (����������� ������� �������� ����������)';
l_FIN_KOD.ORD :=617;
l_FIN_KOD.KOD :='LK17';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��18 � ��������� ������������� (������ ����� ���������� �� ������)';
l_FIN_KOD.ORD :=618;
l_FIN_KOD.KOD :='LK18';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��18 � ��������� ������������� (������ ����� ���������� �� ������)';
l_FIN_KOD.ORD :=618;
l_FIN_KOD.KOD :='LK18';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��2 � ��������� �������� �������� (����������� ���������� ��������� �������������-� ����������� �� ������� ��������� ������)';
l_FIN_KOD.ORD :=602;
l_FIN_KOD.KOD :='LK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��2 � ��������� �������� �������� (����������� ���������� ��������� �������������-� ����������� �� ������� ��������� ������)';
l_FIN_KOD.ORD :=602;
l_FIN_KOD.KOD :='LK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��2 � ��������� ������������� ������   ';
l_FIN_KOD.ORD :=302;
l_FIN_KOD.KOD :='PK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��2 � ��������� ������������� ������   ';
l_FIN_KOD.ORD :=202;
l_FIN_KOD.KOD :='PK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��3 � ��������� �������� ����� ��������� �� ������������� (����������� �������������� ����� ��������� �� �������������)';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='LK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��3 � ��������� �������� ����� ��������� �� ������������� (����������� �������������� ����� ��������� �� �������������)';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='LK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��3 ��������� �������� ���������� ������ �� ������������  ���������� ��������';
l_FIN_KOD.ORD :=203;
l_FIN_KOD.KOD :='PK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��3 ��������� �������� ���������� ������ �� ������������  ���������� ��������';
l_FIN_KOD.ORD :=203;
l_FIN_KOD.KOD :='PK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��4 � ��������� ���������� ������������� ������ ( ����������� ������������ ������ ���������� � ���������� �������� )';
l_FIN_KOD.ORD :=604;
l_FIN_KOD.KOD :='LK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��4 � ��������� ���������� ������������� ������ ( ����������� ������������ ������ ���������� � ���������� �������� )';
l_FIN_KOD.ORD :=604;
l_FIN_KOD.KOD :='LK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��5 � ��������� ���������� ������ ( ����� ������� ������� ������ )';
l_FIN_KOD.ORD :=605;
l_FIN_KOD.KOD :='LK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��5 � ��������� ���������� ������ ( ����� ������� ������� ������ )';
l_FIN_KOD.ORD :=605;
l_FIN_KOD.KOD :='LK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��6 � ��������� �������� ����� ������� ��������� ( ����������� �������������� ����� ������� ��������� )';
l_FIN_KOD.ORD :=606;
l_FIN_KOD.KOD :='LK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��6 � ��������� �������� ����� ������� ��������� ( ����������� �������������� ����� ������� ��������� )';
l_FIN_KOD.ORD :=606;
l_FIN_KOD.KOD :='LK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��6 � ��������� �������� �������� ����� ';
l_FIN_KOD.ORD :=306;
l_FIN_KOD.KOD :='PK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��6 � ��������� �������� �������� ����� ';
l_FIN_KOD.ORD :=206;
l_FIN_KOD.KOD :='PK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��7 � ��������� �������� ������ ���������� ������ ����������� ��������� (����������� ������������ ������ ������������� ������ �� ������������ ���������� �';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='LK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��7 � ��������� �������� ������ ���������� ������ ����������� ��������� (����������� ������������ ������ ������������� ������ �� ������������ ���������� �';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='LK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��7 � ��������� ������ ��������';
l_FIN_KOD.ORD :=207;
l_FIN_KOD.KOD :='PK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��7 � ��������� ������ ��������';
l_FIN_KOD.ORD :=307;
l_FIN_KOD.KOD :='PK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��8 � ��������� ���������� ������ ';
l_FIN_KOD.ORD :=208;
l_FIN_KOD.KOD :='PK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��8 � ��������� ���������� ������ ';
l_FIN_KOD.ORD :=308;
l_FIN_KOD.KOD :='PK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��8 � ��������� ���������� ������������ ������������� ( ����� ������� ������� ������������ ������������� )';
l_FIN_KOD.ORD :=608;
l_FIN_KOD.KOD :='LK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��8 � ��������� ���������� ������������ ������������� ( ����� ������� ������� ������������ ������������� )';
l_FIN_KOD.ORD :=608;
l_FIN_KOD.KOD :='LK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��9 � ��������� ���������� ���������� ������������� (����� ������� ������� ���������� �������������)';
l_FIN_KOD.ORD :=609;
l_FIN_KOD.KOD :='LK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��9 � ��������� ���������� ���������� ������������� (����� ������� ������� ���������� �������������)';
l_FIN_KOD.ORD :=609;
l_FIN_KOD.KOD :='LK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��9 ���������� ���������� �������� ������';
l_FIN_KOD.ORD :=309;
l_FIN_KOD.KOD :='PK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��9 ���������� ���������� �������� ������';
l_FIN_KOD.ORD :=209;
l_FIN_KOD.KOD :='PK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������ ������';
l_FIN_KOD.ORD :=7;
l_FIN_KOD.KOD :='AP7';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='����������� ������';
l_FIN_KOD.ORD :=3;
l_FIN_KOD.KOD :='AB3';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��������� ������';
l_FIN_KOD.ORD :=7;
l_FIN_KOD.KOD :='AB7';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������������� �������� / ������';
l_FIN_KOD.ORD :=5;
l_FIN_KOD.KOD :='AP5';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� ������';
l_FIN_KOD.ORD :=13;
l_FIN_KOD.KOD :='AB13';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='����������� �������� / ������';
l_FIN_KOD.ORD :=8;
l_FIN_KOD.KOD :='AZ8';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ ������, ���������� �� ���������� ';
l_FIN_KOD.ORD :=2;
l_FIN_KOD.KOD :='AB2';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='AP1';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������';
l_FIN_KOD.ORD :=16;
l_FIN_KOD.KOD :='AZ16';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� �����''������';
l_FIN_KOD.ORD :=15;
l_FIN_KOD.KOD :='AP15';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� - X14 ';
l_FIN_KOD.ORD :=414;
l_FIN_KOD.KOD :='X14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� - X15 ';
l_FIN_KOD.ORD :=415;
l_FIN_KOD.KOD :='X15';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� - X16';
l_FIN_KOD.ORD :=416;
l_FIN_KOD.KOD :='X16';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X1  ';
l_FIN_KOD.ORD :=401;
l_FIN_KOD.KOD :='X1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X10 ';
l_FIN_KOD.ORD :=410;
l_FIN_KOD.KOD :='X10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X11 ';
l_FIN_KOD.ORD :=411;
l_FIN_KOD.KOD :='X11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X12 ';
l_FIN_KOD.ORD :=412;
l_FIN_KOD.KOD :='X12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X13';
l_FIN_KOD.ORD :=413;
l_FIN_KOD.KOD :='X13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X2  ';
l_FIN_KOD.ORD :=402;
l_FIN_KOD.KOD :='X2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X3';
l_FIN_KOD.ORD :=403;
l_FIN_KOD.KOD :='X3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X4 ';
l_FIN_KOD.ORD :=404;
l_FIN_KOD.KOD :='X4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X5';
l_FIN_KOD.ORD :=405;
l_FIN_KOD.KOD :='X5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X6  ';
l_FIN_KOD.ORD :=406;
l_FIN_KOD.KOD :='X6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X7';
l_FIN_KOD.ORD :=407;
l_FIN_KOD.KOD :='X7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X8  ';
l_FIN_KOD.ORD :=408;
l_FIN_KOD.KOD :='X8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� -X9  ';
l_FIN_KOD.ORD :=409;
l_FIN_KOD.KOD :='X9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ �����''������';
l_FIN_KOD.ORD :=17;
l_FIN_KOD.KOD :='AP17';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ ������� �� �����������';
l_FIN_KOD.ORD :=13;
l_FIN_KOD.KOD :='AP13';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ �������� ������';
l_FIN_KOD.ORD :=10;
l_FIN_KOD.KOD :='AB10';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� ���������� �������������';
l_FIN_KOD.ORD :=9;
l_FIN_KOD.KOD :='AB9';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='�������� / ������ �� �������������';
l_FIN_KOD.ORD :=15;
l_FIN_KOD.KOD :='AZ15';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ data (���� � ����� �� ���� �����)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='RKD2';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ data (���� � ������ �� ���� �����)';
l_FIN_KOD.ORD :=618;
l_FIN_KOD.KOD :='RKD1';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ data (������� �������)';
l_FIN_KOD.ORD :=616;
l_FIN_KOD.KOD :='RKD0';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ data (����� �������� �������)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='VDD1';
l_FIN_KOD.IDF :=74;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ data (����� �������� �������)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='ZDD1';
l_FIN_KOD.IDF :=75;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ data (����� �������� �������)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='ZDD1';
l_FIN_KOD.IDF :=57;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ data (����� �������� �������)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='VDD1';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ � (���� � ����� �� ���� �����)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='RKN2';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ � (���� � ������ �� ���� �����)';
l_FIN_KOD.ORD :=617;
l_FIN_KOD.KOD :='RKN1';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ � (������� �������)';
l_FIN_KOD.ORD :=615;
l_FIN_KOD.KOD :='RKN0';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ � (����� �������� �������)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='VDN1';
l_FIN_KOD.IDF :=74;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ � (����� �������� �������)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='VDN1';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ � (����� �������� �������)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='ZDN1';
l_FIN_KOD.IDF :=75;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='г����� ������������ ������ � (����� �������� �������)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='ZDN1';
l_FIN_KOD.IDF :=57;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ ����������� �������� ������';
l_FIN_KOD.ORD :=4;
l_FIN_KOD.KOD :='AP4';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��������� �� ����� � ������';
l_FIN_KOD.ORD :=11;
l_FIN_KOD.KOD :='AZ11';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���������� ���������� ���������';
l_FIN_KOD.ORD :=2;
l_FIN_KOD.KOD :='AZ2';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='��������� ������';
l_FIN_KOD.ORD :=2;
l_FIN_KOD.KOD :='AP2';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='����������� ������ ������ �� ��������� ���������, %';
l_FIN_KOD.ORD :=609;
l_FIN_KOD.KOD :='SRKA';
l_FIN_KOD.IDF :=52;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� �� ���� ���������� �������������';
l_FIN_KOD.ORD :=4;
l_FIN_KOD.KOD :='AB4';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� �� ���� ������������ �������������';
l_FIN_KOD.ORD :=14;
l_FIN_KOD.KOD :='AP14';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Գ������ �������';
l_FIN_KOD.ORD :=10;
l_FIN_KOD.KOD :='AZ10';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Գ������ ������';
l_FIN_KOD.ORD :=9;
l_FIN_KOD.KOD :='AZ9';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='���� ����������';
l_FIN_KOD.ORD :=3;
l_FIN_KOD.KOD :='AP3';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='����� �������� ������������� �� �������� EBITDA';
l_FIN_KOD.ORD :=602;
l_FIN_KOD.KOD :='KZDE';
l_FIN_KOD.IDF :=52;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='����� �������� ������������� �� ����� ������� �� ���������';
l_FIN_KOD.ORD :=601;
l_FIN_KOD.KOD :='KZDV';
l_FIN_KOD.IDF :=52;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ �������� / ������';
l_FIN_KOD.ORD :=17;
l_FIN_KOD.KOD :='AZ17';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������ �������� / ������ �� �������� ������';
l_FIN_KOD.ORD :=14;
l_FIN_KOD.KOD :='AZ14';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='������� ��� ����������';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='KKDP';
l_FIN_KOD.IDF :=60;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_FIN_KOD.sql =========*** End
PROMPT ===================================================================================== 
