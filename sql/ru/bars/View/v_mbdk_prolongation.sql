CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_PROLONGATION
(
   ND,
   FDAT,
   NPP,
   TXT,
   KV,
   NLS
)
AS
     SELECT p.nd,
            p.fdat,
            p.npp,
            SUBSTR (p.txt, 1, 250) txt,
            a.kv,
            a.nls
       FROM cc_prol p, accounts a
      WHERE p.acc = a.acc
   ORDER BY p.fdat, p.npp;

COMMENT ON TABLE BARS.V_MBDK_PROLONGATION IS '����: �������� ��� ���� � ����';

COMMENT ON COLUMN BARS.V_MBDK_PROLONGATION.ND IS '����� ��������';

COMMENT ON COLUMN BARS.V_MBDK_PROLONGATION.FDAT IS '���� ���';

COMMENT ON COLUMN BARS.V_MBDK_PROLONGATION.NPP IS '� �/�';

COMMENT ON COLUMN BARS.V_MBDK_PROLONGATION.TXT IS '���� ���';

COMMENT ON COLUMN BARS.V_MBDK_PROLONGATION.KV IS '������';

COMMENT ON COLUMN BARS.V_MBDK_PROLONGATION.NLS IS '�������� �������';

GRANT SELECT ON BARS.V_MBDK_PROLONGATION TO BARS_ACCESS_DEFROLE;
