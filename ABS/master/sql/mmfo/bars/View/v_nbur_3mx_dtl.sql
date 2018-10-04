PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3mx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_3MX_DTL
AS
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.Q003_1   as FIELD_CODE
         , p.EKP
         , p.KU
         , p.T071
         , p.Q003_1
         , p.F091
         , p.R030
         , p.F090
         , p.K040
         , p.F089
         , p.K020
         , p.K021
         , p.Q001_1
         , p.B010
         , p.Q033
         , p.Q001_2
         , p.Q003_2
         , p.Q007_1
         , p.F027
         , p.F02D
         , p.Q006
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.CUST_ID
         , p.REF
         , p.BRANCH
    from NBUR_LOG_F3MX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#3M' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table v_nbur_3mx_DTL is '��������� �������� ����� 3MX';
comment on column v_nbur_3mx_DTL.REPORT_DATE is '����� ����';
comment on column v_nbur_3mx_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_3mx_DTL.NBUC is '��� ������ �����';
comment on column v_nbur_3mx_DTL.VERSION_ID is '��. ���� �����';
comment on column v_nbur_3mx_DTL.FIELD_CODE is '��� ���������';
comment on column v_nbur_3mx_DTL.EKP is 'XML ��� ���������';
comment on column v_nbur_3mx_DTL.KU is '��� �������';
comment on column v_nbur_3mx_DTL.T071 is '����';
comment on column v_nbur_3mx_DTL.Q003_1 is '������� ����� �����';
comment on column v_nbur_3mx_DTL.F091 is '��� ��������';
comment on column v_nbur_3mx_DTL.R030 is '��� ������';
comment on column v_nbur_3mx_DTL.F090 is '��� ���� �����������/��������';
comment on column v_nbur_3mx_DTL.K040 is '��� �����';
comment on column v_nbur_3mx_DTL.F089 is '������ �����������';
comment on column v_nbur_3mx_DTL.K020 is '��� ����������/����������';
comment on column v_nbur_3mx_DTL.K021 is '��� ������ ����������������� ����';
comment on column v_nbur_3mx_DTL.Q001_1 is '������������ �볺���';
comment on column v_nbur_3mx_DTL.B010 is '��� ���������� �����';
comment on column v_nbur_3mx_DTL.Q033 is '����� ���������� �����';
comment on column v_nbur_3mx_DTL.Q001_2 is '������������ ����������� - �����������';
comment on column v_nbur_3mx_DTL.Q003_2 is '����� ���������/��������, ���������� ��������/�������� ������';
comment on column v_nbur_3mx_DTL.Q007_1 is '���� ���������/��������, ���������� ��������/�������� ������';
comment on column v_nbur_3mx_DTL.F027 is '��� ����������';
comment on column v_nbur_3mx_DTL.F02D is '��� �� ������� ����������';
comment on column v_nbur_3mx_DTL.Q006 is '³������ ��� ��������';
comment on column v_nbur_3mx_DTL.DESCRIPTION is '���� (��������)';
comment on column v_nbur_3mx_DTL.ACC_ID is '��. �������';
comment on column v_nbur_3mx_DTL.ACC_NUM is '����� �������';
comment on column v_nbur_3mx_DTL.KV is '��. ������';
comment on column v_nbur_3mx_DTL.CUST_ID is '��. �볺���';
comment on column v_nbur_3mx_DTL.REF is '��. ��������� ���������';
comment on column v_nbur_3mx_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3mx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
