

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_CASHVISA_DOCS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_CASHVISA_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_CASHVISA_DOCS ("COLOR1", "COLOR2", "VDAT", "REF", "TT", "NLSA", "NLSB", "MFOB", "NB_B", "S", "S_", "DK", "SK", "LCV1", "DIG1", "USERID", "CHK", "NAZN", "LCV2", "DIG2", "S2", "S2_", "ND", "NEXTVISAGRP", "KV", "KV2", "FLAGS", "DEAL_TAG", "DATD", "PDAT", "PRTY", "SOS", "NAM_B", "MFOA", "NB_A", "DATP", "VOB", "NAM_A", "BRANCH", "ID_A", "ID_B") AS 
  select /*+ full(r) index(a pk_oper) */
       sign (a.vdat - bankdate) as color1,
       nvl(a.sk,0) as color2,
       a.vdat,
       a.ref,
       a.tt,
       a.nlsa,
       a.nlsb,
       a.mfob,
       bb.nb as nb_b,
       a.s,
       a.s / v1.denom as s_,
       a.dk,
       a.sk,
       v1.lcv as lcv1,
       v1.dig as dig1,
       a.userid,
       a.chk,
       a.nazn,
       v2.lcv as lcv2,
       v2.dig as dig2,
       a.s2,
       a.s2 / v2.denom as s2_,
       a.nd,
       a.nextvisagrp,
       v1.kv,
       v2.kv as kv2,
       tt.flags || tt.fli as flags,
       a.deal_tag,
       a.datd,
       a.pdat,
       a.prty,
       a.sos,
       a.nam_b,
       a.mfoa,
       ba.nb as nb_a,
       a.datp,
       a.vob,
       a.nam_a,
       a.branch,
       a.id_a,
       a.id_b
  from ref_que r,
       oper a,
       tabval$global v1,
       tabval$global v2,
       tts tt,
       banks$base ba, banks$base bb
 where v1.kv = a.kv
   and v2.kv = a.kv2
   and a.ref = r.ref
   and a.sos >= 0 and a.sos<5
   and a.tt = tt.tt
   and a.nextvisagrp='01' -- 01 - группа визирования Касса
   and a.mfoa = ba.mfo
   and a.mfob = bb.mfo
   and instr(a.next_visa_branches,
             sys_context('bars_context','user_branch')||',') > 0 -- совпадает один из бранчей;

PROMPT *** Create  grants  V_USER_CASHVISA_DOCS ***
grant SELECT                                                                 on V_USER_CASHVISA_DOCS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_CASHVISA_DOCS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_USER_CASHVISA_DOCS to WR_CHCKINNR_CASH;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_CASHVISA_DOCS.sql =========*** E
PROMPT ===================================================================================== 
