

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RET_2012.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view RET_2012 ***

  CREATE OR REPLACE FORCE VIEW BARS.RET_2012 ("PROC", "VDAT", "ND", "NAM_A", "NLSA", "NLS", "S", "NAZN", "REF", "BRANCH") AS 
  SELECT (UTL_URL.escape (
              url           =>   'begin null; end;'
                              || '@begin'
                              || ' gl.payv(0,:REF,gl.Bdate,''OWK'',1'
                              || ',980,'''
                              || bpk_get_transit (NULL,
                                                  O.NLSA,
                                                  A.NLS,
                                                  980)
                              || ''','
                              || O.S
                              || ',980,'''
                              || (nbs_ob22_nls('2906','16',a.NLS))
                              || ''','
                              || O.S
                              || '); '
                              || 'end;',
              url_charset   => 'AL32UTF8'))
             proc,
          o.pdat vdat,
          TRIM (o.nd) nd,
          o.nam_a,
          o.nlsa,
          a.nls,
          o.S / 100,
          o.nazn,
          o.REF,
          a.branch
     FROM oper o, saldoa s, opldok k,
          (SELECT acc, nls,
                  nms,
                  ostc,
                  branch
             FROM v_gl
            WHERE nbs = '2625' AND ob22 = '22' AND ostc > 0 AND ostb = ostc) a
    WHERE     o.kv = 980  and a.acc = s.acc and k.fdat = s.fdat and k.acc = s.acc and o.ref = k.ref
          AND o.tt = 'W4V'
          AND o.sos = 5
          AND o.nlsb = a.nls
          AND a.ostc >= o.S
          AND SUBSTR (O.NLSA, 1, 4) = '2906'
          --AND o.vdat >= TO_DATE ('27-05-2012', 'dd-mm-yyyy')
          AND o.pdat >= TO_DATE ('27-05-2012', 'dd-mm-yyyy');

PROMPT *** Create  grants  RET_2012 ***
grant SELECT                                                                 on RET_2012        to BARSREADER_ROLE;
grant SELECT                                                                 on RET_2012        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RET_2012        to PYOD001;
grant SELECT                                                                 on RET_2012        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RET_2012.sql =========*** End *** =====
PROMPT ===================================================================================== 
