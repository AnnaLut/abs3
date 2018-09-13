PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_73x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_73x ***

CREATE OR REPLACE VIEW V_NBUR_73X AS
select V.REPORT_DATE
     , V.KF
     , V.VERSION_ID
     , null FIELD_CODE
     , extractvalue( column_value, 'DATA/EKP'  ) as EKP
     , extractvalue( column_value, 'DATA/KU'   ) as KU
     , extractvalue( column_value, 'DATA/R030' ) as R030
     , extractvalue( column_value, 'DATA/T100' ) as T100
  from NBUR_REF_FILES F
     , NBUR_LST_FILES V
     , table( xmlsequence( XMLTYPE( V.FILE_BODY ).extract( '/NBUSTATREPORT/DATA' ) ) ) T
 where F.ID = V.FILE_ID
   and F.FILE_CODE = '73X'
   and F.FILE_FMT = 'XML'
   and V.FILE_STATUS in ( 'FINISHED', 'BLOCKED' );
         
comment on table V_NBUR_73X is '���� 73X - ������ �������� �������� ������ �� �������� ������ ���������� ������';
comment on column V_NBUR_73X.REPORT_DATE is '��i��� ����';
comment on column V_NBUR_73X.KF is '�i�i�';
comment on column V_NBUR_73X.VERSION_ID is '����� ���� �����';
comment on column V_NBUR_73X.KU         is '��� ������i ����i�� �������� �����';
comment on column V_NBUR_73X.FIELD_CODE is '�������� ��� ���������';
comment on column V_NBUR_73X.EKP is '��� ���������';
comment on column V_NBUR_73X.R030 is '��� ������';
comment on column V_NBUR_73X.T100 is '���� � �������� �����/ʳ������ ���';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_73x.sql =========*** End *** =
PROMPT ===================================================================================== 