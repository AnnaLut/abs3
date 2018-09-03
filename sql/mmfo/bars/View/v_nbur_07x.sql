PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_07X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_07X ***

create or replace view v_nbur_07X 
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
       , t.K072
       , t.R030
       , t.S183
       , t.S130
       , t.K040
       , t.S240
       , t.T100
       , t.Q130 
       , t.Q003
from   (select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/KU'  ) as KU
               , extractValue( COLUMN_VALUE, 'DATA/T020'  ) as T020
               , extractValue( COLUMN_VALUE, 'DATA/R020'  ) as R020
               , extractValue( COLUMN_VALUE, 'DATA/R011'  ) as R011
               , extractValue( COLUMN_VALUE, 'DATA/K072'  ) as K072    		   
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/S183'  ) as S183
               , extractValue( COLUMN_VALUE, 'DATA/S130'  ) as S130               
               , extractValue( COLUMN_VALUE, 'DATA/K040'  ) as K040
               , extractValue( COLUMN_VALUE, 'DATA/S240'  ) as S240
               , extractValue( COLUMN_VALUE, 'DATA/Q130'  ) as Q130
               , extractValue( COLUMN_VALUE, 'DATA/Q003'  ) as Q003
               , extractValue( COLUMN_VALUE, 'DATA/T100'  ) as T100
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '07X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
       
comment on table  V_NBUR_07X is '07X ��� ��� ���� �������� ������ �����';
comment on column V_NBUR_07X.REPORT_DATE is '����� ����';
comment on column V_NBUR_07X.KF is '��� �i�i��� (���)';
comment on column V_NBUR_07X.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_07X.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_07X.FIELD_CODE is '��� ���������';
comment on column V_NBUR_07X.EKP is '��� ���������';
comment on column V_NBUR_07X.KU is '��� �������';
comment on column V_NBUR_07X.T020 is '������� �������';
comment on column V_NBUR_07X.R020 is '����� �������';
comment on column V_NBUR_07X.R011 is '��� �� ���������� �������� ����������� ������� R011';
comment on column V_NBUR_07X.K072 is '��� ������� ��������';
comment on column V_NBUR_07X.R030 is '��� ������';
comment on column V_NBUR_07X.S183 is '������������ ��� ���������� ������ ���������';
comment on column V_NBUR_07X.S130 is '��� ���� ������� ������';
comment on column V_NBUR_07X.K040 is '��� �����';
comment on column V_NBUR_07X.S240 is '��� ������ �� ���������';
comment on column V_NBUR_07X.Q003 is '���������� ����� ������� ������';
comment on column V_NBUR_07X.Q130 is '��� ������� ������';
comment on column V_NBUR_07X.T100 is '���� / ʳ������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_07X.sql =========*** End *** =
PROMPT ===================================================================================== 