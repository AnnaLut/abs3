CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#F4_DTL
(
   REPORT_DATE,
   KF,
   VERSION_ID,
   NBUC,
   FIELD_CODE,
   SEG_01,
   SEG_02,
   SEG_03,
   SEG_04,
   SEG_05,
   SEG_06,
   SEG_07,
   SEG_08,
   SEG_09,
   SEG_10,
   SEG_11,
   FIELD_VALUE,
   DESCRIPTION,
   ACC_ID,
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
   REF,
   BRANCH
)
AS
   SELECT p.REPORT_DATE,
          p.KF,
          p.VERSION_ID,
          p.NBUC,
          p.FIELD_CODE,
          SUBSTR (p.FIELD_CODE, 1, 1) AS SEG_01,
          SUBSTR (p.FIELD_CODE, 2, 1) AS SEG_02,
          SUBSTR (p.FIELD_CODE, 3, 4) AS SEG_03,
          SUBSTR (p.FIELD_CODE, 7, 1) AS SEG_04,
          SUBSTR (p.FIELD_CODE, 8, 1) AS SEG_05,
          SUBSTR (p.FIELD_CODE, 9, 1) AS SEG_06,
          SUBSTR (p.FIELD_CODE, 10, 1) AS SEG_07,
          SUBSTR (p.FIELD_CODE, 11, 1) AS SEG_08,
          SUBSTR (p.FIELD_CODE, 12, 2) AS SEG_09,
          SUBSTR (p.FIELD_CODE, 14, 3) AS SEG_10,
          SUBSTR (p.FIELD_CODE, 17, 1) AS SEG_11,
          p.FIELD_VALUE,
          p.DESCRIPTION,
          p.ACC_ID,
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
          p.REF,
          p.BRANCH
     FROM NBUR_DETAIL_PROTOCOLS_ARCH p
          JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
          JOIN
          NBUR_LST_FILES v
             ON (    v.REPORT_DATE = p.REPORT_DATE
                 AND v.KF = p.KF
                 AND v.VERSION_ID = p.VERSION_ID
                 AND v.FILE_ID = f.ID)
          LEFT OUTER JOIN CUSTOMER c ON (p.KF = c.KF AND p.CUST_ID = c.RNK)
          LEFT OUTER JOIN CC_DEAL a ON (p.KF = a.KF AND p.nd = a.ND)
    WHERE p.REPORT_CODE = '#F4' AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

COMMENT ON TABLE BARS.V_NBUR_#F4_DTL IS '��������� �������� ����� #F4';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.REPORT_DATE IS '����� ����';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.KF IS '��� �i�i��� (���)';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.VERSION_ID IS '��. ���� �����';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.NBUC IS '��� ������ ����� � ������� ����';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.FIELD_CODE IS '��� ���������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_01 IS '1 - ����, 2 - %% ������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_02 IS '5-�� ������ 6-�� ������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_03 IS '���. ���.';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_04 IS '�������� R013';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_05 IS '��� ����ii ���� ������. �i�������i';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_06 IS '��� ������� ������i��';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_07 IS '��� ����������� ������ ���������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_08 IS '������� ��i���';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_09 IS '�������� D020';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_10 IS '��� ������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.SEG_11 IS '��� ������ ���.����-��';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.FIELD_VALUE IS '�������� ���������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.DESCRIPTION IS '���� (��������)';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.ACC_ID IS '��. �������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.ACC_NUM IS '����� �������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.KV IS '��. ������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.MATURITY_DATE IS '���� ���������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.CUST_ID IS '��. �볺���';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.CUST_CODE IS '��� �볺���';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.CUST_NAME IS '����� �볺���';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.ND IS '��. ��������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.AGRM_NUM IS '����� ��������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.BEG_DT IS '���� ������� ��������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.END_DT IS '���� ��������� ��������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.REF IS '��. ��������� ���������';

COMMENT ON COLUMN BARS.V_NBUR_#F4_DTL.BRANCH IS '��� ��������';



GRANT SELECT ON BARS.V_NBUR_#F4_DTL TO BARSREADER_ROLE;

GRANT SELECT ON BARS.V_NBUR_#F4_DTL TO BARS_ACCESS_DEFROLE;
