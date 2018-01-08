
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_lim_bycardcode.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_LIM_BYCARDCODE (p_code in w4_card.code%type)
/*
 2015-10-07 inga
 http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3745
 �� 2. ������ ������ "��� ��������� ����� ���� (������������ (�������) ����� �������) ������� ������������� �������� �� �������: ��/�    �������� �����    ������������ ����� ������� "

 1) �������� �������� ������� ������� � ��, � ����� �������� ������ �� ����������������.
 2) ������ "������ ��������� ���" � �������� ��������� �������� ������� - ���������� ���������� ������

    ECONOM�                 ���������           5000
    STND�                   �����������         5000
    PENS_SOC�               ��������           2148
    PENS_ARS�               �������� "�������" 50000
    SAL_STUD�               ������������        5000
    SAL� ��� (SAL_STUD�)   ����������          45000
    OBU_SAL�     ���������� �����������       60000
    PREM�                   ������             120000
    SOC�                    ����������          0

*/
return number
is
 l_lim  number := 0;
begin
 select
 case
  when p_code like 'ECONOM%'    then 5000
  when p_code like 'STND%'      then 5000
  when p_code like 'PENS_SOC%'  then 2148
  when p_code like 'PENS_ARS%'  then 50000
  when p_code like 'SAL_STUD%'  then 5000
  when p_code like 'SAL_%' and p_code not like 'SAL_STUD%' then 100000
  when p_code like 'OBU_SAL%'   then 60000
  when p_code like 'PREM%'      then 120000
  when p_code like 'SOC%'       then 5000
  else 0
 end
 into l_lim
 from dual;


 return l_lim;
end;
/
 show err;
 
PROMPT *** Create  grants  GET_LIM_BYCARDCODE ***
grant EXECUTE                                                                on GET_LIM_BYCARDCODE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_lim_bycardcode.sql =========***
 PROMPT ===================================================================================== 
 