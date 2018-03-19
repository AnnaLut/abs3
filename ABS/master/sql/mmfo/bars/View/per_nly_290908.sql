

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PER_NLY_290908.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view PER_NLY_290908 ***

  CREATE OR REPLACE FORCE VIEW BARS.PER_NLY_290908 ("NLSA", "KVA", "MFOB", "NLSB", "KVB", "TT", "VOB", "ND", "DATD", "S", "NAM_A", "NAM_B", "NAZN", "OKPOA", "OKPOB", "GRP", "REF", "SOS", "ID", "ACC", fdat) AS 
  SELECT a.nls nlsa,
          a.kv kva,
          f_ourmfo mfob,
          a2.nls nlsb,
          a.kv kvb,
          'D66' tt,
          6 vob,
          NULL   nd,
          gl.bd datd,
            o.s  s,
          CASE
             WHEN SUBSTR (a.nls, 0, 4) IN (SELECT nbs FROM NBS_PRINT_BANK) 
             THEN
                SUBSTR (GetGlobalOption ('NAME'), 1, 38)
             ELSE
                SUBSTR (a.nms, 1, 38)
          END
             nam_a,
          a2.nms  nam_b,                                               
          (SELECT nazn FROM oper WHERE REF = o.REF)         nazn,
          SUBSTR (f_ourokpo, 1, 8) okpoa,
          SUBSTR (f_ourokpo, 1, 8) okpob,
          0 grp,
          o.REF,
          0 sos,
          o.REF id,
          a.acc,
		  o.fdat
     FROM opldok o,
          v_gl a,
          saldoa ss,
          nlk_ref k,
          accounts a2
    WHERE     a.nls LIKE '2909%' and a.ob22 = '08' and a.tip = 'NLY'
          and k.acc = a.acc and k.ref2 is  null
          and o.ref = k.ref1
          AND ss.acc = a.acc
          AND ss.fdat BETWEEN SYSDATE -1395 AND SYSDATE-1095
          AND o.fdat = ss.fdat
          AND o.acc = ss.acc
          AND o.sos = 5
          AND o.dk = 1
          and a2.nls = nbs_ob22_null('6340','09',a.branch) and a2.kv = 980;
		  
		  -- 6399/08

PROMPT *** Create  grants  PER_NLY_290908 ***
grant DELETE,SELECT,UPDATE                                                   on PER_NLY_290908  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PER_NLY_290908.sql =========*** End ***
PROMPT ===================================================================================== 
