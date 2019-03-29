CREATE OR REPLACE FUNCTION BARS.F_FIN_MAX (p_dat01 date, p_nd integer, p_fin integer, p_tipa integer) RETURN date is

/* ������ 1.1   14-03-2019  10-04-2018
   ���� ������������� ������������� �������� ���.������
14-03-2019(1.1) -���� ���������� � ������ ���.��������    
*/

l_fdat    nbu23_rez.fdat%type;
-- ���� ������� 䳿 ��������� 351  ( COBUSUPABS-7190 "������ ������� ������������� �����������.pdf �.5)
l_start   date := to_date('03-01-2017','dd-mm-yyyy'); 

begin
   for k in (select distinct fdat,fin from rez_cr 
             where  fdat >=l_start and  fdat <= P_dat01 
               and  nd in (select nd   from cc_deal where nd = p_nd union all
                           select ndg  from cc_deal where nd = p_nd union all
                           select p_nd from dual)  
               and  pd_0<>1 
               and  tipa = p_tipa 
             order  by fdat desc
            )
   loop
      if k.fin = p_fin THEN   l_fdat := k.fdat;
      else
      return least(l_fdat,p_dat01);
      end if;
   end loop;
   return least(l_fdat,p_dat01);
end;
/

 show err;
 
PROMPT *** Create  grants  F_FIN_MAX ***
grant EXECUTE                        on F_FIN_MAX to BARS_ACCESS_DEFROLE;
grant EXECUTE                        on F_FIN_MAX to START1;
