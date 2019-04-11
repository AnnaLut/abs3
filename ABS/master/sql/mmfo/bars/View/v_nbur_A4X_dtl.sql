create or replace view v_nbur_A4X_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.KU
         , p.T020
         , p.R020
         , p.R030
         , p.K040
         , p.T070
         , p.T071
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.CUST_ID
         , p.CUST_CODE
         , p.CUST_NAME
         , p.BRANCH
    from NBUR_LOG_FA4X p
         join NBUR_REF_FILES f on (f.FILE_CODE = 'A4X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
   order by EKP,R020,R030;

comment on table V_NBUR_A4X_DTL			is '��������� �������� ����� A4X';
comment on column V_NBUR_A4X_DTL.REPORT_DATE	is '����� ����';
comment on column V_NBUR_A4X_DTL.KF		is '��� �i�i� (���)';
comment on column V_NBUR_A4X_DTL.NBUC		is '��� ���';
comment on column V_NBUR_A4X_DTL.VERSION_ID	is '��. ���� �����';
comment on column V_NBUR_A4X_DTL.EKP		is '��� ���������';
comment on column V_NBUR_A4X_DTL.KU		is '��� �������';
comment on column V_NBUR_A4X_DTL.T020		is '������� �������';
comment on column V_NBUR_A4X_DTL.R020		is '����� �������';
comment on column V_NBUR_A4X_DTL.R030		is '��� ������';
comment on column V_NBUR_A4X_DTL.K040		is '��� �����';
comment on column V_NBUR_A4X_DTL.T070		is '���� � ���������� ���������';
comment on column V_NBUR_A4X_DTL.T071		is '���� � ���������� ������';
comment on column V_NBUR_A4X_DTL.DESCRIPTION	is '���� (��������)';
comment on column V_NBUR_A4X_DTL.ACC_ID		is '��. �������';
comment on column V_NBUR_A4X_DTL.ACC_NUM	is '����� �������';
comment on column V_NBUR_A4X_DTL.KV		is '��. ������';
comment on column V_NBUR_A4X_DTL.CUST_ID	is '��. �볺���';
comment on column V_NBUR_A4X_DTL.CUST_CODE	is '��� �볺���';
comment on column V_NBUR_A4X_DTL.CUST_NAME	is '����� �볺���';
comment on column V_NBUR_A4X_DTL.BRANCH		is '��� ��������';
