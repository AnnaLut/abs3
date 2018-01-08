

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KASM.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KASM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KASM ("REFA", "DATA", "REFB", "DATB", "HH", "NAME", "NSM", "NOMS", "BRANCH", "B_NAME", "IDZ", "SVID", "KV", "S", "K2", "K3", "K4", "SOSB") AS 
  SELECT refa,
          data,
          refb,
          datb,
          round(hh,2),
          name,
          nsm,
          noms,
          branch,
          b_name,
          idz,
          svid,
          kv,
          s,
          k2,
          k3,
          k4,
          sosb
     FROM (  SELECT a.*,
                    o.s,
                    ov.data,
                    CASE
                       WHEN ovb.datb IS NOT NULL THEN ovb.datb
                       ELSE ov.datb
                    END
                       datb,
                    ob.sosb,
                    CASE
                       WHEN ov.REF IS NOT NULL
                       THEN
                            (  CASE
                                  WHEN ovb.datb IS NOT NULL THEN ovb.datb
                                  ELSE ov.datb
                               END
                             - ov.data)
                          * 24
                    END
                       HH
               FROM (SELECT kas_zv.idm,
                            m.name,
                            kas_zv.ids,
                            s.noms,
                            kas_zv.branch,
                            b.name b_name,
                            kas_zv.dat2,
                            kas_zv.idz,
                            kas_zv.vid,
                            kas_zv.svid,
                            kas_zv.kv,
                            kas_zv.kodv,
                            kas_zv.s1,
                            kas_zv.k2,
                            kas_zv.k3,
                            kas_zv.k4,
                            kas_zv.refa,
                            kas_zv.refb,
                            kas_zv.nsm,
                            kas_zv.sos sosa
                       FROM kas_zv,
                            kas_m m,
                            kas_u s,
                            branch b
                      WHERE     kas_zv.branch = b.branch
                            AND kas_zv.idm = m.idm
                            AND kas_zv.ids = s.ids
                            AND kas_zv.sos >= 2
                            AND kas_zv.sos < 5) a
                    LEFT JOIN (SELECT REF, s / 100 s, sos FROM oper) o
                       ON a.refa = o.REF
                    LEFT JOIN (SELECT REF, DAT DATA, SYSDATE DATB
                                 FROM oper_visa
                                WHERE status = 2) ov
                       ON a.refa = ov.REF AND o.sos >= 4
                    LEFT JOIN (SELECT REF, sos SOSB FROM oper) ob
                       ON a.refb = ob.REF
                    LEFT JOIN (SELECT REF, DAT DATB
                                 FROM oper_visa
                                WHERE status = 2) ovb
                       ON a.refb = ovb.REF AND ob.sosb >= 4
           ORDER BY a.sosa,
                    a.idm,
                    a.branch,
                    a.dat2,
                    a.ids,
                    a.idz);

PROMPT *** Create  grants  V_KASM ***
grant SELECT                                                                 on V_KASM          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_KASM          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KASM          to PYOD001;
grant SELECT                                                                 on V_KASM          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KASM.sql =========*** End *** =======
PROMPT ===================================================================================== 
