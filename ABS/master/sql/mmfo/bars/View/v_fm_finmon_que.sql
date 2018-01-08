

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_FINMON_QUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_FINMON_QUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_FINMON_QUE ("ID", "REF", "REFTYPE", "ND", "FDATE", "FTIME", "KV", "S", "SQ", "DATD", "ID_A", "MFOA", "NAM_A", "NLSA", "ID_B", "MFOB", "NAM_B", "NLSB", "NAZN", "FIO", "VOBNAME", "OZN", "STATUS", "MONITOR_MODE", "OPR_VID1", "OPR_VID2", "COMM_VID2", "OPR_VID3", "COMM_VID3", "RNK_A", "RNK_B", "OPR_OBL_KOD", "OPR_TERROR", "OPR_NBU", "DAT_I", "PDAT", "KF") AS 
  SELECT f.id,
          f.rec,
          'н' AS refType,
          O.ND,
          TRUNC (o.DAT_A) FDATE,
          TO_CHAR (o.DAT_A, 'HH24MI') FTIME,
          O.KV,
          O.S,
          DECODE (O.KV, 980, O.S, BARS.GL.P_ICURVAL (O.KV, O.S, o.DAT_A)) SQ,
          O.DATD,
          O.ID_A,
          O.MFOA,
          O.NAM_A,
          O.NLSA,
          O.ID_B,
          O.MFOB,
          O.NAM_B,
          O.NLSB,
          O.NAZN,
          NVL (S.FIO, 'яео мас') FIO,
          V.NAME VOBNAME,
          BARS.FINMON_EXPORT.GETSTATUS (O.SOS) OZN,
          f.STATUS,
          f.MONITOR_MODE,
          f.OPR_VID1,
          f.OPR_VID2,
          f.COMM_VID2,
          f.OPR_VID3,
          f.COMM_VID3,
          f.RNK_A,
          f.RNK_B,
          BARS.FINMON_EXPORT.GETOPROBLKOD (f.rec, 2) OPR_OBL_KOD,
          2 OPR_TERROR,
          0 OPR_NBU,
          F.DAT_I,
          o.dat_a,
          f.kf
     FROM                                                                                                                                                                                                                                                                                  /*BARS.STAFF S,*/
         BARS.VOB V,
          BARS.ARC_RRP o,
             bars.finmon_que f
          LEFT JOIN
             BARS.STAFF S
          ON S.ID = f.AGENT_ID
    WHERE                                                                                                                                                                                                                                                                             /*S.ID=O.USERID AND */
         V.VOB = O.VOB AND f.rec IS NOT NULL AND f.REF IS NULL AND f.rec = o.rec
   UNION ALL
   SELECT p.id,
          p.REF,
          'м' AS refType,
          O.ND,
          TRUNC (p.fdat) FDATE,
          TO_CHAR (NVL ( (SELECT MAX (dat)
                            FROM bars.oper_visa ov
                           WHERE o.REF = ov.REF AND status = 2),
                        o.pdat), 'HH24MI')
             FTIME,
          O.KV,
          O.S,
          DECODE (O.KV, 980, O.S, BARS.GL.P_ICURVAL (O.KV, O.S, p.fdat)) SQ,
          O.DATD,
          O.ID_A,
          O.MFOA,
          O.NAM_A,
          O.NLSA,
          O.ID_B,
          O.MFOB,
          O.NAM_B,
          O.NLSB,
          O.NAZN,
          S.FIO,
          V.NAME VOBNAME,
          BARS.FINMON_EXPORT.GETSTATUS (O.SOS) OZN,
          p.STATUS,
          p.MONITOR_MODE,
          p.OPR_VID1,
          p.OPR_VID2,
          p.COMM_VID2,
          p.OPR_VID3,
          p.COMM_VID3,
          p.RNK_A,
          p.RNK_B,
          BARS.FINMON_EXPORT.GETOPROBLKOD (p.REF, 1) OPR_OBL_KOD,
          DECODE (p.status, 'T', 3, 1) OPR_TERROR,
          0 OPR_NBU,
          p.DAT_I,
          o.pdat,
          p.kf
     FROM bars.staff$base S,
          BARS.VOB V,
          (  SELECT DISTINCT f.REF,
                             f.rec,
                             MAX (TRUNC (d.fdat)) FDAT,
                             f.id,
                             f.STATUS,
                             f.MONITOR_MODE,
                             f.OPR_VID1,
                             f.OPR_VID2,
                             f.COMM_VID2,
                             f.OPR_VID3,
                             f.COMM_VID3,
                             f.RNK_A,
                             f.RNK_B,
                             f.AGENT_ID,
                             F.DAT_I,
                             F.KF
               FROM bars.finmon_que f, bars.opldok d
              WHERE f.REF IS NOT NULL AND d.REF = f.REF
           GROUP BY f.REF,
                    f.rec,
                    f.id,
                    f.STATUS,
                    f.MONITOR_MODE,
                    f.OPR_VID1,
                    f.OPR_VID2,
                    f.COMM_VID2,
                    f.OPR_VID3,
                    f.COMM_VID3,
                    f.RNK_A,
                    f.RNK_B,
                    f.AGENT_ID,
                    F.DAT_I,
                    F.KF) p,
          BARS.OPER O
    WHERE p.REF IS NOT NULL AND ( (S.ID = p.AGENT_ID AND p.AGENT_ID IS NOT NULL) OR (S.ID = O.USERID AND p.AGENT_ID IS NULL)) AND V.VOB = O.VOB AND O.REF = p.REF;

PROMPT *** Create  grants  V_FM_FINMON_QUE ***
grant SELECT                                                                 on V_FM_FINMON_QUE to BARS_ACCESS_DEFROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on V_FM_FINMON_QUE to FINMON;
grant SELECT                                                                 on V_FM_FINMON_QUE to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_FINMON_QUE.sql =========*** End **
PROMPT ===================================================================================== 
