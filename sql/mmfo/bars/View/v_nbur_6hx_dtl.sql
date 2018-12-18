
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Hx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_6Hx_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
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
         , p.DESCRIPTION
         , p.ACC_ID     	 
	 , p.ACC_NUM    	 
         , p.KV         	 
         , p.CUST_ID    	 
         , p.CUST_CODE	 
         , p.CUST_NAME	 
         , p.ND         	 
         , p.AGRM_NUM	 
         , p.BEG_DT
         , p.END_DT     	 
         , p.BRANCH
         , p.VERSION_D8
    from NBUR_LOG_F6HX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#6H' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_6Hx_DTL 		is '��������� �������� ����� 6HX';
comment on column v_nbur_6Hx_DTL.REPORT_DATE 	is '����� ����';
comment on column v_nbur_6Hx_DTL.KF 		is '��� �i�i��� (���)';
comment on column v_nbur_6Hx_DTL.VERSION_ID 	is '��. ���� �����';
comment on column v_nbur_6Hx_DTL.EKP 		is '��� ���������';
comment on column v_nbur_6Hx_DTL.K020		is '����������������/������������ ���/����� �����������/���?����� � ������ �����';                       
comment on column v_nbur_6Hx_DTL.K021		is '��� ������ �����������������/������������� ����/������';                                              
comment on column v_nbur_6Hx_DTL.Q003_2  	is '������� ���������� ����� ��������';                                                                               
comment on column v_nbur_6Hx_DTL.Q003_4		is '������� ���������� ����� ������';                                                                                 
comment on column v_nbur_6Hx_DTL.R030		is '��� ������';                                                                                                      
comment on column v_nbur_6Hx_DTL.Q007_1		is '���� ���������� �������������/���.����������';                                                                  
comment on column v_nbur_6Hx_DTL.Q007_2		is '���� �������� ��������� �������������/���.����������';                                                         
comment on column v_nbur_6Hx_DTL.S210		is '��� ������� �������� ���� ����������������/��������������';                                                      
comment on column v_nbur_6Hx_DTL.S083		is '��� ���� ������ ���������� ������';                                                                               
comment on column v_nbur_6Hx_DTL.S080_1  	is '��� ����� �����������/������� � ������ �����';                                                                  
comment on column v_nbur_6Hx_DTL.S080_2  	is '��� ������������� ����� �����������/������� � ������ �����';                                                    
comment on column v_nbur_6Hx_DTL.F074		is '��� ������� ���� ��������� �� ����� ��������� ��� �� ������� ��������� ��� �� ����� ��������� �����������'; 
comment on column v_nbur_6Hx_DTL.F077		is '��� ������� ���� ���������� ������ �����';                                                                      
comment on column v_nbur_6Hx_DTL.F078		is '��� ������� ���� ���������� �������������';                                                                       
comment on column v_nbur_6Hx_DTL.F102		is '��� ���� �������� ���������� � ���������� �����';                                                              
comment on column v_nbur_6Hx_DTL.Q017		is '��� ������� ���� �������� ������, �� ������� ��� ������� ��������� ����� (�� F075)';                            
comment on column v_nbur_6Hx_DTL.Q027		is '��� ������� ���� ��䳿 ������� (�� F076)';                                                                        
comment on column v_nbur_6Hx_DTL.Q034		is '��� �������, �� ������ ����� ����������� ���� �����������/�������� � ������ ����� (�� F079)';                 
comment on column v_nbur_6Hx_DTL.Q035		is '��� ������ ��䳿 �������, ���� ��� �������� ��������� ������� (�� F080)';                                      
comment on column v_nbur_6Hx_DTL.T070_2  	is '����� ���������� ������ (CR)';                                                                                   
comment on column v_nbur_6Hx_DTL.T090		is '��������� ������';                                                                                                
comment on column v_nbur_6Hx_DTL.T100_1  	is '���������� ������ ���������� ������ (PD)';                                                                       
comment on column v_nbur_6Hx_DTL.T100_2  	is '���������� LGD';                                                                                                  
comment on column v_nbur_6Hx_DTL.T100_3  	is '���������� CCF';                                                                                                  
comment on column v_nbur_6Hx_DTL.DESCRIPTION 	is '���� (��������)';                                                                                         
comment on column v_nbur_6Hx_DTL.ACC_ID		is '��. �������';                                                                                             
comment on column v_nbur_6Hx_DTL.ACC_NUM 	is '����� �������';                                                                                           
comment on column v_nbur_6Hx_DTL.KV		is '��. ������';                                                                                              
comment on column v_nbur_6Hx_DTL.CUST_ID 	is '��. �볺���';                                                                                             
comment on column v_nbur_6Hx_DTL.CUST_CODE      is '��� �볺���';                                                                                             
comment on column v_nbur_6Hx_DTL.CUST_NAME	is '����� �볺���';                                                                                           
comment on column v_nbur_6Hx_DTL.ND		is '��. ��������';                                                                                            
comment on column v_nbur_6Hx_DTL.AGRM_NUM	is '����� ��������';                                                                                          
comment on column v_nbur_6Hx_DTL.BEG_DT		is '���� ������� ��������';                                                                                   
comment on column v_nbur_6Hx_DTL.END_DT		is '���� ��������� ��������';                                                                                
comment on column v_nbur_6Hx_DTL.BRANCH		is '��� ��������';                                                                                          
comment on column v_nbur_6Hx_DTL.VERSION_D8 	is '��. ���� ����� #D8';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Hx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
