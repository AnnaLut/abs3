
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Ix_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_6Ix_dtl
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
         , p.R020
         , p.F081
         , p.S031	 
         , p.T070_DTL
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
    from NBUR_LOG_F6IX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#6I' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_6Ix_DTL 		is '��������� �������� ����� 6IX';
comment on column v_nbur_6Ix_DTL.REPORT_DATE 	is '����� ����';
comment on column v_nbur_6Ix_DTL.KF 		is '��� �i�i��� (���)';
comment on column v_nbur_6Ix_DTL.VERSION_ID 	is '��. ���� �����';
comment on column v_nbur_6Ix_DTL.EKP 		is '��� ���������';
comment on column v_nbur_6Ix_DTL.K020		is '����������������/������������ ���/����� �����������/���?����� � ������ �����';                       
comment on column v_nbur_6Ix_DTL.K021		is '��� ������ �����������������/������������� ����/������';                                              
comment on column v_nbur_6Ix_DTL.Q003_2  	is '������� ���������� ����� ��������';                                                                               
comment on column v_nbur_6Ix_DTL.Q003_4		is '������� ���������� ����� ������';                                                                                 
comment on column v_nbur_6Ix_DTL.R030		is '��� ������';                                                                                                      
comment on column v_nbur_6Ix_DTL.R020		is '����� �������';                                                
comment on column v_nbur_6Ix_DTL.F081		is '��� ���� ��������� �� ���������� ��������� ���������� ������';
comment on column v_nbur_6Ix_DTL.S031		is '��� ���� ������������ �������� �������� �� ���������';        
comment on column v_nbur_6Ix_DTL.T070_DTL 	is '���� ��� ����������';                                                         
comment on column v_nbur_6Ix_DTL.DESCRIPTION 	is '���� (��������)';                                                                                         
comment on column v_nbur_6Ix_DTL.ACC_ID		is '��. �������';                                                                                             
comment on column v_nbur_6Ix_DTL.ACC_NUM 	is '����� �������';                                                                                           
comment on column v_nbur_6Ix_DTL.KV		is '��. ������';                                                                                              
comment on column v_nbur_6Ix_DTL.CUST_ID 	is '��. �볺���';                                                                                             
comment on column v_nbur_6Ix_DTL.CUST_CODE      is '��� �볺���';                                                                                             
comment on column v_nbur_6Ix_DTL.CUST_NAME	is '����� �볺���';                                                                                           
comment on column v_nbur_6Ix_DTL.ND		is '��. ��������';                                                                                            
comment on column v_nbur_6Ix_DTL.AGRM_NUM	is '����� ��������';                                                                                          
comment on column v_nbur_6Ix_DTL.BEG_DT		is '���� ������� ��������';                                                                                   
comment on column v_nbur_6Ix_DTL.END_DT		is '���� ��������� ��������';                                                                                
comment on column v_nbur_6Ix_DTL.BRANCH		is '��� ��������';                                                                                          
comment on column v_nbur_6Ix_DTL.VERSION_D8 	is '��. ���� ����� #D8';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Ix_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
