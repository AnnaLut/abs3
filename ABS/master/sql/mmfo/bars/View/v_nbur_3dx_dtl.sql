PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3DX_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_3DX_dtl ***

create or replace view v_nbur_3DX_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.Q003_1
     , p.Q003_2
     , p.Q007_1
     , p.T070_1
     , p.T070_2
     , p.T070_3
     , p.T070_4
     , p.Q003_3
     , p.Q007_2
     , p.S031	
     , p.T070_5
     , p.T090	
     , p.Q014	
     , p.Q001_1
     , p.Q015_1
     , p.Q015_2
     , p.Q001_2
     , p.K020_1
     , p.Q003_4
     , p.F017_1
     , p.Q007_3
     , p.F018_1
     , p.Q007_4
     , p.Q005	
     , p.T070_6
     , p.T070_7
     , p.T070_8
     , p.T070_9
     , p.IDKU_1
     , p.Q002_1
     , p.Q002_2
     , p.Q002_3
     , p.Q001_3
     , p.DESCRIPTION
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.MATURITY_DATE
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.ND         	 
     , p.AGRM_NUM	 
     , p.BEG_DT
     , p.END_DT     	 
     , p.REF
     , p.BRANCH
  from NBUR_LOG_F3DX p
       join NBUR_REF_FILES f on (f.FILE_CODE = '3DX')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
 order by Q003_1,Q003_2,Q007_1,Q003_3,Q007_2,S031,Q001_1,K020_1,Q003_4, acc_num, kv;
   
comment on table V_NBUR_3DX_DTL			is '��������� �������� ����� 3DX';
comment on column V_NBUR_3DX_DTL.REPORT_DATE	is '����� ����';
comment on column V_NBUR_3DX_DTL.KF		is '��� �i�i��� (���)';
comment on column V_NBUR_3DX_DTL.VERSION_ID	is '��. ���� �����';
comment on column V_NBUR_3DX_DTL.NBUC		is '��� ������ ����� � ������� ����';
comment on column V_NBUR_3DX_DTL.EKP		is '��� ���������';
comment on column V_NBUR_3DX_DTL.Q003_1		is '������� ���������� ����� ���������� ��������';                                                   
comment on column V_NBUR_3DX_DTL.Q003_2		is '����� ���������� ��������';                                                                      
comment on column V_NBUR_3DX_DTL.Q007_1		is '���� ���������� ��������';                                                                       
comment on column V_NBUR_3DX_DTL.T070_1		is '������� ������� ������������� �� ����� ����';                                                 
comment on column V_NBUR_3DX_DTL.T070_2		is '������� ������������� �� ���������';                                                           
comment on column V_NBUR_3DX_DTL.T070_3		is '��������� ���� �������';                                                                       
comment on column V_NBUR_3DX_DTL.T070_4		is '���� ���������� ���';                                                                          
comment on column V_NBUR_3DX_DTL.Q003_3		is '����� �������� �������/�������';                                                                 
comment on column V_NBUR_3DX_DTL.Q007_2		is '���� �������� �������/�������';                                                                  
comment on column V_NBUR_3DX_DTL.S031		is '��� ������������ �������';                                                                       
comment on column V_NBUR_3DX_DTL.T070_5		is '�������� ������� ���� �������� �������';                                                       
comment on column V_NBUR_3DX_DTL.T090  		is '�������� ����������� �����������';                                                               
comment on column V_NBUR_3DX_DTL.Q014		is '�������� ������������ ����';                                                                    
comment on column V_NBUR_3DX_DTL.Q001_1		is '����� �����/�������, �������� �������, �� ������� �� ������� �� ��������� �������������� ���'; 
comment on column V_NBUR_3DX_DTL.Q015_1		is '������� ������� �������������� �������� �������';                                               
comment on column V_NBUR_3DX_DTL.Q015_2		is 'ʳ������ �������������� (����� ����)/ ����� ������ �������� �������';                          
comment on column V_NBUR_3DX_DTL.Q001_2		is '����� ������������ ������������ / ������������';                                                 
comment on column V_NBUR_3DX_DTL.K020_1		is '��� ������������ / ������������';                                                                
comment on column V_NBUR_3DX_DTL.Q003_4		is '����� �������� ��� �������� ���������';                                                        
comment on column V_NBUR_3DX_DTL.F017_1		is '���� ����� �� ��������� �����������';                                                           
comment on column V_NBUR_3DX_DTL.Q007_3		is '���� �������� �������� ����� ����� ������ / ���� ���������';                                  
comment on column V_NBUR_3DX_DTL.F018_1		is '���� ����� �� ���� �������� ��������';                                                         
comment on column V_NBUR_3DX_DTL.Q007_4		is '���� ��������� �������� ����������� / ���� ��������� ������ ������';                           
comment on column V_NBUR_3DX_DTL.Q005		is '��������� ������� ������ ������';	                                                     
comment on column V_NBUR_3DX_DTL.T070_6		is '��������� ������� ������ ������';                                                              
comment on column V_NBUR_3DX_DTL.T070_7		is '����������� ������� ������ ������';                                                            
comment on column V_NBUR_3DX_DTL.T070_8		is '�������� ������� �������� �������';                                                             
comment on column V_NBUR_3DX_DTL.T070_9		is '�������� ������� ����� / �������� �������';                                                     
comment on column V_NBUR_3DX_DTL.IDKU_1		is '̳�������������� �����/�������, �������� ������� ';                                              
comment on column V_NBUR_3DX_DTL.Q002_1		is '����� ��������������� �����/�������, �������� �������';                                         
comment on column V_NBUR_3DX_DTL.Q002_2		is '���������� ����� ��������������� �����/�������, �������� �������';                              
comment on column V_NBUR_3DX_DTL.Q002_3		is '����� ������, ����� �������, ����� �������� ��������������� �����/�������, �������� �������';   
comment on column V_NBUR_3DX_DTL.Q001_3		is '���������� ������������� (��� ������ ������)';                                                 
comment on column V_NBUR_3DX_DTL.DESCRIPTION 	is '���� (��������)';                                                                                
comment on column V_NBUR_3DX_DTL.ACC_ID		is '��. �������';                                                                                    
comment on column V_NBUR_3DX_DTL.ACC_NUM 	is '����� �������';                                                                                  
comment on column V_NBUR_3DX_DTL.KV 		is '��. ������';                                                                                     
comment on column V_NBUR_3DX_DTL.MATURITY_DATE 	is '���� ���������';                                                                                 
comment on column V_NBUR_3DX_DTL.CUST_ID 	is '��. �볺���';                                                                                    
comment on column V_NBUR_3DX_DTL.CUST_CODE 	is '��� �볺���';                                                                                    
comment on column V_NBUR_3DX_DTL.CUST_NAME 	is '����� �볺���';                                                                                  
comment on column V_NBUR_3DX_DTL.ND 		is '��. ��������';                                                                                   
comment on column V_NBUR_3DX_DTL.AGRM_NUM 	is '����� ��������';                                                                                 
comment on column V_NBUR_3DX_DTL.BEG_DT		is '���� ������� ��������';                                                                          
comment on column V_NBUR_3DX_DTL.END_DT		is '���� ��������� ��������';                                                                       
comment on column V_NBUR_3DX_DTL.REF 		is '��. ��������� ���������';                                                                       
comment on column V_NBUR_3DX_DTL.BRANCH		is '��� ��������';                                                                                 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3DX_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 