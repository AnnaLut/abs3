

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACR_DATSV.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view ACR_DATSV ***

  CREATE OR REPLACE FORCE VIEW BARS.ACR_DATSV ("ACC", "ID", "DAT", "REF", "TT", "VOB", "ND", "PDAT", "VDAT", "KV", "DK", "S", "SQ", "SK", "DATD", "DATP", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "NAZN", "D_REC", "USERID", "ID_A", "ID_B", "ID_O", "SIGN", "SOS", "VP", "CHK", "S2", "KV2", "KVQ", "REFL", "PRTY", "CURRVISAGRP", "NEXTVISAGRP", "REF_A") AS 
  select e.acc, e.id, p.int_date dat, o.ref, o.tt, o.vob, o.nd, o.pdat, o.vdat, o.kv, o.dk,
       o.s, o.sq, o.sk, o.datd, o.datp, o.nam_a, o.nlsa, o.mfoa, o.nam_b, o.nlsb, o.mfob,
       o.nazn, o.d_rec, o.userid, o.id_a, o.id_b, o.id_o, o.sign, o.sos, o.vp,
       o.chk, o.s2, o.kv2, o.kvq, o.refl, o.prty, o.currvisagrp, o.nextvisagrp, o.ref_a
  from int_accn e, acr_docs p, oper o
 where e.acc     = p.acc
   and e.id      = p.id
   and p.int_ref = o.ref
 ;

PROMPT *** Create  grants  ACR_DATSV ***
grant SELECT                                                                 on ACR_DATSV       to BARSREADER_ROLE;
grant SELECT                                                                 on ACR_DATSV       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACR_DATSV       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACR_DATSV.sql =========*** End *** ====
PROMPT ===================================================================================== 
