
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cp_get_bvondate.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CP_GET_BVONDATE (p_id in cp_kod.id%type, p_figure in varchar2, p_dat in date) return number
is
 /*14/03/2017*/
 l_res number;
 sqlstr varchar2(32000);
 h constant varchar2(32) := 'CP_HIERARCHY: f_cp_get_bvondate:';
begin
 bars_audit.info(h||'('||p_id||','||p_figure||','||to_char(p_dat,'dd/mm/yyyy')||')');
sqlstr := 'WITH dd AS (SELECT :p_dat d FROM DUAL)
   SELECT ' ||
   case when p_figure = 'BV' then ' sum( nvl(osta,0)
           + nvl(ostd,0)
           + nvl(ostp,0)
           + nvl(ostr,0)
           + nvl(ostr2,0)
           + nvl(ostr3,0)
           + nvl(ostunrec,0)
           + nvl(osts,0)
           + nvl(OST_2VD,0)
           + nvl(OST_2VP,0)
           + nvl(OSTEXPN,0)
           + nvl(OSTEXPR,0)
           + nvl(rez,0)) BAL_VAR '
        when  p_figure = 'N' then 'sum(osta)'
        when  p_figure ='KIL' then '  sum(ROUND ((  FOSTZN (acc, COALESCE (dd.d, gl.bd))
              / NULLIF (F_CENA_CP (id, COALESCE (dd.d, gl.bd), 0), 0)
              * DECODE (tip, 1, -1, 1) / 100), 0))'
   end
     ||
     'FROM dd,
          (SELECT o.sos, o.nd, o.datd,
                  o.s / 100 SUMB,
                  a.dazs, k.tip, e.REF, k.ID, k.cp_id, k.datp MDATE, k.ir,
                  ROUND (DECODE (e.erate, NULL, e.erat * 100 * 365, e.erat), 4) ERAT,
                  e.ryn p_ryn, v.vidd, a.kv, a.acc, e.accd ACCD,
                  e.accp ACCP, e.accr ACCR, e.accr2 ACCR2, e.accr3 ACCR3, e.accunrec ACCUNREC,
                  e.accEXPN ACCEXPN,e.accEXPR ACCEXPR,s.acc ACCS,
                  p_icurval(k.kv,NVL (fostzng (a.acc, COALESCE (dd.d, gl.bd)), 0), dd.d)/ 100 OSTA,
                  p_icurval(k.kv,DECODE (k.dox, 1, 0, NVL (fostzng (e.accd, COALESCE (dd.d, gl.bd)), 0)),dd.d)/ 100 OSTD,
                  p_icurval(k.kv,DECODE (k.dox, 1, 0, NVL (fostzng (p.acc, COALESCE (dd.d, gl.bd)), 0)), dd.d)/ 100 OSTP,
                  p_icurval(k.kv,NVL (fostzng (e.ACCr, COALESCE (dd.d, gl.bd)), 0), dd.d)/ 100 OSTR,
                  p_icurval(k.kv,NVL (fostzng (e.ACCr2, COALESCE (dd.d, gl.bd)), 0), dd.d)/ 100 OSTR2,
                  p_icurval(k.kv,NVL (fostzng (e.ACCr3, COALESCE (dd.d, gl.bd)), 0), dd.d)/ 100 OSTR3,
                  p_icurval(k.kv,NVL (fostzng (e.ACCUNREC, COALESCE (dd.d, gl.bd)), 0), dd.d)/ 100 OSTUNREC,
                  p_icurval(k.kv,NVL (fostzng (e.ACCEXPN, COALESCE (dd.d, gl.bd)), 0), dd.d)/ 100 OSTEXPN,
                  p_icurval(k.kv,NVL (fostzng (e.ACCEXPR, COALESCE (dd.d, gl.bd)), 0), dd.d)/ 100 OSTEXPR,
                  p_icurval(k.kv,NVL (fostzng (s.acc, COALESCE (dd.d, gl.bd)), 0), dd.d)/ 100 OSTS,
                  p_icurval(k.kv,NVL (a.ostb, 0), dd.d)/ 100 OSTAB,
                  p_icurval(k.kv,NVL (a.ostb + a.ostf, 0), dd.d)/ 100 OSTAF,
                  (SELECT sum(rez39) FROM NBU23_REZ r where r.nd = e.ref and fdat = add_months(trunc(dd.d,''month''),1)) rez,
                  k.emi, k.dox, k.rnk, v.pf, cp.NAME PFNAME, NVL (a.dapp, a.daos) DAPP, o.datp,
                  (SELECT   NVL ( SUM (fost (a2d.acc, COALESCE (dd.d, gl.bd))), 0)/ 100
                     FROM cp_ref_acc c2d, accounts a2d
                    WHERE     c2d.REF = e.REF
                          AND a2d.acc = c2d.acc
                          AND a2d.tip = ''2VD'') OST_2VD,
                  (SELECT   NVL ( SUM (fost (a2p.acc, COALESCE (dd.d, gl.bd))), 0) / 100
                     FROM cp_ref_acc c2p, accounts a2p
                    WHERE     c2p.REF = e.REF
                          AND a2p.acc = c2p.acc
                          AND a2p.tip = ''2VP'') OST_2VP,                  country,
                  NVL (cp.no_p, 0) no_p, LEAST (
                     CASE WHEN o.sos > 0 AND o.sos < 5 THEN 0
                          WHEN o.sos = 5 THEN 1
                          WHEN o.sos < 0 THEN -1
                     END, e.active) AS active
             FROM cp_kod k, dd, cp_deal e,
                  (SELECT * FROM accounts t, cp_accounts ca WHERE CA.CP_ACC = t.acc and coalesce(t.nbs,substr(t.nls,1,4)) != ''4203'') a,
                  (SELECT * FROM accounts t, cp_accounts ca WHERE CA.CP_ACC = t.acc and coalesce(t.nbs,substr(t.nls,1,4)) != ''4203'') p,
                  (SELECT * FROM accounts t, cp_accounts ca WHERE CA.CP_ACC = t.acc and coalesce(t.nbs,substr(t.nls,1,4)) != ''4203'') s,
                  cp_vidd v, cp_pf cp, oper o
            WHERE     v.vidd IN  (SUBSTR (a.nls, 1, 4), NVL (SUBSTR (p.nls, 1, 4), ''''))
                  AND o.REF = e.REF
                  AND k.ID = e.ID
                  and k.id = :p_id
                  AND a.acc = e.acc
                  AND p.acc(+) = e.accp AND s.acc(+) = e.accs
                  AND v.pf = cp.pf AND v.emi = k.emi)';
 bars_audit.info(h||sqlstr);
 execute immediate sqlstr into l_res using p_dat, p_id;
 return abs(l_res);
end f_cp_get_bvondate;
/
 show err;
 
PROMPT *** Create  grants  F_CP_GET_BVONDATE ***
grant EXECUTE                                                                on F_CP_GET_BVONDATE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cp_get_bvondate.sql =========*** 
 PROMPT ===================================================================================== 
 