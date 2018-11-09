PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_I5X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_I5X ***

create or replace view v_nbur_I5X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/KU') as KU
          , extractValue(COLUMN_VALUE, 'DATA/T020') as T020
          , extractValue(COLUMN_VALUE, 'DATA/R020') as R020
          , extractValue(COLUMN_VALUE, 'DATA/R011') as R011
          , extractValue(COLUMN_VALUE, 'DATA/R030') as R030
          , extractValue(COLUMN_VALUE, 'DATA/K040') as K040
          , extractValue(COLUMN_VALUE, 'DATA/K072') as K072
          , extractValue(COLUMN_VALUE, 'DATA/K111') as K111
          , extractValue(COLUMN_VALUE, 'DATA/K140') as K140
          , extractValue(COLUMN_VALUE, 'DATA/F074') as F074
          , extractValue(COLUMN_VALUE, 'DATA/S032') as S032
          , extractValue(COLUMN_VALUE, 'DATA/S183') as S183
          , extractValue(COLUMN_VALUE, 'DATA/S241') as S241
          , extractValue(COLUMN_VALUE, 'DATA/S260') as S260
          , extractValue(COLUMN_VALUE, 'DATA/F048') as F048
          , extractValue(COLUMN_VALUE, 'DATA/T070') as T070
          , extractValue(COLUMN_VALUE, 'DATA/T090') as T090
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '#I5'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_I5X              is '���� I5X - ��� ��� ����������� ������ �� ��������� ���������� �����';
comment on column V_NBUR_I5X.REPORT_DATE is '��i��� ����';
comment on column V_NBUR_I5X.KF          is '�i�i�';
comment on column V_NBUR_I5X.VERSION_ID  is '����� ���� �����';
comment on column V_NBUR_I5X.EKP         is '��� ���������';
comment on column V_NBUR_I5X.KU          is '��� ������i ����i�� �������� �����';
comment on column V_NBUR_I5X.T020        is '������� �������';
comment on column V_NBUR_I5X.R020        is '����� �������';
comment on column V_NBUR_I5X.R011        is '��� �� ���������� �������� ����������� ������� R011';
comment on column V_NBUR_I5X.R030        is '��� ������';
comment on column V_NBUR_I5X.K040        is '��� �����';
comment on column V_NBUR_I5X.K072        is '��� ������� ��������';
comment on column V_NBUR_I5X.K111        is '��� ����i�� ���� ������i��� �i�������i';
comment on column V_NBUR_I5X.K140        is '��� ������ ��ᒺ��� ��������������';
comment on column V_NBUR_I5X.F074        is '��� ���� ��������� �����������/�������� � ������ ����� �� ����� ��������� ��� �� ������� ��������� ��� �� ����� ��';
comment on column V_NBUR_I5X.S032        is '������������ ��� ���� ������������ �������';
comment on column V_NBUR_I5X.S183        is '������������ ��� ���������� ������ ���������';
comment on column V_NBUR_I5X.S241        is '������������ ��� ������ �� ���������';
comment on column V_NBUR_I5X.S260        is '��� �������������� ���������� �� ������';
comment on column V_NBUR_I5X.F048        is '��� ���� ��������� ������';
comment on column V_NBUR_I5X.T070        is '����';
comment on column V_NBUR_I5X.T090        is '��������� ������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_
I5X.sql =========*** End *** =
PROMPT ===================================================================================== 

