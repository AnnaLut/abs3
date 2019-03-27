

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_CASH2VISA_DOCS2.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_CASH2VISA_DOCS2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_CASH2VISA_DOCS2 ("COLOR1", "COLOR2", "VDAT", "REF", "TT", "NLSA", "NLSB", "MFOB", "NB_B", "S", "S_", "DK", "SK", "LCV1", "DIG1", "USERID", "FIO", "CHK", "NAZN", "LCV2", "DIG2", "S2", "S2_", "ND", "NEXTVISAGRP", "KV", "KV2", "FLAGS", "DEAL_TAG", "DATD", "PDAT", "PRTY", "SOS", "NAM_B", "MFOA", "NB_A", "DATP", "VOB", "NAM_A", "BRANCH", "ID_A", "ID_B") AS 
  SELECT
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
          a.s / (select v1.denom from tabval$global v1 where v1.kv = a.kv) AS s_,
          a.dk,
          a.sk,
          currency_utl.get_currency_lcv(a.kv) AS lcv1,
          currency_utl.get_currency_scale(a.kv) AS dig1,
          a.userid,
          us.fio,
          a.chk,
          a.nazn,
          currency_utl.get_currency_lcv(a.kv2) AS lcv2,
          currency_utl.get_currency_scale(a.kv2) AS dig2,
          a.s2,
          a.s2 / (select v1.denom from tabval$global v1 where v1.kv = a.kv2) AS s2_,
          a.nd,
          a.nextvisagrp,
          a.kv,
          a.kv2 AS kv2,
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
     FROM (select k.* from  oper k , ref_que r where r.ref = k.ref)  a,
          tts tt,
          banks$base ba,
          banks$base bb,
          staff$base us
    WHERE     a.sos >= 0
          AND a.sos < 5
          AND a.tt = tt.tt
          AND a.nextvisagrp = '04'          -- 04 - ������ ����������� �������
          AND a.mfoa = ba.mfo
          AND a.mfob = bb.mfo
          and a.userid = us.id
          AND INSTR (a.next_visa_branches,
                     SYS_CONTEXT ('bars_context', 'user_branch') || ',') > 0  -- ��������� ���� �� �������
;

PROMPT *** Create  grants  V_USER_CASH2VISA_DOCS2 ***
grant SELECT                                                                 on V_USER_CASH2VISA_DOCS2 to BARSREADER_ROLE;
grant SELECT                                                                 on V_USER_CASH2VISA_DOCS2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_CASH2VISA_DOCS2.sql =========***
PROMPT ===================================================================================== 