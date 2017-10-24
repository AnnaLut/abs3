
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_swi_sum_ret.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SWI_SUM_RET (p_s number)  return number is
/* ��������� ����� �������� �������� ��� �������� ������� ��� ��������� ���� DATT */
 l_date_tran date default sysdate;
begin
 -- ��������� ���� �������� - �������� DATT, ����� ������� �� ���
 l_date_tran := trunc(sysdate);
 begin
    select to_date (w.value, 'DD/MM/YYYY' ) into l_date_tran from operw w where w.ref = gl.aRef and w.tag  = 'DATT';
 exception when others then l_date_tran := trunc(sysdate);
 end;
 if l_date_tran != trunc(sysdate) then -- ���� �������� �� �������
    return 0;
 end if;
 return p_s;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_swi_sum_ret.sql =========*** End 
 PROMPT ===================================================================================== 
 