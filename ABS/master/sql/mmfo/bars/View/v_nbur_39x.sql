PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_39x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_39x ***


create or replace view v_nbur_39x as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID

       , t.EKP
       , t.R030
       , t.T071
       , t.T075

       , t.NBUC
       , t.EKP || t.R030 as FIELD_CODE
from   (
         select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/KU'  ) as K021
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/T071'  ) as T071
               , extractValue( COLUMN_VALUE, 'DATA/T075'  ) as T075

               , extractValue( COLUMN_VALUE, 'DATA/KU'  ) as NBUC
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '39X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_39X is '���� 39X - ���i ��� ���� �� ������ ������i� ����� � ���i��i �� ������� ���i����� i������� ������';
comment on column V_NBUR_39X.REPORT_DATE is '��i��� ����';
comment on column V_NBUR_39X.KF is '�i�i�';
comment on column V_NBUR_39X.VERSION_ID is '����� ���� �����';
comment on column V_NBUR_39X.EKP is 'A39001 - ������, A39002 - ������';
comment on column V_NBUR_39X.R030 is '��� ������';
comment on column V_NBUR_39X.T071 is '���� � i������i� �����i';
comment on column V_NBUR_39X.T075 is '���������������� ����';
comment on column V_NBUR_39X.NBUC is '��� ������i ����i�� �������� �����';
comment on column V_NBUR_39X.FIELD_CODE is '��� ���������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_39x.sql =========*** End *** =
PROMPT ===================================================================================== 