

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_VISA_DOCS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_VISA_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_VISA_DOCS ("COLOR1", "COLOR2", "VDAT", "REF", "TT", "NLSA", "NLSB", "MFOB", "NB_B", "S", "S_", "DK", "SK", "LCV1", "DIG1", "USERID", "FIO", "CHK", "NAZN", "LCV2", "DIG2", "S2", "S2_", "ND", "NEXTVISAGRP", "KV", "KV2", "TOBO", "FLAGS", "DEAL_TAG", "DATD", "PDAT", "PRTY", "SOS", "NAM_B", "MFOA", "NB_A", "DATP", "VOB", "NAM_A", "BRANCH", "ID_A", "ID_B") AS 
  SELECT /*+ leading(r a) full(r) index(a pk_oper) */
         SIGN (a.vdat - bankdate) AS color1,
          NVL (a.sk, 0) AS color2,
          a.vdat,
          a.REF,
          a.tt,
          a.nlsa,
          a.nlsb,
          a.mfob,
          bb.nb AS nb_b,
          a.s,
          a.s / v1.denom AS s_,
          a.dk,
          a.sk,
          v1.lcv AS lcv1,
          v1.dig AS dig1,
          a.userid,
          us.fio,
          a.chk,
          a.nazn,
          v2.lcv AS lcv2,
          v2.dig AS dig2,
          a.s2,
          a.s2 / v2.denom AS s2_,
          a.nd,
          a.nextvisagrp,
          v1.kv,
          v2.kv AS kv2,
          a.tobo,
          tt.flags || tt.fli AS flags,
          a.deal_tag,
          a.datd,
          a.pdat,
          a.prty,
          a.sos,
          a.nam_b,
          a.mfoa,
          ba.nb AS nb_a,
          a.datp,
          a.vob,
          a.nam_a,
          a.branch,
          a.id_a,
          a.id_b
     FROM ref_que r,
          oper a,
          v_user_visa uv,
          tts tt,
          banks$base ba,
          banks$base bb,
          tabval$global v1,
          tabval$global v2,
          staff$base us
    WHERE     v1.kv = a.kv
          AND v2.kv = a.kv2
          AND a.REF = r.REF
          AND a.sos >= 0
          AND a.sos < 5
          AND a.nextvisagrp = uv.grpid_hex
          AND a.tt = tt.tt
          AND a.mfoa = ba.mfo
          AND a.mfob = bb.mfo
          AND a.userid = us.id;

PROMPT *** Create  grants  V_USER_VISA_DOCS ***
grant SELECT                                                                 on V_USER_VISA_DOCS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_VISA_DOCS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_USER_VISA_DOCS to WR_CHCKINNR_ALL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_VISA_DOCS.sql =========*** End *
PROMPT ===================================================================================== 
