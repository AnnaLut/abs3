-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 18.04.2018
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

prompt -- ======================================================
prompt -- create view V_NBUR_01X
prompt -- ======================================================

create or replace force view V_NBUR_01X
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
) as
select V.REPORT_DATE
     , V.KF
     , V.VERSION_ID
     , extractvalue( column_value, 'DATA/EKP'  ) as EKP
     , extractvalue( column_value, 'DATA/KU'   ) as KU
     , extractvalue( column_value, 'DATA/R020' ) as R020
     , extractvalue( column_value, 'DATA/T020' ) as T020
     , extractvalue( column_value, 'DATA/R030' ) as R030
     , extractvalue( column_value, 'DATA/K040' ) as K040
     , extractvalue( column_value, 'DATA/T070' ) as T070
     , extractvalue( column_value, 'DATA/T071' ) as T071
  from NBUR_REF_FILES F
     , NBUR_LST_FILES V
     , table( xmlsequence( XMLTYPE( V.FILE_BODY ).extract( '/NBUSTATREPORT/DATA' ) ) ) T
 where F.ID = V.FILE_ID
   and F.FILE_CODE = '01X'
   and F.FILE_FMT = 'XML'
   and V.FILE_STATUS in ( 'FINISHED', 'BLOCKED' );

show errors;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  V_NBUR_01X             is '���� 02X - ������� ����� ������� �� �� ����� ����  (����� �����)';

comment on column V_NBUR_01X.REPORT_DATE is '����� ����';
comment on column V_NBUR_01X.KF          is '��� �i�i��� (���)';
comment on column V_NBUR_01X.EKP         is '��� ���������';
comment on column V_NBUR_01X.KU          is '��� ������i ����i�� �������� �����';
comment on column V_NBUR_01X.R020        is '����� �������';
comment on column V_NBUR_01X.T020        is '��� �������� ����� �� ��������';
comment on column V_NBUR_01X.R030        is '��� ������';
comment on column V_NBUR_01X.K040        is '��� �����';
comment on column V_NBUR_01X.T070        is '���� � ���������� ���������';
comment on column V_NBUR_01X.T071        is '���� � �������� �����';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON V_NBUR_01X TO BARSREADER_ROLE;
GRANT SELECT ON V_NBUR_01X TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON V_NBUR_01X TO UPLD;
