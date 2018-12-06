
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3Bx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_3Bx_dtl
 as
select	   p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP 
         , p.F059
         , p.F060
         , p.F061
         , p.K111
         , p.K031
         , p.F063
         , p.F064
         , p.S190
         , p.F073
         , p.F003
         , p.Q001
         , p.K020
         , p.Q026
         , p.T100
         , p.DESCRIPTION
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.BRANCH
    from NBUR_LOG_F3BX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '3BX' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_3Bx_DTL 		is '��������� �������� ����� 3BX';
comment on column v_nbur_3Bx_DTL.REPORT_DATE 	is '����� ����';
comment on column v_nbur_3Bx_DTL.KF		is '��� �i�i��� (���)';
comment on column v_nbur_3Bx_DTL.VERSION_ID	is '��. ���� �����';
comment on column v_nbur_3Bx_DTL.EKP 		is '��� ���������';
comment on column v_nbur_3Bx_DTL.T100 is '����';                                                                                    
comment on column v_nbur_3Bx_DTL.F059 is '��� ������ ��������';                                                                    
comment on column v_nbur_3Bx_DTL.F060 is '��� ���� ������';                                                                        
comment on column v_nbur_3Bx_DTL.F061 is '��� ������ ��������';                                                                     
comment on column v_nbur_3Bx_DTL.K111 is '��� ������ ���� ��������� �������� (����������)';                                 
comment on column v_nbur_3Bx_DTL.K031 is '��� ������ �������������� ���������';                                                   
comment on column v_nbur_3Bx_DTL.F063 is '��� ���� ��������� ��������� �������';                                                 
comment on column v_nbur_3Bx_DTL.F064 is '��� ��������� �� ����� ��������� ��� �� ������� ���������';                           
comment on column v_nbur_3Bx_DTL.S190 is '��� ������ ������������ ��������� �����';                                                 
comment on column v_nbur_3Bx_DTL.F073 is '��� ��������� �� ��������, ������� ���� ����� ��� ��������� �������������� �������';  
comment on column v_nbur_3Bx_DTL.F003 is '��� ����� �������������';                                                                
comment on column v_nbur_3Bx_DTL.Q001 is '�������� ��������� ������������ ��������';                                                
comment on column v_nbur_3Bx_DTL.K020 is '������ �������� �����';                                                                  
comment on column v_nbur_3Bx_DTL.Q026 is '��������� �������� �� ����� ��������� �����������';                                    
comment on column v_nbur_3Bx_DTL.DESCRIPTION	is '���� (��������)';
comment on column v_nbur_3Bx_DTL.CUST_ID	is '��. �볺���';
comment on column v_nbur_3Bx_DTL.CUST_CODE	is '��� �볺���';
comment on column v_nbur_3Bx_DTL.CUST_NAME	is '����� �볺���';
comment on column v_nbur_3Bx_DTL.BRANCH		is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3Bx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
