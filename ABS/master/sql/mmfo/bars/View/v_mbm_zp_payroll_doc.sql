PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/view/v_mbm_zp_payroll_doc.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view bars.v_mbm_zp_payroll_doc as
select d.id,
       d.id_pr payroll_id,
       d.namb,
       case when coalesce(d.okpob, '0000000000') = '0000000000' then coalesce(upper(d.passp_serial||d.passp_num), d.idcard_num) else d.okpob end doc_num,
       d.mfob,
       d.nlsb,
       d.s*0.01 as s,
       o.sos,
       d.okpob,
       d.passp_serial,
       d.passp_num,
       d.idcard_num,
       d.corp2_id,
       a.rnk as staff_rnk
from bars.zp_payroll_doc d
     left join bars.oper o on o.ref = d.ref
     left join bars.accounts a on a.nls = d.nlsb and a.kf = d.mfob and a.kv = 980;

PROMPT *** Create comments on bars.v_mbm_zp_payroll_doc ***

comment on table V_MBM_ZP_PAYROLL_DOC          is 'Документи відомості';
comment on column V_MBM_ZP_PAYROLL_DOC.NAMB    is 'ПІБ співробтника';
comment on column V_MBM_ZP_PAYROLL_DOC.DOC_NUM is 'ІПН співробітника або тип документу, номер документу (серія та номер або номер)';
comment on column V_MBM_ZP_PAYROLL_DOC.MFOB    is 'МФО рахунку для зарахування суми зп/авансу/інше';
comment on column V_MBM_ZP_PAYROLL_DOC.NLSB    is 'номер рахунку для зарахування зп\аванс\інше';
comment on column V_MBM_ZP_PAYROLL_DOC.S       is 'сума зп\аванс\інше';
comment on column V_MBM_ZP_PAYROLL_DOC.SOS     is 'статус платежу';
comment on column V_MBM_ZP_PAYROLL_DOC.okpob   is 'ОКПО';
comment on column V_MBM_ZP_PAYROLL_DOC.passp_serial is 'Серія парспорта';
comment on column V_MBM_ZP_PAYROLL_DOC.passp_num    is 'Номер паспорта';
comment on column V_MBM_ZP_PAYROLL_DOC.idcard_num   is 'Номер паспорта нового зразка';
comment on column V_MBM_ZP_PAYROLL_DOC.corp2_id     is 'id corp2';
comment on column V_MBM_ZP_PAYROLL_DOC.staff_rnk    is 'rnk отримувача';

PROMPT *** Create  grants  v_mbm_zp_payroll_doc ***

grant select on bars.v_mbm_zp_payroll_doc to upld;
grant select on bars.v_mbm_zp_payroll_doc to barsreader_role;
grant select on bars.v_mbm_zp_payroll_doc to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_mbm_zp_payroll_doc.sql =========*** End *** =
PROMPT ===================================================================================== 
