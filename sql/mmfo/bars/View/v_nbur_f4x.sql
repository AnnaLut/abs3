PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_F4X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_F4X ***

create or replace view v_nbur_F4X 
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , null as FIELD_CODE
       , t.EKP
       , t.KU
       , t.T020
       , t.R020
       , t.R011
       , t.R030
       , t.K072
       , t.K111
       , t.K140
       , t.F074
       , t.S180
       , t.D020
       , t.T070
       , t.T090
from   (select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/KU'  ) as KU
               , extractValue( COLUMN_VALUE, 'DATA/T020'  ) as T020
               , extractValue( COLUMN_VALUE, 'DATA/R020'  ) as R020
               , extractValue( COLUMN_VALUE, 'DATA/R011'  ) as R011
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/K072'  ) as K072    		   
               , extractValue( COLUMN_VALUE, 'DATA/K111'  ) as K111    		   
               , extractValue( COLUMN_VALUE, 'DATA/K140'  ) as K140
               , extractValue( COLUMN_VALUE, 'DATA/F074'  ) as F074
               , extractValue( COLUMN_VALUE, 'DATA/S180'  ) as S180
               , extractValue( COLUMN_VALUE, 'DATA/D020'  ) as D020
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
               , extractValue( COLUMN_VALUE, 'DATA/T090'  ) as T090
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = 'F4X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
       
comment on table  V_NBUR_F4X is 'F4X ��� ��� ���� � �������� ������ �� �������� ��������� �� ���������� ���������� ';
comment on column V_NBUR_F4X.REPORT_DATE is '����� ����';
comment on column V_NBUR_F4X.KF is '��� �i�i��� (���)';
comment on column V_NBUR_F4X.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_F4X.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_F4X.FIELD_CODE is '��� ���������';
comment on column V_NBUR_F4X.EKP is '��� ���������';
comment on column V_NBUR_F4X.KU is '��� �������';
comment on column V_NBUR_F4X.T020 is '������� �������';
comment on column V_NBUR_F4X.R020 is '����� �������';
comment on column V_NBUR_F4X.R011 is '��� �� ���������� �������� ����������� ������� R011';
comment on column V_NBUR_F4X.R030 is '��� ������';
comment on column V_NBUR_F4X.K072 is '��� ������� ��������';
comment on column V_NBUR_F4X.K111 is '��� ����i�� ���� ������i��� �i�������i';
comment on column V_NBUR_F4X.K140 is '��� ������ ��ᒺ��� ��������������';
comment on column V_NBUR_F4X.F074 is '��� ���� ��������� �����������/�������� � ������ ����� �� ����� ��������� ��� �� ������� ��������� ��� �� ����� ��';
comment on column V_NBUR_F4X.S180 is '��� ����������� ������ ���������';
comment on column V_NBUR_F4X.D020 is '��� �������� ������� �� ��������';
comment on column V_NBUR_F4X.T070 is '����';
comment on column V_NBUR_F4X.T090 is '����� ��������� ������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_F4X.sql =========*** End *** =
PROMPT ===================================================================================== 