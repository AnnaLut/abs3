
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rato.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RATO (
    p_kv        number,
    p_dat       date)
return number
-- ��� ������ �� �������, � �� �� view
result_cache relies_on (cur_rates$base)
--
-- ��������� ��������� ���� ������ �� ����
-- SERG, 17/05/2010
--
-- ����������� ��� ����:
-- ��������� cur_rates$base �� ����� ���������,
-- �� ��������� ���� ��������� ��� ���, � �� ��������� �� ������� � cur_rates$base,
-- ��������� ����������
-- cur_rates = cur_rates_official(���� ��� ���) + cur_rates_commercial(� ����� �������)
--
-- SERG 18/05/2010
--
is
 l_rat number;
begin
    select rate_o/bsum into l_rat
    from cur_rates
    where (kv,vdate) =
            ( select kv,max(vdate) from cur_rates
               where vdate <= p_dat and kv = p_kv
               group by kv);
    return l_rat;
exception when no_data_found then
    raise_application_error(-(20207),'\9314 - �� ����������� ��������� ���� ������ '||p_kv
    ||' �� ���� '||to_char(p_dat,'DD.MM.YYYY')
    ||' �� �������� '||sys_context('bars_context','user_branch')
    ,true);
end rato;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rato.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 