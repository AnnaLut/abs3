

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_BOUND_VMD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_BOUND_VMD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_BOUND_VMD ("BOUND_ID", "CONTR_ID", "VMD_ID", "DIRECT", "TYPE_ID", "DOC_TYPE", "NUM", "DOC_DATE", "ALLOW_DATE", "VT", "S_VT", "RATE_VK", "S_VK", "FILE_DATE", "FILE_NAME", "CONTRACT_NUM", "CONTRACT_DATE", "S_PL_VK", "Z_VT", "Z_VK", "S_PL_AFTER_VK", "CONTROL_DATE", "OVERDUE", "COMMENTS", "CREATE_DATE", "MODIFY_DATE", "BORG_REASON", "EA_URL", "DEADLINE_DOC", "ZQ_VT", "IS_DOC", "DATE_MAX_BOUND_DOC", "BRANCH") AS 
  select a.bound_id, a.contr_id, a.vmd_id, a.direct, 0, (select max(name) from cim_act_types where type_id=0), a.num,
          a.allow_dat, a.allow_dat, a.vt, a.s_vt, a.rate_vk, a.s_vk, a.file_date, a.file_name, a.doc, a.sdate,
          a.s, round(a.s_vt*(1-a.s/a.s_vk),2), a.s_vk-a.s, a.s_after, a.control_date,
          case when bankdate>a.control_date and a.s_vk>a.s then  trunc(bankdate)-trunc(a.control_date) else 0 end,
          a.comments, a.create_date, a.modify_date, a.borg_reason,
          (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts c where c.contr_id=a.contr_id)||
           '&'||'typecode=30&'||'number='||cim_mgr.form_url_encode(a.num)||'&'||'date='||to_char(a.allow_dat, 'yyyy-mm-dd') as ea_url,
          a.deadline_doc,
          cim_mgr.val_convert(nvl(a.date_max_bound_doc, a.allow_dat), round(a.s_vt*(1-a.s/a.s_vk),2)/*z_vt*/ * 100, a.vt, 980) / 100 as zq_vt,
          a.is_doc, a.date_max_bound_doc, a.branch
   from (select b.bound_id, b.contr_id, b.vmd_id, b.direct, v.cnum_cst||'/'||v.cnum_year||'/'||to_char(v.cnum_num,'fm000000') as num, v.cim_date as doc_date,
                trunc(v.allow_dat) as allow_dat, v.kv as vt, round(b.s_vt/100,2) as s_vt, b.rate_vk, round(b.s_vk/100,2) as s_vk, v.dat as file_date,
                v.fn as file_name, b.comments, cim_mgr.get_control_date(1, 0, b.bound_id) as control_date, translatedos2win(v.doc) as doc,
                trunc(v.sdate) as sdate, round((select nvl(sum(s),0)
           from cim_link where delete_date is null and vmd_id=b.bound_id)/100,2) as s,
                (select round(nvl(sum(case when v.allow_dat+c.deadline<nvl2(l.payment_id,
                        (select max(vdat) from oper where ref=(select max(ref)from cim_payments_bound where bound_id=l.payment_id)),
                           (select max(val_date) from cim_fantom_payments
                              where fantom_id=(select max(fantom_id) from cim_fantoms_bound where bound_id=l.fantom_id))) then s else 0 end),0)
                             /100,2)
                 from cim_link l where l.delete_date is null and l.vmd_id=b.bound_id
                ) as s_after, b.create_date, b.modify_date as modify_date, b.borg_reason, b.deadline as deadline_doc, decode(b.is_doc, 1, 'Так', 'Ні') as is_doc,
               (select max(nvl2(l.payment_id,
                                  (select max(vdat) from oper where ref=(select max(ref)from cim_payments_bound where bound_id=l.payment_id)),
                                  (select max(val_date) from cim_fantom_payments where fantom_id=(select max(fantom_id) from cim_fantoms_bound where bound_id=l.fantom_id))))
                  from cim_link l where l.delete_date is null and l.vmd_id=b.bound_id) as date_max_bound_doc, b.branch
         from cim_vmd_bound b, customs_decl v, cim_contracts_trade c
         where v.cim_id=b.vmd_id and b.delete_date is null and c.contr_id=b.contr_id
        ) a
   union all
   select a.bound_id, a.contr_id, a.act_id, a.direct, a.act_type, a.type_name, a.num, a.act_date, a.allow_date,
          a.kv, a.s_vt, a.rate_vk, a.s_vk, a.file_date, a.file_name, null, null, a.s,  round(a.s_vt*(1-a.s/a.s_vk),2),
          a.s_vk-a.s, a.s_after, a.control_date,
          case when bankdate>a.control_date and a.s_vk>a.s then  bankdate-trunc(a.control_date) else 0 end,
          a.comments, a.create_date, a.modify_date, a.borg_reason,
          (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts c where c.contr_id=a.contr_id)||
           '&'||'typecode='||case when a.act_type=5 then 32 when a.act_type in (1,6,7) then 31 else 30 end||'&'||'number='||cim_mgr.form_url_encode(a.num)||'&'||'date='||
           to_char(a.allow_date, 'yyyy-mm-dd') as ea_url,
          a.deadline_doc,
          cim_mgr.val_convert(nvl(a.date_max_bound_doc, a.allow_date), round(a.s_vt*(1-a.s/a.s_vk),2)/*z_vt*/ * 100, a.kv, 980) / 100 as zq_vt,
          a.is_doc, a.date_max_bound_doc, a.branch
   from (select b.contr_id, b.bound_id, b.act_id, b.direct, a.act_type, a.file_name, a.file_date,
                (select max(name) from cim_act_types where type_id=a.act_type) as type_name,
                a.num, a.act_date, a.allow_date, a.kv, round(b.s_vt/100,2) as s_vt, b.rate_vk, round(b.s_vk/100,2) as s_vk, b.comments,
                cim_mgr.get_control_date(1, a.act_type, b.bound_id) as control_date,
                round((select nvl(sum(s),0) from cim_link where delete_date is null and act_id=b.bound_id)/100,2) as s,
                (select round(nvl(sum(case when a.allow_date+c.deadline<nvl2(l.payment_id,
                           (select max(vdat) from oper where ref=(select max(ref)from cim_payments_bound where bound_id=l.payment_id)),
                           (select max(val_date)
                              from cim_fantom_payments
                              where fantom_id=(select max(fantom_id) from cim_fantoms_bound where bound_id=l.fantom_id)))
                                     then s else 0 end),0)/100,2)
                 from cim_link l where l.delete_date is null and l.act_id=b.bound_id
                ) as s_after, b.create_date, b.modify_date as modify_date, b.borg_reason, b.deadline as deadline_doc, decode(b.is_doc, 1, 'Так', 'Ні') as is_doc,
               (select max(nvl2(l.payment_id,
                                 (select max(vdat) from oper where ref=(select max(ref)from cim_payments_bound where bound_id=l.payment_id)),
                                 (select max(val_date) from cim_fantom_payments where fantom_id=(select max(fantom_id) from cim_fantoms_bound where bound_id=l.fantom_id))))
                   from cim_link l where l.delete_date is null and l.act_id=b.bound_id
                ) as date_max_bound_doc, b.branch
         from cim_act_bound b, cim_acts a, cim_contracts_trade c
         where  a.act_id=b.act_id and b.delete_date is null and c.contr_id=b.contr_id
        ) a;

