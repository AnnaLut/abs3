-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 30.06.2016
-- ======================================================================================
-- create view V_DPU_ARCHIVE
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_DPU_ARCHIVE
prompt -- ======================================================

CREATE OR REPLACE VIEW BARS.V_DPU_ARCHIVE
( KF
, BRANCH
, DPU_ID
, DPU_GEN
, DPU_ADD 
, ND
, VIDD_ID
, VIDD_NM
, CCY_ID
, CCY_CODE
, CTR_AMT
, CUST_ID
, CUST_NM
, CUST_CODE
, ACC_NUM
, DEP_BAL
, INT_BAL
, RATE
, CTR_DT
, BEG_DT
, END_DT
, MAT_DT
, CNT_DUBL
, USER_ID
, RPT_DT
) as
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

show err

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_DPU_ARCHIVE           IS 'Архів депозитів ЮО';

COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.KF        IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.BRANCH    IS 'Код підроздулу (ТВБВ)';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.DPU_ID    IS 'Ід. депозитного договору';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.DPU_GEN   IS 'Ід. ген. договору';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.DPU_ADD   IS 'Ід. дод. договору (в рамках ген.дог.)';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.ND        IS 'Номер догоовру';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.VIDD_ID   IS 'Ід. виду депозиту';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.VIDD_NM   IS 'Назва виду депозиту';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.CCY_ID    IS 'Валюта';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.CCY_CODE  IS 'Символьний код валюти';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.CUST_ID   IS 'Ід. клієнта';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.CUST_NM   IS 'Назва клієнта';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.CUST_CODE IS 'Код клієнта (ЕДРПОУ)';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.ACC_NUM   IS 'Номер депозитного рахунку';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.DEP_BAL   IS 'Залишок на депозитному рахунку';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.INT_BAL   IS 'Залишок на відсотковому рахунку';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.RATE      IS 'Відсткова ставка';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.BEG_DT    IS 'Дата початку дії договору';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.END_DT    IS 'Дата закінчення дії договору';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.MAT_DT    IS 'Дата погашення (повернення) коштів';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.CNT_DUBL  IS 'К-ть пролонгацій договору';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.CTR_AMT   IS 'Сума договору'; 
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.CTR_DT    IS 'Дата укладення договору';
COMMENT ON COLUMN BARS.V_DPU_ARCHIVE.RPT_DT    IS 'Звітна дата';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_DPU_ARCHIVE TO BARS_ACCESS_DEFROLE;
