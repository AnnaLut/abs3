

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_TRADE_CONTRACTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_TRADE_CONTRACTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_TRADE_CONTRACTS ("CONTR_ID", "CONTR_TYPE", "CONTR_TYPE_NAME", "NUM", "SUBNUM", "RNK", "OKPO", "NMK", "NMKK", "ND", "VED", "VED_NAME", "OPEN_DATE", "CLOSE_DATE", "KV", "S", "BENEF_ID", "BENEF_NAME", "BENEF_ADR", "COUNTRY_ID", "COUNTRY_NAME", "STATUS_ID", "STATUS_NAME", "COMMENTS", "BRANCH", "BRANCH_NAME", "OWNER", "SPEC_ID", "SPEC_NAME", "WITHOUT_ACTS", "SUBJECT_ID", "SUBJECT_NAME", "DEADLINE", "TRADE_DESC", "BIC", "B010", "BANK_NAME", "SERVICE_BRANCH", "EA_URL", "S_PL", "Z_PL", "S_PL_AFTER", "S_VMD", "Z_VMD", "S_VMD_AFTER", "OWNER_UID", "OWNER_NAME", "IS_FRAGMENT") AS 
  SELECT  c.contr_id, c.contr_type, c.contr_type_name, c.num, c.subnum, c.rnk,
          c.okpo, c.nmk, c.nmkk,
          c.nd, c.ved, c.ved_name, c.open_date, c.close_date, c.kv, c.s, c.benef_id, c.benef_name, c.benef_adr,
          c.country_id, c.country_name, c.status_id, c.status_name, c.comments, c.branch, c.branch_name, c.owner,
          ---------------------------------------------------------------------------------------------------------
          ctd.spec_id, s.spec_name, ctd.without_acts, ctd.subject_id,  cb.subject_name, ctd.deadline, ctd.trade_desc, c.bic, c.b010, c.bank_name, c.service_branch, c.ea_url,
          ---------------------------------------------------------------------------------------------------------
          nvl((select sum(s_vk) from v_cim_trade_payments where type_id not in (9, 10) and pay_flag=0 and contr_id=c.contr_id),0),
          nvl((select sum(zs_vk) from v_cim_trade_payments where pay_flag=0 and contr_id=c.contr_id),0),
          nvl((select sum(s_pl_after_vk) from v_cim_bound_vmd where contr_id=c.contr_id),0),
          nvl((select sum(s_vk) from v_cim_bound_vmd where contr_id=c.contr_id),0)-
            nvl((select sum(s_vk) from v_cim_trade_payments where type_id in (9, 10) and pay_flag=0 and contr_id=c.contr_id),0),
          nvl((select sum(z_vk) from v_cim_bound_vmd where contr_id=c.contr_id),0),
          nvl((select sum(s_pd_after) from v_cim_trade_payments where pay_flag=0 and contr_id=c.contr_id),0),
          c.owner_uid, c.owner_name, decode(ctd.is_fragment , 1, 'Так','Ні') is_fragment
     FROM v_cim_all_contracts c, cim_contracts_trade ctd, cim_contract_specs s, cim_contract_subjects cb
    WHERE ctd.subject_id = cb.subject_id(+)
		  and ctd.spec_id = s.spec_id(+)
		  and c.contr_id = ctd.contr_id(+)
		  and c.contr_type in (0,1);

