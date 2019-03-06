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
       p.nls_2909,
       d.id as ProjectId
from bars.v_zp_payroll p
     inner join bars.zp_deals d on d.id = p.zp_id
     left join accounts a29 on a29.acc = d.acc_2909;

PROMPT *** Create comments on bars.v_mbm_zp_payroll ***

comment on table V_MBM_ZP_PAYROLL              is 'ЗП відомості для корплайт';
comment on column V_MBM_ZP_PAYROLL.PAYROLL_NUM is 'номер ЗКП';
comment on column V_MBM_ZP_PAYROLL.ZP_DEAL_ID  is 'Номер – номер ЗП відомості в АБС';
comment on column V_MBM_ZP_PAYROLL.CRT_DATE    is 'дата – дата створення відомості в АБС';
comment on column V_MBM_ZP_PAYROLL.ACC_6510    is 'рахунок списання – рахунок для списання коштів для оплати відомості та для оплати комісії по ЗП відомості';
comment on column V_MBM_ZP_PAYROLL.ACC_2909    is 'рахунок зарахування - рахунок зарахування коштів для оплати відомості та для оплати комісії по ЗП відомості';
comment on column V_MBM_ZP_PAYROLL.NAZN        is 'призначення платежу – відображення призначення платежу при оплаті відомості для ЗП відомості (загальний платіж)';
comment on column V_MBM_ZP_PAYROLL.S           is 'сума відомості – сума записів по ЗП відомості';
comment on column V_MBM_ZP_PAYROLL.CMS         is 'сума комісії – сума комісії за оплату відомості';
comment on column V_MBM_ZP_PAYROLL.SOS         is 'статус – поточний статус ЗП відомості';
comment on column V_MBM_ZP_PAYROLL.corp2_id    is 'id corp2';
comment on column V_MBM_ZP_PAYROLL.nls_2909    is 'Номер рахунка зарахування';
comment on column V_MBM_ZP_PAYROLL.ProjectId   is 'id договору';

PROMPT *** Create  grants  v_mbm_zp_payroll ***

grant select on bars.v_mbm_zp_payroll to upld;
grant select on bars.v_mbm_zp_payroll to barsreader_role;
grant select on bars.v_mbm_zp_payroll to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_mbm_zp_payroll.sql =========*** End *** =
PROMPT ===================================================================================== 
