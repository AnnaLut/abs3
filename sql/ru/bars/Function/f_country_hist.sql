
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_country_hist.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_COUNTRY_HIST (pn_rnk number, pd_dat date) return varchar2 is
    ln_country number;
begin
--    select nvl(country, 804)
--    into ln_country
--    from customer_update a
--    where a.rnk = pn_rnk and
--          a.idupd = (select max(idupd)
--                     from customer_update
--                     where rnk = a.rnk and
--                           effectdate <= pd_dat);
--
    select nvl(country, 804)
    into ln_country
    from customer a
    where a.rnk = pn_rnk;

    return ln_country;
exception
    when no_data_found then
        return 804;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_country_hist.sql =========*** End
 PROMPT ===================================================================================== 
 