

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_ALL_CONTRACTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_ALL_CONTRACTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_ALL_CONTRACTS ("CONTR_ID", "CONTR_TYPE", "CONTR_TYPE_NAME", "NUM", "SUBNUM", "RNK", "OKPO", "NMK", "NMKK", "CUSTTYPE", "ND", "VED", "VED_NAME", "OPEN_DATE", "CLOSE_DATE", "KV", "S", "BENEF_ID", "BENEF_NAME", "BENEF_ADR", "COUNTRY_ID", "COUNTRY_NAME", "STATUS_ID", "STATUS_NAME", "COMMENTS", "BRANCH", "BRANCH_NAME", "OWNER", "OWNER_UID", "OWNER_NAME", "CAN_DELETE", "BIC", "B010", "BANK_NAME", "ATTANTION_FLAG", "SERVICE_BRANCH", "EA_URL", "BANK_CHANGE") AS 
  select cc.contr_id, cc.contr_type, ct.contr_type_name, cc.num, cc.subnum, cc.rnk, c.okpo,
          nvl((select nmku from corps where rnk=cc.rnk), c.nmk), c.nmkk, c.custtype, c.nd, c.ved, v.name, cc.open_date, cc.close_date,
          cc.kv, round(cc.s/100,2), cc.benef_id, b.benef_name, b.benef_adr, b.country_id, co.name,
          cc.status_id, cs.status_name, cc.comments,cc.branch, br.name,
          case when cc.branch=SYS_CONTEXT ('bars_context', 'user_branch') then 1 else 0 end case,
          cc.owner_uid, (select fio from staff$base where id=cc.owner_uid),
          case when cc.status_id !=1 and cc.status_id != 9 then 0 else
            case when exists(select 1 from cim_payments_bound where contr_id=cc.contr_id)
                   or exists(select 1 from cim_fantoms_bound where contr_id=cc.contr_id)
                   or exists(select 1 from cim_vmd_bound where contr_id=cc.contr_id)
                   or exists(select 1 from cim_act_bound where contr_id=cc.contr_id)
                   or exists(select 1 from cim_contracts_ape where contr_id=cc.contr_id)
                   or exists(select 1 from cim_conclusion where contr_id=cc.contr_id)
            then 0 else 1
            end
          end,
          cc.bic, cc.b010, (select max(bank_name) as bank_name from v_cim_bank_code where bic=cc.bic and b010=cc.b010),
          case when cc.status_id in (4, 5) and cc.contr_type = 1 then
                 case when exists(select 1 from cim_vmd_bound b
                                   where not exists(select 1 from bars.cim_link where delete_date is null and vmd_id = b.bound_id)
                                         and bankdate-b.create_date<=t.n and contr_id=cc.contr_id)
                      then 1 else 0
                 end
               else 0
          end, cc.service_branch,
          u.ea_url||'document?clientcode='||c.okpo||'&'||'typecode='||to_char(cc.contr_type, 'fm0')||'&'||'number='||cim_mgr.FORM_URL_ENCODE(cc.num)||
          '&'||'date='||to_char(cc.open_date, 'yyyy-mm-dd') as ea_url, cc.bank_change
/*       ,
          case when cc.contr_type = 0
                 then (select min(control_date) from v_cim_bound_vmd x where x.control_date>=bankdate and x.z_vk>0 and x.contr_id=cc.contr_id)
               when cc.contr_type = 1
                 then (select min(control_date) from v_cim_trade_payments x where x.control_date>=bankdate and x.zs_vk>0 and x.contr_id=cc.contr_id)
               else null
          end */
     from cim_contracts cc
          join cim_contract_statuses cs on cs.status_id=cc.status_id
          join cim_contract_types ct on ct.contr_type_id=cc.contr_type
          join customer c on c.rnk=cc.rnk
          left outer join ved v on v.ved=c.ved
          join cim_beneficiaries b on b.benef_id=cc.benef_id
          left outer join country co on co.country=b.country_id
          left outer join branch br on br.branch=cc.branch
          left outer join (select to_number(par_value) as n from cim_params where par_name='ALERT_TERM') t on 1=1
          left outer join (select par_value as ea_url from cim_params where par_name='EA_URL') u on 1=1
    where
      -- підпорядковані відділення
          ( cc.service_branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask') or
            cc.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask') );

PROMPT *** Create  grants  V_CIM_ALL_CONTRACTS ***
grant SELECT                                                                 on V_CIM_ALL_CONTRACTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_ALL_CONTRACTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_ALL_CONTRACTS to CIM_ROLE;
grant SELECT                                                                 on V_CIM_ALL_CONTRACTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_ALL_CONTRACTS.sql =========*** En
PROMPT ===================================================================================== 
