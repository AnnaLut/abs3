

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_ARCHIVE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_ARCHIVE ("KF", "BRANCH", "DPU_ID", "DPU_GEN", "DPU_ADD", "ND", "VIDD_ID", "VIDD_NM", "CCY_ID", "CCY_CODE", "CTR_AMT", "CUST_ID", "CUST_NM", "CUST_CODE", "ACC_NUM", "DEP_BAL", "INT_BAL", "RATE", "CTR_DT", "BEG_DT", "END_DT", "MAT_DT", "CNT_DUBL", "USER_ID", "RPT_DT") AS 
  select du.KF
     , du.BRANCH
     , du.DPU_ID
     , nvl(du.DPU_GEN, du.DPU_ID)
     , du.DPU_ADD
     , du.ND
     , du.VIDD
     , v.name
     , v.kv
     , t.lcv
     , nvl2(du.DPU_GEN, du.SUM, nvl(sum(nvl2(du.dpu_gen,du.SUM,Null)) over (partition by nvl(du.dpu_gen, du.dpu_id)), du.SUM ))/t.denom
     , du.rnk
     , c.NMK
     , c.OKPO
     , a.NLS
     , nvl(fost(du.acc,DPU_RPT_UTIL.GET_FINISH_DT)/t.denom,0) as DEP_BAL
     , nvl(fost(i.acra,DPU_RPT_UTIL.GET_FINISH_DT)/t.denom,0) as INT_BAL
     , nvl(acrn.fproc(du.acc,DPU_RPT_UTIL.GET_FINISH_DT),0)   as RATE
     , du.datz
     , du.dat_begin
     , du.dat_end
     , du.datv
     , nvl(du.cnt_dubl,0) as CNT_DUBL
     , du.USER_ID
     , DPU_RPT_UTIL.GET_FINISH_DT
  from BARS.DPU_DEAL_UPDATE du
  join BARS.DPU_VIDD v
    on ( v.VIDD = du.VIDD )
  join BARS.TABVAL$GLOBAL t
    on ( t.KV = v.KV )
  join BARS.ACCOUNTS a
    on ( a.ACC = du.ACC )
  join BARS.CUSTOMER c
    on ( c.RNK = du.RNK )
  join BARS.INT_ACCN i
    on ( i.ACC = du.ACC and i.ID = 1 )
 where ( du.IDU ) IN ( select max(IDU)
                         from DPU_DEAL_UPDATE
                        where BDATE <= DPU_RPT_UTIL.GET_FINISH_DT
                        group by DPU_ID )
   and du.TYPEU  < 9 -- без видалених
   and du.CLOSED = 0 -- без закритих
 order by du.VIDD, nvl(du.DPU_GEN,du.DPU_ID), du.DPU_ADD
;

PROMPT *** Create  grants  V_DPU_ARCHIVE ***
grant SELECT                                                                 on V_DPU_ARCHIVE   to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_ARCHIVE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_ARCHIVE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_ARCHIVE.sql =========*** End *** 
PROMPT ===================================================================================== 
