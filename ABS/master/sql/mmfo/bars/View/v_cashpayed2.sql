

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASHPAYED2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASHPAYED2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASHPAYED2 ("REF", "ACC", "NLS", "KV", "KVNAME", "NMS", "OPTYPE", "S", "SQ", "ND", "DK", "SK", "TT", "TTNAME", "NAZN", "NLSK", "LASTVISADAT", "LASTVISA_USRID", "LASTVISA_USRNAM", "POSTDAT", "POST_USRID", "POST_USRNAM", "OPDATE", "SHIFT", "ENDOPDATE") AS 
  select
  o.ref, v.acc, v.nls, v.kv, tv.name, v.nms,
  decode(l.dk, 0, decode(pap, 1, 1,   0), decode(pap, 1, 0, 1) ),
  l.s,  decode(o.kv, o.kv2, decode( v.kv, 980, l.s, gl.p_icurval( v.kv, l.s, pdat)), o.s2 ) sq,
  nd, l.dk, o.sk, l.tt, t.name, o.nazn,
  ol.nls,
  ov.dat, ov.userid, stv.fio,
  o.pdat, o.userid,  stp.fio,
  opdate, shift,
  bars_cash.next_shift_date(ko.shift, opdate)
from   oper o, opldok l, v_cashaccounts v,
       cash_lastvisa ov, cash_open ko, tts t, tabval tv,
       staff$base stv,  staff$base stp,
       opl ol
where  ov.dat >= ko.opdate and ov.dat <  bars_cash.next_shift_date(ko.shift, opdate)
       and o.ref = l.ref and l.acc = v.acc  and l.sos = 5
       and ov.ref= o.ref
       and t.tt = l.tt
       and o.userid  = stp.id
       and ov.userid = stv.id
       and ol.ref = l.ref and ol.stmt = l.stmt and ol.dk = 1-l.dk
       and tv.kv = v.kv
       and ko.branch = sys_context('bars_context','user_branch')
 ;

PROMPT *** Create  grants  V_CASHPAYED2 ***
grant SELECT                                                                 on V_CASHPAYED2    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CASHPAYED2    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CASHPAYED2    to RPBN001;
grant SELECT                                                                 on V_CASHPAYED2    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CASHPAYED2    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASHPAYED2.sql =========*** End *** =
PROMPT ===================================================================================== 
