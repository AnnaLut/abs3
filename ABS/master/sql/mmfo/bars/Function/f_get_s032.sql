
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s032.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S032 (acc_ in number, dat_ in date, s031_ in varchar2,
            nd_ number default null) return varchar2
    -----------------------------------------
    -- version 06/03/2012 (07.09.2009)
    -----------------------------------------
    -- nd_ - РЕФ КД, якщо є (якщо не заповнений, то визначемо у функції)
    -----------------------------------------
is
    p080_   varchar2(2);
    s032_   varchar2(2);
    mfo_    number;
    mfou_   number;
    datz_   date := add_months(trunc(dat_, 'mm'),1);
begin
    mfo_ := f_ourmfo;

    -- МФО "родителя"
    BEGIN
       SELECT mfou
         INTO mfou_
         FROM BANKS
        WHERE mfo = mfo_;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN
          mfou_ := mfo_;
    END;

--    --Для ГОУ Сбербанка
--    if 300465 in  (mfo_) then
--       p080_ := s031_;
--    else
       p080_ := f_get_s031(acc_, dat_, s031_, nd_);
--    end if;

    begin
      select s032
      into s032_
      from kl_s031
      where s031=p080_ and
          (d_open is null or d_open <= datz_) and
          (d_close is null or d_close > datz_);
    exception
      when no_data_found then
          s032_ := '9';
    end;

    return s032_;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_S032 ***
grant EXECUTE                                                                on F_GET_S032      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s032.sql =========*** End ***
 PROMPT ===================================================================================== 
 