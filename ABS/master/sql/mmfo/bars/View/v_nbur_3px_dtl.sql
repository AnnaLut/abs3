PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/View/v_nbur_3px_dtl.sql ======== *** Run *** =
PROMPT ===================================================================================== 

DROP VIEW BARS.V_NBUR_3PX_DTL;

/* Formatted on 17/01/2019 9:31:03 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_3PX_DTL
(
   REPORT_DATE,
   KF,
   NBUC,
   VERSION_ID,
   FIELD_CODE,
   EKP,
   KU,
   K020,
   R030_1,
   R030_2,
   K040,
   S050,
   S184,
   F009,
   F010,
   F011,
   F012,
   F014,
   F028,
   F036,
   F045,
   F047,
   F048,
   F050,
   F052,
   F054,
   F055,
   F070,
   Q001_1,
   Q001_2,
   Q001_3,
   Q001_4,
   Q003_1,
   Q003_2,
   Q003_3,
   Q006,
   Q007_1,
   Q007_2,
   Q007_3,
   Q007_4,
   Q007_5,
   Q007_6,
   Q007_7,
   Q007_8,
   Q007_9,
   Q009,
   Q010_1,
   Q010_2,
   Q010_3,
   Q011_1,
   Q011_2,
   Q012_1,
   Q012_2,
   Q013,
   Q021,
   T071,
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
          p.KF AS NBUC,
          p.VERSION_ID,
          p.EKP || p.R030_1 || p.K020 || p.Q003_3 || p.Q007_9 || p.Q006
             AS FIELD_CODE,
          p.EKP,
          p.KU,
          p.K020,
          p.R030_1,
          p.R030_2,
          p.K040,
          p.S050,
          p.S184,
          p.F009,
          p.F010,
          p.F011,
          p.F012,
          p.F014,
          p.F028,
          p.F036,
          p.F045,
          p.F047,
          p.F048,
          p.F050,
          p.F052,
          p.F054,
          p.F055,
          p.F070,
          p.Q001_1,
          p.Q001_2,
          p.Q001_3,
          p.Q001_4,
          p.Q003_1,
          p.Q003_2,
          p.Q003_3,
          p.Q006,
          p.Q007_1,
          p.Q007_2,
          p.Q007_3,
          p.Q007_4,
          p.Q007_5,
          p.Q007_6,
          p.Q007_7,
          p.Q007_8,
          p.Q007_9,
          p.Q009,
          p.Q010_1,
          p.Q010_2,
          p.Q010_3,
          p.Q011_1,
          p.Q011_2,
          p.Q012_1,
          p.Q012_2,
          p.Q013,
          p.Q021,
          p.T071,
          p.DESCRIPTION,
          p.ACC_ID,
          p.ACC_NUM,
          p.KV,
          p.MATURITY_DATE,
          p.CUST_ID,
          c.CUST_CODE,
          c.CUST_NAME,
          p.ND,
          a.AGRM_NUM,
          a.BEG_DT,
          a.END_DT,
          p.REF,
          p.BRANCH
     FROM NBUR_LOG_F3PX p
          JOIN NBUR_REF_FILES f ON (f.FILE_CODE = '#3P')
          JOIN
          NBUR_LST_FILES v
             ON     (v.REPORT_DATE = p.REPORT_DATE)
                AND (v.KF = p.KF)
                AND (v.VERSION_ID = p.VERSION_ID)
                AND (v.FILE_ID = f.ID)
          LEFT JOIN
          V_NBUR_DM_CUSTOMERS c
             ON     (p.REPORT_DATE = c.REPORT_DATE)
                AND (p.KF = c.KF)
                AND (p.CUST_ID = c.CUST_ID)
          LEFT JOIN
          V_NBUR_DM_AGREEMENTS a
             ON     (p.REPORT_DATE = a.REPORT_DATE)
                AND (p.KF = a.KF)
                AND (p.nd = a.AGRM_ID)
    WHERE v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

COMMENT ON TABLE BARS.V_NBUR_3PX_DTL IS '��������� �������� ����� 3PX';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.VERSION_ID IS '��. ���� �����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.FIELD_CODE IS '�������� ��� ���������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.EKP IS '��� ���������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.KU IS '��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.K020 IS '��� ������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.R030_1 IS '������ (�������)';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.R030_2 IS '������ (����������)';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.K040 IS '��� �����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.S050 IS '��� ���� ����������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.S184 IS '���������� ����� ���������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F009 IS '���  ���� ������� ������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F010 IS '��� ���� �����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F011 IS '��� ������� ��������� �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F012 IS '��� ���� ����� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F014 IS '��� ���� ������� ����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F028 IS '��� �������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F036 IS '��� ������������ ��������� ������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F045 IS '������ �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F047 IS '��� ���� ������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F048 IS '��� ��������� ������ �� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F050 IS 'ֳ� ������������ �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F052 IS '��� ���������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F054 IS '����������� ��������� �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F055 IS '��� ���� �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.F070 IS '��� ���� ������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q001_1 IS '����� ������������/�볺��� �����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q001_2 IS '����� ����������, ��������, �� ������� �������������� ����������� � ���� ������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q001_3 IS '����� ���������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q001_4 IS '����� ����������, ��������, �� ������� �������� �������������� ����������� � ���� ���������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q003_1 IS '�����  ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q003_2 IS '����� ������������� ��������, ������ ���';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q003_3 IS '���������� ����� ������ (�������� � ��������� ������� � ����� �������� ��)';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q006 IS '������� � ����������� ������������ � ��� �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_1 IS '���� ������� ��������������� �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_2 IS '���� ���������� ��������������� �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_3 IS '��������� ���� ������ �����������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_4 IS '������ ���� ������ �����������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_5 IS '���� ��������� ����� ��� ������� �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_6 IS '���� ������� ������� �� ����������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_7 IS '���� ���������� ������� �� ����������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_8 IS '����, ��������� � ��� �������� ����������� �� ������ ���������� ������� ��� ��������������� ����� �������� ����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q007_9 IS '���� ��������� �������� � ������������� �����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q009 IS '���� ������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q010_1 IS '����� ���� (� ������) �� ���������� ����� ������� ������� �� ������ �������������� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q010_2 IS '����� �� ������, �� �� �������� ������� ������� �� ������������� ����� �������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q010_3 IS '����� �� �����, �� �� �������� ������� ������� �� ������������� ����� �������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q011_1 IS '������� �������������� ������� �� ������ ������������ �� �������� ������������ �� ��';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q011_2 IS '������� ������� �� �� (�� �������� ����� �� ��������� ������� �� ���� ������� �� ��������������-����������)';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q012_1 IS '���� 1 ��� ���������� �������� ��������� ������ �� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q012_2 IS '���� 2 ��� ���������� �������� ��������� ������ �� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q013 IS '����� ���� ��������� ������ �� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.Q021 IS '���� ����� �� ��������� � ������������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.T071 IS '����';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.DESCRIPTION IS '���� (��������)';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.ACC_ID IS '��. �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.ACC_NUM IS '����� �������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.KV IS '��. ������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.MATURITY_DATE IS '���� ���������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.CUST_ID IS '��. �볺���';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.CUST_CODE IS '��� �볺���';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.CUST_NAME IS '����� �볺���';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.ND IS '��. ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.AGRM_NUM IS '����� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.BEG_DT IS '���� ������� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.END_DT IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.REF IS '��. ��������� ���������';
COMMENT ON COLUMN BARS.V_NBUR_3PX_DTL.BRANCH IS '��� ��������';


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/View/v_nbur_3px_dtl.sql ======== *** End *** =
PROMPT ===================================================================================== 
