

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FINMON_QUE_OPER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FINMON_QUE_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FINMON_QUE_OPER ("ID", "REF", "REC", "DK", "TT", "ND", "DATD", "PDAT", "USERID", "SK", "NLSA", "S", "SQ", "MFOA", "NAM_A", "NLSB", "S2", "SQ2", "MFOB", "NAM_B", "VDAT", "NAZN", "SOS", "ID_A", "ID_B", "KV", "KV2", "STATUS", "STATUS_NAME", "OPR_VID1", "OPR_VID2", "FV2_AGG", "COMM_VID2", "OPR_VID3", "FV3_AGG", "COMM_VID3", "MONITOR_MODE", "AGENT_ID", "IN_DATE", "RNK_A", "RNK_B", "LCV", "DIG", "LCV2", "DIG2", "FIO", "OTM", "TOBO", "COMMENTS", "NMKA", "NMKB") AS 
  SELECT f.id,
          o.REF,
          NULL rec,
          o.dk,
          o.tt,
          o.nd,
          o.datd,
          o.pdat,
          o.userid,
          o.sk,
          o.nlsa,
          o.s,
          gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) AS sq,
          o.mfoa,
          o.nam_a,
          o.nlsb,
          o.s2,
          gl.p_icurval (COALESCE (o.kv2, o.kv, 980), NVL (o.s2, 0), o.vdat)
             AS sq2,
          o.mfob,
          o.nam_b,
          o.vdat,
          o.nazn,
          o.sos,
          o.id_a,
          o.id_b,
          o.kv,
          NVL (o.kv2, o.kv),
          UPPER (f.status) status,
          NVL2 (f.status,
                (SELECT name
                   FROM finmon_que_status
                  WHERE status = f.status),
                NULL)
             status_name,
          f.opr_vid1,
          f.opr_vid2,
          fv2.agg AS fv2_agg,
          f.comm_vid2,
          f.opr_vid3,
          fv3.agg AS fv3_agg,
          f.comm_vid3,
          NVL (f.monitor_mode, 0) AS monitor_mode,
          f.agent_id,
          f.in_date,
          f.rnk_a,
          f.rnk_b,
          t.lcv,
          t.dig,
          t2.lcv,
          t2.dig,
          s.fio,
          q.otm,
          o.tobo,
          f.comments,
          DECODE (
             o.mfoa,
             o.kf, (SELECT c.nmk
                      FROM accounts n, customer c
                     WHERE o.nlsa = n.nls AND o.kv = n.kv AND n.rnk = c.rnk),
             o.nam_a)
             nmka,
          DECODE (
             o.mfob,
             o.kf, (SELECT c.nmk
                      FROM accounts n, customer c
                     WHERE     o.nlsb = n.nls
                           AND NVL (o.kv2, o.kv) = n.kv
                           AND n.rnk = c.rnk),
             o.nam_b)
             nmkb
     FROM oper o,
          tabval t,
          tabval t2,
          finmon_que f,
          (  SELECT f.id AS id,
                    LISTAGG (f.vid, ' ') WITHIN GROUP (ORDER BY (coalesce(f.order_id,0))) AS agg
               FROM finmon_que_vid2 f
           GROUP BY f.id) fv2,
          (  SELECT f.id AS id,
                    LISTAGG (f.vid, ' ') WITHIN GROUP (ORDER BY (f.vid)) AS agg
               FROM finmon_que_vid3 f
           GROUP BY f.id) fv3,
          fm_ref_que q,
          staff$base s
    WHERE     o.kv = t.kv
          AND NVL (o.kv2, o.kv) = t2.kv
          AND o.REF = f.REF(+)
          AND f.id = fv2.id(+)
          AND f.id = fv3.id(+)
          AND f.agent_id = s.id(+)
          AND o.REF = q.REF(+)
          AND (   o.branch LIKE
                     SYS_CONTEXT ('bars_context', 'user_branch_mask')
               OR     o.mfoa = f_ourmfo
                  AND EXISTS
                         (SELECT 1
                            FROM accounts
                           WHERE     nls = o.nlsa
                                 AND kv = o.kv
                                 AND branch LIKE
                                        SYS_CONTEXT ('bars_context',
                                                     'user_branch_mask'))
               OR     o.mfob = f_ourmfo
                  AND EXISTS
                         (SELECT 1
                            FROM accounts
                           WHERE     nls = o.nlsb
                                 AND kv = NVL (o.kv2, o.kv)
                                 AND branch LIKE
                                        SYS_CONTEXT ('bars_context',
                                                     'user_branch_mask')));

PROMPT *** Create  grants  V_FINMON_QUE_OPER ***
grant SELECT                                                                 on V_FINMON_QUE_OPER to BARSREADER_ROLE;
grant SELECT                                                                 on V_FINMON_QUE_OPER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FINMON_QUE_OPER to FINMON01;
grant SELECT                                                                 on V_FINMON_QUE_OPER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FINMON_QUE_OPER.sql =========*** End 
PROMPT ===================================================================================== 
