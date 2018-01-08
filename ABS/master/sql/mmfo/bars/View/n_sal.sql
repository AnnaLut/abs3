

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/N_SAL.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view N_SAL ***

  CREATE OR REPLACE FORCE VIEW BARS.N_SAL ("ACC", "KV", "NLS", "NLSALT", "OSTB", "OSTC", "DOS", "KOS", "LIM", "OSTF", "OSTQ", "DOSQ", "KOSQ", "NBS", "NBS2", "PAP", "DAOS", "DAPP", "DAZS", "ISP", "TIP", "VID", "NMS", "TRCN", "BLKD", "BLKK", "ACCC", "POS") AS 
  SELECT
   acc,kv,nls,nlsalt,ostb,ostc,dos,kos,lim,ostf,ostq,dosq,kosq,
   nbs,nbs2,pap,daos,dapp,dazs,isp,tip,vid,nms,trcn,blkd,blkk,accc,pos
  FROM accounts
  WHERE
     isp = (SELECT id FROM staff WHERE logname=USER)
OR acc IN (SELECT acc FROM id_acc WHERE id=(SELECT id FROM staff WHERE logname=USER));

PROMPT *** Create  grants  N_SAL ***
grant SELECT                                                                 on N_SAL           to BARSREADER_ROLE;
grant SELECT                                                                 on N_SAL           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N_SAL           to START1;
grant SELECT                                                                 on N_SAL           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/N_SAL.sql =========*** End *** ========
PROMPT ===================================================================================== 
