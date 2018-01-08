

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_UNCLEAR_PAYMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UNCLEAR_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_UNCLEAR_PAYMENTS ("NLSA", "KVA", "MFOB", "NLSB", "KVB", "TT", "VOB", "ND", "DATD", "S", "NAM_A", "NAM_B", "NAZN", "NAZN2", "OKPOA", "OKPOB", "GRP", "REF", "SOS", "ID", "SS") AS 
  SELECT   a.nls nlsa,
          a.kv kva,
          a.kf,
          b.nls nlsb,
          b.kv  kvb,
          'PS1' tt,
          6 vob,
          NULL nd,
          o.datd datd,
          o.s  s,
          substr(a.nms,1,38) nam_a,
          substr(b.nms,1,38) nam_b,
          Substr('Ðåô¹'||o.ref||' äîê¹'||o.nd||' â³ä '||to_char(p.fdat,'dd/mm/yyyy')||' '||o.nazn,1,160) nazn,
          Substr('Ðåô¹'||o.ref||' äîê¹'||o.nd||' â³ä '||to_char(p.fdat,'dd/mm/yyyy')||' '||o.nazn,1,160) nazn2,
          SUBSTR (f_ourokpo, 1, 8) okpoa,
          SUBSTR (f_ourokpo, 1, 8) okpob,
          0 grp,
          o.REF,
          0 sos,
          o.REF id
          , o.s ss
     FROM opldok p, oper o,
          v_gl a, saldoa s, accounts b
    WHERE  a.acc = s.acc       and
           a.nls like '2902%'  and a.nbs = '2902' and a.ostc > 0 and
           s.fdat >= gl.bd - 10 and
           p.fdat = s.fdat     and
           p.acc = s.acc       and
           p.dk = 1            and
           p.sos = 5           and
           o.ref = p.ref       and
           o.mfob != o.mfoa    and o.mfob = f_ourmfo and
           b.kv = 980 and b.nls = nbs_ob22_null('2909','08',a.branch)
       --and b.tip = 'NLY'
       AND NOT EXISTS (SELECT 1 FROM per_que  WHERE REF = o.REF);

PROMPT *** Create  grants  V_UNCLEAR_PAYMENTS ***
grant DELETE,SELECT,UPDATE                                                   on V_UNCLEAR_PAYMENTS to BARS015;
grant SELECT                                                                 on V_UNCLEAR_PAYMENTS to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on V_UNCLEAR_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_UNCLEAR_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_UNCLEAR_PAYMENTS.sql =========*** End
PROMPT ===================================================================================== 
