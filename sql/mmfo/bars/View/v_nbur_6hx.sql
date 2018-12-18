PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Hx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_6HX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP
       , p.K020	
       , p.K021	
       , p.Q003_2
       , p.Q003_4
       , p.R030	
       , p.Q007_1
       , p.Q007_2
       , p.S210	
       , p.S083	
       , p.S080_1
       , p.S080_2
       , p.F074	
       , p.F077	
       , p.F078	
       , p.F102	
       , p.Q017	
       , p.Q027	
       , p.Q034	
       , p.Q035	
       , p.T070_2
       , p.T090	
       , p.T100_1
       , p.T100_2
       , p.T100_3
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP   '  )	as EKP   
               , extractValue( COLUMN_VALUE, 'DATA/K020	 '  )	as K020	 
               , extractValue( COLUMN_VALUE, 'DATA/K021	 '  )	as K021	 
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2'  )	as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/Q003_4'  )	as Q003_4
               , extractValue( COLUMN_VALUE, 'DATA/R030	 '  )	as R030	 
               , extractValue( COLUMN_VALUE, 'DATA/Q007_1'  )	as Q007_1
               , extractValue( COLUMN_VALUE, 'DATA/Q007_2'  )	as Q007_2
               , extractValue( COLUMN_VALUE, 'DATA/S210	 '  )	as S210	 
               , extractValue( COLUMN_VALUE, 'DATA/S083	 '  )	as S083	 
               , extractValue( COLUMN_VALUE, 'DATA/S080_1'  )	as S080_1
               , extractValue( COLUMN_VALUE, 'DATA/S080_2'  )	as S080_2
               , extractValue( COLUMN_VALUE, 'DATA/F074	 '  )	as F074	 
               , extractValue( COLUMN_VALUE, 'DATA/F077	 '  )	as F077	 
               , extractValue( COLUMN_VALUE, 'DATA/F078	 '  )	as F078	 
               , extractValue( COLUMN_VALUE, 'DATA/F102	 '  )	as F102	 
               , extractValue( COLUMN_VALUE, 'DATA/Q017	 '  )	as Q017	 
               , extractValue( COLUMN_VALUE, 'DATA/Q027	 '  )	as Q027	 
               , extractValue( COLUMN_VALUE, 'DATA/Q034	 '  )	as Q034	 
               , extractValue( COLUMN_VALUE, 'DATA/Q035	 '  )	as Q035	 
               , extractValue( COLUMN_VALUE, 'DATA/T070_2'  )	as T070_2
               , extractValue( COLUMN_VALUE, 'DATA/T090	 '  )	as T090	 
               , extractValue( COLUMN_VALUE, 'DATA/T100_1'  )	as T100_1
               , extractValue( COLUMN_VALUE, 'DATA/T100_2'  )	as T100_2
               , extractValue( COLUMN_VALUE, 'DATA/T100_3'  )	as T100_3
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#6H'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by K020;

comment on table  v_nbur_6Hx is '���� 6HX - ���i ��� ������������ ������ �� ��������� ���������� ����� � ������������� � �� (���������� �� �������� �� ��������)';
comment on column v_nbur_6Hx.REPORT_DATE is '��i��� ����';
comment on column v_nbur_6Hx.KF 	is '�i�i�';
comment on column v_nbur_6Hx.VERSION_ID is '����� ���� �����';
comment on column v_nbur_6Hx.EKP	is '��� ���������';
comment on column v_nbur_6Hx.K020	is '����������������/������������ ���/����� �����������/���?����� � ������ �����';                       
comment on column v_nbur_6Hx.K021	is '��� ������ �����������������/������������� ����/������';                                              
comment on column v_nbur_6Hx.Q003_2	is '������� ���������� ����� ��������';                                                                                 
comment on column v_nbur_6Hx.Q003_4	is '������� ���������� ����� ������';                                                                                   
comment on column v_nbur_6Hx.R030	is '��� ������';                                                                                                        
comment on column v_nbur_6Hx.Q007_1	is '���� ���������� �������������/���.����������';                                                                    
comment on column v_nbur_6Hx.Q007_2	is '���� �������� ��������� �������������/���.����������';                                                           
comment on column v_nbur_6Hx.S210	is '��� ������� �������� ���� ����������������/��������������';                                                        
comment on column v_nbur_6Hx.S083	is '��� ���� ������ ���������� ������';                                                                                 
comment on column v_nbur_6Hx.S080_1	is '��� ����� �����������/������� � ������ �����';                                                                    
comment on column v_nbur_6Hx.S080_2	is '��� ������������� ����� �����������/������� � ������ �����';                                                      
comment on column v_nbur_6Hx.F074	is '��� ������� ���� ��������� �� ����� ��������� ��� �� ������� ��������� ��� �� ����� ��������� �����������';   
comment on column v_nbur_6Hx.F077	is '��� ������� ���� ���������� ������ �����';                                                                        
comment on column v_nbur_6Hx.F078	is '��� ������� ���� ���������� �������������';                                                                         
comment on column v_nbur_6Hx.F102	is '��� ���� �������� ���������� � ���������� �����';                                                                
comment on column v_nbur_6Hx.Q017	is '��� ������� ���� �������� ������, �� ������� ��� ������� ��������� ����� (�� F075)';                              
comment on column v_nbur_6Hx.Q027	is '��� ������� ���� ��䳿 ������� (�� F076)';                                                                          
comment on column v_nbur_6Hx.Q034	is '��� �������, �� ������ ����� ����������� ���� �����������/�������� � ������ ����� (�� F079)';                   
comment on column v_nbur_6Hx.Q035	is '��� ������ ��䳿 �������, ���� ��� �������� ��������� ������� (�� F080)';                                        
comment on column v_nbur_6Hx.T070_2	is '����� ���������� ������ (CR)';                                                                                     
comment on column v_nbur_6Hx.T090	is '��������� ������';                                                                                                  
comment on column v_nbur_6Hx.T100_1	is '���������� ������ ���������� ������ (PD)';                                                                         
comment on column v_nbur_6Hx.T100_2	is '���������� LGD';                                                                                                    
comment on column v_nbur_6Hx.T100_3	is '���������� CCF';                                                                                                    

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Hx.sql =========*** End *** ===
PROMPT ===================================================================================== 

