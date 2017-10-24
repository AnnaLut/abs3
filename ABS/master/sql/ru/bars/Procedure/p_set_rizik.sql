

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SET_RIZIK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SET_RIZIK ***


CREATE OR REPLACE PROCEDURE "P_SET_RIZIK" (p_rnk number, p_rizik varchar2)
is
/*author: lanbina
��. ������������� ������ ����� �������
COBUSUPABS-2301 04.03.2014
lypskykh:
COBUMMFOTEST-775 13.02.2017 ��������� ��� ����
COBUSUPABS-6059 12.06.2017 ���� �� ������ ������� � update-�������
*/
begin
    delete from bars.customerw where rnk = p_rnk and tag = 'RIZIK';
    insert into bars.customerw (rnk, tag, value, isp)
    values (p_rnk, 'RIZIK', p_rizik, 0);
end;
/
show err;

PROMPT *** Create  grants  P_SET_RIZIK ***
grant EXECUTE                                                                on P_SET_RIZIK     to CUST001;
grant EXECUTE                                                                on P_SET_RIZIK     to FINMON01;
grant EXECUTE                                                                on P_SET_RIZIK     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_RIZIK.sql =========*** End *
PROMPT ===================================================================================== 
