
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_dos_kor.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_DOS_KOR (acc_ in number, datb_ in date, date_ in date) return number is
    sumk_   number;
    dat_    date := add_months(trunc(date_, 'mm'), -1);
begin
    select NVL (SUM (dos), 0)
      INTO sumk_
    from saldoz a
    where a.fdat = dat_ and
          a.acc = acc_ and
          a.DOS <> 0;

    return sumk_;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_dos_kor.sql =========*** End 
 PROMPT ===================================================================================== 
 