
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_acctornk_check.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ACCTORNK_CHECK (p_rnk number, p_newrnk number) return varchar2
is
  l_msg       varchar2(254) := null;
  l_custtype1 varchar2(100);
  l_custtype2 varchar2(100);
begin
  begin
     select decode(custtype,3,decode(nvl(trim(sed),'00'),'91','‘Œ-—œƒ','‘Œ'),'ﬁŒ') into l_custtype1 from customer where rnk = p_rnk;
  exception when no_data_found then null;
  end;
  begin
     select decode(custtype,3,decode(nvl(trim(sed),'00'),'91','‘Œ-—œƒ','‘Œ'),'ﬁŒ') into l_custtype2 from customer where rnk = p_newrnk;
  exception when no_data_found then null;
  end;
  if l_custtype1 <> l_custtype2 then
     l_msg := 'ÕÂ ÒÔ≥‚Ô‡‰‡Â∫ ÚËÔ ÍÎ≥∫ÌÚ‡: –Õ  ' || p_rnk || ' - ' || l_custtype1 || ', –Õ  ' || p_newrnk || ' - ' || l_custtype2 || chr(10) || 'œÓ‰Ó‚ÊËÚË?';
  end if;
  return l_msg;
end f_acctornk_check;
/
 show err;
 
PROMPT *** Create  grants  F_ACCTORNK_CHECK ***
grant EXECUTE                                                                on F_ACCTORNK_CHECK to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ACCTORNK_CHECK to CUST001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_acctornk_check.sql =========*** E
 PROMPT ===================================================================================== 
 