comment on table V_CIM_TRADE_CONTRACTS is 'Довідник торгових контрактів v 1.00.04';
comment on column V_CIM_TRADE_CONTRACTS.CONTR_ID is 'Внутрішній код контракту';
comment on column V_CIM_TRADE_CONTRACTS.CONTR_TYPE is 'Тип контракту';
comment on column V_CIM_TRADE_CONTRACTS.CONTR_TYPE_NAME is 'Найменування типу контракту';
comment on column V_CIM_TRADE_CONTRACTS.NUM is 'Символьний номер контракту';
comment on column V_CIM_TRADE_CONTRACTS.SUBNUM is 'Субномер контракту';
comment on column V_CIM_TRADE_CONTRACTS.RNK is 'Внутрішній номер (rnk) контрагента контракту';
comment on column V_CIM_TRADE_CONTRACTS.OKPO is 'ОКПО контрагента контракту';
comment on column V_CIM_TRADE_CONTRACTS.NMK is 'Найменування контрагента';
comment on column V_CIM_TRADE_CONTRACTS.NMKK is 'Коротке найменування контрагента';
comment on column V_CIM_TRADE_CONTRACTS.ND is 'Номер договору контрагента';
comment on column V_CIM_TRADE_CONTRACTS.VED is 'Код виду економічної діяльності';
comment on column V_CIM_TRADE_CONTRACTS.VED_NAME is 'Вид економічної діяльності';
comment on column V_CIM_TRADE_CONTRACTS.OPEN_DATE is 'Дата відкриття';
comment on column V_CIM_TRADE_CONTRACTS.CLOSE_DATE is 'Дата закриття ';
comment on column V_CIM_TRADE_CONTRACTS.KV is 'Валюта контракту';
comment on column V_CIM_TRADE_CONTRACTS.S is 'Сума контракту';
comment on column V_CIM_TRADE_CONTRACTS.BENEF_ID is 'Код клієнта-неризидента';
comment on column V_CIM_TRADE_CONTRACTS.BENEF_NAME is 'Найменування клієнта-неризидента';
comment on column V_CIM_TRADE_CONTRACTS.BENEF_ADR is 'Адреса клієнта-нерезидента';
comment on column V_CIM_TRADE_CONTRACTS.COUNTRY_ID is 'id країни клієнта-нерезидента';
comment on column V_CIM_TRADE_CONTRACTS.COUNTRY_NAME is 'Назва країни клієнта-нерезидента';
comment on column V_CIM_TRADE_CONTRACTS.STATUS_ID is 'Код статусу контракту';
comment on column V_CIM_TRADE_CONTRACTS.STATUS_NAME is 'Статус контракту';
comment on column V_CIM_TRADE_CONTRACTS.COMMENTS is 'Деталі контракту';
comment on column V_CIM_TRADE_CONTRACTS.BRANCH is 'Код установи';
comment on column V_CIM_TRADE_CONTRACTS.BRANCH_NAME is 'Назва установи';
comment on column V_CIM_TRADE_CONTRACTS.OWNER is 'Установа - власник контракту (1 - так, 0 - ні)';
comment on column V_CIM_TRADE_CONTRACTS.SPEC_ID is 'Код спеціалізації';
comment on column V_CIM_TRADE_CONTRACTS.SPEC_NAME is 'Найменування спеціалізації';
comment on column V_CIM_TRADE_CONTRACTS.WITHOUT_ACTS is 'Робота без актів цінової експертизи';
comment on column V_CIM_TRADE_CONTRACTS.SUBJECT_ID is 'Код предмету контракту';
comment on column V_CIM_TRADE_CONTRACTS.SUBJECT_NAME is 'Предмет контракту';
comment on column V_CIM_TRADE_CONTRACTS.DEADLINE is 'Контрольний строк';
comment on column V_CIM_TRADE_CONTRACTS.TRADE_DESC is 'Уточнення предмету контракту';
comment on column V_CIM_TRADE_CONTRACTS.BIC is 'BIC-код банку-нерезидента';
comment on column V_CIM_TRADE_CONTRACTS.B010 is 'Код B010 банку нерезидента';
comment on column V_CIM_TRADE_CONTRACTS.BANK_NAME is 'Назва банку нерезидента';
comment on column V_CIM_TRADE_CONTRACTS.SERVICE_BRANCH is 'Установа, відповідальна за прийом первинних документів';
comment on column V_CIM_TRADE_CONTRACTS.EA_URL is 'Адреса сервера електронного архіву ВК';
comment on column V_CIM_TRADE_CONTRACTS.S_PL is 'Сума платежів';
comment on column V_CIM_TRADE_CONTRACTS.Z_PL is 'Заборгованість по МД/Актах';
comment on column V_CIM_TRADE_CONTRACTS.S_PL_AFTER is 'Сума платежів після контрольного дня';
comment on column V_CIM_TRADE_CONTRACTS.S_VMD is 'Сума МД/Актів';
comment on column V_CIM_TRADE_CONTRACTS.Z_VMD is 'Заборгованість по платежах';
comment on column V_CIM_TRADE_CONTRACTS.S_VMD_AFTER is 'Сума МД/Актів після контрольного дня';
comment on column V_CIM_TRADE_CONTRACTS.OWNER_UID is 'Id користувача, за яким закріплено контракт';
comment on column V_CIM_TRADE_CONTRACTS.OWNER_NAME is 'ПІБ користувача, за яким закріплено контракт';
comment on column V_CIM_TRADE_CONTRACTS.IS_FRAGMENT is 'Ознака дроблення';


PROMPT *** Create  grants  V_CIM_TRADE_CONTRACTS ***
grant SELECT                                                                 on V_CIM_TRADE_CONTRACTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_TRADE_CONTRACTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_TRADE_CONTRACTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_TRADE_CONTRACTS.sql =========*** 
PROMPT ===================================================================================== 
