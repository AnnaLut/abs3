PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/View/v_nbur_3kx_dtl.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

create or replace force view v_nbur_3kx_dtl 
(  REPORT_DATE
       , KF
       , VERSION_ID
       , NBUC
         , FIELD_CODE
       , EKP
       , Q003_1
       , F091
       , R030
       , T071
       , K020
       , K021
       , K030
       , Q001
       , Q024  
       , D100
       , S180
       , F089
       , F092
       , Q003_2
       , Q007_1
       , Q006
       , DESCRIPTION, ACC_ID, ACC_NUM, CUST_ID, REF )
as
        select report_date, kf, version_id, kf      as NBUC 
                , substr(trim(ekp_2),1,3)   as FIELD_CODE
                , 'A3K001'   as   EKP
                , ekp_2                as Q003_1
                , F091                 as F091
                , R030                 as R030
                , T071                 as T071
                , K020                 as K020
                , K021                 as K021
                , K030                 as K030
                , Q001                 as Q001
                , Q024                 as Q024
                , D100                 as D100
                , S180                 as S180
                , F089                 as F089
                , F092                 as F092
                , Q003                 as Q003_2
                , Q007                 as Q007_1
                , Q006                 as Q006
                , description, acc_id, acc_num, cust_id, ref
          from ( select *
              from ( select substr(p.field_code,5,3) ekp_2,
                            substr(p.field_code,1,4) ekp_1, p.field_value znap,
                            p.kf, p.report_date, p.version_id,
                            p.description, p.acc_id, p.acc_num, p.cust_id, p.ref
                     from nbur_detail_protocols_arch p
                      join NBUR_REF_FILES f
                        on ( f.FILE_CODE = p.REPORT_CODE )
                      join NBUR_LST_FILES v
                        on ( v.REPORT_DATE = p.REPORT_DATE and
                             v.KF          = p.KF          and
                             v.VERSION_ID  = p.VERSION_ID  and
                             v.FILE_ID     = f.ID )           
                    where p.report_code = '#3K'
                      and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
                   )
                    pivot
                   ( max(trim(znap))
                     for ekp_1 in ( 'F091' as F091, 'R030' as R030, 'T071' as T071,
                                    'K020' as K020, 'K021' as K021, 'K030' as K030,
                                    'Q001' as Q001, 'Q024' as Q024, 'D100' as D100,
                                    'S180' as S180, 'F089' as F089, 'F092' as F092,
                                    'Q003' as Q003, 'Q007' as Q007, 'Q006' as Q006 )
                   ) );

comment on table  v_nbur_3kx_dtl is '��������� �������� ����� 3KX';
comment on column v_nbur_3kx_dtl.REPORT_DATE is '��i��� ����';
comment on column v_nbur_3kx_dtl.KF is '�i�i�';
comment on column v_nbur_3kx_dtl.VERSION_ID is '����� ���� �����';
comment on column v_nbur_3kx_dtl.NBUC is '��� ������ �����';
comment on column v_nbur_3kx_dtl.FIELD_CODE is '��� ���������';
comment on column v_nbur_3kx_dtl.EKP is 'XML ��� ���������';
comment on column v_nbur_3kx_dtl.Q003_1 is '������� ����� �����';
comment on column v_nbur_3kx_dtl.F091 is '��� ��������';
comment on column v_nbur_3kx_dtl.R030 is '��� ������';
comment on column v_nbur_3kx_dtl.T071 is '���� �����/�������';
comment on column v_nbur_3kx_dtl.K020 is '��� ����������/����������';
comment on column v_nbur_3kx_dtl.K021 is '��� ������ ����������������� ����';
comment on column v_nbur_3kx_dtl.K030 is '��� ������������';
comment on column v_nbur_3kx_dtl.Q001 is '����� �������/��������';
comment on column v_nbur_3kx_dtl.Q024 is '��� �����������';
comment on column v_nbur_3kx_dtl.D100 is '��� ���� ������� ��������';
comment on column v_nbur_3kx_dtl.S180 is '����� ������� ��������';
comment on column v_nbur_3kx_dtl.F089 is '������ �����������';
comment on column v_nbur_3kx_dtl.F092 is 'ϳ������ ��� �����/ ���� �������';
comment on column v_nbur_3kx_dtl.Q003_2 is '����� ���������';
comment on column v_nbur_3kx_dtl.Q007_1 is '���� ���������';
comment on column v_nbur_3kx_dtl.Q006 is '³������ ��� ��������';
comment on column v_nbur_3kx_dtl.DESCRIPTION is '���� (��������)';
comment on column v_nbur_3kx_dtl.ACC_ID is '��. �������';
comment on column v_nbur_3kx_dtl.ACC_NUM is '����� �������';
comment on column v_nbur_3kx_dtl.CUST_ID is '��. �볺���';
comment on column v_nbur_3kx_dtl.REF is '��. ��������� ���������';

GRANT SELECT ON BARS.V_NBUR_3KX TO BARSREADER_ROLE;
GRANT SELECT ON BARS.V_NBUR_3KX TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_NBUR_3KX TO UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/View/v_nbur_3kx_dtl.sql ======= *** End *** ===
PROMPT ===================================================================================== 

