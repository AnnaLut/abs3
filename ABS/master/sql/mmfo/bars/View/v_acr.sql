

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACR.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACR ("BRANCH", "ID", "ACC", "KV", "NLS", "NMS", "RNK", "NBS", "DAOS", "ACRA", "KVA", "NLSA", "ACRB", "KVB", "NLSB", "KVP", "NLSP", "ACR_DAT", "IR", "BR", "BDAT", "APL_DAT") AS 
  SELECT a.BRANCH, i.ID, a.acc,  a.KV, a.NLS , a.NMS,  a.RNK, a.NBS, a.DAOS,
                       aa.acc, aa.KV, aa.NLS,
                       ab.acc, ab.kv, ab.nls,
                              i.KVB, i.NLSB,       --<-- —чет выплаты %%
                       i.acr_dat, r.IR , r.BR,
                       r.bdat, i.APL_DAT
FROM  Accounts a, Accounts aa, Accounts ab,  Int_accn i, Int_ratn r
WHERE a.DAZS is NULL
  AND a.acc = i.acc  and  i.ID in (1,3)
  AND ( a.NBS in ('2560','2600','2603','2604','2650')  OR
        a.NBS='2620' and a.OB22='07' )
  AND a.acc not in (Select ACC from DPU_DEAL)
  AND i.acra= aa.acc(+)
  AND i.acrb= ab.acc(+)
  and i.acc = r.acc (+)
  and i.id  =r.id   (+)
  and (r.acc,r.id,r.bdat) = (select acc,id,max(bdat) from int_ratn
                            where acc=r.acc and id=r.id group by acc,id )
  and ( nvl(r.IR,0)>0 or nvl(r.BR,0)>0 )
  ----and ACRN.FPROCN(a.ACC,1,gl.BD)>0;

PROMPT *** Create  grants  V_ACR ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_ACR           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ACR           to DPT_ADMIN;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_ACR           to START1;
grant FLASHBACK,SELECT                                                       on V_ACR           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACR.sql =========*** End *** ========
PROMPT ===================================================================================== 
