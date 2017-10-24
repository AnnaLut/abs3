

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RKO_SETTARIF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RKO_SETTARIF ***

  CREATE OR REPLACE PROCEDURE BARS.P_RKO_SETTARIF (
  p_acc    number,
  p_indpar number,
  p_organ  number,
  p_dopen  date,
  p_dclose date )
is
begin
  if p_organ is null and
     p_dopen is null and
     p_dclose is null then
     delete from rko_tarif where acc = p_acc and indpar = p_indpar;
  else
     begin
        insert into rko_tarif (acc, indpar, organ, date_open, date_close)
        values (p_acc, p_indpar, p_organ, p_dopen, p_dclose);
     exception when dup_val_on_index then
        update rko_tarif
           set organ = p_organ,
               date_open = p_dopen,
               date_close = p_dclose
         where acc = p_acc
           and indpar = p_indpar;
     end;
  end if;
end p_rko_settarif;
/
show err;

PROMPT *** Create  grants  P_RKO_SETTARIF ***
grant EXECUTE                                                                on P_RKO_SETTARIF  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_RKO_SETTARIF  to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RKO_SETTARIF.sql =========*** En
PROMPT ===================================================================================== 
