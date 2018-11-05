
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_f8x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_F8X_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.F034       
         , p.F035       
         , p.R030       
         , p.S080       
         , p.K111       
         , p.S260       
         , p.S032       
         , p.S245       
         , p.T100       
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
    from NBUR_LOG_FF8X p
         join NBUR_REF_FILES f on (f.FILE_CODE = 'F8X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_F8X_DTL is '��������� �������� ����� F8X';
comment on column v_nbur_F8X_DTL.REPORT_DATE is '����� ����';
comment on column v_nbur_F8X_DTL.KF is '��� �i�i��� (���)';
comment on column v_nbur_F8X_DTL.VERSION_ID is '��. ���� �����';
comment on column v_nbur_F8X_DTL.EKP    is '��� ���������';
comment on column v_nbur_F8X_DTL.F034   is '��� ������� �� ������ �������������';        
comment on column v_nbur_F8X_DTL.F035   is '��� ���� ��������';                             
comment on column v_nbur_F8X_DTL.R030   is '��� ������';                                    
comment on column v_nbur_F8X_DTL.S080   is '��� ����� ��������/�����������';                
comment on column v_nbur_F8X_DTL.K111   is '��� ������ ���� ��������� ��������';       
comment on column v_nbur_F8X_DTL.S260   is '��� ���� �������������� ���������� �� ������'; 
comment on column v_nbur_F8X_DTL.S032   is '��� ������������� ���� ������������ �������';   
comment on column v_nbur_F8X_DTL.S245   is '��� ��������������� �������� ������ ���������';
comment on column v_nbur_F8X_DTL.T100   is '����/�������';                                

comment on column v_nbur_F8X_DTL.DESCRIPTION  is '���� (��������)';
comment on column v_nbur_F8X_DTL.ACC_ID       is '��. �������';             
comment on column v_nbur_F8X_DTL.ACC_NUM      is '����� �������';           
comment on column v_nbur_F8X_DTL.KV           is '������';                  
comment on column v_nbur_F8X_DTL.CUST_ID      is '��. �볺���';             
comment on column v_nbur_F8X_DTL.CUST_CODE    is '��� �볺���';             
comment on column v_nbur_F8X_DTL.CUST_NAME    is '����� �볺���';           
comment on column v_nbur_F8X_DTL.ND           is '��. ��������';            
comment on column v_nbur_F8X_DTL.AGRM_NUM     is '����� ��������';          
comment on column v_nbur_F8X_DTL.BEG_DT       is '���� ������� ��������';   
comment on column v_nbur_F8X_DTL.END_DT       is '���� ��������� ��������';
comment on column v_nbur_F8X_DTL.BRANCH       is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_f8x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
