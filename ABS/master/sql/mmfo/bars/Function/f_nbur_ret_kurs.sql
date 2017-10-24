
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_ret_kurs.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_RET_KURS (p_kv_ number, p_dat_ date) return number is
	l_dat_ date;
	l_kurs_ number;
	l_bsum_ number;
begin
    begin
        SELECT  r.bsum, r.rate_o
        into l_bsum_, l_kurs_
        FROM cur_rates r
        WHERE r.kv = p_kv_               AND
              r.vdate = (SELECT max(rr.vdate)
                         FROM cur_rates rr
                         WHERE rr.kv=p_kv_ and
                               rr.vdate<=p_dat_);
    exception
        when no_data_found then
            begin -- тимчасовий крок, бо повна фігня з курсами валют (по Криму наприклад немає за дату меншу 01/07/2016)
                SELECT  r.bsum, r.rate_o
                into l_bsum_, l_kurs_
                FROM cur_rates r
                WHERE r.kv = p_kv_               AND
                      r.vdate = (SELECT min(rr.vdate)
                                 FROM cur_rates rr
                                 WHERE rr.kv=p_kv_ and
                                       rr.vdate>=p_dat_);
            exception
                when no_data_found then
                    null;
            end;
    end;

	return l_kurs_/l_bsum_;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_ret_kurs.sql =========*** En
 PROMPT ===================================================================================== 
 