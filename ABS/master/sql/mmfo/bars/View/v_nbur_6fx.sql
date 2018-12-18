PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Fx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_6FX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP
       , p.K020	
       , p.K021	
       , p.Q001	
       , p.F084	
       , p.K040	
       , p.KU_1	
       , p.K110	
       , p.K074	
       , p.K140	
       , p.Q020	
       , p.Q003_1
       , p.Q029  
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   )	as EKP
               , extractValue( COLUMN_VALUE, 'DATA/K020'  )	as K020	 
               , extractValue( COLUMN_VALUE, 'DATA/K021'  )	as K021	 
               , extractValue( COLUMN_VALUE, 'DATA/Q001'  )	as Q001	 
               , extractValue( COLUMN_VALUE, 'DATA/F084'  )	as F084	 
               , extractValue( COLUMN_VALUE, 'DATA/K040'  )	as K040	 
               , extractValue( COLUMN_VALUE, 'DATA/KU_1'  )	as KU_1	 
               , extractValue( COLUMN_VALUE, 'DATA/K110'  )	as K110	 
               , extractValue( COLUMN_VALUE, 'DATA/K074'  )	as K074	 
               , extractValue( COLUMN_VALUE, 'DATA/K140'  )	as K140	 
               , extractValue( COLUMN_VALUE, 'DATA/Q020'  )	as Q020	 
               , extractValue( COLUMN_VALUE, 'DATA/Q003_1'  )	as Q003_1
               , extractValue( COLUMN_VALUE, 'DATA/Q029'  )	as Q029  
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#6F'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by K020;

comment on table  v_nbur_6Fx is '���� 6FX - ���i ��� ������������ ������ �� ��������� ���������� ����� (���������� ��� �����������/��)';
comment on column v_nbur_6Fx.REPORT_DATE is '��i��� ����';
comment on column v_nbur_6Fx.KF 	is '�i�i�';
comment on column v_nbur_6Fx.VERSION_ID is '����� ���� �����';
comment on column v_nbur_6Fx.EKP	is '��� ���������';
comment on column v_nbur_6Fx.K020	is '����������������/������������ ���/����� �����������/���?����� � ������ �����';                       
comment on column v_nbur_6Fx.K021	is '��� ������ �����������������/������������� ����/������';                                              
comment on column v_nbur_6Fx.Q001	is '������������ �����������/�������� � ������ �����';                                                   
comment on column v_nbur_6Fx.F084	is '��� ���� ��������� ����������� �� ������ ������������ ����������� (SPE)';                           
comment on column v_nbur_6Fx.K040	is '��� �����';                                                                                           
comment on column v_nbur_6Fx.KU_1	is '��� ������';                                                                                          
comment on column v_nbur_6Fx.K110	is '��� ���� ��������� ��������';                                                                       
comment on column v_nbur_6Fx.K074	is '��� �������������� ������� ��������';                                                                  
comment on column v_nbur_6Fx.K140	is '��� ������ ��ᒺ��� ��������������';                                                                   
comment on column v_nbur_6Fx.Q020	is '��� ���� �������� � ������ �����';                                                                    
comment on column v_nbur_6Fx.Q003_1	is '���������� ����� ����� �����������';                                                                   
comment on column v_nbur_6Fx.Q029   	is '��� �����������/�� ����� ����������� ��� ���� � ����� �������� ��� ���������� ������������ ������'; 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Fx.sql =========*** End *** ===
PROMPT ===================================================================================== 

