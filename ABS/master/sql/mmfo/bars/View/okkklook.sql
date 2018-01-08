

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OKKKLOOK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view OKKKLOOK ***

  CREATE OR REPLACE FORCE VIEW BARS.OKKKLOOK ("SAB", "RNK", "NMK", "EOM", "NAEX", "ND", "DATAD", "NLS", "KV1", "NMS", "KOKA", "MFO", "NLSP", "KV2", "NAIMP", "KOKB", "S", "TEXT1", "PRWO", "FL") AS 
  SELECT c.sab,c.rnk,c.nmk,k.eom,k.naex,k.nd,k.datad,k.nls,k.kv,a.nms,k.koka,
          k.mfo,k.nlsp,k.kv,k.naimp,k.kokb,k.s,k.text1,k.prwo,k.fl
     FROM klp k, customer c, accounts a
    WHERE c.sab=substr(k.naex,8,1) || substr(k.naex,10,3) and a.nls=k.nls and
          a.kv=k.kv and k.fl>7 
 ;

PROMPT *** Create  grants  OKKKLOOK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OKKKLOOK        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OKKKLOOK        to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OKKKLOOK        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OKKKLOOK        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OKKKLOOK.sql =========*** End *** =====
PROMPT ===================================================================================== 
