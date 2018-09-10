PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_01X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_01X_dtl ***

create or replace view v_nbur_01X_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , null as FIELD_CODE
         , p.EKP
         , p.KU
         , p.T020
         , p.R020
         , p.R030
         , p.K040
         , p.T070
         , p.T071
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.BRANCH
    from NBUR_LOG_F01X p
         join NBUR_REF_FILES f on (f.FILE_CODE = '01X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table V_NBUR_01X_DTL is '��������� �������� ����� 01X';
comment on column V_NBUR_01X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_01X_DTL.KF is '��� �i�i� (���)';
comment on column V_NBUR_01X_DTL.NBUC is '��� ���';
comment on column V_NBUR_01X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_01X_DTL.FIELD_CODE is '�������� ��� ���������';
comment on column V_NBUR_01X_DTL.EKP is '��� ���������';
comment on column V_NBUR_01X_DTL.KU is '��� �������';
comment on column V_NBUR_01X_DTL.T020 is '������� �������';
comment on column V_NBUR_01X_DTL.R020 is '����� �������';
comment on column V_NBUR_01X_DTL.R030 is '��� ������';
comment on column V_NBUR_01X_DTL.K040 is '��� �����';
comment on column V_NBUR_01X_DTL.T070 is '���� � ���������� ���������';
comment on column V_NBUR_01X_DTL.T071 is '���� � ���������� ������';
comment on column V_NBUR_01X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_01X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_01X_DTL.KV is '��. ������';
comment on column V_NBUR_01X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_01X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_01X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_01X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_01X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 