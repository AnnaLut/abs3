create or replace view bars.v_user_visa_docs as
select /*+ no_parallel(oper) no_index(a idx_oper_vdat_kf) index(a pk_oper)*/ sign (a.vdat - bankdate) as color1,
       nvl (a.sk, 0) as color2,
       a.vdat,
       a.ref,
       a.tt,
       a.nlsa,
       a.nlsb,
       a.mfob,
       (select bb.nb from banks$base bb where a.mfob = bb.mfo) as nb_b,
       a.s,
       a.s / v1.denom as s_,
       a.dk,
       a.sk,
       v1.lcv as lcv1,
       v1.dig as dig1,
       a.userid,
       (select us.fio from staff$base us where a.userid = us.id) fio,
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
       a.tobo,
       (select tt.flags || tt.fli from tts tt where tt.tt = a.tt) as flags,
       a.deal_tag,
       a.datd,
       a.pdat,
       a.prty,
       a.sos,
       a.nam_b,
       a.mfoa,
       (select ba.nb from banks$base ba where a.mfoa = ba.mfo) nb_a,
       a.datp,
       a.vob,
       a.nam_a,
       a.branch,
       a.id_a,
       a.id_b
from   oper a
join   tabval$global v1 on v1.kv = a.kv
join   tabval$global v2 on v2.kv = a.kv2
where  a.sos >= 0 and
       a.sos < 5 and
       a.nextvisagrp in (select v.grpid_hex from v_user_visa v) and
       a.ref in (select q.ref from ref_que q);
PROMPT *** Create  grants  V_USER_VISA_DOCS ***
grant SELECT                                                                 on V_USER_VISA_DOCS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_VISA_DOCS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_USER_VISA_DOCS to WR_CHCKINNR_ALL;

