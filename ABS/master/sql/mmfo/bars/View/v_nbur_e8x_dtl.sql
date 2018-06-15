PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_e8x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_e8x_dtl ***

create or replace view v_nbur_e8x_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , substr(p.FIELD_CODE, 1, 10) as FIELD_CODE
     , substr(p.FIELD_CODE, 11) as FIELD_CD
     , case substr(p.FIELD_CODE, 11)
         when 'EKP' then '��� ���������'
         when 'Q003_12' then '������� ���������� ����� ������ � ������� ����'
         when 'Q001' then '������������ ���������'
         when 'K020' then '��� ���������'
         when 'K021' then '��� ������ ���� ���������'
         when 'Q029' then '��� ��������� - ����������� ��� ���� � ����� �������� ��� ���������� ������������ ������'
         when 'Q020' then '��� ���� ���''����� � ������ �����'
         when 'K040' then '��� ����� ���������'
         when 'KU_1' then '��� ������, � ����� ������������� ��������'
         when 'K014' then '��� ���� �볺��� �����'
         when 'K110' then '��� ���� ��������� �������� ���������'
         when 'K074' then '��� �������������� ������� ��������'
         when 'Q003_1' then '������� ���������� ����� �������� � ������� ����'
         when 'Q003_2' then '����� ��������'
         when 'Q007_1' then '���� �������� ��� ���� ������� ���� �����'
         when 'Q007_2' then '���� �������� ��������� �������������'
         when 'R030' then '��� ������'
         when 'T090' then '����� ��������� ������'
         when 'R020' then '����� ����������� �������'
         when 'T070_1' then '������� ���� �����'
         when 'T070_2' then '������������� �������/�����'
         when 'T070_3' then '��������� �������'
         when 'T070_4' then '���������� (��������/������)'
       else
         '�������� ��������'
       end as FIELD_NAME
     , p.FIELD_VALUE
     , p.DESCRIPTION
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.MATURITY_DATE
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.ND
     , a.CC_ID AGRM_NUM
     , a.SDATE BEG_DT
     , a.WDATE END_DT
     , p.REF
     , p.BRANCH
  from NBUR_DETAIL_PROTOCOLS_ARCH p
       join NBUR_REF_FILES f on (f.FILE_CODE = p.REPORT_CODE)
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
       LEFT JOIN CC_DEAL a  on (p.KF = a.KF)
                               and (p.nd = a.ND )
 where p.REPORT_CODE = 'E8X'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
comment on table V_NBUR_E8X_DTL is '��������� �������� ����� E8X';
comment on column V_NBUR_E8X_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_E8X_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_E8X_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_E8X_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_E8X_DTL.FIELD_CODE is '��� ���������';
comment on column V_NBUR_E8X_DTL.FIELD_CD is '��� ��������� � ����';
comment on column V_NBUR_E8X_DTL.FIELD_NAME is '������������ ���������';
comment on column V_NBUR_E8X_DTL.FIELD_VALUE is '�������� ���������';
comment on column V_NBUR_E8X_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_E8X_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_E8X_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_E8X_DTL.KV is '��. ������';
comment on column V_NBUR_E8X_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_E8X_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_E8X_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_E8X_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_E8X_DTL.ND is '��. ��������';
comment on column V_NBUR_E8X_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_E8X_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_E8X_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_E8X_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_E8X_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_e8x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 