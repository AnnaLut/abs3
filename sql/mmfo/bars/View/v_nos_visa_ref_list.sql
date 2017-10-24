

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOS_VISA_REF_LIST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOS_VISA_REF_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOS_VISA_REF_LIST ("COLOR1", "COLOR2", "VDAT", "REF", "TT", "NLSA", "NLSB", "MFOB", "NB_B", "S", "S_", "DK", "SK", "LCV1", "DIG1", "USERID", "FIO", "CHK", "NAZN", "LCV2", "DIG2", "S2", "S2_", "ND", "NEXTVISAGRP", "KV", "KV2", "FLAGS", "DEAL_TAG", "DATD", "PDAT", "PRTY", "SOS", "NAM_B", "MFOA", "NB_A", "DATP", "VOB", "NAM_A", "BRANCH", "ID_A", "ID_B") AS 
  SELECT /*+ leading( q doc ) full( q ) index( doc UK_OPER ) */
         SIGN (doc.vdat - bankdate) AS color1,
          NVL (doc.sk, 0) AS color2,
          doc.vdat,
          doc.REF,
          doc.tt,
          doc.nlsa,
          doc.nlsb,
          doc.mfob,
          bb.nb AS nb_b,
          doc.s,
          doc.s / v1.denom AS s_,
          doc.dk,
          doc.sk,
          v1.lcv AS lcv1,
          v1.dig AS dig1,
          doc.userid,
          us.fio,
          doc.chk,
          doc.nazn,
          v2.lcv AS lcv2,
          v2.dig AS dig2,
          doc.s2,
          doc.s2 / v2.denom AS s2_,
          doc.nd,
          doc.nextvisagrp,
          v1.kv,
          v2.kv AS kv2,
          tt.flags || tt.fli AS flags,
          doc.deal_tag,
          doc.datd,
          doc.pdat,
          doc.prty,
          doc.sos,
          doc.nam_b,
          doc.mfoa,
          ba.nb AS nb_a,
          doc.datp,
          doc.vob,
          doc.nam_a,
          doc.branch,
          doc.id_a,
          doc.id_b
     FROM OPER doc
          JOIN REF_QUE q ON (q.REF = doc.REF)
          JOIN SW_OPER swd ON (swd.REF = doc.REF)
          JOIN SW_JOURNAL swj ON (swj.SWREF = swd.SWREF)
          JOIN TTS tt ON (tt.tt = doc.tt)
          JOIN BANKS$BASE ba ON (ba.mfo = doc.mfoa)
          JOIN BANKS$BASE bb ON (bb.mfo = doc.mfob)
          JOIN TABVAL$GLOBAL v1 ON (v1.kv = doc.kv)
          JOIN TABVAL$GLOBAL v2 ON (v2.kv = doc.kv2)
          JOIN STAFF$BASE us ON (us.id = doc.userid)
    WHERE     doc.KF = SYS_CONTEXT ('bars_context', 'user_mfo')
          AND doc.TT = 'NOS'
          AND doc.VDAT = gl.bd ()
          AND doc.SOS < 5
          AND doc.NEXTVISAGRP = '47'                       -- CHK.TO_HEX( 71 )
          AND swj.MT = '103'
          AND swj.TRN IN (SELECT swo.VALUE
                            FROM OPER doc
                                 JOIN SW_OPER swd ON (swd.REF = doc.REF)
                                 JOIN SW_JOURNAL swj
                                    ON (swj.SWREF = swd.SWREF)
                                 JOIN SW_OPERW swo ON (swo.SWREF = swd.SWREF)
                           WHERE     doc.KF =
                                        SYS_CONTEXT ('bars_context',
                                                     'user_mfo')
                                 AND doc.TT = 'D07'
                                 AND doc.SOS = 5
                                 AND doc.VDAT = gl.bd ()
                                 AND swj.MT = '190'
                                 AND swo.TAG = '21');

PROMPT *** Create  grants  V_NOS_VISA_REF_LIST ***
grant SELECT                                                                 on V_NOS_VISA_REF_LIST to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOS_VISA_REF_LIST.sql =========*** En
PROMPT ===================================================================================== 
