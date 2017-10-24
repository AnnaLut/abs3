
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_visa30.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_VISA30 (p_ref number, p_dk number) return number
is
  l_ret number := 1;
  i     number;
begin
  begin
     select 1 into i
       from opldok o, accounts a
      where o.ref = p_ref
        and o.acc = a.acc and a.tip like 'W4%'
        and o.dk  = p_dk;
  exception when no_data_found then l_ret := 0;
            when too_many_rows then l_ret := 1;
  end;
  return l_ret;
end bpk_visa30;
/
 show err;
 
PROMPT *** Create  grants  BPK_VISA30 ***
grant EXECUTE                                                                on BPK_VISA30      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BPK_VISA30      to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_visa30.sql =========*** End ***
 PROMPT ===================================================================================== 
 