PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_39x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_39x_dtl ***

create or replace view v_nbur_39x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.VERSION_ID
         , substr(p.FIELD_CODE, 2) as FIELD_CODE --��� ��� ������ � ������-��������������
         , SUBSTR(p.FIELD_CODE, 2, 6) as EKP --��� ���������
         , p.NBUC
         , SUBSTR(p.FIELD_CODE, 8, 3) as R030 --��� ������
         , p.FIELD_VALUE as T071 --���� � i������i� �����i
         , p1.FIELD_VALUE as T075 --���������������� ����
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.MATURITY_DATE
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.ND
         , a.AGRM_NUM
         , a.BEG_DT
         , a.END_DT
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
         left  join V_NBUR_DM_AGREEMENTS a on (p.REPORT_DATE = a.REPORT_DATE)
                                              and (p.KF = a.KF)
                                              and (p.nd = a.AGRM_ID)
         --����������� ������ ������ �� ������
         left  join NBUR_DETAIL_PROTOCOLS_ARCH p1 on (p.report_date = p1.report_date)
                                                     and (p.kf = p1.kf)
                                                     and (p.version_id = p1.version_id)
                                                     and (p.report_code = p1.report_code)
                                                     and (p.nbuc = p1.nbuc)
                                                     and (p.ref = p1.ref)
                                                     and (p1.field_code like '4%')
   where p.REPORT_CODE = '39X' --����� ���������� �� ����� ������
         and p.field_code like '1%' --�������� ��� ������ ������ �� ������
         and v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
;
comment on table V_NBUR_39X_DTL is '��������� �������� ����� #39';
comment on column V_NBUR_39X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_39X_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_39X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_39X_DTL.FIELD_CODE is '��� ���������';
comment on column V_NBUR_39X_DTL.EKP is 'A39001 - ������, A39002 - ������';
comment on column V_NBUR_39X_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_39X_DTL.R030 is '��� ������';
comment on column V_NBUR_39X_DTL.T071 is '���� � i������i� �����i';
comment on column V_NBUR_39X_DTL.T075 is '���������������� ����';
comment on column V_NBUR_39X_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_39X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_39X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_39X_DTL.KV is '��. ������';
comment on column V_NBUR_39X_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_39X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_39X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_39X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_39X_DTL.ND is '��. ��������';
comment on column V_NBUR_39X_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_39X_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_39X_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_39X_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_39X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_39x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 