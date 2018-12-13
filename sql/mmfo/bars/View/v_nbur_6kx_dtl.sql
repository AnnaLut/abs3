PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6kx_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_6kx_dtl ***

create or replace view v_nbur_6kx_dtl as
  select p.REPORT_DATE
         , p.KF
         , V.VERSION_ID
         , p.NBUC
         , p.EKP || p.R030 as FIELD_CODE
         , p.EKP
         , p.R030
         , p.T100
         , p.T100_PCT
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
         , null as REF
         , p.BRANCH
    from nbur_log_f6kx p
         join NBUR_REF_FILES f on ( f.FILE_CODE = '#6K' )
         join NBUR_LST_FILES v on (
                                    v.REPORT_DATE = p.REPORT_DATE
                                    and v.KF = p.KF
                                    and v.FILE_ID     = f.ID
				    AND v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
                                  )
         left join V_NBUR_DM_CUSTOMERS c on (
                                              p.REPORT_DATE = c.REPORT_DATE
                                              and p.KF = c.KF
                                              and p.CUST_ID    = c.CUST_ID )
         left join V_NBUR_DM_AGREEMENTS a on (
                                               p.REPORT_DATE = a.REPORT_DATE
                                               and p.KF          = a.KF
                                               and p.nd          = a.AGRM_ID
                                             )
    where ekp not in (select ekp from bars.nbur_dct_f6kx_ekp where constant_value =0);

comment on table V_NBUR_6kx_DTL is '��������� �������� ����� 6kx';
comment on column V_NBUR_6kx_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_6kx_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_6kx_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_6kx_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_6kx_DTL.FIELD_CODE is '��� ���������';
comment on column V_NBUR_6kx_DTL.EKP is '��� ���������';
comment on column V_NBUR_6kx_DTL.R030 is '������';
comment on column V_NBUR_6kx_DTL.T100 is '����/�������';
comment on column V_NBUR_6kx_DTL.T100_PCT is '������� ���������� � ������������ ���������';
comment on column V_NBUR_6kx_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_6kx_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_6kx_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_6kx_DTL.KV is '��. ������';
comment on column V_NBUR_6kx_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_6kx_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_6kx_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_6kx_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_6kx_DTL.ND is '��. ��������';
comment on column V_NBUR_6kx_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_6kx_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_6kx_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_6kx_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_6kx_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6kx_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 