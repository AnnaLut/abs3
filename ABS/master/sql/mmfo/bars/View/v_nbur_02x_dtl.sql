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
--, ACC_NUM
--, ACC_KV
--, MATURITY_DATE
--, CUST_ID
--, BRANCH
--, CUST_ID
--, CUST_CODE
--, CUST_NAME
) as
select v.REPORT_DATE
     , v.KF
     , v.VERSION_ID
     , l.EKP
     , l.KU
     , l.R020
     , l.T020
     , l.R030
     , l.K040
     , l.T070
     , l.T071
     , l.ACC_ID
--   , a.ACC_NUM
--   , a.KV
--   , a.MATURITY_DATE
--   , a.CUST_ID
--   , a.BRANCH
--   , c.CUST_ID
--   , c.CUST_CODE
--   , c.CUST_NAME
  from NBUR_LOG_F02X  l
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = l.REPORT_DATE and
         v.KF          = l.KF )
  join NBUR_REF_FILES f
    on ( f.ID = v.FILE_ID )
--left outer
--join V_NBUR_DM_ACCOUNTS a
--  on ( a.REPORT_DATE = l.REPORT_DATE and
--       a.KF          = l.KF          and
--       a.ACC_ID      = l.ACC_ID )
--left outer
--join V_NBUR_DM_CUSTOMERS c
--  on ( c.REPORT_DATE = a.REPORT_DATE and
--       c.KF          = a.KF          and
--       c.CUST_ID     = a.CUST_ID )
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
comment on column V_NBUR_02X_DTL.EKP         is '��� ���������';
comment on column V_NBUR_02X_DTL.KU          is '��� ������i ����i�� �������� �����';
comment on column V_NBUR_02X_DTL.R020        is '����� �������';
comment on column V_NBUR_02X_DTL.T020        is '��� �������� ����� �� ��������';
comment on column V_NBUR_02X_DTL.R030        is '��� ������';
comment on column V_NBUR_02X_DTL.K040        is '��� �����';
comment on column V_NBUR_02X_DTL.T070        is '���� � ���������� ���������';
comment on column V_NBUR_02X_DTL.T071        is '���� � �������� �����';
comment on column V_NBUR_02X_DTL.ACC_ID      is 'I������i����� �������';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON V_NBUR_02X_DTL TO BARSREADER_ROLE;
GRANT SELECT ON V_NBUR_02X_DTL TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON V_NBUR_02X_DTL TO UPLD;
