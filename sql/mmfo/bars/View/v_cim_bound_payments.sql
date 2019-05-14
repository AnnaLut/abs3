

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_BOUND_PAYMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_BOUND_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_BOUND_PAYMENTS ("BOUND_ID", "CONTR_ID", "PAY_FLAG", "PAY_FLAG_NAME", "REF", "DIRECT", "TYPE_ID", "TYPE", "VDAT", "ACCOUNT", "NAZN", "V_PL", "S_VPL", "SK_VPL", "RATE", "S_VK", "CREATE_DATE", "MODIFY_DATE", "BORG_REASON", "EA_URL", "BRANCH", "DEADLINE_DOC", "IS_DOC") AS 
  SELECT b.bound_id, b.contr_id, b.pay_flag, (select name from cim_payflag where id=b.pay_flag), b.REF, b.direct, 0,
          (select type_name from cim_payment_types where type_id=0), nvl((select max(fdat) from opldok where ref=o.ref),o.vdat) as vdat,
          decode(b.direct,0,o.nlsb,1,o.nlsa), o.nazn, o.kv, b.s/100, b.comiss/100, b.rate, b.s_cv/100, b.create_date, b.modify_date, b.borg_reason,
          (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts c where c.contr_id=b.contr_id)||
           '&'||'typecode=25&'||'number='||cim_mgr.form_url_encode(o.nd)||'&'||'date='||to_char(nvl((select max(fdat) from opldok where ref=o.ref),o.vdat), 'yyyy-mm-dd') as ea_url,
          b.branch, b.deadline as deadline_doc, decode(b.is_doc, 1, 'Так', 'Ні') as is_doc
   FROM cim_payments_bound b join oper o on o.ref=b.ref
   WHERE b.delete_date is null
     UNION ALL
   SELECT b.bound_id, b.contr_id, b.pay_flag, (select name from cim_payflag where id=b.pay_flag), b.fantom_id, b.direct,
          f.payment_type, (select type_name from cim_payment_types where type_id=f.payment_type), f.val_date, null, f.details, f.kv, b.s/100,
          b.comiss/100, b.rate, b.s_cv/100, b.create_date, b.modify_date, b.borg_reason,
          (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts c where c.contr_id=b.contr_id)||'&'||
            'typecode='||case when f.payment_type=5 then 32 when f.payment_type=4 then 26 else 25 end||'&'||'number='||to_char(b.fantom_id, 'fm999999999')||'&'||
            'date='||to_char(f.val_date, 'yyyy-mm-dd') as ea_url,
          b.branch, b.deadline as deadline_doc, decode(b.is_doc, 1, 'Так', 'Ні') as is_doc
   FROM cim_fantoms_bound b join cim_fantom_payments f on f.fantom_id=b.fantom_id
   WHERE b.delete_date is null;

comment on table V_CIM_BOUND_PAYMENTS is 'Прив`язані платежі v 1.00.05';
comment on column V_CIM_BOUND_PAYMENTS.BOUND_ID is 'Id прив''язки';
comment on column V_CIM_BOUND_PAYMENTS.CONTR_ID is 'Внутрішній код контракту';
comment on column V_CIM_BOUND_PAYMENTS.PAY_FLAG is 'id cпецифікатора платежу';
comment on column V_CIM_BOUND_PAYMENTS.PAY_FLAG_NAME is 'Назва специфікатора платежу';
comment on column V_CIM_BOUND_PAYMENTS.REF is 'Референс платежу';
comment on column V_CIM_BOUND_PAYMENTS.DIRECT is 'Напрямок платежу (0-вхідні, 1-вихідні)';
comment on column V_CIM_BOUND_PAYMENTS.TYPE_ID is 'id типу платежу';
comment on column V_CIM_BOUND_PAYMENTS.TYPE is 'Тип платежу';
comment on column V_CIM_BOUND_PAYMENTS.VDAT is 'Дата валютування';
comment on column V_CIM_BOUND_PAYMENTS.ACCOUNT is 'Рахунок';
comment on column V_CIM_BOUND_PAYMENTS.NAZN is 'Призначення платежу';
comment on column V_CIM_BOUND_PAYMENTS.V_PL is 'Валюта платежу';
comment on column V_CIM_BOUND_PAYMENTS.S_VPL is 'Сума у валюті платежу';
comment on column V_CIM_BOUND_PAYMENTS.RATE is 'Курс відносно валюти контракту';
comment on column V_CIM_BOUND_PAYMENTS.S_VK is 'Сума у валюті клнтракту';
comment on column V_CIM_BOUND_PAYMENTS.CREATE_DATE is 'Дата створення';
comment on column V_CIM_BOUND_PAYMENTS.MODIFY_DATE is 'Дата модифікації';
comment on column V_CIM_BOUND_PAYMENTS.BORG_REASON is 'Причина заборгованості ';
comment on column V_CIM_BOUND_PAYMENTS.EA_URL is 'Адреса сервера електронного архіву ВК';
comment on column V_CIM_BOUND_PAYMENTS.DEADLINE_DOC is 'Контрольний строк по документу';
comment on column V_CIM_BOUND_PAYMENTS.IS_DOC is 'Наявність документів у Банку';

PROMPT *** Create  grants  V_CIM_BOUND_PAYMENTS ***
grant SELECT                                                                 on V_CIM_BOUND_PAYMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_BOUND_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_BOUND_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_BOUND_PAYMENTS.sql =========*** E
PROMPT ===================================================================================== 
