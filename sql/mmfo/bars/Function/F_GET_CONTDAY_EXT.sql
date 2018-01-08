
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_contday_ext.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_CONTDAY_EXT 
(
  p_date_low    date,
  p_date_high   date
 ) return number
is
  l_count_day  number;
begin
-- ������� �������� �� ��������� �������� ���������� ���� �� ���� p_date_low �� ���� p_date_high,
-- �������� � �������� ���� �������� p_date_low => 04/05/1952 ��������� ����  p_date_high =>28/04/2017 ������ �������� 6 ���� �� ���� ��������
        SELECT  ADD_MONTHS (
                  p_date_low,
                    TRUNC (
                           (  p_date_high
                            - p_date_low)
                         / 365.25
                       + 1)
                  * 12) -p_date_high
          INTO l_count_day
          FROM DUAL;

       if l_count_day = 365 then
          l_count_day :=0;
       end if;
 return l_count_day;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_CONTDAY_EXT ***
grant EXECUTE                                                                on F_GET_CONTDAY_EXT to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_contday_ext.sql =========*** 
 PROMPT ===================================================================================== 
 