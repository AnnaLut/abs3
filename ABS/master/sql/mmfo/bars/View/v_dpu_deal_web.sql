-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 07.06.2017
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
          b1.nb,
          d.mfo_p,
          d.nls_p,
          d.nms_p,
          NVL (d.okpo_p, c.okpo),
          b2.nb,
          d.comments,
          v.kv,
          t.lcv,
          t.name,
          c.nmk,
          c.okpo,
          c.adr,
          (SELECT SUBSTR (w.VALUE, 1, 1)
             FROM customerw w
            WHERE w.tag = 'K013' AND w.rnk = c.rnk
          ) as K013,
          ir.bdat,
          ir.br,
          br.name,
          ir.op,
          ir.ir,
          d.freqv,
          fr.name,
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
          d.id_stop,
          s.name,
          NVL (d.min_sum / t.denom, 0),
          d.closed,
          NVL (v.fl_add, 0),
          NVL (v.fl_extend, 0),
          d.branch,
          brc.name,
          v.DPU_CODE,
          v.DPU_TYPE,
          v.TERM_TYPE,
          d.TRUSTEE_ID,
          cast( null as varchar2(70)  ) as FIO,      -- tas.fio,
          cast( null as varchar2(100) ) as POSITION, -- tas.position,
          cast( null as varchar2(100) ) as DOCUMENT, -- tas.document,
          d.acc2,
          DECODE((NVL(d.dpu_add,0)+NVL(v.fl_extend,0)), 2, NVL(dt.shablon,v.shablon), v.shablon),
          DECODE(a.ostc, a.ostb, 0, 1) + DECODE (a1.ostc, a1.ostb, 0, 1),
          dt.type_id,
          dt.type_name,
          NVL (d.cnt_dubl, 0)
     FROM dpu_deal d,
          dpu_vidd v,
          tabval t,
          customer c,
          dpt_stop s,
          int_accn ia,
          ( select KF, ACC, ID, BDAT, IR, BR, OP
              from INT_RATN
             where ( ACC, ID, BDAT ) in ( select ACC, ID, max(BDAT)
                                            from INT_RATN
                                           where ID = 1
                                             and BDAT <= gl.bd
                                           group by ACC, ID )
          ) ir,
          banks b1,
          banks b2,
          accounts a,
          accounts a1,
          brates br,
          freq fr,
          branch brc,
          dpu_types dt
    WHERE d.vidd = v.vidd
      AND v.kv = t.kv
      AND v.type_id = dt.type_id
      AND ia.acra = a1.acc
      AND c.rnk = d.rnk
      AND a.acc = d.acc
      AND ia.acc = d.acc
      AND ia.id = 1
      AND ir.acc = d.acc
      AND ir.id = 1
      AND d.mfo_d = b1.mfo(+)
      AND d.mfo_p = b2.mfo(+)
      AND d.id_stop = s.id(+)
      AND ir.br = br.br_id(+)
      AND d.freqv = fr.freq
      AND d.branch = brc.branch
;

show err

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_DPU_DEAL_WEB           IS '��� ��� WEB';

COMMENT ON COLUMN BARS.V_DPU_DEAL_WEB.VISED     IS '�������� �� ��������� �� �������� ��������';
COMMENT ON COLUMN BARS.V_DPU_DEAL_WEB.DPU_TYPE  IS '���������� ���� �������� (S181): 0-�� ������, 1-����������������, 2-��������������';
COMMENT ON COLUMN BARS.V_DPU_DEAL_WEB.TERM_TYPE IS '��� ������ ���� �������� (1 - ���������, 2 - �������)';
COMMENT ON COLUMN BARS.V_DPU_DEAL_WEB.OSTC      IS '������� �� ����������� ������� (���������)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_DPU_DEAL_WEB TO BARS_ACCESS_DEFROLE;
