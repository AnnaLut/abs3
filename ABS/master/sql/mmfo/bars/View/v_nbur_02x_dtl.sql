-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 18.04.2018
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

prompt -- ======================================================
prompt -- create view V_NBUR_02X_DTL
prompt -- ======================================================

create or replace force view V_NBUR_02X_DTL
( REPORT_DATE
, KF
, VERSION_ID
, EKP
, KU
, R020
, T020
, R030
, K040
, T070
, T071
, ACC_ID
, ACC_NUM
, KV
, BRANCH
, CUST_ID
, CUST_CODE
, CUST_NAME
) as
select l.REPORT_DATE
     , l.KF
     , l.VERSION_ID
     , l.EKP
     , l.KU
     , l.R020
     , l.T020
     , l.R030
     , l.K040
     , l.T070
     , l.T071
     , l.ACC_ID
     , l.ACC_NUM
     , l.KV
     , l.BRANCH
     , l.CUST_ID
     , c.CUST_CODE
     , c.CUST_NAME
  from NBUR_LOG_F02X  l
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
 where f.FILE_CODE = '02X'
   and f.FILE_FMT = 'XML'
   and v.FILE_STATUS in ( 'FINISHED', 'BLOCKED' );

show errors;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  V_NBUR_02X_DTL         is '���� 02X - ������� ����� ������� �� �� ����� ����  (����� �����)';

comment on column V_NBUR_02X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_02X_DTL.KF          is '��� �i�i��� (���)';
comment on column V_NBUR_02X_DTL.VERSION_ID  is '��. ���� �����';
comment on column V_NBUR_02X_DTL.EKP         is '��� ���������';
comment on column V_NBUR_02X_DTL.KU          is '��� ������i ����i�� �������� �����';
comment on column V_NBUR_02X_DTL.R020        is '����� �������';
comment on column V_NBUR_02X_DTL.T020        is '��� �������� ����� �� ��������';
comment on column V_NBUR_02X_DTL.R030        is '��� ������';
comment on column V_NBUR_02X_DTL.K040        is '��� �����';
comment on column V_NBUR_02X_DTL.T070        is '���� � ���������� ���������';
comment on column V_NBUR_02X_DTL.T071        is '���� � �������� �����';
comment on column V_NBUR_02X_DTL.ACC_ID      is 'I������i����� �������';
comment on column V_NBUR_02X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_02X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_02X_DTL.KV is '��. ������';
comment on column V_NBUR_02X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_02X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_02X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_02X_DTL.BRANCH is '��� ��������';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON V_NBUR_02X_DTL TO BARSREADER_ROLE;
GRANT SELECT ON V_NBUR_02X_DTL TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON V_NBUR_02X_DTL TO UPLD;
