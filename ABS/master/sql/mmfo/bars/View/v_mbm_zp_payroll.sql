PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/view/v_mbm_zp_payroll.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view bars.v_mbm_zp_payroll as
select p.id,
       p.payroll_num,
       p.zp_deal_id,
       p.crt_date,
       bars.zp.get_nls_6510(d.fs) acc_6510,
       d.acc_2909,
       p.nazn,
       p.s,
       p.cms,
       p.sos,
       p.sos_name,
       p.corp2_id,
       p.nls_2909
from bars.v_zp_payroll p
     inner join bars.zp_deals d on d.id = p.zp_id;

PROMPT *** Create comments on bars.v_mbm_zp_payroll ***

comment on table V_MBM_ZP_PAYROLL              is '�� ������� ��� ��������';
comment on column V_MBM_ZP_PAYROLL.PAYROLL_NUM is '����� ���';
comment on column V_MBM_ZP_PAYROLL.ZP_DEAL_ID  is '����� � ����� �� ������� � ���';
comment on column V_MBM_ZP_PAYROLL.CRT_DATE    is '���� � ���� ��������� ������� � ���';
comment on column V_MBM_ZP_PAYROLL.ACC_6510    is '������� �������� � ������� ��� �������� ����� ��� ������ ������� �� ��� ������ ���� �� �� �������';
comment on column V_MBM_ZP_PAYROLL.ACC_2909    is '������� ����������� - ������� ����������� ����� ��� ������ ������� �� ��� ������ ���� �� �� �������';
comment on column V_MBM_ZP_PAYROLL.NAZN        is '����������� ������� � ����������� ����������� ������� ��� ����� ������� ��� �� ������� (��������� �����)';
comment on column V_MBM_ZP_PAYROLL.S           is '���� ������� � ���� ������ �� �� �������';
comment on column V_MBM_ZP_PAYROLL.CMS         is '���� ���� � ���� ���� �� ������ �������';
comment on column V_MBM_ZP_PAYROLL.SOS         is '������ � �������� ������ �� �������';
comment on column V_MBM_ZP_PAYROLL.corp2_id    is 'id corp2';
comment on column V_MBM_ZP_PAYROLL.nls_2909    is '����� ������� �����������';

PROMPT *** Create  grants  v_mbm_zp_payroll ***

grant select on bars.v_mbm_zp_payroll to upld;
grant select on bars.v_mbm_zp_payroll to barsreader_role;
grant select on bars.v_mbm_zp_payroll to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_mbm_zp_payroll.sql =========*** End *** =
PROMPT ===================================================================================== 
