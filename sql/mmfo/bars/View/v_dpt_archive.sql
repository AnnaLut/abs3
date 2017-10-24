CREATE OR REPLACE FORCE VIEW BARS.V_DPT_ARCHIVE
(
   KF,
   BRANCH,
   DPT_ID,
   ND,
   VIDD_ID,
   VIDD_NM,
   CCY_ID,
   CCY_CODE,
   CTR_AMT,
   CUST_ID,
   CUST_NM,
   ACC_NUM,
   DEP_BAL,
   INT_BAL,
   RATE,
   CTR_DT,
   BEG_DT,
   END_DT,
   CNT_DUBL,
   USER_ID,
   EBPY,
   RPT_DT
)
AS
     SELECT d.KF,
            d.BRANCH,
            d.deposit_id,
            d.ND,
            d.VIDD,
            v.type_name,
            v.kv,
            t.lcv,
            d.LIMIT,
            d.rnk,
            c.nmk,
            a.nls,
            NVL (fost (d.acc, DPT_RPT_UTIL.GET_FINISH_DT) / t.denom, 0)
               AS DEP_BAL,
            NVL (fost (i.acra, DPT_RPT_UTIL.GET_FINISH_DT) / t.denom, 0)
               AS INT_BAL,
            NVL (acrn.fproc (d.acc, DPT_RPT_UTIL.GET_FINISH_DT), 0) AS RATE,
            d.datz,
            d.dat_begin,
            d.dat_end,
            NVL (d.cnt_dubl, 0) AS CNT_DUBL,
            d.USERID,
            CASE WHEN D.ARCHDOC_ID > 0 THEN 'ТАК' ELSE 'НІ' END EBPY,
            (SELECT REQ_BNKDAT
               FROM DPT_EXTREFUSALS
              WHERE DPTID = d.deposit_id AND REQ_STATE = 1)
       FROM BARS.DPT_DEPOSIT_CLOS d
            JOIN BARS.DPT_VIDD v ON (v.VIDD = d.VIDD)
            JOIN BARS.TABVAL$GLOBAL t ON (t.KV = d.KV)
            JOIN BARS.ACCOUNTS a ON (a.ACC = d.ACC)
            JOIN BARS.CUSTOMER c ON (c.RNK = d.RNK)
            JOIN BARS.INT_ACCN i ON (i.ACC = d.ACC AND i.ID = 1)
      WHERE (d.IDUPD) IN (  SELECT MAX (IDUPD)
                              FROM DPT_DEPOSIT_CLOS
                             WHERE BDATE <= DPT_RPT_UTIL.GET_FINISH_DT
                          GROUP BY deposit_id)
   ORDER BY d.VIDD;

COMMENT ON TABLE BARS.V_DPT_ARCHIVE IS 'Архів депозитів ФО';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.KF IS 'Код філіалу (МФО)';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.BRANCH IS 'Код підроздулу (ТВБВ)';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.DPT_ID IS 'Ід. депозитного договору';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.ND IS 'Номер догоовру';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.VIDD_ID IS 'Ід. виду депозиту';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.VIDD_NM IS 'Назва виду депозиту';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.CCY_ID IS 'Валюта';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.CCY_CODE IS 'Символьний код валюти';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.CTR_AMT IS 'Сума договору';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.CUST_ID IS 'Ід. клієнта';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.CUST_NM IS 'Назва клієнта';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.ACC_NUM IS 'Номер депозитного рахунку';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.DEP_BAL IS 'Залишок на депозитному рахунку';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.INT_BAL IS 'Залишок на відсотковому рахунку';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.RATE IS 'Відсткова ставка';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.CTR_DT IS 'Дата укладення договору';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.BEG_DT IS 'Дата початку дії договору';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.END_DT IS 'Дата закінчення дії договору';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.CNT_DUBL IS 'К-ть пролонгацій договору';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.EBPY IS 'ЄБП';

COMMENT ON COLUMN BARS.V_DPT_ARCHIVE.RPT_DT IS 'Звітна дата';



GRANT SELECT ON BARS.V_DPT_ARCHIVE TO BARS_ACCESS_DEFROLE;
