
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_exceeding_3540_by_rnk.sql ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_EXCEEDING_3540_BY_RNK (rnk_ in number, dat_ in date) return number
    -- VERSION     :  22/03/2013
is
  sum_exc  number := 0;
begin
  SELECT abs(nvl(sum(case when a.ostq + nvl(b.ostq,0) < 0  then a.ostq + nvl(b.ostq, 0) else 0 end),0))
  into sum_exc
  from (SELECT substr(s.nls, 6) nls, sum(gl.p_icurval(kv, s.ost, fdat)) ostq
          from sal s, specparam p
          where s.fdat = dat_ and
                s.rnk = rnk_ and
                s.nbs = '3540' and
                s.acc = p.acc and
                p.r013 in ('4', '5') and
                s.ost <> 0
	    group by substr(s.nls, 6)) a
    left outer join
    (SELECT substr(s.nls, 6) nls, sum(gl.p_icurval(kv, s.ost, fdat)) ostq
          from sal s
          where s.fdat = dat_ and
                s.rnk = rnk_ and
                s.nbs = '3640'
		  group by substr(s.nls, 6)) b
    on (substr(a.nls, 6) = substr(b.nls, 6));

   return sum_exc;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_exceeding_3540_by_rnk.sql ===
 PROMPT ===================================================================================== 
 