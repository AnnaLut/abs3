begin

   for k in (select kf from MV_KF) loop
       bc.subst_mfo(k.kf);

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '35442539', '��� ''Գ������� ������� ������������ ��''', 
            '���. N 8 �� 22.02.2012 1 �� � ������������ ��������� �������� ������������������');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '36425142', '��� ''������ ���''', 
            '���. N 64 �� 08.07.2013 1 �� � ������������ ��������� �� �������� ��������� �����');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '34046074', '��� ''������''', 
            '���. N 104 �� 27.06.2014 1 �� � ������������ ��������� �������� ������������������');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '38324133', '��� ''���� Գ����''', 
            '���. N 110 �� 26.09.2014 1 �� � ������������ ��������� �� �������� ��������� �����');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '35075436', '��� ''�������� �����Ͳ� ��Ͳ��''', 
            '���. N 147 �� 02.06.2015 1 �� � ������������ ��������� �������� ������������������');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '36426020', '��� ''Բ������� ����Ͳ� ���-2013''', 
            '���. N 148 �� 04.06.2015 1 �� � ������������ ��������� �������� ������������������');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39859339', '��� ''�²�� ������''', 
            '���. N 230 �� 30.05.2016 1 �� � ������������ ��������� �������� ������������������');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '40243180', '��� ��������� ������� Ѳ���̻', 
            '���. N 231 �� 10.05.2016 1 �� � ������������ ��������� ��������� �����');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39776771', '��� �Բ������� �����Ͳ� ��������� ��I�', 
            '���. N 253 �� 19.10.2016 1 �� � ������������ ��������� ��������� �����');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39299501', '��� ''�в����.��Ͳ''', 
            '���. N 288 �� 27.02.2017 1 �� � ������������ ��������� �������� ������������������');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39405417', '��� �Գ������� ������� �������-Բ���ѻ', 
            '���. N 290 �� 15.03.2017 1 �� � ������������ ��������� �������� ������������������');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '36060724', '��� ''�� ������� Բ����''', 
            '���. N 211/25-11 �� 18.06.2014 1 �� � ������������ ��������� �� ���������� ���. ����������');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39601463', '��� ''���''', 
            '���. N 1478 �� 03.06.2016 1 �� � ������������ ��������� ��������� �����');
       
       for k in ( select unique c.rnk, p.okpo
                  from customer c, CUST_PTKC p
                  where c.rnk in (select rnk
                                  from accounts 
                                  where nls like '2909%' 
                                    and kv = 980 
                                    and ob22 = '43') 
                    and c.okpo = p.okpo
                ) 

           loop
      
              update CUST_PTKC set rnk = k.rnk 
              where okpo = k.okpo;
          
           end loop;
        commit;   
   end loop;

end;
/           
          
exec bc.home;
 
