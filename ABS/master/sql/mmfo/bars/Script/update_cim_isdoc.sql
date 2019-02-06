/*
При встановленні оновлення  по МД/Актах, прив’язаних до експортних контрактів (тип контракту - 0) значення «Наявні документи» заповнити значеннями:
Для МД/Актів у яких Дата дозволу менша 07.02.2019р. – встановити значення «Так».
Для МД/Актів у яких Дата дозволу більша-рівна 07.02.2019р. – встановити значення «Ні».
*/
update cim_vmd_bound b 
set b.is_doc = 1 
where exists (select * from customs_decl where cim_id = b.vmd_id and allow_dat < to_date('07.02.2019', 'DD.MM.YYYY')) 
  and b.contr_id in (select contr_id from cim_contracts where contr_type = 0)
  and b.is_doc != 1;
/
update cim_act_bound b 
set b.is_doc = 1 
where exists (select * from cim_acts where act_id = b.act_id and allow_date < to_date('07.02.2019', 'DD.MM.YYYY')) 
  and b.contr_id in (select contr_id from cim_contracts where contr_type = 0)
  and b.is_doc != 1;
/
commit;