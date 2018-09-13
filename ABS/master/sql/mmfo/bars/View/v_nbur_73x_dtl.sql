PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_73x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_73x_dtl ***

create or replace view v_nbur_73x_dtl as
select l.REPORT_DATE
     , l.KF
     , l.VERSION_ID
     , l.EKP
     , l.KU
     , l.R030
     , l.T100
     , l.ACC_ID
     , l.ACC_NUM
     , l.KV
     , l.CUST_ID
     , c.CUST_CODE
     , c.CUST_NAME
     , l.REF
     , l.BRANCH
  from NBUR_LOG_F73X  l
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = l.REPORT_DATE and
         v.KF          = l.KF )
  join NBUR_REF_FILES f
    on ( f.ID = v.FILE_ID )
left outer
join V_NBUR_DM_CUSTOMERS c
  on ( c.REPORT_DATE = l.REPORT_DATE and
       c.KF          = l.KF          and
       c.CUST_ID     = l.CUST_ID )
 where f.FILE_CODE = '73X'
   and f.FILE_FMT = 'XML'
   and v.FILE_STATUS in ( 'FINISHED', 'BLOCKED' );

comment on table V_NBUR_73X_DTL is '��������� �������� ����� 73X';
comment on column V_NBUR_73X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_73X_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_73X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_73X_DTL.EKP is '��� ���������';
comment on column V_NBUR_73X_DTL.R030 is '��� ������';
comment on column V_NBUR_73X_DTL.T100 is '���� � �������� �����/ʳ������ ���';
comment on column V_NBUR_73X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_73X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_73X_DTL.KV is '��. ������';
comment on column V_NBUR_73X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_73X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_73X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_73X_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_73X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_73x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 