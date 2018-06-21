PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_13x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_13x ***

create or replace view v_nbur_13x as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.EKP || t.D010 || t.KU as FIELD_CODE
       , t.EKP
       , t.KU
       , t.D010
       , t.T070
from   (
         select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/KU'  ) as KU
               , extractValue( COLUMN_VALUE, 'DATA/D010'  ) as D010
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '13X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_13X is '13X - ����� �������';
comment on column V_NBUR_13X.REPORT_DATE is '����� ����';
comment on column V_NBUR_13X.KF is '��� �i�i��� (���)';
comment on column V_NBUR_13X.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_13X.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_13X.FIELD_CODE is '��� ���������';
comment on column V_NBUR_13X.EKP is '����� ���������';
comment on column V_NBUR_13X.KU is '��������';
comment on column V_NBUR_13X.D010 is '������� ������� �������';
comment on column V_NBUR_13X.T070 is '���� � ���.�����';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_13x.sql =========*** End *** =
PROMPT ===================================================================================== 