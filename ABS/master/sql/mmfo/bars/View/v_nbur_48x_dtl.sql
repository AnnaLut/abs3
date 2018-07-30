PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_48x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_48x_dtl ***

create or replace view v_nbur_48x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.Q003 as FIELD_CODE
         , p.EKP
         , p.Q003
         , p.Q001
         , p.Q002
         , p.Q008
         , p.Q029
         , p.K020
         , p.K021
         , p.K040
         , p.K110
         , p.T070
         , p.T080
         , p.T090_1
         , p.T090_2
         , p.T090_3
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.MATURITY_DATE
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.ND
         , a.AGRM_NUM
         , a.BEG_DT
         , a.END_DT
         , p.REF
         , p.BRANCH
    from NBUR_LOG_F48X p
         join NBUR_REF_FILES f on (f.FILE_CODE = '48X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
         left  join V_NBUR_DM_AGREEMENTS a on (p.REPORT_DATE = a.REPORT_DATE)
                                              and (p.KF = a.KF)
                                              and (p.nd = a.AGRM_ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table V_NBUR_48X_DTL is '��������� �������� ����� 48X';
comment on column V_NBUR_48X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_48X_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_48X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_48X_DTL.FIELD_CODE is '�������� ��� ���������';
comment on column V_NBUR_48X_DTL.EKP is '��� ���������';
comment on column V_NBUR_48X_DTL.Q003 is '������� ���������� ����� �������� �����';
comment on column V_NBUR_48X_DTL.Q001 is '����� ������������ �������� ����� ��� �������, ���, �� ������� ������� ����� �������� �����';
comment on column V_NBUR_48X_DTL.Q002 is '������ �������� ����� ��� ������ ��������� ���� ���������� ������� �����';
comment on column V_NBUR_48X_DTL.Q008 is '������ �������� �������� ����� ��� �������� ��� ������� �����';
comment on column V_NBUR_48X_DTL.Q029 is '��� �������� ����� ����������� ��� ���� � ����� �������� ��� ���������� ������������ ������';
comment on column V_NBUR_48X_DTL.K020 is '��� �������� �����';
comment on column V_NBUR_48X_DTL.K021 is '��� ������ �����������������/������������� ����/������';
comment on column V_NBUR_48X_DTL.K040 is '��� ����� �������� �����';
comment on column V_NBUR_48X_DTL.K110 is '��� ���� ��������� �������� �������� �����';
comment on column V_NBUR_48X_DTL.T070 is '������� ����� (���)';
comment on column V_NBUR_48X_DTL.T080 is 'ʳ������ ����� (���)';
comment on column V_NBUR_48X_DTL.T090_1 is '³������ ����� ����� � ���������� ������';
comment on column V_NBUR_48X_DTL.T090_2 is '³������ �������������� ����� � ���������� ������';
comment on column V_NBUR_48X_DTL.T090_3 is '³������ �������� ����� � ���������� ������';
comment on column V_NBUR_48X_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_48X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_48X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_48X_DTL.KV is '��. ������';
comment on column V_NBUR_48X_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_48X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_48X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_48X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_48X_DTL.ND is '��. ��������';
comment on column V_NBUR_48X_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_48X_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_48X_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_48X_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_48X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_48x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 