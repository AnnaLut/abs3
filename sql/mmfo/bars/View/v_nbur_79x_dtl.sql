PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_79X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_79X_dtl ***

create or replace view v_nbur_79X_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.KU
     , p.R030
     , p.K030
     , p.Q001
     , p.K020
     , p.K021
     , p.Q007_1
     , p.Q007_2
     , p.Q007_3
     , p.Q007_4
     , p.Q003_1
     , p.Q003_2
     , p.Q003_3
     , p.T070_1
     , p.T070_2
     , p.T070_3
     , p.T070_4
     , p.T090_1
     , p.T090_2
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.BRANCH
  from NBUR_LOG_F79X p
       join NBUR_REF_FILES f on (f.FILE_CODE = '79X')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
   
comment on table V_NBUR_79X_DTL is '��������� �������� ����� 79X';
comment on column V_NBUR_79X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_79X_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_79X_DTL.KU is '��� ������';
comment on column V_NBUR_79X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_79X_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_79X_DTL.EKP    is '��� ���������';
comment on column V_NBUR_79X_DTL.R030   is '��� ������ ��������������� �����';
comment on column V_NBUR_79X_DTL.K030   is '��� ������������ ���������';
comment on column V_NBUR_79X_DTL.Q001   is '����� ������������ �������� ����� ��� �������, ���, �� ������� ������� ����� ���������';
comment on column V_NBUR_79X_DTL.K020   is '��� ���������';
comment on column V_NBUR_79X_DTL.K021   is '��� ������ �����������������/������������� ����/������';
comment on column V_NBUR_79X_DTL.Q007_1 is '���� ��������� ����� ��� �������������� ����';
comment on column V_NBUR_79X_DTL.Q007_2 is '���� ��������� 䳿 ����� ��� �������������� ����';
comment on column V_NBUR_79X_DTL.Q007_3 is '���� ������ ������� � ������ ������� �� ����������� �������� ����� ��� ��������� �� �������';
comment on column V_NBUR_79X_DTL.Q007_4 is '���� ��������� ��������';
comment on column V_NBUR_79X_DTL.Q003_1 is '����� ������ ������� � ������ ������� �� ����������� �������� ����� ��� ��������� �� �������';
comment on column V_NBUR_79X_DTL.Q003_2 is '����� ��������� ��������';
comment on column V_NBUR_79X_DTL.Q003_3 is '������� ���������� ����� ����� ��� ����������� ���������';
comment on column V_NBUR_79X_DTL.T070_1 is '���� ���������� ��������������� ����� ��� ���������� �� ������� ����� �� �/� 3660,3661';
comment on column V_NBUR_79X_DTL.T070_2 is '����, �� ��� �������� ����� �� ���������� ��������� ����� �� ������ ��������������� ����� �� ������� �����';
comment on column V_NBUR_79X_DTL.T070_3 is '���� ��������������� �����, ��� ����������� � ���������� ������������� ������� �����';
comment on column V_NBUR_79X_DTL.T070_4 is '���� ����������� ���������, ������������� ������� 3.10 ����� 3 ������ III ���������� � 368';
comment on column V_NBUR_79X_DTL.T090_1 is '�������, ���� �������� �� ���������� ���� ��������������� �����';
comment on column V_NBUR_79X_DTL.T090_2 is '����� ��������� ������, ��� �������������� �� �������������� ������, ����� � ������';
comment on column V_NBUR_79X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_79X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_79X_DTL.KV is '��. ������';
comment on column V_NBUR_79X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_79X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_79X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_79X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_79X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 