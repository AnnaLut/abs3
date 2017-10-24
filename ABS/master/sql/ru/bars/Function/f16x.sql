
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f16x.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F16X (n_ int) return char IS
    mask	VARCHAR2(16);
begin
    if n_ < 0 or n_ > 15 then
        return  to_char(n_);
    end if;
	mask := '0123456789ABCDEF';
    return substr(mask, n_+1, 1);
end;
/
 show err;
 
PROMPT *** Create  grants  F16X ***
grant EXECUTE                                                                on F16X            to ABS_ADMIN;
grant EXECUTE                                                                on F16X            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F16X            to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f16x.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 