

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MBK_DSW_CONS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MBK_DSW_CONS ***

  CREATE OR REPLACE PROCEDURE BARS.P_MBK_DSW_CONS (p_date date)
is
begin
    p_mbk_dsw(p_date);

update TMP_MBK_DSW_REP
set con=1 where id in (24,4);

update TMP_MBK_DSW_REP
set con=2 where id in (25,5);

update TMP_MBK_DSW_REP
set con=3 where id in (21,1);

update TMP_MBK_DSW_REP
set con=4 where id in (22,2);

end;
/
show err;

PROMPT *** Create  grants  P_MBK_DSW_CONS ***
grant EXECUTE                                                                on P_MBK_DSW_CONS  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_MBK_DSW_CONS  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MBK_DSW_CONS.sql =========*** En
PROMPT ===================================================================================== 
