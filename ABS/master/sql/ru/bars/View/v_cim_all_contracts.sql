
prompt
prompt v_cim_all_contracts - Перелік усіх контрактів
prompt v 1.00.05
prompt

create or replace FORCE view v_cim_all_contracts 
(   
	contr_id,
	contr_type,
	contr_type_name,
	num,
    subnum,
	rnk,
	okpo,
	nmk,
	nmkk,
	custtype,
	nd,
	ved,
	ved_name,
	open_date,
	close_date,
	kv,
	s,
	benef_id,
	benef_name,
	benef_adr,
	country_id,
	country_name,
	status_id,
	status_name,
	comments,
	branch,
	branch_name,
    owner,
    owner_uid,
    owner_name,
    can_delete,
    bic,
    b010,
    bank_name,
    attantion_flag,
    service_branch,
    ea_url,
    bank_change
--    nearest_control_date
)
AS
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

comment on table  v_cim_all_contracts					is 'Довідник контрактів v 1.00.04';
comment on column v_cim_all_contracts.contr_id			is 'Внутрішній код контракту';
comment on column v_cim_all_contracts.contr_type		is 'Тип контракту';
comment on column v_cim_all_contracts.contr_type_name   is 'Найменування типу контракту';
comment on column v_cim_all_contracts.rnk				is 'Внутрішній номер (rnk) контрагента контракту';
comment on column v_cim_all_contracts.okpo				is 'ОКПО контрагента контракту';
comment on column v_cim_all_contracts.nmk				is 'Найменування контрагента';
comment on column v_cim_all_contracts.nmkk			    is 'Коротке найменування контрагента';
comment on column v_cim_all_contracts.custtype			is 'Тип контрагента (1 -банк, 2 - ЮО, 3-ФО)';
comment on column v_cim_all_contracts.nd				is 'Номер договору контрагента';
comment on column v_cim_all_contracts.ved				is 'Код виду економічної діяльності';
comment on column v_cim_all_contracts.ved_name			is 'Вид економічної діяльності';
comment on column v_cim_all_contracts.num				is 'Символьний номер контракту';
comment on column v_cim_all_contracts.subnum			is 'Cубномер контракту';
comment on column v_cim_all_contracts.open_date			is 'Дата відкриття';
comment on column v_cim_all_contracts.close_date		is 'Дата закриття ';
comment on column v_cim_all_contracts.s					is 'Сума контракту';
comment on column v_cim_all_contracts.kv				is 'Валюта контракту';
comment on column v_cim_all_contracts.benef_id			is 'Код клієнта-неризидента';
comment on column v_cim_all_contracts.benef_name		is 'Найменування клієнта-неризидента';
comment on column v_cim_all_contracts.benef_adr			is 'Адреса клієнта-нерезидента';
comment on column v_cim_all_contracts.country_id		is 'id країни клієнта-нерезидента';
comment on column v_cim_all_contracts.country_name		is 'Назва країни клієнта-нерезидента';
comment on column v_cim_all_contracts.status_id			is 'Код статусу контракту';
comment on column v_cim_all_contracts.status_name		is 'Статус контракту';
comment on column v_cim_all_contracts.comments			is 'Деталі контракту';
comment on column v_cim_all_contracts.branch			is 'Код відділеня'; 
comment on column v_cim_all_contracts.branch_name		is 'Відділеня';
comment on column v_cim_all_contracts.owner      		is 'Установа - власник контракту (1 - так, 0 - ні)';  
comment on column v_cim_all_contracts.owner_uid   		is 'Id користувача, за яким закріплено контракт';
comment on column v_cim_all_contracts.owner_name   		is 'ПІБ користувача, за яким закріплено контракт';
comment on column v_cim_all_contracts.can_delete   		is 'Можливість видалення контракту (1 - так, 0 - ні)';
comment on column v_cim_all_contracts.bic               is 'BIC-код банку-нерезидента';
comment on column v_cim_all_contracts.b010              is 'Код B010 банку нерезидента';
comment on column v_cim_all_contracts.bank_name         is 'Назва банку нерезидента';
comment on column v_cim_all_contracts.attantion_flag    is 'Відмітка про наявність нових МД по контракту';
comment on column v_cim_all_contracts.service_branch    is 'Установа, відповідальна за прийом первинних документів';
comment on column v_cim_all_contracts.ea_url            is 'Адреса сервера електронного архіву ВК';
--comment on column v_cim_all_contracts.nearest_control_date  is 'Найближча контрольна дата';

grant select on v_cim_all_contracts to bars_access_defrole;
grant select on v_cim_all_contracts to cim_role;