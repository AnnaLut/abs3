

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_V.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_V ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_V ("ID", "ND", "CC_ID", "VIDD", "RNK", "AIM", "SOUR", "KV", "S", "FREQ", "GPK", "ACCKRED", "MFOKRED", "DSDATE", "ABDATE", "DWDATE", "AWDATE", "APDATE", "REFV", "REFP", "ISTVAL", "S090", "S080", "PR", "OSTC", "NLS", "ACC", "GRP", "SEC", "SROK", "SOS", "OBS", "NAMK", "CRISK", "ACC8", "PRIM", "BASEM", "DAY", "DAZS", "BRANCH", "CUSTTYPE", "OKPO", "PROD", "SDOG", "KPROLOG", "DAYSN", "NDI", "RCOUN", "RDAT") AS 
  SELECT d.user_id , d.nd     , d.cc_id, d.vidd , d.rnk  ,AD.aim  , AD.sour  ,
 a8.kv     , d.LIMIT  , aD.FREQ, a8.vid ,
 AD.acckred,aD.mfokred, d.sdate,aD.bdate, D.wdate,AD.wdate,AD.pdate  ,
 AD.refv   , AD.refp  , p.ISTVAL, p.s090, p.s080 , acrN.FPROCN(ac.ACC,0,'') ,
 -a8.ostc  , ac.NLS   , ac.acc , ac.grp , ac.sec , d.wdate-aD.wdate,
 d.SOS     , d.obs    , (case when d.vidd in (1,2,3) and c.nmkk is not null then c.nmkk else C.NMK end) nmk,
 NVL (d.fin, c.crisk), a8.acc , TO_NUMBER(a8.nlsalt),
 i.BASEM   ,
 i.s       ,
 a8.dazs   ,
 d.branch, decode(d.vidd, 1,2, 2,2, 3,2, 3 ),
 c.OKPO    , d.PROD   , d.SDOG  , d.kprolog, to_number(f_get_nd_txt(d.nd, 'DAYSN', bankdate)), d.NDI, r.coun, r.dat
FROM CC_DEAL  D,   ACCOUNTS AC,   SPECPARAM P, CUSTOMER C,
    ACCOUNTS A8,   INT_ACCN i ,     CC_ADD AD, nd_acc   N,
    (select nd, count(*) coun, max(fdat) dat from cck_restr group by nd ) r
WHERE AD.nd  =  d.nd      AND aD.ADDS= 0       AND n.nd  =d.nd   AND C.RNK=D.RNK
  AND c.RNK  =  a8.rnk
  AND aD.accs=  ac.acc(+) AND a8.acc = p.acc(+) AND i.acc =a8.acc AND i.id  =0
  and n.acc  =  a8.acc    AND a8.tip ='LIM'     and a8.nls like '8999%'
  and d.nd = r.nd(+)
  and d.vidd in (1,2,3,11,12,13)
  AND not ( d.sos=0 and exists (select 1 from nd_txt
                                where substr(txt,1,1) = '2'
                                  and tag = 'CCSRC'
                                  and nd  = d.nd
                                )
          )
;

PROMPT *** Create  grants  CC_V ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_V            to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_V            to RCC_DEAL;
grant SELECT                                                                 on CC_V            to START1;
grant SELECT                                                                 on CC_V            to WCS_SYNC_USER;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_V            to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_V            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_V.sql =========*** End *** =========
PROMPT ===================================================================================== 
