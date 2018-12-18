
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Fx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_6Fx_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
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
	 , p.FLAG_XML       
         , p.DESCRIPTION
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
    from NBUR_LOG_F6FX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#6F' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_6Fx_DTL is '��������� �������� ����� 6FX';
comment on column v_nbur_6Fx_DTL.REPORT_DATE is '����� ����';
comment on column v_nbur_6Fx_DTL.KF is '��� �i�i��� (���)';
comment on column v_nbur_6Fx_DTL.VERSION_ID is '��. ���� �����';
comment on column v_nbur_6Fx_DTL.EKP is '��� ���������';
comment on column v_nbur_6Fx_DTL.K020	is '����������������/������������ ���/����� �����������/���?����� � ������ �����';                       
comment on column v_nbur_6Fx_DTL.K021	is '��� ������ �����������������/������������� ����/������';                                              
comment on column v_nbur_6Fx_DTL.Q001	is '������������ �����������/�������� � ������ �����';                                                   
comment on column v_nbur_6Fx_DTL.F084	is '��� ���� ��������� ����������� �� ������ ������������ ����������� (SPE)';                           
comment on column v_nbur_6Fx_DTL.K040	is '��� �����';                                                                                           
comment on column v_nbur_6Fx_DTL.KU_1	is '��� ������';                                                                                          
comment on column v_nbur_6Fx_DTL.K110	is '��� ���� ��������� ��������';                                                                      
comment on column v_nbur_6Fx_DTL.K074	is '��� �������������� ������� ��������';                                                                 
comment on column v_nbur_6Fx_DTL.K140	is '��� ������ ��ᒺ��� ��������������';                                                                  
comment on column v_nbur_6Fx_DTL.Q020	is '��� ���� �������� � ������ �����';                                                                   
comment on column v_nbur_6Fx_DTL.Q003_1	is '���������� ����� ����� �����������';                                                                  
comment on column v_nbur_6Fx_DTL.Q029  	is '��� �����������/�� ����� ����������� ��� ���� � ����� �������� ��� ���������� ������������ ������';
comment on column v_nbur_6Fx_DTL.FLAG_XML       is '���� ��������� � XML ���� (1-���, 0-�)';
comment on column v_nbur_6Fx_DTL.DESCRIPTION 	is '���� (��������)';                                                                              
comment on column v_nbur_6Fx_DTL.KV		is '��. ������';                                                                                   
comment on column v_nbur_6Fx_DTL.CUST_ID 	is '��. �볺���';                                                                                  
comment on column v_nbur_6Fx_DTL.CUST_CODE      is '��� �볺���';                                                                                  
comment on column v_nbur_6Fx_DTL.CUST_NAME	is '����� �볺���';                                                                                
comment on column v_nbur_6Fx_DTL.ND		is '��. ��������';                                                                                 
comment on column v_nbur_6Fx_DTL.AGRM_NUM	is '����� ��������';                                                                               
comment on column v_nbur_6Fx_DTL.BEG_DT		is '���� ������� ��������';                                                                        
comment on column v_nbur_6Fx_DTL.END_DT		is '���� ��������� ��������';                                                                     
comment on column v_nbur_6Fx_DTL.BRANCH		is '��� ��������';                                                                               
comment on column v_nbur_6Fx_DTL.VERSION_D8 is '��. ���� ����� #D8';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Fx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
