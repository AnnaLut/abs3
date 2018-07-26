PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_12x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_12x ***

create or replace view v_nbur_12x as
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
                and f.FILE_CODE = '12X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_12X is '12X - ����� �������';
comment on column V_NBUR_12X.REPORT_DATE is '����� ����';
comment on column V_NBUR_12X.KF is '��� �i�i��� (���)';
comment on column V_NBUR_12X.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_12X.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_12X.FIELD_CODE is '��� ���������';
comment on column V_NBUR_12X.EKP is '����� ���������';
comment on column V_NBUR_12X.KU is '��������';
comment on column V_NBUR_12X.D010 is '������� ������� �������';
comment on column V_NBUR_12X.T070 is '���� � ���.�����';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_12x.sql =========*** End *** =
PROMPT ===================================================================================== 