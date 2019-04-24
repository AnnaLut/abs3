
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_2gx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_2GX_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP||p.F091||p.D100||p.Q024  as field_code
         , p.EKP   
         , p.F091
         , p.D100
         , p.Q024
         , p.T070
         , p.KV
         , p.CUST_ID
         , p.CUST_NAME
         , p.ACC_ID
         , p.ACC_NUM
         , p.REF
         , p.DESCRIPTION
    from NBUR_LOG_F2GX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '2GX' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_2GX_DTL is '��������� �������� ����� 2GX';
comment on column v_nbur_2GX_DTL.REPORT_DATE is '����� ����';
comment on column v_nbur_2GX_DTL.KF is '��� �i�i��� (���)';
comment on column v_nbur_2GX_DTL.NBUC is '��� ������ �����';
comment on column v_nbur_2GX_DTL.VERSION_ID is '��. ���� �����';
comment on column v_nbur_2GX_DTL.EKP     is '��� ���������';
comment on column v_nbur_2GX_DTL.F091    is '��� ��������';
comment on column v_nbur_2GX_DTL.D100    is '����� ������� ��������';
comment on column v_nbur_2GX_DTL.Q024    is '��� �����������';
comment on column v_nbur_2GX_DTL.T070    is '���� � ���.�����';

comment on column v_nbur_2GX_DTL.KV         is '��. ������';
comment on column v_nbur_2GX_DTL.CUST_ID    is '��. �볺���';
comment on column v_nbur_2GX_DTL.CUST_NAME  is '����� �볺���';
COMMENT ON COLUMN v_nbur_2GX_DTL.REF        IS '��. ��������� ���������';
COMMENT ON COLUMN v_nbur_2GX_DTL.ACC_ID     IS '��. �������';
COMMENT ON COLUMN v_nbur_2GX_DTL.ACC_NUM    IS '����� �������';
COMMENT ON COLUMN v_nbur_2GX_DTL.DESCRIPTION   IS '���� ��������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_2gx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
