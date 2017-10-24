
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_chr36.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHR36 (n_ in number)
RETURN VARCHAR2 IS
  s_ char(1);
BEGIN
  s_ := '';
  IF n_ >= 0 AND n_ <= 9 THEN
    s_ := to_char(n_);
  ELSIF n_ <=31 THEN
    s_ := chr(n_+55);
  END IF;
  RETURN s_;
END f_chr36;
/
 show err;
 
PROMPT *** Create  grants  F_CHR36 ***
grant EXECUTE                                                                on F_CHR36         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_chr36.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 