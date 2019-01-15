PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_8BX.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_8BX ***

create or replace view v_nbur_8BX as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/F103') as F103
          , extractValue(COLUMN_VALUE, 'DATA/Q003_4') as Q003_4
          , extractValue(COLUMN_VALUE, 'DATA/T070') as T070
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '8BX'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_8BX is '���� 8BX -  ����� ��� �� ������ ������������� ����� ������';
comment on column V_NBUR_8BX.REPORT_DATE is '��i��� ����';
comment on column V_NBUR_8BX.KF is '�i�i�';
comment on column V_NBUR_8BX.VERSION_ID is '����� ���� �����';
comment on column V_NBUR_8BX.EKP    is '��� ���������';
comment on column V_NBUR_8BX.F103   is '��� ����� ��� ���������� ���������� ���������';
comment on column V_NBUR_8BX.Q003_4 is '������� ���������� ����� �����������';
comment on column V_NBUR_8BX.T070   is '����';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_8BX.sql =========*** End *** =
PROMPT ===================================================================================== 