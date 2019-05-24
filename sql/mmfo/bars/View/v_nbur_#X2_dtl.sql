PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#X2_DTL.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#X2_DTL
(
   REPORT_DATE,
   KF,
   VERSION_ID,
   FIELD_CODE,
   SEG_01,
   SEG_02,
   SEG_03,
   FIELD_VALUE,
   DESCRIPTION,
   ACC_ID,
   NBS, 
   ACC_NUM,
   KV,
   MATURITY_DATE,
   CUST_ID,
   CUST_CODE,
   CUST_NAME,
   ND,
   AGRM_NUM,
   BEG_DT,
   END_DT,
   NBUC,
   REF,
   BRANCH
)
AS
   SELECT p.REPORT_DATE,
          p.KF,
          p.VERSION_ID,
          p.FIELD_CODE,
          SUBSTR (p.FIELD_CODE, 1, 2) AS SEG_01,
          SUBSTR (p.FIELD_CODE, 3, 4) AS SEG_02,
          SUBSTR (p.FIELD_CODE, 7, 3) AS SEG_03,
          p.FIELD_VALUE,
          p.DESCRIPTION,
          p.ACC_ID,
          substr(p.ACC_NUM, 1, 4) AS NBS,
          p.ACC_NUM,
          p.KV,
          p.MATURITY_DATE,
          p.CUST_ID,
          c.OKPO CUST_CODE,
          c.NMK CUST_NAME,
          p.ND,
          a.CC_ID AGRM_NUM,
          a.SDATE BEG_DT,
          a.WDATE END_DT,
          (case when p.REF = p.CUST_ID or p.NBUC = '000' then null else p.NBUC end) AS NBUC,
          (case when p.REF = p.CUST_ID or p.NBUC = '000' then null else p.REF end) AS REF,
          p.BRANCH
     FROM NBUR_DETAIL_PROTOCOLS_ARCH p
          JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
          JOIN NBUR_LST_FILES v
             ON (    v.REPORT_DATE = p.REPORT_DATE
                 AND v.KF = p.KF
                 AND v.VERSION_ID = p.VERSION_ID
                 AND v.FILE_ID = f.ID)
          LEFT OUTER JOIN CUSTOMER c ON (p.branch = c.KF AND p.CUST_ID = c.RNK)
          LEFT OUTER JOIN CC_DEAL a ON (p.branch = a.KF AND p.nd = a.ND)
    WHERE p.REPORT_CODE = '#X2' AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

COMMENT ON TABLE BARS.V_NBUR_#X2_DTL IS '��������� �������� ����� #X2';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.REPORT_DATE IS '����� ����';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.KF IS '��� �i�i��� (���)';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.VERSION_ID IS '��. ���� �����';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.FIELD_CODE IS '��� ���������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.SEG_01 IS 'DD';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.SEG_02 IS 'N ����������� ��� i��������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.SEG_03 IS '��� ������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.FIELD_VALUE IS '�������� ���������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.DESCRIPTION IS '���� (��������)';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.ACC_ID IS '��. �������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.NBS IS '���������� �������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.ACC_NUM IS '����� �������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.KV IS '��. ������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.MATURITY_DATE IS '���� ���������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.CUST_ID IS '��. �볺���';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.CUST_CODE IS '��� �볺���';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.CUST_NAME IS '����� �볺���';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.ND IS '��. ��������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.AGRM_NUM IS '����� ��������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.BEG_DT IS '���� ������� ��������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.END_DT IS '���� ��������� ��������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.REF IS '����� ����� �����������';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.NBUC IS '����� ����� �����������  (��� #D8)';

COMMENT ON COLUMN BARS.V_NBUR_#X2_DTL.BRANCH IS '��� ��������';


PROMPT *** Create  grants  V_NBUR_#X2_DTL ***
grant SELECT                                                                 on V_NBUR_#X2_DTL  to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_#X2_DTL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_#X2_DTL  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#X2_DTL.sql =========*** End ***
PROMPT ===================================================================================== GRANT SELECT ON BARS.V_NBUR_#X2_DTL TO BARS_ACCESS_DEFROLE;
