
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_lim_bycardcode.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_LIM_BYCARDCODE (p_code in w4_card.code%type)
/*
 2017-05-30 Skal
 SC-0036102
 �� 2. ������ ������ "��� ��������� ����� ���� (������������ (�������) ����� �������) ������� ������������� �������� �� �������: ��/�    �������� �����    ������������ ����� ������� "

 1) �������� �������� ������� ������� � ��, � ����� �������� ������ �� ����������������.
 2) ������ "������ ��������� ���" � �������� ��������� �������� ������� - ���������� ���������� ������

    ECONOM�                 ���������           5000
    STND�                   �����������         5000
    PENS_SOC�               ��������           15000
    PENS_ARS�               �������� "�������" 30000
    SAL_STUD�               ������������        5000
    SAL� ��� (SAL_STUD�)   ����������          100000
    BUDG_LOYAL_             ���������           100000
    OBU_SAL�     ���������� �����������       60000
    PREM�                   ������             120000
    SOC�                    ����������          5000

*/
return number
is
 l_lim  number := 0;
begin
 select
 case
  when p_code like 'ECONOM%'    then 50000
  when p_code like 'STND%'      then 50000
  when p_code like 'PENS_SOC%'  then 15000
  when p_code like 'PENS_ARS%'  then 30000
  when p_code like 'SAL_STUD%'  then 50000
  when p_code like 'SAL_%' and p_code not like 'SAL_STUD%' then 100000
  when p_code like 'BUDG_LOYAL%' then 100000
  when p_code like 'OBU_SAL%'   then 250000
  when p_code like 'SAL_NBU%'   then 250000
  when p_code like 'PREM%'      then 120000
  when p_code like 'SOC%'       then 50000
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
 