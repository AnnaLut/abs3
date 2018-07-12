PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_1px_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_1px_dtl ***

create or replace view v_nbur_1px_dtl as
  select p.REPORT_DATE
         , p.KF
         , V.VERSION_ID
         , p.NBUC
         , p.Q003_1 as FIELD_CODE
         , p.EKP
         , p.K040_1
         , p.RCBNK_B010
         , p.RCBNK_NAME
         , p.K040_2
         , p.R030
         , p.R020
         , p.R040
         , p.T023
         , p.RCUKRU_GLB_2
         , p.K018
         , p.K020
         , p.Q001
         , p.RCUKRU_GLB_1
         , p.Q003_1
         , p.Q004
         , p.T071
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
    from nbur_log_f1px p
         join NBUR_REF_FILES f on ( f.FILE_CODE = '1PX' )
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
                                             );

comment on table V_NBUR_1PX_DTL is '��������� �������� ����� 1PX';
comment on column V_NBUR_1PX_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_1PX_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_1PX_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_1PX_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_1PX_DTL.FIELD_CODE is '��� ���������';
comment on column V_NBUR_1PX_DTL.EKP is '��� ���������';
comment on column V_NBUR_1PX_DTL.K040_1 is '��� ����� �����-�������������';
comment on column V_NBUR_1PX_DTL.RCBNK_B010	is '��� ���������� �����';
comment on column V_NBUR_1PX_DTL.RCBNK_NAME	is '����� ���������� �����';
comment on column V_NBUR_1PX_DTL.K040_2 is '��� �����-��������/���������� �������';
comment on column V_NBUR_1PX_DTL.R030 is '������';
comment on column V_NBUR_1PX_DTL.R020 is '���� �������';
comment on column V_NBUR_1PX_DTL.R040 is '����� ��������� �������';
comment on column V_NBUR_1PX_DTL.T023 is '��� ��������';
comment on column V_NBUR_1PX_DTL.RCUKRU_GLB_2 is '��� �����-��������';
comment on column V_NBUR_1PX_DTL.K018 is '��� ���� �볺���';
comment on column V_NBUR_1PX_DTL.K020 is '��� �볺���';
comment on column V_NBUR_1PX_DTL.Q001 is '����� �볺���';
comment on column V_NBUR_1PX_DTL.RCUKRU_GLB_1 is '��� �����-����������';
comment on column V_NBUR_1PX_DTL.Q003_1 is '������� ����� �����';
comment on column V_NBUR_1PX_DTL.Q004 is '���� ��������';
comment on column V_NBUR_1PX_DTL.T071 is '���� � �������i� �����i';
comment on column V_NBUR_1PX_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_1PX_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_1PX_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_1PX_DTL.KV is '��. ������';
comment on column V_NBUR_1PX_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_1PX_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_1PX_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_1PX_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_1PX_DTL.ND is '��. ��������';
comment on column V_NBUR_1PX_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_1PX_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_1PX_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_1PX_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_1PX_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_1px_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 