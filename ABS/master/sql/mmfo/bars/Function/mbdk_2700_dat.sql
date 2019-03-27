
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/mbdk_2700_dat.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MBDK_2700_DAT (p_nd integer, Mode_ integer) RETURN date is

/* ������ 2.0 08-08-2017
   ����������� ������������ ��������� % ��� 2700

1) 08-08-2017  mode_ = 0 - ����� (��������� � ������� ���������)
                       1 - ���� �� ������� % ���������
*/
l_dat       date;
l_dat_start date;
begin
   l_dat       := gl.bdate;
   l_dat_start := gl.bdate;
   for k in (select * from nd_acc  where nd = p_nd )
   LOOP
      if    k.acc in (54852101, 54852301) THEN l_dat := to_date('01-10-2017','dd-mm-yyyy'); l_dat_start := to_date('01-07-2017','dd-mm-yyyy');
      elsif k.acc in (46941001)           THEN l_dat := to_date('19-01-2018','dd-mm-yyyy'); l_dat_start := to_date('19-07-2017','dd-mm-yyyy');
      elsif k.acc in (25452101)           THEN l_dat := to_date('10-09-2017','dd-mm-yyyy'); l_dat_start := to_date('10-03-2017','dd-mm-yyyy');
      elsif k.acc in (32123101)           THEN l_dat := to_date('20-09-2017','dd-mm-yyyy'); l_dat_start := to_date('20-03-2017','dd-mm-yyyy');
      end if;
   end LOOP;
   if mode_ = 0 THEN return(l_dat_start);
   else              return(l_dat);
   end if;
end;
/
 show err;
 
PROMPT *** Create  grants  MBDK_2700_DAT ***
grant EXECUTE                                                                on MBDK_2700_DAT   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MBDK_2700_DAT   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/mbdk_2700_dat.sql =========*** End 
 PROMPT ===================================================================================== 
 