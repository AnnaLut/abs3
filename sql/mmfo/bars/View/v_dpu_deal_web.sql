-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 28.12.2017
-- ======================================================================================
-- create view V_DPU_DEAL_WEB
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_DPU_DEAL_WEB
prompt -- ======================================================

CREATE OR REPLACE FORCE VIEW BARS.V_DPU_DEAL_WEB
( DPU_ID,
  ND,
  VIDD,
  VIDD_NAME,
  RNK,
  SUM,
  DAT_BEGIN,
  DAT_END,
  DATZ,
  DATV,
  MFO_D,
  NLS_D,
  NMS_D,
  NB_D,
  MFO_P,
  NLS_P,
  NMS_P,
  OKPO_P,
  NB_P,
  COMMENTS,
  KV,
  LCV,
  NAMEV,
  NMK,
  OKPO,
  ADR,
  K013,
  BDAT,
  BR,
  BR_NAME,
  OP,
  IR,
  FREQV,
  FREQV_NAME,
  ACC,
  NLS,
  DAPP,
  DAZS,
  OSTB,
  OSTC,
  ACRA,
  ACRB,
  ACR_DAT,
  STP_DAT,
  ACR_NLS,
  ACR_OSTB,
  ACR_OSTC,
  COMPROC,
  DPU_ADD,
  DPU_GEN,
  ID_STOP,
  STOP_NAME,
  MIN_SUM,
  CLOSED,
  FL_ADD,
  FL_EXT,
  BRANCH,
  BRANCH_NAME,
  DPU_CODE,
  DPU_TYPE,
  TERM_TYPE,
  TAS_ID,
  TAS_FIO,
  TAS_POS,
  TAS_DOC,
  ACC2,
  TEMPLATE_ID,
  VISED,
  TYPE_ID,
  TYPE_NAME,
  CNT_DUBL
) AS
   SELECT d.dpu_id,
          d.nd,
          d.vidd,
          v.name,
          d.rnk,
          d.SUM / t.denom,
          d.dat_begin,
          d.dat_end,
          d.datz,
          d.datv,
          d.mfo_d,
          d.nls_d,
          d.nms_d,
          ( select nb from BANKS$BASE where mfo = d.mfo_d ),
          d.mfo_p,
          d.nls_p,
          d.nms_p,
          NVL (d.okpo_p, c.okpo),
          ( select nb from BANKS$BASE where mfo = d.mfo_p ),
          d.comments,
          v.kv,
          t.lcv,
          t.name,
          c.nmk,
          c.okpo,
          c.adr,
          (SELECT substr(w.VALUE, 1, 1)
             FROM CUSTOMERW w
            WHERE w.tag = 'K013' AND w.rnk = c.rnk
          ) as K013,
          ir.bdat,
          ir.br,
          ( select NAME from BRATES where BR_ID = ir.BR ),
          ir.op,
          ir.ir,
          d.freqv,
          ( select NAME from FREQ where FREQ = d.FREQV ),
          a.acc,
          a.nls,
          a.dapp,
          a.dazs,
          NVL(a.OSTB / t.denom, 0),
          NVL(a.OSTC / t.denom, 0),
          ia.acra,
          ia.acrb,
          ia.acr_dat,
          ia.stp_dat,
          a1.nls,
          NVL(a1.OSTB / t.denom, 0),
          NVL(a1.OSTC / t.denom, 0),
          d.comproc,
          NVL (d.dpu_add, 0),
          d.dpu_gen,
          d.ID_STOP,
          ( select NAME from DPT_STOP where ID = d.ID_STOP ),
          NVL (d.min_sum / t.denom, 0),
          d.closed,
          NVL (v.fl_add, 0),
          NVL (v.fl_extend, 0),
          d.BRANCH,
          ( select NAME from BRANCH where BRANCH = d.BRANCH ),
          v.DPU_CODE,
          v.DPU_TYPE,
          v.TERM_TYPE,
          d.TRUSTEE_ID,
          cast( null as varchar2(70)  ) as FIO,      -- tas.fio,
          cast( null as varchar2(100) ) as POSITION, -- tas.position,
          cast( null as varchar2(100) ) as DOCUMENT, -- tas.document,
          d.acc2,
          DECODE((NVL(d.dpu_add,0)+NVL(v.fl_extend,0)), 2, NVL(p.shablon,v.shablon), v.shablon),
          DECODE(a.ostc, a.ostb, 0, 1) + DECODE (a1.ostc, a1.ostb, 0, 1),
          v.TYPE_ID,
          p.TYPE_NAME,
          NVL(d.cnt_dubl, 0)
     from DPU_DEAL d
     join ACCOUNTS a
       on ( a.KF  = d.KF  and a.acc  = d.acc )
     join INT_ACCN ia
       on ( ia.KF = d.KF and ia.acc = d.acc and ia.id = 1 )
     join ACCOUNTS a1
       on ( a1.acc = ia.acra )
     join CUSTOMER c
       on ( c.rnk = d.rnk )
     join DPU_VIDD v
       on ( v.vidd = d.vidd )
     join DPU_TYPES p
       on ( p.TYPE_ID = v.TYPE_ID )
     join TABVAL$GLOBAL t
       on ( t.kv = v.kv )
     join INT_RATN ir
--     join ( select KF, ACC, ID, BDAT, IR, BR, OP
--              from INT_RATN
--             where ( KF, ACC, ID, BDAT ) in ( select KF, ACC, ID, max(BDAT)
--                                                from INT_RATN
--                                               where ID = 1
--                                                 and BDAT <= gl.bd
--                                               group by KF, ACC, ID )
--          ) ir
       on ( ir.KF = ia.KF and ir.ACC = ia.ACC and ir.ID = ia.ID )
    where ( ir.ACC, ir.ID, ir.BDAT) = ( select ACC, ID, max(BDAT)
                                          from INT_RATN
                                         where acc = d.acc 
                                           and ID = 1
                                           and BDAT <= GL.BD()
                                         group by ACC, ID );
;

show err

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_DPU_DEAL_WEB           IS 'Дані для WEB';

COMMENT ON COLUMN BARS.V_DPU_DEAL_WEB.VISED     IS 'Завізовані усі документи по рахунках договору';
COMMENT ON COLUMN BARS.V_DPU_DEAL_WEB.DPU_TYPE  IS 'Строковість виду депозиту (S181): 0-на вимогу, 1-короткостроковий, 2-довгостроковий';
COMMENT ON COLUMN BARS.V_DPU_DEAL_WEB.TERM_TYPE IS 'Тип терміну виду депозиту (1 - фікований, 2 - діапазон)';
COMMENT ON COLUMN BARS.V_DPU_DEAL_WEB.OSTC      IS 'Залишок на депозитному рахунку (фактичний)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_DPU_DEAL_WEB TO BARS_ACCESS_DEFROLE;