comment on table V_CIM_BOUND_VMD is 'Прив`язані ВМД v 1.00.06';
comment on column V_CIM_BOUND_VMD.BOUND_ID is 'Id прив''язки';
comment on column V_CIM_BOUND_VMD.CONTR_ID is 'Внутрішній код контракту';
comment on column V_CIM_BOUND_VMD.VMD_ID is 'id ВМД';
comment on column V_CIM_BOUND_VMD.DIRECT is 'Напрямок ВМД (0-вхідні, 1-вихідні)';
comment on column V_CIM_BOUND_VMD.TYPE_ID is 'id типу документу';
comment on column V_CIM_BOUND_VMD.DOC_TYPE is 'Тип документу';
comment on column V_CIM_BOUND_VMD.NUM is 'Номер документу';
comment on column V_CIM_BOUND_VMD.DOC_DATE is 'Дата паперового носія';
comment on column V_CIM_BOUND_VMD.ALLOW_DATE is 'Дата дозволу';
comment on column V_CIM_BOUND_VMD.VT is 'Валюта товару';
comment on column V_CIM_BOUND_VMD.S_VT is 'Сума у валюті товару';
comment on column V_CIM_BOUND_VMD.RATE_VK is 'Курс валюти контракту відносно валюти товару s_vk/s_vt';
comment on column V_CIM_BOUND_VMD.S_VK is 'Сума у валюті контракту';
comment on column V_CIM_BOUND_VMD.FILE_DATE is 'Дата реєстру';
comment on column V_CIM_BOUND_VMD.FILE_NAME is '№ реєстру';
comment on column V_CIM_BOUND_VMD.CONTRACT_NUM is '№ контракту (з МД)';
comment on column V_CIM_BOUND_VMD.CONTRACT_DATE is 'Дата конттракту (з МД)';
comment on column V_CIM_BOUND_VMD.S_PL_VK is 'Сума пов`язаних платежів';
comment on column V_CIM_BOUND_VMD.Z_VT is 'Заборгованість по платежах у валюті товару';
comment on column V_CIM_BOUND_VMD.Z_VK is 'Заборгованість по платежах у валюті контракту';
comment on column V_CIM_BOUND_VMD.S_PL_AFTER_VK is 'Сума пов`язаних платежів після контрольного дня (експ';
comment on column V_CIM_BOUND_VMD.CONTROL_DATE is 'Дата контрольного дня (експ)';
comment on column V_CIM_BOUND_VMD.OVERDUE is 'Кількість днів прострочки';
comment on column V_CIM_BOUND_VMD.COMMENTS is 'Примітка';
comment on column V_CIM_BOUND_VMD.CREATE_DATE is 'Дата створення';
comment on column V_CIM_BOUND_VMD.MODIFY_DATE is 'Дата модифікації';
comment on column V_CIM_BOUND_VMD.BORG_REASON is 'Причина заборгованості';
comment on column V_CIM_BOUND_VMD.EA_URL is 'Адреса сервера електронного архіву ВК';
comment on column V_CIM_BOUND_VMD.DEADLINE_DOC is 'Контрольний строк по документу';
comment on column V_CIM_BOUND_VMD.ZQ_VT is 'Грн.екв.останньої події незавершеного розрахунку';
comment on column V_CIM_BOUND_VMD.IS_DOC is 'Наявність документів у Банку';
comment on column V_CIM_BOUND_VMD.DATE_MAX_BOUND_DOC is 'Дата привязки останньої події';
comment on column V_CIM_BOUND_VMD.BRANCH is 'Підрозділ';

PROMPT *** Create  grants  V_CIM_BOUND_VMD ***
grant SELECT                                                                 on V_CIM_BOUND_VMD to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_BOUND_VMD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_BOUND_VMD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_BOUND_VMD.sql =========*** End **
PROMPT ===================================================================================== 
