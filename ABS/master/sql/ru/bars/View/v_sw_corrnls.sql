CREATE OR REPLACE FORCE VIEW BARS.V_SW_CORRNLS
(
   KV,
   LCV,
   NLS,
   BIC,
   NAME,
   ACC,
   TRANSIT,
   THEIR_ACC
)
AS
   SELECT an.KV,
          tb.LCV,
          an.NLS,
          ba.BIC,
          sw.NAME,
          ba.ACC,
          ba.TRANSIT,
          ba.THEIR_ACC                                                    
        FROM accounts an
          INNER JOIN bic_acc ba ON ba.acc = an.acc
          INNER JOIN sw_banks sw ON sw.bic = ba.bic
          INNER JOIN tabval tb ON tb.kv = an.kv
          LEFT OUTER JOIN accounts at ON at.acc = ba.TRANSIT;

COMMENT ON TABLE BARS.V_SW_CORRNLS IS 'SWIFT ���������� �����';

COMMENT ON COLUMN BARS.V_SW_CORRNLS.KV IS '���~������';

COMMENT ON COLUMN BARS.V_SW_CORRNLS.LCV IS 'ISO~������';

COMMENT ON COLUMN BARS.V_SW_CORRNLS.NLS IS '���. ���';

COMMENT ON COLUMN BARS.V_SW_CORRNLS.BIC IS 'BIC';

COMMENT ON COLUMN BARS.V_SW_CORRNLS.NAME IS '����� �����';

COMMENT ON COLUMN BARS.V_SW_CORRNLS.TRANSIT IS '���.VOSTRO';

COMMENT ON COLUMN BARS.V_SW_CORRNLS.THEIR_ACC IS '����������~�������';


GRANT INSERT, SELECT, UPDATE ON BARS.V_SW_CORRNLS TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_SW_CORRNLS TO START1;