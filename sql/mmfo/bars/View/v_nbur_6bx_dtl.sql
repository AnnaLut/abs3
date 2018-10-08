
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6bx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_6bx_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.F083
         , p.F082
         , p.S083
         , p.S080
         , p.S031
         , p.K030
         , p.R030
         , p.T070
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.REF
         , p.BRANCH
    from NBUR_LOG_F6BX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '6BX' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_6bx_DTL is '��������� �������� ����� 6BX';
comment on column v_nbur_6bx_DTL.REPORT_DATE is '����� ����';
comment on column v_nbur_6bx_DTL.KF is '��� �i�i��� (���)';
comment on column v_nbur_6bx_DTL.VERSION_ID is '��. ���� �����';
comment on column v_nbur_6bx_DTL.EKP is '��� ���������';
comment on column v_nbur_6bx_DTL.T070 is '����';
comment on column v_nbur_6bx_DTL.F083 is '��� �������� ����������� �������� �������, ���� �������� ����� ��������, �������� ��������� �������';
comment on column v_nbur_6bx_DTL.F082 is '��� ���� ��������';
comment on column v_nbur_6bx_DTL.S083 is '��� ���� ������ ���������� ������';
comment on column v_nbur_6bx_DTL.S080 is '��� ����� ��������/�����������';
comment on column v_nbur_6bx_DTL.S031 is '��� ���� ������������ �������';
comment on column v_nbur_6bx_DTL.K030 is '��� ������������';
comment on column v_nbur_6bx_DTL.R030 is '��� ������';
comment on column v_nbur_6bx_DTL.DESCRIPTION is '���� (��������)';
comment on column v_nbur_6bx_DTL.ACC_ID is '��. �������';
comment on column v_nbur_6bx_DTL.ACC_NUM is '����� �������';
comment on column v_nbur_6bx_DTL.KV is '��. ������';
comment on column v_nbur_6bx_DTL.CUST_ID is '��. �볺���';
comment on column v_nbur_6bx_DTL.CUST_CODE is '��� �볺���';
comment on column v_nbur_6bx_DTL.CUST_NAME is '����� �볺���';
comment on column v_nbur_6bx_DTL.REF is '��. ��������� ���������';
comment on column v_nbur_6bx_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6bx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
