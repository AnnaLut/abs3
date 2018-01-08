

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FINREZ.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FINREZ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FINREZ ("TT", "REF", "DK", "S", "FDAT", "STMT", "NLS", "NAZN", "NMS", "BRANCH", "BR_FIN", "ACC", "OB22") AS 
  SELECT o.tt,   o.REF,  o.dk,     o.s / 100 S,  o.fdat,  o.stmt,  a.nls,   p.nazn, a.nms,  a.branch,
        SUBSTR (br3_finrez (o.REF, o.stmt, o.dk), 1, 22) br_fin,  a.acc,   a.ob22
 FROM oper p, opldok o,   (SELECT *  FROM v_gl  WHERE nbs LIKE '6%' OR nbs LIKE '7%') a
 WHERE p.REF = o.REF AND o.acc = a.acc
   AND o.fdat >= NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'),  gl.bd)
   AND o.fdat <= NVL (TO_DATE (pul.get_mas_ini_val ('sFdat2'), 'dd.mm.yyyy'),  gl.bd)
          AND LENGTH (br3_finrez (o.REF, o.stmt, o.dk)) < 22;

PROMPT *** Create  grants  V_FINREZ ***
grant SELECT                                                                 on V_FINREZ        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_FINREZ        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_FINREZ        to START1;
grant SELECT                                                                 on V_FINREZ        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FINREZ.sql =========*** End *** =====
PROMPT ===================================================================================== 
