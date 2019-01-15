PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_8BX_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_8BX_dtl ***

create or replace view v_nbur_8BX_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.F103
     , p.Q003_4
     , p.T070
     , p.DESCRIPTION
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.ND         	 
     , p.AGRM_NUM	 
     , p.BEG_DT
     , p.END_DT     	 
     , p.REF
     , p.BRANCH
  from NBUR_LOG_F8BX p
       join NBUR_REF_FILES f on (f.FILE_CODE = '8BX')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
 order by F103, Q003_4, acc_num, kv;
   
comment on table V_NBUR_8BX_DTL is '��������� �������� ����� 8BX';
comment on column V_NBUR_8BX_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_8BX_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_8BX_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_8BX_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_8BX_DTL.EKP is '��� ���������';
comment on column V_NBUR_8BX_DTL.F103   is '��� ����� ��� ���������� ���������� ���������';
comment on column V_NBUR_8BX_DTL.Q003_4 is '������� ���������� ����� �����������';
comment on column V_NBUR_8BX_DTL.T070      is '����';
comment on column V_NBUR_8BX_DTL.DESCRIPTION 	is '���� (��������)';          
comment on column V_NBUR_8BX_DTL.ACC_ID		is '��. �������';              
comment on column V_NBUR_8BX_DTL.ACC_NUM 	is '����� �������';            
comment on column V_NBUR_8BX_DTL.KV		is '��. ������';               
comment on column V_NBUR_8BX_DTL.CUST_ID 	is '��. �볺���';              
comment on column V_NBUR_8BX_DTL.CUST_CODE      is '��� �볺���';              
comment on column V_NBUR_8BX_DTL.CUST_NAME	is '����� �볺���';            
comment on column V_NBUR_8BX_DTL.ND		is '��. ��������';             
comment on column V_NBUR_8BX_DTL.AGRM_NUM	is '����� ��������';           
comment on column V_NBUR_8BX_DTL.BEG_DT		is '���� ������� ��������';    
comment on column V_NBUR_8BX_DTL.END_DT		is '���� ��������� ��������'; 
comment on column V_NBUR_8BX_DTL.REF		is '��. ��������� ���������';
comment on column V_NBUR_8BX_DTL.BRANCH		is '��� ��������';           

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_8BX_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 