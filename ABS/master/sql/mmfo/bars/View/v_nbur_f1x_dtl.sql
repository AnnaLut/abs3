PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_f1x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_f1x_dtl ***

create or replace view v_nbur_f1x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.VERSION_ID
         , p.Field_Code --��� ��� ������ � ������-��������������
         , SUBSTR(p.FIELD_CODE, 1, 6) as EKP --��� ���������
         , p.NBUC
         , substr(p.field_code, 7, 1)  as K030
         , substr(p.field_code, 8, 3)  as R030
         , substr(p.field_code, 11, 3) as K040
         , p.FIELD_VALUE as T071
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.MATURITY_DATE
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.nd
         , p.REF
         , p.BRANCH
    from NBUR_DETAIL_PROTOCOLS_ARCH p
         join NBUR_REF_FILES f on (f.FILE_CODE = p.REPORT_CODE )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
   where p.REPORT_CODE = 'F1X' 
         and v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table v_nbur_f1x_DTL is '��������� �������� ����� F1X';
comment on column v_nbur_f1x_DTL.REPORT_DATE is '����� ����';
comment on column v_nbur_f1x_DTL.KF is '��� �i�i��� (���)';
comment on column v_nbur_f1x_DTL.VERSION_ID is '��. ���� �����';
comment on column v_nbur_f1x_DTL.FIELD_CODE is '�������� ��� ���������';
comment on column v_nbur_f1x_DTL.EKP is '��� ���������';
comment on column v_nbur_f1x_DTL.NBUC is '��� ������ ��������� ������ �������� �����';
comment on column v_nbur_f1x_DTL.K030 is '���������i���';
comment on column v_nbur_f1x_DTL.R030 is '��� ������';
comment on column v_nbur_f1x_DTL.K040 is '��� �����';
comment on column v_nbur_f1x_DTL.T071 is '���� � �����';
comment on column v_nbur_f1x_DTL.DESCRIPTION is '���� (��������)';
comment on column v_nbur_f1x_DTL.ACC_ID is '��. �������';
comment on column v_nbur_f1x_DTL.ACC_NUM is '����� �������';
comment on column v_nbur_f1x_DTL.KV is '��. ������';
comment on column v_nbur_f1x_DTL.MATURITY_DATE is '���� ���������';
comment on column v_nbur_f1x_DTL.CUST_ID is '��. �볺���';
comment on column v_nbur_f1x_DTL.CUST_CODE is '��� �볺���';
comment on column v_nbur_f1x_DTL.CUST_NAME is '����� �볺���';
comment on column v_nbur_f1x_DTL.ND is '��. ��������';
comment on column v_nbur_f1x_DTL.REF is '��. ��������� ���������';
comment on column v_nbur_f1x_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_f1x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 