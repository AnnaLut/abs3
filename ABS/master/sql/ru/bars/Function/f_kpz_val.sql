
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_kpz_val.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_KPZ_VAL (p_kpz integer) RETURN varchar2 is

/* ������ 1.0 06-09-2016
   ���������� ���������� ����. �������� ����� ������������� �� KPZ
   -------------------------------------
    1 (�������) - KPZ >= 1.3
    2 (������)  - KPZ >= 1
    3 (�������) - KPZ <  1, ��� ������������ ������

 */

 l_name varchar2(20);

begin
   begin
      select  name into l_name from KPZ where p_kpz BETWEEN kpz_min AND kpz_max;
   exception when NO_DATA_FOUND THEN l_name := '�������';
   end;
   return l_name;
end;
/
 show err;
 
PROMPT *** Create  grants  F_KPZ_VAL ***
grant EXECUTE                                                                on F_KPZ_VAL       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_KPZ_VAL       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_kpz_val.sql =========*** End *** 
 PROMPT ===================================================================================== 
 