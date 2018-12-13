PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6kx.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_6kx ***

create or replace view v_nbur_6kx as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.EKP || t.R030 as FIELD_CODE
       , t.EKP
       , t.R030
       , t.T100
from   (
         select
                v.REPORT_DATE
                , v.KF
                , v.version_id
                , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
                , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
                , extractValue( COLUMN_VALUE, 'DATA/T100'  ) as T100
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#6K'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_6EX is '6EX ��� ��� ���������� ����������� �������� �������� (LCR)';
comment on column V_NBUR_6EX.REPORT_DATE is '����� ����';
comment on column V_NBUR_6EX.KF is '��� �i�i��� (���)';
comment on column V_NBUR_6EX.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_6EX.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_6EX.FIELD_CODE is '��� ���������';
comment on column V_NBUR_6EX.EKP is '��� ���������';
comment on column V_NBUR_6EX.R030 is '������';
comment on column V_NBUR_6EX.T100 is '����/�������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6ex.sql =========*** End *** =
PROMPT ===================================================================================== 