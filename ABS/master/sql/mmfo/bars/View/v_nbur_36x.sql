PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_36X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_36X ***

create or replace view v_nbur_36X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/B040') as B040
          , extractValue(COLUMN_VALUE, 'DATA/F021') as F021
          , extractValue(COLUMN_VALUE, 'DATA/K020') as K020
          , extractValue(COLUMN_VALUE, 'DATA/K021') as K021
          , extractValue(COLUMN_VALUE, 'DATA/Q001_1') as Q001_1
          , extractValue(COLUMN_VALUE, 'DATA/Q001_2') as Q001_2
          , extractValue(COLUMN_VALUE, 'DATA/Q002') as Q002
          , extractValue(COLUMN_VALUE, 'DATA/Q003_2') as Q003_2
          , extractValue(COLUMN_VALUE, 'DATA/Q003_3') as Q003_3
          , extractValue(COLUMN_VALUE, 'DATA/Q007_1') as Q007_1
          , extractValue(COLUMN_VALUE, 'DATA/Q007_2') as Q007_2
          , extractValue(COLUMN_VALUE, 'DATA/Q007_3') as Q007_3
          , extractValue(COLUMN_VALUE, 'DATA/Q007_4') as Q007_4
          , extractValue(COLUMN_VALUE, 'DATA/Q007_5') as Q007_5
          , extractValue(COLUMN_VALUE, 'DATA/K040') as K040
          , extractValue(COLUMN_VALUE, 'DATA/D070') as D070
          , extractValue(COLUMN_VALUE, 'DATA/F008') as F008
          , extractValue(COLUMN_VALUE, 'DATA/K112') as K112
          , extractValue(COLUMN_VALUE, 'DATA/F019') as F019
          , extractValue(COLUMN_VALUE, 'DATA/F020') as F020
          , extractValue(COLUMN_VALUE, 'DATA/R030') as R030
          , extractValue(COLUMN_VALUE, 'DATA/Q023') as Q023
          , extractValue(COLUMN_VALUE, 'DATA/T071') as T071
          , extractValue(COLUMN_VALUE, 'DATA/T070') as T070
          , extractValue(COLUMN_VALUE, 'DATA/Q006') as Q006
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '#36'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_36X              is '���� 36X - ��� ��� ����������� ������ �� ��������� ���������� �����';
comment on column V_NBUR_36X.REPORT_DATE is '��i��� ����';
comment on column V_NBUR_36X.KF          is '�i�i�';
comment on column V_NBUR_36X.VERSION_ID  is '����� ���� �����';
comment on column V_NBUR_36X.EKP     is '��� ���������';
comment on column V_NBUR_36X.B040        is '��� ����������� ��������';
comment on column V_NBUR_36X.F021        is '��� ����������� ��� ������ �� ��������/������ � ��������';        
comment on column V_NBUR_36X.K020        is '��� ���������';        
comment on column V_NBUR_36X.K021        is '������ ����';        
comment on column V_NBUR_36X.Q001_1      is '����� ������������ ���������';        
comment on column V_NBUR_36X.Q001_2      is '����� ������������ ����������� (����� � ����������)';        
comment on column V_NBUR_36X.Q002        is '̳�������������� ���������';        
comment on column V_NBUR_36X.Q003_2      is '������� ���������� ����� ���������';        
comment on column V_NBUR_36X.Q003_3      is '����� ������������������� ���������';        
comment on column V_NBUR_36X.Q007_1      is '���� ��������� ������������������� ���������';        
comment on column V_NBUR_36X.Q007_2      is '���� ������� ��� ����������� ������ ����������';        
comment on column V_NBUR_36X.Q007_3      is '���� �������� ��� �� ����������';        
comment on column V_NBUR_36X.Q007_4      is '���� ������ ��������� � ��������';        
comment on column V_NBUR_36X.Q007_5      is '���� ������������ ��������� �������� �� ������ ���������� ��� ���� ��������� ���������� ��������� ���������';        
comment on column V_NBUR_36X.K040        is '��� ����� �����������';        
comment on column V_NBUR_36X.D070        is '��� ����������������� �������� �볺���';        
comment on column V_NBUR_36X.F008        is '���  ����� ����������������� �������� �볺���';        
comment on column V_NBUR_36X.K112        is '��� ������ ���� ��������� ��������';        
comment on column V_NBUR_36X.F019        is '��� ������� ���������� �������������';        
comment on column V_NBUR_36X.F020        is '��� ������ ��� ��������� ������������� ��������� �� ������������������ ����������';        
comment on column V_NBUR_36X.R030        is '��� ������ ����������';        
comment on column V_NBUR_36X.Q023        is '��� �������� �����, ���� ���������';        
comment on column V_NBUR_36X.T071        is '���� ������������ ����� � �����';        
comment on column V_NBUR_36X.T070        is '���� ������������ ����� � ���������� ���������';        
comment on column V_NBUR_36X.Q006        is '�������'; 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_36X.sql =========*** End *** =
PROMPT ===================================================================================== 

