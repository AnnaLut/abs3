PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_2kx_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_2kx_dtl ***

create or replace view v_nbur_2kx_dtl as
select
     p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , substr(p.FIELD_CODE, 1, 14) as FIELD_CODE
     , substr(p.Field_Code, 15) as FIELD_CD
     , case substr(p.Field_Code, 15)
         when 'EKP' then '��� ���������'
         when 'Q003_1' then '������� ���������� ����� ������ � ������� ����'
         when 'Q001_1' then '������������ / ϲ� ��������� �����, ��������� � ������� �� ������ ���� ������'
         when 'Q002' then '̳��������������/���� ����������, ����������� ��������� �����'
         when 'K020_1' then '��� �� ������/���'
         when 'K021_1' then '������ ���� �� ������/���'
         when 'Q003_2' then '����� ������� ����� �� ��������� �������� �� ������ ���� ������'
         when 'Q003_3' then '����� ����� ���������� ������, ����� � ���� ������� � �� ������ ���� ������'
         when 'Q030' then '������� �������� �� ������ ���� ������'
         when 'Q006' then '�������'
         when 'F086' then '���� ������� ��������� �����'
         when 'Q003_4' then '����� ������� ��������� �����'
         when 'R030_1' then '��� ������ ������� ��������� �����'
         when 'Q007_1' then '���� �������� ������� ��������� �����'
         when 'Q007_2' then '���� �������� ������� ��������� �����'
         when 'Q031_1' then '���� ������������ ������� ���� ������� ��������� �����'
         when 'T070_1' then '������� ����� �� ������� ��������� ����� ������ �� ���� �������� � �� ������ ���� ������'
         when 'T070_2' then '������� ����� �� ������� ��������� ����� ������ �� ����� ����'
         when 'F088' then '��� ���� ��������� ��������, ��� ���� ���� ��������'
         when 'Q007_3' then '���� ������ ���������� ��������� ��������'
         when 'Q003_5' then '����� ������� ���������� / ��������'
         when 'Q001_2' then '������������ / �������, ���, �� ������� ���������� / ��������'
         when 'K020_2' then '��� �� ������ / ��� ��� ���������� / ��������'
         when 'K021_2' then '������ ���� �� ������/���'
         when 'Q001_3' then '������������ ����� ���������� / ��������'
         when 'T070_3' then '���� ��������� ��������'
         when 'R030_2' then '��� ������ ��������� �������� ��� ����� ���������� ��������� ��������'
         when 'Q032' then '����������� ������� ��� ����� ���������� ��������� ��������'
         when 'Q031_2' then 'ĳ� ����� ��� ����� ���������� ��������� ��������'
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
                                and (v.FILE_ID = f.ID)
       left join CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
       left join CC_DEAL a on  (p.KF = a.KF)
                               and (p.nd = a.ND )
 where p.REPORT_CODE = '2KX'
       and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
 order by
       FIELD_CODE;
comment on table V_NBUR_2KX_DTL is '��������� �������� ����� 2KX';
comment on column V_NBUR_2KX_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_2KX_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_2KX_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_2KX_DTL.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_2KX_DTL.FIELD_CODE is '��� ���������';
comment on column V_NBUR_2KX_DTL.FIELD_CD is '��� ��������� � ����';
comment on column V_NBUR_2KX_DTL.FIELD_NAME is '����� ���������';
comment on column V_NBUR_2KX_DTL.FIELD_VALUE is '�������� ���������';
comment on column V_NBUR_2KX_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_2KX_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_2KX_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_2KX_DTL.KV is '��. ������';
comment on column V_NBUR_2KX_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_2KX_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_2KX_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_2KX_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_2KX_DTL.ND is '��. ��������';
comment on column V_NBUR_2KX_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_2KX_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_2KX_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_2KX_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_2KX_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_2kx_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 