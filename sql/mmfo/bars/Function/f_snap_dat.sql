
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_snap_dat.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SNAP_DAT (pdat_ in date, ptp_ in number default 1) return date is
    l_dat      date;
begin
    if ptp_ = 1 then -- щоденний баланс
        l_dat := pdat_;
    elsif ptp_ = 2 then -- місячний баланс
        l_dat := last_day(pdat_) +  1 ;
        l_dat := add_months(l_dat, -1);
    elsif ptp_ = 3 then -- річний баланс
        l_dat := last_day(pdat_) +  1 ;
        l_dat := add_months(l_dat, -12);
    else
        l_dat := null;
    end if;

    return l_dat;
exception
    when no_data_found then
        return null;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_snap_dat.sql =========*** End ***
 PROMPT ===================================================================================== 
 