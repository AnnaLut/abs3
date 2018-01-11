

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPLDOK_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPLDOK_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPLDOK_ACC ("SOS", "REF", "STMT", "TT", "FDAT", "ACC", "NLS", "KV", "DK", "S", "TXT") AS 
  select m.sos, m.ref, m.stmt, m.tt, m.fdat, dk.acc, a.nls, a.kv,
       dk.dk, dk.s, dk.txt from
accounts a,
opldok m,
(select ref, stmt, dacc acc, 0 dk, ds s, dtxt txt from v_opldok_access d
union all
select ref, stmt, kacc acc, 1 dk, ks s, ktxt txt from v_opldok_access k) dk
where m.ref=dk.ref and m.stmt=dk.stmt
and m.dk=0 and a.acc=dk.acc
;

PROMPT *** Create  grants  V_OPLDOK_ACC ***
grant SELECT                                                                 on V_OPLDOK_ACC    to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPLDOK_ACC    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OPLDOK_ACC    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPLDOK_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
