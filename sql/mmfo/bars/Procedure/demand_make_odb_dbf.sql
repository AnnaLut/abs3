

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DEMAND_MAKE_ODB_DBF.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DEMAND_MAKE_ODB_DBF ***

  CREATE OR REPLACE PROCEDURE BARS.DEMAND_MAKE_ODB_DBF (
    p_nls   accounts.nls%type,
    p_kv    accounts.kv%type
 ) is
  l_acc       accounts%rowtype;
  l_cust      customer%rowtype;
  l_person    person%rowtype;
  l_value     tmp_demand_odb%rowtype;
begin

  delete from tmp_demand_odb;

  begin
    select * into l_acc from accounts where nls=p_nls and kv=p_kv;
  exception when no_data_found then
    raise_application_error(-20000, 'Рахунок не знайдено: '||p_nls||'('||p_kv||')', true);
  end;
  select * into l_cust from customer where rnk=l_acc.rnk;
  if l_cust.custtype<>3 then
    raise_application_error(-20000, 'Власник рахунку не є фізособою', true);
  end if;
  select * into l_person from person where rnk=l_acc.rnk;

  -- 1. acc_type
  l_value.acc_type    := bpk_tip_psys(l_acc.tip, l_acc.kv, p_kv, 4);

  -- 2. curr
  select lcv into l_value.curr from tabval where kv=p_kv;
  -- 3. client_n
  l_value.client_n    := substr(l_cust.nmk, 1, 40);

  -- 4. cond_set
  begin
    select demand_cond_set into l_value.cond_set from specparam_int
    where acc=l_acc.acc and demand_cond_set is not null;
  exception when no_data_found then
    raise_application_error(-20000, 'В картці рахунку не заповнено спецпараметр "DEMAND. Код умови рахунку"', true);
  end;

  -- 5. type
  l_value.type        := 1;  -- фізособа

  -- 6. lacct
  l_value.lacct       := to_number(p_nls);

  -- 7. BRN
  begin
    select demand_brn into l_value.brn from specparam_int
    where acc=l_acc.acc and demand_brn is not null;
  exception when no_data_found then
    raise_application_error(-20000, 'В картці рахунку не заповнено спецпараметр "DEMAND. Код відділення"', true);
  end;

  -- 8. crd
  l_value.crd         := greatest(l_acc.lim/100, 0);

  -- 9. id_a
  l_value.id_a        := to_number(l_cust.okpo);

  -- 10. kk
  begin
    select demand_kk into l_value.kk from specparam_int
    where acc=l_acc.acc and demand_kk is not null;
  exception when no_data_found then
    raise_application_error(-20000, 'В картці рахунку не заповнено спецпараметр "DEMAND. Категорія клієнта"', true);
  end;

  -- 11. work
  begin
    select substr(value,1,30) into l_value.work from customerw
    where rnk=l_cust.rnk and tag='WORK ' and value is not null;
  exception when no_data_found then
    raise_application_error(-20000, 'В картці клієнта не заповнено поле "Місце роботи, посада"', true);
  end;

  -- 12. reg_nr
  l_value.reg_nr          := '*';

  -- 13. phone
  -- person.teld
  l_value.phone       := substr(l_person.teld,1,11);

  -- 14. cntry
   select substr(name,1,15) into l_value.cntry from country where country=l_cust.country;

  -- 15. pcode
  begin
    select to_number(substr(value, 1, 6)) into l_value.pcode from customerw
    where rnk=l_cust.rnk and tag='FGIDX' and value is not null;
  exception when no_data_found then
    raise_application_error(-20000, 'В картці клієнта не заповнено поле "Індекс"', true);
  end;

  -- 16. city
  begin
    select substr(value, 1, 15) into l_value.city from customerw
    where rnk=l_cust.rnk and tag='FGTWN' and value is not null;
  exception when no_data_found then
    raise_application_error(-20000, 'В картці клієнта не заповнено поле "Місто"', true);
  end;

  -- 17. street
  begin
    select substr(value, 1, 30) into l_value.street from customerw
    where rnk=l_cust.rnk and tag='FGADR' and value is not null;
  exception when no_data_found then
    raise_application_error(-20000, 'В картці клієнта не заповнено поле "Вулиця, дім, кв."', true);
  end;

  -- 18. office
  begin
    select substr(value,1,25) into l_value.office from customerw
    where rnk=l_cust.rnk and tag='WORK ' and value is not null;
  exception when no_data_found then
    raise_application_error(-20000, 'В картці клієнта не заповнено поле "Місце роботи, посада"', true);
  end;

  -- 19. phone_w
  l_value.phone_w := '*';

  -- 20. cntry_w
  l_value.cntry_w := '*';

  -- 21. pcode_w
  l_value.pcode_w := null;

  -- 22. city_w
  l_value.city_w := '*';

  -- 23. street_w
  l_value.street_w := '*';

  -- 24. min_bal
  l_value.min_bal := 0;
  -- 25. deposit
  l_value.deposit := to_number(bpk_tip_psys(l_acc.tip, l_acc.kv, p_kv, 3));

  -- 26. resident
  l_value.resident := case l_cust.codcagent
                        when 5 then 1
                        else 0
                      end;

  -- 27. name
  l_value.name := substr(l_cust.nmkv, 1, 24);

  -- 28. id_c
  l_value.id_c := substr(l_person.ser||' '||l_person.numdoc, 1, 14);

  -- 29. b_date
  l_value.b_date := null;

  -- 30. m_name
  l_value.m_name := '***';

  -- 31. mt
  l_value.mt := substr(l_person.teld, 1, 10);

  --
  -- вставляем запись во временную таблицу
  insert into tmp_demand_odb values l_value;
end demand_make_odb_dbf;
/
show err;

PROMPT *** Create  grants  DEMAND_MAKE_ODB_DBF ***
grant EXECUTE                                                                on DEMAND_MAKE_ODB_DBF to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DEMAND_MAKE_ODB_DBF to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DEMAND_MAKE_ODB_DBF.sql =========*
PROMPT ===================================================================================== 
