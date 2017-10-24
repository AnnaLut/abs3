

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_BOUND_PAYMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_BOUND_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_BOUND_PAYMENTS ("BOUND_ID", "CONTR_ID", "PAY_FLAG", "PAY_FLAG_NAME", "REF", "DIRECT", "TYPE_ID", "TYPE", "VDAT", "ACCOUNT", "NAZN", "V_PL", "S_VPL", "SK_VPL", "RATE", "S_VK", "CREATE_DATE", "MODIFY_DATE", "BORG_REASON", "EA_URL") AS 
  SELECT b.bound_id, b.contr_id, b.pay_flag, (select name from cim_payflag where id=b.pay_flag), b.REF, b.direct, 0,
          (select type_name from cim_payment_types where type_id=0), nvl((select max(fdat) from opldok where ref=o.ref),o.vdat) as vdat,
          decode(b.direct,0,o.nlsb,1,o.nlsa), o.nazn, o.kv, b.s/100, b.comiss/100, b.rate, b.s_cv/100, b.create_date, b.modify_date, b.borg_reason,
          (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts c where c.contr_id=b.contr_id)||
           '&'||'typecode=25&'||'number='||cim_mgr.form_url_encode(o.nd)||'&'||'date='||to_char(nvl((select max(fdat) from opldok where ref=o.ref),o.vdat), 'yyyy-mm-dd') as ea_url
   FROM cim_payments_bound b join oper o on o.ref=b.ref
   WHERE b.delete_date is null
     UNION ALL
   SELECT b.bound_id, b.contr_id, b.pay_flag, (select name from cim_payflag where id=b.pay_flag), b.fantom_id, b.direct,
          f.payment_type, (select type_name from cim_payment_types where type_id=f.payment_type), f.val_date, null, f.details, f.kv, b.s/100,
          b.comiss/100, b.rate, b.s_cv/100, b.create_date, b.modify_date, b.borg_reason,
          (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts c where c.contr_id=b.contr_id)||'&'||
            'typecode='||case when f.payment_type=5 then 32 when f.payment_type=4 then 26 else 25 end||'&'||'number='||to_char(b.fantom_id, 'fm999999999')||'&'||
            'date='||to_char(f.val_date, 'yyyy-mm-dd') as ea_url
   FROM cim_fantoms_bound b join cim_fantom_payments f on f.fantom_id=b.fantom_id
   WHERE b.delete_date is null;

PROMPT *** Create  grants  V_CIM_BOUND_PAYMENTS ***
grant SELECT                                                                 on V_CIM_BOUND_PAYMENTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_BOUND_PAYMENTS.sql =========*** E
PROMPT ===================================================================================== 
