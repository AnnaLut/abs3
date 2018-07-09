PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_a7x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_a7x ***

create or replace view v_nbur_a7x 
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.EKP || t.T020 || t.R020 || t.R011 || t.R013 || t.R030
         || t.K030 || t.S181 || t.S190 || t.S240 as FIELD_CODE
       , t.EKP
       , t.T020
       , t.R020
       , t.R011
       , t.R013
       , t.R030
       , t.K030
       , t.S181
       , t.S190
       , t.S240
       , t.T070
from   (
         select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/T020'  ) as T020
               , extractValue( COLUMN_VALUE, 'DATA/R020'  ) as R020
               , extractValue( COLUMN_VALUE, 'DATA/R011'  ) as R011
               , extractValue( COLUMN_VALUE, 'DATA/R013'  ) as R013
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/K030'  ) as K030
               , extractValue( COLUMN_VALUE, 'DATA/S181'  ) as S181
               , extractValue( COLUMN_VALUE, 'DATA/S190'  ) as S190
               , extractValue( COLUMN_VALUE, 'DATA/S240'  ) as S240
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = 'A7X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_A7X is 'A7X ��������� ������ �� ������';
comment on column V_NBUR_A7X.REPORT_DATE is '����� ����';
comment on column V_NBUR_A7X.KF is '��� �i�i��� (���)';
comment on column V_NBUR_A7X.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_A7X.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_A7X.FIELD_CODE is '��� ���������';
comment on column V_NBUR_A7X.EKP is '��� ���������';
comment on column V_NBUR_A7X.T020 is '������� �������';
comment on column V_NBUR_A7X.R020 is '����� �������';
comment on column V_NBUR_A7X.R011 is '��� �� ���������� �������� ����������� ������� R011';
comment on column V_NBUR_A7X.R013 is '��� �� ���������� �������� ����������� ������� R013';
comment on column V_NBUR_A7X.R030 is '��� ������';
comment on column V_NBUR_A7X.K030 is '��� ������������';
comment on column V_NBUR_A7X.S181 is '��� ����������� ������ ���������';
comment on column V_NBUR_A7X.S190 is '��� ������ ������������ ��������� �����';
comment on column V_NBUR_A7X.S240 is '��� ������ �� ���������';
comment on column V_NBUR_A7X.T070 is '����';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_a7x.sql =========*** End *** =
PROMPT ===================================================================================== 