PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3mx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

create or replace force view v_nbur_3MX 
(  REPORT_DATE
       , KF
       , VERSION_ID
       , NBUC
         , FIELD_CODE
       , EKP
       , KU
       , T071
       , Q003_1
       , F091
       , R030
       , F090
       , K040
       , F089
       , K020
       , K021
       , Q001_1
       , B010
       , Q033
       , Q001_2
       , Q003_2
       , Q007_1
       , F027
       , F02D
       , Q006 )
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , lpad(trim(to_char(t.KU)),2,'0')   as NBUC
         , substr(trim(t.Q003_1),1,3)   as FIELD_CODE
       , t.EKP
       , t.KU
       , t.T071
       , t.Q003_1
       , t.F091
       , t.R030
       , t.F090
       , t.K040
       , t.F089
       , t.K020
       , t.K021
       , t.Q001_1
       , t.B010
       , t.Q033
       , t.Q001_2
       , t.Q003_2
       , t.Q007_1
       , t.F027
       , t.F02D
       , t.Q006
from   (select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/KU'    ) as KU
               , extractValue( COLUMN_VALUE, 'DATA/T071'  ) as T071
               , extractValue( COLUMN_VALUE, 'DATA/Q003_1') as Q003_1
               , extractValue( COLUMN_VALUE, 'DATA/F091'  ) as F091
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/F090'  ) as F090
               , extractValue( COLUMN_VALUE, 'DATA/K040'  ) as K040
               , extractValue( COLUMN_VALUE, 'DATA/F089'  ) as F089
               , extractValue( COLUMN_VALUE, 'DATA/K020'  ) as K020
               , extractValue( COLUMN_VALUE, 'DATA/K021'  ) as K021
               , extractValue( COLUMN_VALUE, 'DATA/Q001_1') as Q001_1
               , extractValue( COLUMN_VALUE, 'DATA/B010'  ) as B010
               , extractValue( COLUMN_VALUE, 'DATA/Q033'  ) as Q033
               , extractValue( COLUMN_VALUE, 'DATA/Q001_2') as Q001_2
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2') as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/Q007_1') as Q007_1
               , extractValue( COLUMN_VALUE, 'DATA/F027'  ) as F027
               , extractValue( COLUMN_VALUE, 'DATA/F02D'  ) as F02D
               , extractValue( COLUMN_VALUE, 'DATA/Q006'  ) as Q006
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#3M'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;

comment on table  v_nbur_3mx is '���� 3MX - ����������� �� �������� ����������� �������� ������';
comment on column v_nbur_3mx.REPORT_DATE is '��i��� ����';
comment on column v_nbur_3mx.KF is '�i�i�';
comment on column v_nbur_3mx.VERSION_ID is '����� ���� �����';
comment on column v_nbur_3mx.NBUC is '��� ������ �����';
comment on column v_nbur_3mx.FIELD_CODE is '��� ���������';
comment on column v_nbur_3mx.EKP is 'XML ��� ���������';
comment on column v_nbur_3mx.KU is '��� �������';
comment on column v_nbur_3mx.T071 is '����';
comment on column v_nbur_3mx.Q003_1 is '������� ����� �����';
comment on column v_nbur_3mx.F091 is '��� ��������';
comment on column v_nbur_3mx.R030 is '��� ������';
comment on column v_nbur_3mx.F090 is '��� ���� �����������/��������';
comment on column v_nbur_3mx.K040 is '��� �����';
comment on column v_nbur_3mx.F089 is '������ �����������';
comment on column v_nbur_3mx.K020 is '��� ����������/����������';
comment on column v_nbur_3mx.K021 is '��� ������ ����������������� ����';
comment on column v_nbur_3mx.Q001_1 is '������������ �볺���';
comment on column v_nbur_3mx.B010 is '��� ���������� �����';
comment on column v_nbur_3mx.Q033 is '����� ���������� �����';
comment on column v_nbur_3mx.Q001_2 is '������������ ����������� - �����������';
comment on column v_nbur_3mx.Q003_2 is '����� ���������/��������, ���������� ��������/�������� ������';
comment on column v_nbur_3mx.Q007_1 is '���� ���������/��������, ���������� ��������/�������� ������';
comment on column v_nbur_3mx.F027 is '��� ����������';
comment on column v_nbur_3mx.F02D is '��� �� ������� ����������';
comment on column v_nbur_3mx.Q006 is '³������ ��� ��������';


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3mx.sql =========*** End *** ===
PROMPT ===================================================================================== 

