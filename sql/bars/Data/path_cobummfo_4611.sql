--������� ����������� ��������� ������������ ������������ �³�����⳻ ������ ���� ������� 01 �������� 2017 ����.
--http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-4611

Begin
update cp_kod
   set datp = to_date('30-12-2016','dd-mm-yyyy')
 where id = case f_ourmfo_g when '300465' then  0 else 282 end; 

commit;
end;
/