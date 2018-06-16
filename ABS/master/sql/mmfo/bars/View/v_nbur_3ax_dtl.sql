PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3ax_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_3ax_dtl ***

create or replace view v_nbur_3ax_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP || p.KU || p.T020 || p.R020 || p.R011 
           || p.D020 || p.S180 || p.R030 || p.K030 as FIELD_CODE
         , p.EKP
         , p.KU
         , p.T020
         , p.R020
         , p.R011
         , p.D020
         , p.S180
         , p.R030
         , p.K030
         , p.T070
         , p.T090
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
    from NBUR_LOG_F3AX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '3AX' )
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

comment on table V_NBUR_3AX_DTL is '��������� �������� ����� 3AX';
comment on column V_NBUR_3AX_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_3AX_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_3AX_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_3AX_DTL.FIELD_CODE is '�������� ��� ���������';
comment on column V_NBUR_3AX_DTL.EKP is '��� ���������';
comment on column V_NBUR_3AX_DTL.KU is '��� �������';
comment on column V_NBUR_3AX_DTL.T020 is '������� �������';
comment on column V_NBUR_3AX_DTL.R020 is '����� �������';
comment on column V_NBUR_3AX_DTL.R011 is '��� �� ���������� �������� ����������� ������� R011';
comment on column V_NBUR_3AX_DTL.D020 is '��� �������� ������� �� ��������';
comment on column V_NBUR_3AX_DTL.S180 is '��� ����������� ������ ���������';
comment on column V_NBUR_3AX_DTL.R030 is '��� ������';
comment on column V_NBUR_3AX_DTL.K030 is '��� ������������';
comment on column V_NBUR_3AX_DTL.T070 is '����';
comment on column V_NBUR_3AX_DTL.T090 is '����� ��������� ������';
comment on column V_NBUR_3AX_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_3AX_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_3AX_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_3AX_DTL.KV is '��. ������';
comment on column V_NBUR_3AX_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_3AX_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_3AX_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_3AX_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_3AX_DTL.ND is '��. ��������';
comment on column V_NBUR_3AX_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_3AX_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_3AX_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_3AX_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_3AX_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3ax_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 