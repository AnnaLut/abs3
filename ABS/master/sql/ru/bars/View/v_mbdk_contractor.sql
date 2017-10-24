CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_CONTRACTOR
(
   RNK,
   NMK,
   OKPO,
   MFO,
   BIC,
   KOD_B,
   CUSTTYPE,
   DATE_ON,
   DATE_OFF,
   TGR,
   C_DST,
   C_REG,
   ND,
   CODCAGENT,
   COD_NAME,
   COUNTRY,
   PRINSIDER,
   PRINS_NAME,
   STMT,
   SAB,
   CRISK,
   ADR,
   VED,
   SED
)
AS 
 SELECT c.rnk,
            c.NMK,
            c.okpo,
            MFO,
            BIC,
            KOD_B,
            c.custtype,
            c.date_on,
            c.date_off,
            c.tgr,
            c.c_dst,
            c.c_reg,
            c.nd,
            c.codcagent,
            g.name cod_name,
            c.country,
            c.prinsider,
            p.name prins_name,
            c.stmt,
            c.SAB,
            c.crisk,
            c.adr,
            c.ved,
            c.sed
       FROM CUSTOMER c
            JOIN CUSTBANK b ON (c.rnk = b.rnk)
            JOIN CODCAGENT g ON (c.codcagent = g.codcagent)
            JOIN PRINSIDER p ON (c.prinsider = p.prinsider)
      WHERE     c.DATE_OFF IS NULL
            AND c.custtype = 1
            AND  (   (c.codcagent = 1 AND b.mfo <> '300465')  OR (c.codcagent = 2 AND b.bic IS NOT NULL))
            AND c.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
            AND c.codcagent IN (1, 2)
      ORDER BY 1;
      
COMMENT ON TABLE BARS.V_MBDK_CONTRACTOR IS '����������� ����';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.RNK IS '���~�����������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.NMK IS '������������ �����������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.OKPO IS '��� ����';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.CUSTTYPE IS '��� (1-����,2-��,~3-��)';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.DATE_ON IS '����~��������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.DATE_OFF IS '����~��������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.TGR IS '���(1-���.,2-���.,~3-������.)';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.C_DST IS '��� �����. �ϲ';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.C_REG IS '��� ���.';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.ND IS '� ��������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.CODCAGENT IS '���-��';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.COD_NAME IS '����� ����';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.COUNTRY IS '��� �����';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.PRINSIDER IS '��� ���������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.PRINS_NAME IS '����� ����';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.STMT IS '������~�������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.SAB IS '��. ���';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.CRISK IS '��������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.ADR IS '������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.VED IS '����~���������~��������';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.SED IS '���~�����~��������';


GRANT SELECT ON BARS.V_MBDK_CONTRACTOR TO BARS_ACCESS_DEFROLE;      