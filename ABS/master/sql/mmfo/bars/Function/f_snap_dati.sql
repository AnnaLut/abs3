
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_snap_dati.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SNAP_DATI (pdat_ in date, ptp_ in number default 1) return number is
    l_caldt_ID accm_calendar.caldt_ID%type;
    l_dat      date;
begin
    if ptp_ = 1 then -- щоденний баланс
        select caldt_ID into l_caldt_ID from accm_calendar where caldt_DATE=pdat_;
    elsif ptp_ = 2 then -- місячний баланс
        l_dat := last_day(pdat_) +  1 ;
        l_dat := add_months(l_dat, -1);

        select caldt_ID into l_caldt_ID from accm_calendar where caldt_DATE=l_dat;
    elsif ptp_ = 3 then -- річний баланс
        l_dat := last_day(pdat_) +  1 ;
        l_dat := add_months(l_dat, -12);

        select caldt_ID into l_caldt_ID from accm_calendar where caldt_DATE=l_dat;
    else
        l_caldt_ID := null;
    end if;

    return l_caldt_ID;
exception
    when no_data_found then
        return null;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_snap_dati.sql =========*** End **
 PROMPT ===================================================================================== 
 