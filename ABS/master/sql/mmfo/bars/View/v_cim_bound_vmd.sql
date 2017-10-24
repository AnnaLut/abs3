

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_BOUND_VMD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_BOUND_VMD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_BOUND_VMD ("BOUND_ID", "CONTR_ID", "VMD_ID", "DIRECT", "TYPE_ID", "DOC_TYPE", "NUM", "DOC_DATE", "ALLOW_DATE", "VT", "S_VT", "RATE_VK", "S_VK", "FILE_DATE", "FILE_NAME", "CONTRACT_NUM", "CONTRACT_DATE", "S_PL_VK", "Z_VT", "Z_VK", "S_PL_AFTER_VK", "CONTROL_DATE", "OVERDUE", "COMMENTS", "CREATE_DATE", "MODIFY_DATE", "BORG_REASON", "EA_URL") AS 
  select a.bound_id, a.contr_id, a.vmd_id, a.direct, 0, (select max(name) from cim_act_types where type_id=0), a.num,
          a.allow_dat, a.allow_dat, a.vt, a.s_vt, a.rate_vk, a.s_vk, a.file_date, a.file_name, a.doc, a.sdate,
          a.s, round(a.s_vt*(1-a.s/a.s_vk),2), a.s_vk-a.s, a.s_after, a.control_date,
          case when bankdate>a.control_date and a.s_vk>a.s then  trunc(bankdate)-trunc(a.control_date) else 0 end,
          a.comments, a.create_date, a.modify_date, a.borg_reason,
          (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts c where c.contr_id=a.contr_id)||
           '&'||'typecode=30&'||'number='||cim_mgr.form_url_encode(a.num)||'&'||'date='||to_char(a.allow_dat, 'yyyy-mm-dd') as ea_url
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
                ) as s_after, b.create_date, b.modify_date as modify_date, b.borg_reason
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
           to_char(a.allow_date, 'yyyy-mm-dd') as ea_url
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
                ) as s_after, b.create_date, b.modify_date as modify_date, b.borg_reason
         from cim_act_bound b, cim_acts a, cim_contracts_trade c
         where  a.act_id=b.act_id and b.delete_date is null and c.contr_id=b.contr_id
        ) a;

PROMPT *** Create  grants  V_CIM_BOUND_VMD ***
grant SELECT                                                                 on V_CIM_BOUND_VMD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_BOUND_VMD.sql =========*** End **
PROMPT ===================================================================================== 
