PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_42X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_42X ***

create or replace view v_nbur_42X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/F099') as F099
          , extractValue(COLUMN_VALUE, 'DATA/Q003_4') as Q003_4
          , extractValue(COLUMN_VALUE, 'DATA/T070') as T070
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '42X'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_42X is '���� 42X - ��� ��� ����������� ������ �� ��������� ���������� �����';
comment on column V_NBUR_42X.REPORT_DATE is '��i��� ����';
comment on column V_NBUR_42X.KF is '�i�i�';
comment on column V_NBUR_42X.VERSION_ID is '����� ���� �����';
comment on column V_NBUR_42X.EKP    is '��� ���������';
comment on column V_NBUR_42X.F099   is '��� ����� ��� ���������� ���������� ���������';
comment on column V_NBUR_42X.Q003_4 is '������� ���������� ����� �����������';
comment on column V_NBUR_42X.T070   is '����';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_42X.sql =========*** End *** =
PROMPT ===================================================================================== 