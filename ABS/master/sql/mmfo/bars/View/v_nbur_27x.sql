PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_27x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_27x ***

create or replace view v_nbur_27x as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.K021 as NBUC
       , t.F091 || t.R020 || t.R030 as FIELD_CODE
       , t.EKP
       , t.R020
       , t.R030
       , t.F091
       , t.T071
from   (
         select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/KU'  ) as K021
               , extractValue( COLUMN_VALUE, 'DATA/R020'  ) as R020
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/F091'  ) as F091
               , extractValue( COLUMN_VALUE, 'DATA/T071'  ) as T071
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '27X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_27X is '27X - ���i ��� ��� ����i� �� ������� 2603';
comment on column V_NBUR_27X.REPORT_DATE is '����� ����';
comment on column V_NBUR_27X.KF is '��� �i�i��� (���)';
comment on column V_NBUR_27X.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_27X.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_27X.FIELD_CODE is '��� ���������';
comment on column V_NBUR_27X.EKP is '��� ������� �� �������';
comment on column V_NBUR_27X.R020 is '���������� �������';
comment on column V_NBUR_27X.R030 is '��� ������';
comment on column V_NBUR_27X.F091 is '��� ��������';
comment on column V_NBUR_27X.T071 is '�������� ���������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_27x.sql =========*** End *** =
PROMPT ===================================================================================== 