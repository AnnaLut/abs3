PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_1px.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_1px ***

create or replace view v_nbur_1px as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.Q003_1 as FIELD_CODE
       , t.EKP
       , t.K040_1
       , t.RCBNK_B010
       , t.RCBNK_NAME
       , t.K040_2
       , t.R030
       , t.R020
       , t.R040
       , t.T023
       , t.RCUKRU_GLB_2
       , t.K018
       , t.K020
       , t.Q001
       , t.RCUKRU_GLB_1
       , t.Q003_1
       , t.Q004
       , t.T080
       , t.T071
from   (
         select
                v.REPORT_DATE
                , v.KF
                , v.version_id
                , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
                , extractValue( COLUMN_VALUE, 'DATA/K040_1'  ) as K040_1
                , extractValue( COLUMN_VALUE, 'DATA/RCBNK_B010'  ) as RCBNK_B010
                , extractValue( COLUMN_VALUE, 'DATA/RCBNK_NAME'  ) as RCBNK_NAME
                , extractValue( COLUMN_VALUE, 'DATA/K040_2'  ) as K040_2
                , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
                , extractValue( COLUMN_VALUE, 'DATA/R020'  ) as R020
                , extractValue( COLUMN_VALUE, 'DATA/R040'  ) as R040
                , extractValue( COLUMN_VALUE, 'DATA/T023'  ) as T023
                , extractValue( COLUMN_VALUE, 'DATA/RCUKRU_GLB_2'  ) as RCUKRU_GLB_2
                , extractValue( COLUMN_VALUE, 'DATA/K018'  ) as K018
                , extractValue( COLUMN_VALUE, 'DATA/K020'  ) as K020
                , extractValue( COLUMN_VALUE, 'DATA/Q001'  ) as Q001
                , extractValue( COLUMN_VALUE, 'DATA/RCUKRU_GLB_1'  ) as RCUKRU_GLB_1
                , extractValue( COLUMN_VALUE, 'DATA/Q003_1'  ) as Q003_1
                , extractValue( COLUMN_VALUE, 'DATA/Q004'  ) as Q004
                , extractValue( COLUMN_VALUE, 'DATA/T080'  ) as T080
                , extractValue( COLUMN_VALUE, 'DATA/T071'  ) as T071
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '1PX'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_1PX is '1PX ��� ����� ��� �������� �������� � �������������';
comment on column V_NBUR_1PX.REPORT_DATE is '����� ����';
comment on column V_NBUR_1PX.KF is '��� �i�i��� (���)';
comment on column V_NBUR_1PX.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_1PX.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_1PX.FIELD_CODE is '��� ���������';
comment on column V_NBUR_1PX.EKP is '��� ���������';
comment on column V_NBUR_1PX.K040_1 is '��� ����� �����-�������������';
comment on column V_NBUR_1PX.RCBNK_B010	is '��� ���������� �����';
comment on column V_NBUR_1PX.RCBNK_NAME	is '����� ���������� �����';
comment on column V_NBUR_1PX.K040_2 is '��� �����-��������/���������� �������';
comment on column V_NBUR_1PX.R030 is '������';
comment on column V_NBUR_1PX.R020 is '���� �������';
comment on column V_NBUR_1PX.R040 is '����� ��������� �������';
comment on column V_NBUR_1PX.T023 is '��� ��������';
comment on column V_NBUR_1PX.RCUKRU_GLB_2 is '��� �����-��������';
comment on column V_NBUR_1PX.K018 is '��� ���� �볺���';
comment on column V_NBUR_1PX.K020 is '��� �볺���';
comment on column V_NBUR_1PX.Q001 is '����� �볺���';
comment on column V_NBUR_1PX.RCUKRU_GLB_1 is '��� �����-����������';
comment on column V_NBUR_1PX.Q003_1 is '������� ����� �����';
comment on column V_NBUR_1PX.Q004 is '���� ��������';
comment on column V_NBUR_1PX.T080 is 'ʳ������ ��������';
comment on column V_NBUR_1PX.T071 is '���� � �������i� �����i';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_1px.sql =========*** End *** =
PROMPT ===================================================================================== 