PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3Vx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_3VX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP 
       , p.F059
       , p.K111
       , p.K031
       , p.F063
       , p.F064
       , p.S190
       , p.F073
       , p.F003
       , p.Q001
       , p.K020
       , p.Q026
       , p.T100
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/F059'  ) as F059
               , extractValue( COLUMN_VALUE, 'DATA/K111'  ) as K111
               , extractValue( COLUMN_VALUE, 'DATA/K031'  ) as K031
               , extractValue( COLUMN_VALUE, 'DATA/F063'  ) as F063
               , extractValue( COLUMN_VALUE, 'DATA/F064'  ) as F064
               , extractValue( COLUMN_VALUE, 'DATA/S190'  ) as S190
               , extractValue( COLUMN_VALUE, 'DATA/F073'  ) as F073
               , extractValue( COLUMN_VALUE, 'DATA/F003'  ) as F003
               , extractValue( COLUMN_VALUE, 'DATA/Q001'  ) as Q001
               , extractValue( COLUMN_VALUE, 'DATA/K020'  ) as K020
               , extractValue( COLUMN_VALUE, 'DATA/Q026'  ) as Q026
               , extractValue( COLUMN_VALUE, 'DATA/T100'  ) as T100
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '3VX'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by K020, K020, F059;

comment on table  v_nbur_3Vx is '���� 3VX ��� ��� �������� �����';
comment on column v_nbur_3Vx.REPORT_DATE 	is '��i��� ����';
comment on column v_nbur_3Vx.KF 		is '�i�i�';
comment on column v_nbur_3Vx.VERSION_ID 	is '����� ���� �����';
comment on column v_nbur_3Vx.EKP 		is '��� ���������';
comment on column v_nbur_3Vx.T100 		is '����';                                                                                  
comment on column v_nbur_3Vx.F059 		is '��� ������ ��������';                                                                  
comment on column v_nbur_3Vx.K111 		is '��� ������ ���� ��������� �������� (����������)';                               
comment on column v_nbur_3Vx.K031 		is '��� ������ �������������� ���������';                                                 
comment on column v_nbur_3Vx.F063 		is '��� ���� ��������� ��������� �������';                                               
comment on column v_nbur_3Vx.F064 		is '��� ��������� �� ����� ��������� ��� �� ������� ���������';                         
comment on column v_nbur_3Vx.S190 		is '��� ������ ������������ ��������� �����';                                               
comment on column v_nbur_3Vx.F073 		is '��� ��������� �� ��������, ������� ���� ����� ��� ��������� �������������� �������';
comment on column v_nbur_3Vx.F003 		is '��� ����� �������������';                                                              
comment on column v_nbur_3Vx.Q001 		is '�������� ��������� ������������ ��������';                                              
comment on column v_nbur_3Vx.K020 		is '������ �������� �����';                                                                
comment on column v_nbur_3Vx.Q026 		is '��������� �������� �� ����� ��������� �����������';                                  

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3Vx.sql =========*** End *** ===
PROMPT ===================================================================================== 

