PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_07X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_07X_dtl ***

create or replace view v_nbur_07X_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , null as FIELD_CODE
	     , p.EKP
	     , p.KU
	     , p.T020
	     , p.R020
	     , p.R011
	     , p.K072
	     , p.R030
	     , p.S183
	     , p.S130
	     , p.K040
	     , p.S240
	     , p.T100
	     , p.Q130 
         , p.Q003
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
    from NBUR_LOG_F07X p
         join NBUR_REF_FILES f on (f.FILE_CODE = '07X' )
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
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table V_NBUR_07X_DTL is '��������� �������� ����� 07X';
comment on column V_NBUR_07X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_07X_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_07X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_07X_DTL.FIELD_CODE is '�������� ��� ���������';
comment on column V_NBUR_07X_DTL.EKP is '��� ���������';
comment on column V_NBUR_07X_DTL.KU is '��� �������';
comment on column V_NBUR_07X_DTL.T020 is '������� �������';
comment on column V_NBUR_07X_DTL.R020 is '����� �������';
comment on column V_NBUR_07X_DTL.R011 is '��� �� ���������� �������� ����������� ������� R011';
comment on column V_NBUR_07X_DTL.K072 is '��� ������� ��������';
comment on column V_NBUR_07X_DTL.R030 is '��� ������';
comment on column V_NBUR_07X_DTL.S183 is '������������ ��� ���������� ������ ���������';
comment on column V_NBUR_07X_DTL.S130 is '��� ���� ������� ������';
comment on column V_NBUR_07X_DTL.K040 is '��� �����';
comment on column V_NBUR_07X_DTL.S240 is '��� ������ �� ���������';
comment on column V_NBUR_07X_DTL.Q003 is '���������� ����� ������� ������';
comment on column V_NBUR_07X_DTL.Q130 is '��� ������� ������';
comment on column V_NBUR_07X_DTL.T100 is '���� / ʳ������';
comment on column V_NBUR_07X_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_07X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_07X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_07X_DTL.KV is '��. ������';
comment on column V_NBUR_07X_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_07X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_07X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_07X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_07X_DTL.ND is '��. ��������';
comment on column V_NBUR_07X_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_07X_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_07X_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_07X_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_07X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_07X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 