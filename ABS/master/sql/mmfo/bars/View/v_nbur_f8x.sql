PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_f8x.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_F8X
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP   
       , p.F034
       , p.F035
       , p.R030
       , p.S080
       , p.K111
       , p.S260
       , p.S032
       , p.S245
       , p.T100
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/F034'  ) as F034
               , extractValue( COLUMN_VALUE, 'DATA/F035'  ) as F035
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/S080'  ) as S080
               , extractValue( COLUMN_VALUE, 'DATA/K111'  ) as K111
               , extractValue( COLUMN_VALUE, 'DATA/S260'  ) as S260
               , extractValue( COLUMN_VALUE, 'DATA/S032'  ) as S032
               , extractValue( COLUMN_VALUE, 'DATA/S245'  ) as S245
               , extractValue( COLUMN_VALUE, 'DATA/T100'  ) as T100
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = 'F8X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p;

comment on table  v_nbur_F8X is '���� F8X�-��� ��� ������� ��������� �������� �� ������ ������������� �� ����';
comment on column v_nbur_F8X.REPORT_DATE is '��i��� ����';
comment on column v_nbur_F8X.KF is '�i�i�';
comment on column v_nbur_F8X.VERSION_ID is '����� ���� �����';
comment on column v_nbur_F8X.EKP    is '��� ���������';                           
comment on column v_nbur_F8X.F034   is '��� ������� �� ������ �������������';
comment on column v_nbur_F8X.F035   is '��� ���� ��������';
comment on column v_nbur_F8X.R030   is '��� ������';
comment on column v_nbur_F8X.S080   is '��� ����� ��������/�����������';
comment on column v_nbur_F8X.K111   is '��� ������ ���� ��������� ��������';
comment on column v_nbur_F8X.S260   is '��� ���� �������������� ���������� �� ������';
comment on column v_nbur_F8X.S032   is '��� ������������� ���� ������������ �������';
comment on column v_nbur_F8X.S245   is '��� ��������������� �������� ������ ���������';
comment on column v_nbur_F8X.T100   is '����/�������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_f8x.sql =========*** End *** ===
PROMPT ===================================================================================== 

