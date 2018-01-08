

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POG_ARJK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view POG_ARJK ***

  CREATE OR REPLACE FORCE VIEW BARS.POG_ARJK ("ARJK", "B", "E", "RNK", "ND", "DAT1", "KV", "POGK", "POGP", "POGT", "NMK", "OKPO", "CC_ID", "VXT", "IXT", "VXP", "IXP", "VXK", "IXK") AS 
  SELECT TO_NUMBER (cck_app.get_nd_txt (e.nd, 'ARJK')) ARJK,
          v.B,
          v.E,
          c.rnk,
          e.ND,
          SUBSTR (T.TXT, 1, 10) DAT1,
          x.kv,
          x.pogk,
          x.pogP,
          x.pogt,
          c.nmk,
          c.okpo,
          e.cc_id,
          (SELECT -fost (q.acc, v.B - 1)
             FROM nd_acc m, accounts q
            WHERE m.nd = e.nd AND m.acc = q.acc AND q.tip IN ('LIM'))
             vxt,
          (SELECT -fost (q.acc, v.E)
             FROM nd_acc m, accounts q
            WHERE m.nd = e.nd AND m.acc = q.acc AND q.tip IN ('LIM'))
             ixt,
          (SELECT -SUM (fost (q.acc, v.B - 1))
             FROM nd_acc m, accounts q
            WHERE     m.nd = e.nd
                  AND m.acc = q.acc
                  AND (q.nbs LIKE '22_8' OR q.nbs LIKE '22_9'))
             vxp,
          (SELECT -SUM (fost (q.acc, v.E))
             FROM nd_acc m, accounts q
            WHERE     m.nd = e.nd
                  AND m.acc = q.acc
                  AND (q.nbs LIKE '22_8' OR q.nbs LIKE '22_9'))
             ixp,
          (SELECT -SUM (fost (q.acc, v.B - 1))
             FROM nd_acc m, accounts q
            WHERE m.nd = e.nd AND m.acc = q.acc AND (q.nbs LIKE '35__'))
             vxk,
          (SELECT -SUM (fost (q.acc, v.E))
             FROM nd_acc m, accounts q
            WHERE m.nd = e.nd AND m.acc = q.acc AND (q.nbs LIKE '35__'))
             ixk
     FROM V_SFDAT v,
          customer c,
          cc_deal e,
          (SELECT *
             FROM nd_txt
            WHERE tag = 'DINDU') t,
          (  SELECT K.ND,
                    k.kv,
                    SUM (CASE WHEN K.NBS LIKE '35__' THEN K.s ELSE 0 END) pogk,
                    SUM (
                       CASE
                          WHEN K.NBS LIKE '22_8' OR K.NBS LIKE '22_9' THEN K.s
                          ELSE 0
                       END)
                       pogP,
                    SUM (
                       CASE
                          WHEN     K.NBS NOT LIKE '22_8'
                               AND K.NBS NOT LIKE '22_9'
                               AND K.NBS NOT LIKE '35__'
                          THEN
                             K.s
                          ELSE
                             0
                       END)
                       pogt
               FROM (SELECT o.REF, o.stmt, o.s
                       FROM opldok o, accounts a, V_SFDAT v
                      WHERE     o.sos = 5
                            AND o.fdat >= V.B
                            AND o.fdat <= V.E
                            AND o.dk = 0
                            AND A.ACC = O.ACC
                            AND a.nbs IN (SELECT nbs FROM NBS_DEB_POG)) d,
                    (SELECT O.fdat,
                            o.REF,
                            o.stmt,
                            o.s,
                            n.ND,
                            A.NBS,
                            A.KV
                       FROM (SELECT n.*
                               FROM nd_acc n, nd_txt t
                              WHERE n.nd = t.nd AND t.tag = 'DINDU') n,
                            (SELECT *
                               FROM accounts
                              WHERE nbs IN (SELECT nbs FROM NBS_KRD_POGK
                                            UNION ALL
                                            SELECT nbs FROM NBS_KRD_POGP
                                            UNION ALL
                                            SELECT nbs FROM NBS_KRD_POGT)) a,
                            (SELECT OO.*
                               FROM opldok OO, V_SFDAT v
                              WHERE     OO.sos = 5
                                    AND OO.fdat >= V.B
                                    AND OO.fdat <= V.E
                                    AND OO.dk = 1) o
                      WHERE A.ACC = O.ACC AND A.ACC = n.acc) k
              WHERE k.REF = d.REF AND k.stmt = d.stmt
           GROUP BY K.ND, k.kv) x
    WHERE c.rnk = e.rnk AND e.nd = x.nd(+) AND e.nd = t.nd;

PROMPT *** Create  grants  POG_ARJK ***
grant SELECT                                                                 on POG_ARJK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POG_ARJK        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POG_ARJK.sql =========*** End *** =====
PROMPT ===================================================================================== 
