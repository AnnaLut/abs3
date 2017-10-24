CREATE OR REPLACE FORCE VIEW BARS.V_NONRESID_PARTNERS
(
   RNK,
   NMK,
   NMKK,
   BIC,
   NUM_ND,
   OKPO,
   LIM,
   DAT_ND,
   BKI
)
AS
     SELECT c.rnk,
            c.nmk,
            c.nmkk,
            u.bic,
            u.num_nd,
            c.okpo,
            c.lim / 100 lim,
            u.dat_nd,
            u.bki
       FROM customer C, custbank u
      WHERE     C.DATE_OFF IS NULL
            AND C.rnk = u.rnk
            AND C.codcagent = 2
            AND u.bic IS NOT NULL
            AND c.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
   ORDER BY c.rnk;

COMMENT ON TABLE BARS.V_NONRESID_PARTNERS IS '����: ��������-�����������';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.RNK IS '���';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.NMK IS '�����';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.NMKK IS '����� ���������';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.BIC IS 'BIC-���';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.NUM_ND IS '� ���. �����';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.OKPO IS '����';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.LIM IS '˳��';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.DAT_ND IS '���� ���. �����';

COMMENT ON COLUMN BARS.V_NONRESID_PARTNERS.BKI IS '������~�������� ���ʲ ';


GRANT SELECT ON BARS.V_NONRESID_PARTNERS TO BARS_ACCESS_DEFROLE;