

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAYOFF_USSR2.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAYOFF_USSR2 ***

  CREATE OR REPLACE PROCEDURE BARS.PAYOFF_USSR2 (p_date date)
is
   l_blob blob;
begin
   l_blob := f_get_ussr2_payoff_data(p_date);
   delete from tmp_lob where id = -1000;
   insert into tmp_lob(id, blobdata) values(-1000, l_blob);

end;
/
show err;

PROMPT *** Create  grants  PAYOFF_USSR2 ***
grant EXECUTE                                                                on PAYOFF_USSR2    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PAYOFF_USSR2    to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAYOFF_USSR2.sql =========*** End 
PROMPT ===================================================================================== 
