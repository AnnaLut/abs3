

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RKO_SETMETHOD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RKO_SETMETHOD ***

  CREATE OR REPLACE PROCEDURE BARS.P_RKO_SETMETHOD (
  p_acc      number,
  p_id_tarif number,
  p_id_rate  number )
is
begin
  if p_id_tarif is null and
     p_id_rate is null then
     delete from rko_method where acc = p_acc;
  else
     begin
        insert into rko_method (acc, id_tarif, id_rate)
        values (p_acc, p_id_tarif, p_id_rate);
     exception when dup_val_on_index then
        update rko_method
           set id_tarif = p_id_tarif,
               id_rate  = p_id_rate
         where acc = p_acc;
     end;
  end if;
end p_rko_setmethod;
/
show err;

PROMPT *** Create  grants  P_RKO_SETMETHOD ***
grant EXECUTE                                                                on P_RKO_SETMETHOD to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_RKO_SETMETHOD to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RKO_SETMETHOD.sql =========*** E
PROMPT ===================================================================================== 
