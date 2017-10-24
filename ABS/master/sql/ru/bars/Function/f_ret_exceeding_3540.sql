
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_exceeding_3540.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_EXCEEDING_3540 (acc_ in number, dat_ in date) return number
    -- VERSION     :  22/03/2013
is
  sum_exc  number := 0;
begin
  SELECT nvl(sum(case when c.s_deb > c.s_kred then c.s_deb - c.s_kred else 0 end),0)
  into sum_exc
  FROM (SELECT k.REF kref, k.dk, k.fdat kfdat, nlsa, nlsb, s.dos,
               s.fdat sfdat, s.acc, nazn,
               gl.p_icurval (r.kv,r.s,dat_) s_deb,
               gl.p_icurval (r.kv2, s2,dat_) s_kred
            FROM (SELECT t.acc, t.nls, t.kv, a.dos / 100 dos, a.fdat
                    FROM accounts t, specparam m, saldoa a
                   WHERE t.acc = acc_
                     and t.acc = m.acc
                     AND t.acc = a.acc
                     AND (a.acc, a.fdat) IN (
                            SELECT   acc, MAX (fdat) fdat
                                FROM saldoa
                               WHERE acc = a.acc
                                 AND dos > 0
                                 AND fdat <= dat_
                            GROUP BY acc)) s,
                 opldok k,
                 oper r
           WHERE s.acc = k.acc
             AND k.dk = 0
             AND k.sos = 5
             AND k.fdat = s.fdat
             AND k.REF = r.REF
        ORDER BY 1, 2) c;

   return sum_exc;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_exceeding_3540.sql =========*
 PROMPT ===================================================================================== 
 