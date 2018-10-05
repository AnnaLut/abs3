PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_e9x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_e9x_dtl ***

create or replace view v_nbur_e9x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.D060_1
         , p.K020
         , p.K021
         , p.F001
         , p.F098
         , p.R030
         , p.K040_1
         , p.KU_1
         , p.K040_2
         , p.KU_2
         , p.D060_2
         , p.Q001
         , p.T071
         , p.T080
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.CUST_ID
         , c.OKPO as CUST_CODE
         , c.NMK as CUST_NAME
         , p.REF
         , p.BRANCH
    from NBUR_LOG_FE9X p
         join NBUR_REF_FILES f on (f.FILE_CODE = 'E9X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join CUSTOMER c on (p.CUST_ID    = c.RNK)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table v_nbur_e9x_DTL is '��������� �������� ����� E9X';
comment on column v_nbur_e9x_DTL.REPORT_DATE is '����� ����';
comment on column v_nbur_e9x_DTL.KF is '��� �i�i��� (���)';
comment on column v_nbur_e9x_DTL.VERSION_ID is '��. ���� �����';
comment on column v_nbur_e9x_DTL.EKP is '��� ���������';
comment on column v_nbur_e9x_DTL.D060_1 is '��� ������� �������� �����';
comment on column v_nbur_e9x_DTL.K020 is '��� ����������/����������';
comment on column v_nbur_e9x_DTL.K021 is '��� ������ ����������������� ����';
comment on column v_nbur_e9x_DTL.F001 is '��� �������� �������� �����';
comment on column v_nbur_e9x_DTL.F098 is '��� ���� ��������';
comment on column v_nbur_e9x_DTL.R030 is '��� ������';
comment on column v_nbur_e9x_DTL.K040_1 is '��� ����� ��������-����������';
comment on column v_nbur_e9x_DTL.KU_1 is '������� ����������';
comment on column v_nbur_e9x_DTL.K040_2 is '��� ����� ��������-����������';
comment on column v_nbur_e9x_DTL.KU_2 is '������� ����������';
comment on column v_nbur_e9x_DTL.T071 is '����';
comment on column v_nbur_e9x_DTL.T080 is 'ʳ������';
comment on column v_nbur_e9x_DTL.D060_2 is '��� ��������� ������� �������� �����';
comment on column v_nbur_e9x_DTL.Q001 is '������������ ����� �������������-�����������';
comment on column v_nbur_e9x_DTL.DESCRIPTION is '���� (��������)';
comment on column v_nbur_e9x_DTL.ACC_ID is '��. �������';
comment on column v_nbur_e9x_DTL.ACC_NUM is '����� �������';
comment on column v_nbur_e9x_DTL.KV is '��. ������';
comment on column v_nbur_e9x_DTL.CUST_ID is '��. �볺���';
comment on column v_nbur_e9x_DTL.CUST_CODE is '��� �볺���';
comment on column v_nbur_e9x_DTL.CUST_NAME is '����� �볺���';
comment on column v_nbur_e9x_DTL.REF is '��. ��������� ���������';
comment on column v_nbur_e9x_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_e9x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
