--������ �볺���,  ������� �����ii      (customer_field_codes.CODE ='SANKC')

--   ������������� ����������� ���������� �� ��������

exec bc.home;

update customer_field
   set name ='����� ������� ����� �� ��������� �������� (���������� ������)'
 where tag ='RNB1R';

update customer_field
   set name ='������� �������� �� ������ ���� ������ (���������� ������)'
 where tag ='RNB1S';

begin
   for k in (select kf from MV_KF) loop
       bc.subst_mfo(k.kf);

       delete from customerw
        where tag in ('RNB1D','RNB1U');

   end loop;

end;
/

exec bc.home;

  delete from customer_field
        where tag in ('RNB1D','RNB1U');
       
commit;


