
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Gx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_6Gx_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.K020    
         , p.K021    
         , p.Q003_2    
         , p.Q003_3    
         , to_char(p.Q007, 'dd.mm.yyyy') Q007
         , p.B040        
         , p.T070_1    
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
    from NBUR_LOG_F6GX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#6G' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_6Gx_DTL		is '��������� �������� ����� 6GX';
comment on column v_nbur_6Gx_DTL.REPORT_DATE	is '����� ����';
comment on column v_nbur_6Gx_DTL.KF		is '��� �i�i��� (���)';
comment on column v_nbur_6Gx_DTL.VERSION_ID	is '��. ���� �����';
comment on column v_nbur_6Gx_DTL.EKP		is '��� ���������';
comment on column v_nbur_6Gx_DTL.K020		is '����������������/������������ ���/����� �����������/���?����� � ������ �����';                       
comment on column v_nbur_6Gx_DTL.K021		is '��� ������ �����������������/������������� ����/������';                                              
comment on column v_nbur_6Gx_DTL.Q003_2		is '������� ���������� ����� ��������';                                
comment on column v_nbur_6Gx_DTL.Q003_3		is '����� ��������� ��������';                                         
comment on column v_nbur_6Gx_DTL.Q007    	is '���� ��������� ��������';                                          
comment on column v_nbur_6Gx_DTL.B040    	is '��� �������� �����, �� ���������� ������������ �� ��������';   
comment on column v_nbur_6Gx_DTL.T070_1    	is '���� ����� ���������� (RC)';                                       
comment on column v_nbur_6Gx_DTL.DESCRIPTION	is '���� (��������)';                                                                              
comment on column v_nbur_6Gx_DTL.KV        	is '��. ������';                                                                                   
comment on column v_nbur_6Gx_DTL.CUST_ID     	is '��. �볺���';                                                                                  
comment on column v_nbur_6Gx_DTL.CUST_CODE      is '��� �볺���';                                                                                  
comment on column v_nbur_6Gx_DTL.CUST_NAME    	is '����� �볺���';                                                                                
comment on column v_nbur_6Gx_DTL.ND        	is '��. ��������';                                                                                 
comment on column v_nbur_6Gx_DTL.AGRM_NUM    	is '����� ��������';                                                                               
comment on column v_nbur_6Gx_DTL.BEG_DT        	is '���� ������� ��������';                                                                        
comment on column v_nbur_6Gx_DTL.END_DT        	is '���� ��������� ��������';                                                                     
comment on column v_nbur_6Gx_DTL.BRANCH        	is '��� ��������';                                                                               
comment on column v_nbur_6Gx_DTL.VERSION_D8	is '��. ���� ����� #D8';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Gx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
