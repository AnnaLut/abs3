PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_26X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_26X_dtl ***

create or replace view v_nbur_26X_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.KU
     , p.T020
     , p.R020
     , p.R011
     , p.R013
     , p.R030
     , p.K040
     , p.Q001
     , p.K020
     , p.K021
     , p.K180
     , p.K190
     , p.S181
     , p.S245
     , p.S580
     , p.F033
     , p.T070
     , p.T071
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.BRANCH
  from NBUR_LOG_F26X p
       join NBUR_REF_FILES f on (f.FILE_CODE = '26X')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
 order by ekp, k020, r020, t020, acc_num, kv;
   
comment on table V_NBUR_26X_DTL is '��������� �������� ����� 26X';
comment on column V_NBUR_26X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_26X_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_26X_DTL.KU is '��� ������';
comment on column V_NBUR_26X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_26X_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_26X_DTL.EKP    is '��� ���������';
comment on column V_NBUR_26X_DTL.T020   is '��� �������� ����� �� ��������';
comment on column V_NBUR_26X_DTL.R020   is '����� ������./����������. �������';
comment on column V_NBUR_26X_DTL.R011   is '��� �� ���������� �������� ����������� ������� R011';
comment on column V_NBUR_26X_DTL.R013   is '��� �� ���������� �������� ����������� ������� R013';
comment on column V_NBUR_26X_DTL.R030   is '��� ������';
comment on column V_NBUR_26X_DTL.K040   is '��� ����� �������� �����';
comment on column V_NBUR_26X_DTL.Q001   is '����� �����-���������/�����-�����������';
comment on column V_NBUR_26X_DTL.K020   is '��� �������� �����';
comment on column V_NBUR_26X_DTL.K021   is '��� ������ �����������������/������������� ����/������';
comment on column V_NBUR_26X_DTL.K180   is '��� ��������� ����� �� �������������� �����';
comment on column V_NBUR_26X_DTL.K190   is '��� ���� ��������';
comment on column V_NBUR_26X_DTL.S181   is '��� ����������� ������ ���������';
comment on column V_NBUR_26X_DTL.S245   is '��� ������������� �������� ������ ���������';
comment on column V_NBUR_26X_DTL.S580   is '��� �������� ������ �� ������� �����';
comment on column V_NBUR_26X_DTL.F033   is '��� ������ ���������� �����';
comment on column V_NBUR_26X_DTL.T070   is '���� � ����������� ����� (���.���.)';
comment on column V_NBUR_26X_DTL.T071   is '���� � �������� �����';
comment on column V_NBUR_26X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_26X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_26X_DTL.KV is '��. ������';
comment on column V_NBUR_26X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_26X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_26X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_26X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_26X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 