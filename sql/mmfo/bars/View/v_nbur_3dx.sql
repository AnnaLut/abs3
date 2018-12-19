PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3DX.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_3DX ***

create or replace view v_nbur_3DX as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP')	as EKP
          , extractValue(COLUMN_VALUE, 'DATA/Q003_1')	as Q003_1
          , extractValue(COLUMN_VALUE, 'DATA/Q003_2')	as Q003_2
          , extractValue(COLUMN_VALUE, 'DATA/Q007_1')	as Q007_1
          , extractValue(COLUMN_VALUE, 'DATA/T070_1')	as T070_1
          , extractValue(COLUMN_VALUE, 'DATA/T070_2')	as T070_2
          , extractValue(COLUMN_VALUE, 'DATA/T070_3')	as T070_3
          , extractValue(COLUMN_VALUE, 'DATA/T070_4')	as T070_4
          , extractValue(COLUMN_VALUE, 'DATA/Q003_3')	as Q003_3
          , extractValue(COLUMN_VALUE, 'DATA/Q007_2')	as Q007_2
          , extractValue(COLUMN_VALUE, 'DATA/S031')	as S031	
          , extractValue(COLUMN_VALUE, 'DATA/T070_5')	as T070_5
          , extractValue(COLUMN_VALUE, 'DATA/T090')	as T090	
          , extractValue(COLUMN_VALUE, 'DATA/Q014')	as Q014	
          , extractValue(COLUMN_VALUE, 'DATA/Q001_1')	as Q001_1
          , extractValue(COLUMN_VALUE, 'DATA/Q015_1')	as Q015_1
          , extractValue(COLUMN_VALUE, 'DATA/Q015_2')	as Q015_2
          , extractValue(COLUMN_VALUE, 'DATA/Q001_2')	as Q001_2
          , extractValue(COLUMN_VALUE, 'DATA/K020_1')	as K020_1
          , extractValue(COLUMN_VALUE, 'DATA/Q003_4')	as Q003_4
          , extractValue(COLUMN_VALUE, 'DATA/F017_1')	as F017_1
          , extractValue(COLUMN_VALUE, 'DATA/Q007_3')	as Q007_3
          , extractValue(COLUMN_VALUE, 'DATA/F018_1')	as F018_1
          , extractValue(COLUMN_VALUE, 'DATA/Q007_4')	as Q007_4
          , extractValue(COLUMN_VALUE, 'DATA/Q005')	as Q005	
          , extractValue(COLUMN_VALUE, 'DATA/T070_6')	as T070_6
          , extractValue(COLUMN_VALUE, 'DATA/T070_7')	as T070_7
          , extractValue(COLUMN_VALUE, 'DATA/T070_8')	as T070_8
          , extractValue(COLUMN_VALUE, 'DATA/T070_9')	as T070_9
          , extractValue(COLUMN_VALUE, 'DATA/IDKU_1')	as IDKU_1
          , extractValue(COLUMN_VALUE, 'DATA/Q002_1')	as Q002_1
          , extractValue(COLUMN_VALUE, 'DATA/Q002_2')	as Q002_2
          , extractValue(COLUMN_VALUE, 'DATA/Q002_3')	as Q002_3
          , extractValue(COLUMN_VALUE, 'DATA/Q001_3')	as Q001_3
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '3DX'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_3DX is '���� 3DX -  ����� ��� �� ������ ������������� ����� ������';
comment on column V_NBUR_3DX.REPORT_DATE	is '��i��� ����';
comment on column V_NBUR_3DX.KF			is '�i�i�';
comment on column V_NBUR_3DX.VERSION_ID		is '����� ���� �����';
comment on column V_NBUR_3DX.EKP		is '��� ���������';
comment on column V_NBUR_3DX.Q003_1		is '������� ���������� ����� ���������� ��������';                                                  
comment on column V_NBUR_3DX.Q003_2		is '����� ���������� ��������';                                                                     
comment on column V_NBUR_3DX.Q007_1		is '���� ���������� ��������';                                                                      
comment on column V_NBUR_3DX.T070_1		is '������� ������� ������������� �� ����� ����';                                                
comment on column V_NBUR_3DX.T070_2		is '������� ������������� �� ���������';                                                          
comment on column V_NBUR_3DX.T070_3		is '��������� ���� �������';                                                                      
comment on column V_NBUR_3DX.T070_4		is '���� ���������� ���';                                                                         
comment on column V_NBUR_3DX.Q003_3		is '����� �������� �������/�������';                                                                
comment on column V_NBUR_3DX.Q007_2		is '���� �������� �������/�������';                                                                 
comment on column V_NBUR_3DX.S031		is '��� ������������ �������';                                                                      
comment on column V_NBUR_3DX.T070_5		is '�������� ������� ���� �������� �������';                                                      
comment on column V_NBUR_3DX.T090  		is '�������� ����������� �����������';                                                              
comment on column V_NBUR_3DX.Q014		is '�������� ������������ ����';                                                                   
comment on column V_NBUR_3DX.Q001_1		is '����� �����/�������, �������� �������, �� ������� �� ������� �� ��������� �������������� ���';
comment on column V_NBUR_3DX.Q015_1		is '������� ������� �������������� �������� �������';                                              
comment on column V_NBUR_3DX.Q015_2		is 'ʳ������ �������������� (����� ����)/ ����� ������ �������� �������';                         
comment on column V_NBUR_3DX.Q001_2		is '����� ������������ ������������ / ������������';                                                
comment on column V_NBUR_3DX.K020_1		is '��� ������������ / ������������';                                                               
comment on column V_NBUR_3DX.Q003_4		is '����� �������� ��� �������� ���������';                                                       
comment on column V_NBUR_3DX.F017_1		is '���� ����� �� ��������� �����������';                                                          
comment on column V_NBUR_3DX.Q007_3		is '���� �������� �������� ����� ����� ������ / ���� ���������';                                 
comment on column V_NBUR_3DX.F018_1		is '���� ����� �� ���� �������� ��������';                                                        
comment on column V_NBUR_3DX.Q007_4		is '���� ��������� �������� ����������� / ���� ��������� ������ ������';                          
comment on column V_NBUR_3DX.Q005		is '��������� ������� ������ ������';	                                                    
comment on column V_NBUR_3DX.T070_6		is '��������� ������� ������ ������';                                                             
comment on column V_NBUR_3DX.T070_7		is '����������� ������� ������ ������';                                                           
comment on column V_NBUR_3DX.T070_8		is '�������� ������� �������� �������';                                                            
comment on column V_NBUR_3DX.T070_9		is '�������� ������� ����� / �������� �������';                                                    
comment on column V_NBUR_3DX.IDKU_1		is '̳�������������� �����/�������, �������� ������� ';                                             
comment on column V_NBUR_3DX.Q002_1		is '����� ��������������� �����/�������, �������� �������';                                        
comment on column V_NBUR_3DX.Q002_2		is '���������� ����� ��������������� �����/�������, �������� �������';                             
comment on column V_NBUR_3DX.Q002_3		is '����� ������, ����� �������, ����� �������� ��������������� �����/�������, �������� �������';  
comment on column V_NBUR_3DX.Q001_3		is '���������� ������������� (��� ������ ������)';                                                

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3DX.sql =========*** End *** =
PROMPT ===================================================================================== 