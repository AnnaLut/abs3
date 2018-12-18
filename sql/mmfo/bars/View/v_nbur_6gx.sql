PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Gx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_6GX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP
       , p.K020	
       , p.K021	
       , p.Q003_2	
       , p.Q003_3	
       , p.Q007		
       , p.B040		
       , p.T070_1	
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   )	as EKP
               , extractValue( COLUMN_VALUE, 'DATA/K020'  )	as K020	 
               , extractValue( COLUMN_VALUE, 'DATA/K021'  )	as K021	 
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2')	as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/Q003_3')	as Q003_3
               , extractValue( COLUMN_VALUE, 'DATA/Q007	' )	as Q007
               , extractValue( COLUMN_VALUE, 'DATA/B040	' )	as B040
               , extractValue( COLUMN_VALUE, 'DATA/T070_1')	as T070_1
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#6G'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by K020;

comment on table  v_nbur_6Gx is '���� 6GX - ���i ��� ������������ ������ �� ��������� ���������� �����';
comment on column v_nbur_6Gx.REPORT_DATE is '��i��� ����';
comment on column v_nbur_6Gx.KF 	is '�i�i�';
comment on column v_nbur_6Gx.VERSION_ID is '����� ���� �����';
comment on column v_nbur_6Gx.EKP	is '��� ���������';
comment on column v_nbur_6Gx.K020	is '����������������/������������ ���/����� �����������/���?����� � ������ �����';                       
comment on column v_nbur_6Gx.K021	is '��� ������ �����������������/������������� ����/������';                                              
comment on column v_nbur_6Gx.Q003_2	is '������� ���������� ����� ��������';                                                          
comment on column v_nbur_6Gx.Q003_3	is '����� ��������� ��������';                                                                   
comment on column v_nbur_6Gx.Q007	is '���� ��������� ��������';                                                                    
comment on column v_nbur_6Gx.B040	is '��� �������� �����, �� ���������� ������������ �� ��������';                             
comment on column v_nbur_6Gx.T070_1	is '���� ����� ���������� (RC)';                                                                  

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Gx.sql =========*** End *** ===
PROMPT ===================================================================================== 

