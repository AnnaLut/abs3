
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_d4x_dtl.sql ======== *** Run *** 
PROMPT ===================================================================================== 

create or replace view v_nbur_d4x_dtl
(
   REPORT_DATE,
   KF,
   VERSION_ID,
   NBUC,
   FIELD_CODE,
   EKP,
   R030,
   F025,
   B010,
   Q006,
   T071,
   DESCRIPTION,
   ACC_ID,
   ACC_NUM,
   KV,
   CUST_ID,
   CUST_CODE,
   CUST_NAME,
   OP_DATE,
   REF,
   BRANCH
) as
select p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , p.NBUC
       , p.EKP || p.R030 || p.F025 || p.B010 as FIELD_CODE
       , p.EKP
       , p.R030
       , p.F025
       , p.B010
       , p.Q006
       , p.T071
       , p.DESCRIPTION
       , p.ACC_ID
       , p.ACC_NUM
       , p.KV
       , p.CUST_ID
       , c.CUST_CODE
       , c.CUST_NAME
       , to_char(p.MATURITY_DATE,'dd.mm.yyyy')  as OP_DATE
       , p.REF
       , p.BRANCH
    from NBUR_LOG_FD4X p
         join NBUR_REF_FILES f on ( f.FILE_CODE = 'D4X' )
         join NBUR_LST_FILES v on (
                                    v.REPORT_DATE = p.REPORT_DATE
                                    and v.KF = p.KF
                                    and v.VERSION_ID  = p.VERSION_ID
                                    and v.FILE_ID     = f.ID
                                  )
         left join V_NBUR_DM_CUSTOMERS c on (
                                              p.REPORT_DATE = c.REPORT_DATE
                                              and p.KF = c.KF
                                              and p.CUST_ID    = c.CUST_ID )
   where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

comment on table V_NBUR_D4X_DTL is '��������� �������� ����� D4X';
comment on column V_NBUR_D4X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_D4X_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_D4X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_D4X_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_D4X_DTL.FIELD_CODE is '��� ���������';
comment on column V_NBUR_D4X_DTL.EKP is '��� ���������';
comment on column V_NBUR_D4X_DTL.R030 is '������';
comment on column V_NBUR_D4X_DTL.F025 is '��� ����� ��������';
comment on column V_NBUR_D4X_DTL.B010 is '��� ���������� �����';
comment on column V_NBUR_D4X_DTL.Q006 is '�������';
comment on column V_NBUR_D4X_DTL.T071 is '����';
comment on column V_NBUR_D4X_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_D4X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_D4X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_D4X_DTL.KV is '��. ������';
comment on column V_NBUR_D4X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_D4X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_D4X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_D4X_DTL.OP_DATE is '���� ��������';
comment on column V_NBUR_D4X_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_D4X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_d4x_dtl.sql ======== *** End ***
PROMPT ===================================================================================== 

