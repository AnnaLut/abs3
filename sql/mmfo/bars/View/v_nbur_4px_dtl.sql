PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_4px_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_4px_dtl ***

create or replace view v_nbur_4px_dtl as
select p.REPORT_DATE
         , p.KF
         , p.KF as NBUC
         , p.VERSION_ID
         , p.EKP || p.R030_1 || p.K020 || p.Q003_3 || p.Q006 || p.Q007_2 as FIELD_CODE
         , p.EKP               
         , p.B040
         , p.R020
         , p.R030_1
         , p.R030_2
         , p.K040
         , p.S050
         , p.S184
         , p.F028
         , p.F045
         , p.F046
         , p.F047
         , p.F048
         , p.F049                                                                                          
         , p.F050
         , p.F052               
         , p.F053
         , p.F054
         , p.F055
         , p.F056
         , p.F057
         , p.F070
         , p.K020
         , p.Q001_1
         , p.Q001_2
         , p.Q003_1
         , p.Q003_2
         , p.Q003_3               
         , p.Q006
         , p.Q007_1
         , p.Q007_2
         , p.Q007_3
         , p.Q010_1
         , p.Q010_2                
         , p.Q012
         , p.Q013
         , p.Q021
         , p.Q022
         , p.T071
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
    from NBUR_LOG_F4PX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#4P' )
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

comment on table V_NBUR_4PX_DTL is '��������� �������� ����� 4PX';
comment on column V_NBUR_4PX_DTL.REPORT_DATE is '����� ����';
comment on column V_NBUR_4PX_DTL.KF is '��� �i�i��� (���)';
comment on column V_NBUR_4PX_DTL.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_4PX_DTL.FIELD_CODE is '�������� ��� ���������';
comment on column V_NBUR_4PX_DTL.EKP is '��� ���������';
comment on column V_NBUR_4PX_DTL.R020 is '���������� �������';
comment on column V_NBUR_4PX_DTL.R030_1 is '������ �������';
comment on column V_NBUR_4PX_DTL.R030_2 is '������ ���������� �� ��������';
comment on column V_NBUR_4PX_DTL.K040 is '�����';
comment on column V_NBUR_4PX_DTL.S050 is '��� ���� ����������';
comment on column V_NBUR_4PX_DTL.S184 is '���������� ����';
comment on column V_NBUR_4PX_DTL.F028 is '��� �������������';
comment on column V_NBUR_4PX_DTL.F045 is '������ �������';
comment on column V_NBUR_4PX_DTL.F046 is '���� ���������� �� ��������';
comment on column V_NBUR_4PX_DTL.F047 is '������������ ��� ������������';
comment on column V_NBUR_4PX_DTL.F048 is '��� ��������� ������ �� ��������';
comment on column V_NBUR_4PX_DTL.F049 is '��� ��������� ���� �������� ��� �� ��������';                                                                                   
comment on column V_NBUR_4PX_DTL.F050 is 'ֳ� ������������ �������';
comment on column V_NBUR_4PX_DTL.F052 is '��� ���������';
comment on column V_NBUR_4PX_DTL.F053 is '��������� ������������ ��������� �������������';
comment on column V_NBUR_4PX_DTL.F054 is '����������� ��������� �������';
comment on column V_NBUR_4PX_DTL.F055 is '��� ������� (���������� ������������)';
comment on column V_NBUR_4PX_DTL.F056 is 'ϳ������ ������� ����';
comment on column V_NBUR_4PX_DTL.F057 is '��� �����������';
comment on column V_NBUR_4PX_DTL.F070 is '��� ���� ������������';
comment on column V_NBUR_4PX_DTL.K020 is '��� ������������';
comment on column V_NBUR_4PX_DTL.Q001_1 is '����� ������������/�볺��� �����';
comment on column V_NBUR_4PX_DTL.Q001_2 is '����� ���������/�������� �� ��� ������������, �������������� ������� � ������� � ������� �� ����';
comment on column V_NBUR_4PX_DTL.Q003_1 is '����� �������� �����';
comment on column V_NBUR_4PX_DTL.Q003_2 is '����� ��������� �������� ������������ ������ ������';
comment on column V_NBUR_4PX_DTL.Q003_3 is '���������� ����� ������ � ����� ������������� �������� ��';        
comment on column V_NBUR_4PX_DTL.Q006 is '�������, �� ������ ��������� ���������� �������� �������� ��� �� ��������';
comment on column V_NBUR_4PX_DTL.Q007_1 is '���� ��������� �������� �����';
comment on column V_NBUR_4PX_DTL.Q007_2 is '���� ��������� �������� ������������ ������ ������';
comment on column V_NBUR_4PX_DTL.Q007_3 is '����� ��������� �������';
comment on column V_NBUR_4PX_DTL.Q010_1 is '����� �� ������, �� �� �������� ������� ������� �� ������������� ����� �������������';
comment on column V_NBUR_4PX_DTL.Q010_2 is '����� �� �����, �� �� �������� ������� ������� �� ������������� ����� �������������';         
comment on column V_NBUR_4PX_DTL.Q012 is '���� ��� ���������� �������� ������ �� ��������';
comment on column V_NBUR_4PX_DTL.Q013 is '����� ���� ��������� ������ �� ��������';
comment on column V_NBUR_4PX_DTL.Q021 is '�������� ���� ������� �� ��������� � ������������';
comment on column V_NBUR_4PX_DTL.Q022 is '�������� ��������� ������ �� �������� ����� �����';
comment on column V_NBUR_4PX_DTL.T071 is '����';
comment on column V_NBUR_4PX_DTL.DESCRIPTION is '���� (��������)';
comment on column V_NBUR_4PX_DTL.ACC_ID is '��. �������';
comment on column V_NBUR_4PX_DTL.ACC_NUM is '����� �������';
comment on column V_NBUR_4PX_DTL.KV is '��. ������';
comment on column V_NBUR_4PX_DTL.MATURITY_DATE is '���� ���������';
comment on column V_NBUR_4PX_DTL.CUST_ID is '��. �볺���';
comment on column V_NBUR_4PX_DTL.CUST_CODE is '��� �볺���';
comment on column V_NBUR_4PX_DTL.CUST_NAME is '����� �볺���';
comment on column V_NBUR_4PX_DTL.ND is '��. ��������';
comment on column V_NBUR_4PX_DTL.AGRM_NUM is '����� ��������';
comment on column V_NBUR_4PX_DTL.BEG_DT is '���� ������� ��������';
comment on column V_NBUR_4PX_DTL.END_DT is '���� ��������� ��������';
comment on column V_NBUR_4PX_DTL.REF is '��. ��������� ���������';
comment on column V_NBUR_4PX_DTL.BRANCH is '��� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_4px_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 