
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_d9x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_d9x_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.Q003_1
         , p.K020_1
         , p.K021_1
         , p.Q001_1
         , p.Q029_1
         , p.K020_2
         , p.K021_2
         , p.Q001_2
         , p.Q029_2
         , p.K014
         , p.K040
         , p.KU_1
         , p.K110
         , p.T090_1
         , p.T090_2
         , p.DESCRIPTION
         , p.KV
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.BRANCH
    from NBUR_LOG_FD9X p
         join NBUR_REF_FILES f on (f.FILE_CODE = 'D9X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_d9x_DTL is '��������� �������� ����� D9X';
comment on column v_nbur_d9x_DTL.REPORT_DATE is '����� ����';
comment on column v_nbur_d9x_DTL.KF is '��� �i�i��� (���)';
comment on column v_nbur_d9x_DTL.VERSION_ID is '��. ���� �����';
comment on column v_nbur_d9x_DTL.EKP    is '��� ���������';
comment on column v_nbur_d9x_DTL.Q003_1 is '������� ���������� ����� ������';         
comment on column v_nbur_d9x_DTL.K020_1 is '��� �����������';                         
comment on column v_nbur_d9x_DTL.K021_1 is '������ ���� �����������';                 
comment on column v_nbur_d9x_DTL.Q001_1 is '����� �����������';                       
comment on column v_nbur_d9x_DTL.Q029_1 is '��� ����������� �����������';             
comment on column v_nbur_d9x_DTL.K020_2 is '��� �������� �����������';                
comment on column v_nbur_d9x_DTL.K021_2 is '������ ���� �������� �����������';        
comment on column v_nbur_d9x_DTL.Q001_2 is '����� �������� �����������';              
comment on column v_nbur_d9x_DTL.Q029_2 is '��� �������� ����������� �����������';    
comment on column v_nbur_d9x_DTL.K014   is '��� �������� �����������';                
comment on column v_nbur_d9x_DTL.K040   is '����� �������� �����������';             
comment on column v_nbur_d9x_DTL.KU_1   is '����� ��������� �������� �����������';  
comment on column v_nbur_d9x_DTL.K110   is '���� �������� �����������';               
comment on column v_nbur_d9x_DTL.T090_1 is '³������ ����� ����� ��������';         
comment on column v_nbur_d9x_DTL.T090_2 is '³������ �������������� ����� ��������';

comment on column v_nbur_d9x_DTL.DESCRIPTION is '���� (��������)';
comment on column v_nbur_d9x_DTL.KV is '��. ������';
comment on column v_nbur_d9x_DTL.CUST_ID is '��. �볺���';
comment on column v_nbur_d9x_DTL.CUST_CODE is '��� �볺���';
comment on column v_nbur_d9x_DTL.CUST_NAME is '����� �볺���';
comment on column v_nbur_d9x_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_d9x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
