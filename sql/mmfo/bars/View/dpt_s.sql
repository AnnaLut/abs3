

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_S.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_S ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_S ("ACC", "NLS", "KV", "ISP", "GRP", "DOS", "KOS", "OST", "ID", "ND", "VIDD", "NAM", "DATN", "DATK", "RNK", "NMK", "ACCN", "BR_ID", "PR", "SN", "FDAT", "REAL_EXPIRE", "BRANCH") AS 
  SELECT a.acc, a.nls, a.kv, a.isp, a.grp,
       decode(s.fdat,b.fdat,s.dos,0), decode(s.fdat,b.fdat,s.kos,0),
       s.ostf - s.dos + s.kos, d.deposit_id, d.nd, v.vidd, v.type_name,
       d.dat_begin, d.dat_end, d.rnk, c.nmk,
       i.acra, v.br_id, acrn.fproc(d.acc,b.fdat),
       decode(d.acc,i.acra,0,fost(i.acra,b.fdat)), b.fdat, a.dazs
     , d.branch
  FROM accounts a, saldoa s, fdat b, dpt_deposit_clos d,
       customer c, dpt_vidd v,int_accn i
 WHERE a.acc = s.acc
   AND d.acc = a.acc
   AND d.action_id = 0
   AND c.rnk = d.rnk
   AND d.vidd = v.vidd
   AND b.fdat <= NVL(a.dazs, b.fdat)
   AND b.fdat >= a.daos
   AND a.acc = i.acc
   AND i.id = 1
   AND (a.acc, s.fdat) =
              (SELECT c.acc,max(c.fdat)
                 FROM saldoa c
                WHERE a.acc = c.acc AND c.fdat <= b.fdat
                GROUP BY c.acc)
 ;

PROMPT *** Create  grants  DPT_S ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_S           to ABS_ADMIN;
grant SELECT                                                                 on DPT_S           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_S           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_S           to DPT;
grant SELECT                                                                 on DPT_S           to START1;
grant SELECT                                                                 on DPT_S           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_S           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_S.sql =========*** End *** ========
PROMPT ===================================================================================== 
