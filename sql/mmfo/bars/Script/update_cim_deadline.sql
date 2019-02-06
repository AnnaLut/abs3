/*
При встановленні оновлення  по первинних документах (для платежів/фантомів  - тип контракту – 1, PAY_FLAG = 0; для МД/Актів – тип контракту -0) значення «Контр. строк» заповнити значеннями:
Для платежів/фантомів (МД/Актів) у яких Дата валютування ( Дата дозволу) менша 11.08.2018р. – встановити значення 180 днів.
Для решти платежів/фантомів (МД/Актів) у яких Дата валютування ( Дата дозволу) більша рівна 11.08.2018р. – встановити значення 365 днів.
*/
declare
  l_cnt number :=0;
begin
  for cur in (select b.bound_id, o.vdat from cim_payments_bound b, oper o where b.contr_id in (select contr_id from cim_contracts where contr_type = 1) and b.ref = o.ref (+))  
  loop
    update cim_payments_bound set deadline = case when cur.vdat < to_date('11.08.2018', 'DD.MM.YYYY') then 180 else 365 end where bound_id = cur.bound_id and deadline is null;
    l_cnt := l_cnt + SQL%ROWCOUNT; 
  end loop;    
  dbms_output.put_line('Оновлено контрольний строк для платежів count '||l_cnt );
  l_cnt := 0;
  for cur in (select b.bound_id, o.val_date from cim_fantoms_bound b, cim_fantom_payments o where b.contr_id in (select contr_id from cim_contracts where contr_type = 1) and b.fantom_id = o.fantom_id (+))  
  loop
    update cim_fantoms_bound set deadline = case when cur.val_date < to_date('11.08.2018', 'DD.MM.YYYY') then 180 else 365 end where bound_id = cur.bound_id and deadline is null;
    l_cnt := l_cnt + SQL%ROWCOUNT; 
  end loop;    
  dbms_output.put_line('Оновлено контрольний строк для фантомів count '||l_cnt );
  l_cnt := 0;
  for cur in (select b.bound_id, trunc(v.allow_dat) allow_dat from cim_vmd_bound b, customs_decl v where b.contr_id in (select contr_id from cim_contracts where contr_type = 0) and v.cim_id=b.vmd_id)  
  loop
    update cim_vmd_bound set deadline = case when cur.allow_dat < to_date('11.08.2018', 'DD.MM.YYYY') then 180 else 365 end where bound_id = cur.bound_id and deadline is null;
    l_cnt := l_cnt + SQL%ROWCOUNT; 
  end loop;    
  dbms_output.put_line('Оновлено контрольний строк для МД count '||l_cnt );
  l_cnt := 0;
  for cur in (select b.bound_id, a.allow_date allow_dat from cim_act_bound b, cim_acts a where b.contr_id in (select contr_id from cim_contracts where contr_type = 0) and a.act_id=b.act_id)  
  loop
    update cim_act_bound set deadline = case when cur.allow_dat < to_date('11.08.2018', 'DD.MM.YYYY') then 180 else 365 end where bound_id = cur.bound_id and deadline is null;
    l_cnt := l_cnt + SQL%ROWCOUNT; 
  end loop;    
  dbms_output.put_line('Оновлено контрольний строк для Актів count '||l_cnt );
end;  
/

/* (ответ дан 29.01.2019г.) :По умолчанию у Вас стоит 180 дней в карточке контрактов.Поэтому речь идет об этом поставить – в карточке контрактов по умолчанию -365 дней. =< Це певно Ходаковська писала
  Зміни внесено у зв’язки платежів/МД (bound).Крім цього треба внести зміни у таблицю cim_contracts_trade – по контрактах, у яких deadline=180, Встановити deadline=365. (цієї вимоги не було у попередньому описі) =< Це певно уточнення Лесняк С.Б.
*/
declare
begin
 update cim_contracts_trade 
 set deadline = 365
 where deadline = 180;
 dbms_output.put_line('Оновлено контрольний строк в cim_contracts_trade  '|| SQL%ROWCOUNT); 
end;
/
commit;
/