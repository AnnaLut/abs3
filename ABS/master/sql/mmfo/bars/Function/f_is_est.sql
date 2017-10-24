
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_is_est.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_IS_EST (nls_ varchar2, kv_ number) return number is
-- определяет является ли счет счетом технической переоценки
     flag_ number;
begin
  begin
     SELECT 1
     into flag_
     FROM tabval WHERE kv=kv_ and
           nls_ in (s0000,s3800,s3801,s0009,'99000');

    exception
        when no_data_found then
             flag_ := 0;
    end;

    return flag_;
end;
/
 show err;
 
PROMPT *** Create  grants  F_IS_EST ***
grant EXECUTE                                                                on F_IS_EST        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_is_est.sql =========*** End *** =
 PROMPT ===================================================================================== 
 