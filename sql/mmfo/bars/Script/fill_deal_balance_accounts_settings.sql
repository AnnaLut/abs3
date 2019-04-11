/*
balance|                                                                                                                           | ob22 |Currency|
2600   |  2600 Кошти на вимогу суб`єктів господарювання                                                                            |  16  |        |  16 - вклад «Вклад на вимогу для клієнтів мікро, малого та середнього бізнесу».
2608   |  2608 Нараховані витрати за коштами на вимогу суб`єктів господарювання                                                    |  29  |        |  29 - за вкладами «Вклад на вимогу для клієнтів мікро, малого та середнього бізнесу».
2610   |  2610 Строкові вклади (депозити) суб`єктів господарювання                                                                 |  34  |        |  34 - вклад (депозит) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу»
2618   |  2618 Нараховані витрати за строковими коштами суб`єктів господарювання                                                   |  42  |        |  42 - за вкладами (депозитами) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу».
2650   |  2650 "Кошти на вимогу небанківських фінансових установ"                                                                  |  14  |        |  14 - вклад «Вклад на вимогу для клієнтів мікро, малого та середнього бізнесу».
2651   |  2651 "Строкові вклади (депозити) небанківських фінансових установ"                                                       |  31  |        |  31 - вклад (депозит) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу».
2658   |  2658 "Нараховані витрати за коштами небанківських фінансових установ "                                                   |  49  |        |  49 - за вкладами «Вклад на вимогу для клієнтів мікро, малого та середнього бізнесу»;
2658   |  2658 "Нараховані витрати за коштами небанківських фінансових установ "                                                   |  50  |        |  50 - за вкладами (депозитами) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу».
6350   |  6350 "Дохід від припинення визнання фінансових зобов`язань"                                                              |  M1  |   980  |  M1 - операційні доходи від перерахування процентів за вкладами (депозитами) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу» у національній валюті;
6350   |  6350 "Дохід від припинення визнання фінансових зобов`язань"                                                              |  M2  |        |  M2 - операційні доходи від перерахування процентів за вкладами (депозитами) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу» в іноземній валюті.
7020   |  7020 "Процентні витрати за коштами на вимогу суб`єктів господарювання, які обліковуються за амортизованою собівартістю " |  52  |   980  |  52 - за вкладами ««Вклад на вимогу для клієнтів мікро, малого та середнього бізнесу» у національній валюті (рахунок 2600);
7020   |  7020 "Процентні витрати за коштами на вимогу суб`єктів господарювання, які обліковуються за амортизованою собівартістю " |  53  |        |  53 - за вкладами ««Вклад на вимогу для клієнтів мікро, малого та середнього бізнесу» в іноземній валюті (рахунок 2600).
7021   |  7021 "Процентні витрати за строковими коштами суб`єктів господарювання, які обліковуються за амортизованою собівартістю "|  A8  |   980  |  A8 - за вкладами (депозитами) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу» у національній валюті (рахунок 2610);
7021   |  7021 "Процентні витрати за строковими коштами суб`єктів господарювання, які обліковуються за амортизованою собівартістю "|  A9  |        |  A9 - за вкладами (депозитами) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу» в іноземній  валюті (рахунок 2610).
7070   |  7070 "Процентнi витрати за коштами на вимогу небанківських фінансових установ"                                           |  26  |   980  |  26 - за вкладами ««Вклад на вимогу для клієнтів мікро, малого та середнього бізнесу» у національній валюті (рахунок 2650);
7070   |  7070 "Процентнi витрати за коштами на вимогу небанківських фінансових установ"                                           |  27  |        |  27 - за вкладами ««Вклад на вимогу для клієнтів мікро, малого та середнього бізнесу» в іноземній валюті (рахунок 2650).
7071   |  7071 "Процентнi витрати за строковими коштами небанківських фінансових установ"                                          |  85  |   980  |  85 - за вкладами (депозитами) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу» у національній валюті (рахунок 2651);
7071   |  7071 "Процентнi витрати за строковими коштами небанківських фінансових установ"                                          |  86  |        |  86 - за вкладами (депозитами) «Строковий депозит для клієнтів мікро, малого та середнього бізнесу» в іноземній  валюті (рахунок 2651).
*/

declare
    l_tranche_product           number;
    l_on_demand_product         number;
    l_group_on_demand_companies number := 4; -- list_item_code = CURRENT_ACCOUNTS_FOR_COMPANIES
    l_group_on_demand_nonbank   number := 7; -- list_item_code = CURR_ACC_FOR_NONBANK_FIN_INST
    l_group_tranche_companies   number := 5; -- list_item_code = DEPOSIT_FOR_COMPANIES
    l_group_tranche_nonbank     number := 8; -- list_item_code = DEPOSIT_FOR_NONBANK_FIN_INST
    l_data                      clob;
    l_qty                       number;
    l_kf                        varchar2(10) := nvl(bc.current_mfo, '/');
begin
    -- если меняются ob22 то нужно проапдейтить accounts для 2600, 2610, 2650, 2651, 2608, 2618, 2658
    select xmlelement("ROOT",
            xmlagg( 
             xmlelement("BALANCE"
               ,xmlelement("AccountCodeId", b.account_type_id)
               ,xmlelement("GroupId", b.deal_group_id)
               ,xmlelement("CurrencyId", b.currency_id)
               ,xmlelement("ProductId", b.product_id)
               ,xmlelement("BalanceAccount", b.balance_account)
               ,xmlelement("OB22Code", b.ob22_code)
              ))).getClobVal() k, count(*)
      into l_data, l_qty
      from deal_balance_account_settings b
          ,attribute_kind a
     where b.account_type_id = a.id
       and b.balance_account in ('2600', '2610', '2650', '2651', '2608', '2618', '2658');
    -- удаляем старые данные
    delete from deal_balance_account_settings;
    -- ***
    -- обработка новых данных
    l_tranche_product   := product_utl.get_product_id('SMB_DEPOSIT_TRANCHE', 'SMB_DEPOSIT_TRANCHE');
    l_on_demand_product := product_utl.get_product_id('SMB_DEPOSIT_ON_DEMAND', 'SMB_DEPOSIT_ON_DEMAND');
    
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                  ,p_deal_group_id => l_group_on_demand_companies
                                  ,p_currency_id => null
                                  ,p_product_id => l_on_demand_product
                                  ,p_balance_account => '2600'
                                  ,p_ob22_code => '16');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_ACCOUNT'
                                  ,p_deal_group_id => l_group_on_demand_companies
                                  ,p_currency_id => null
                                  ,p_product_id => l_on_demand_product
                                  ,p_balance_account => '2608'
                                  ,p_ob22_code => '29');

    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_companies
                                  ,p_currency_id => null
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '2610'
                                  ,p_ob22_code => '34');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_companies
                                  ,p_currency_id => null
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '2618'
                                  ,p_ob22_code => '42');
    
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                  ,p_deal_group_id => l_group_on_demand_nonbank
                                  ,p_currency_id => null
                                  ,p_product_id => l_on_demand_product
                                  ,p_balance_account => '2650'
                                  ,p_ob22_code => '14');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_ACCOUNT'
                                  ,p_deal_group_id => l_group_on_demand_nonbank
                                  ,p_currency_id => null
                                  ,p_product_id => l_on_demand_product
                                  ,p_balance_account => '2658'
                                  ,p_ob22_code => '49');

    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_nonbank
                                  ,p_currency_id => null
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '2651'
                                  ,p_ob22_code => '31');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_nonbank
                                  ,p_currency_id => null
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '2658'
                                  ,p_ob22_code => '50');

--     6350 -- штрафы
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_companies
                                  ,p_currency_id => 980
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '6350'
                                  ,p_ob22_code => 'M1');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_companies
                                  ,p_currency_id => null
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '6350'
                                  ,p_ob22_code => 'M2');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_nonbank
                                  ,p_currency_id => 980
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '6350'
                                  ,p_ob22_code => 'M1');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_nonbank
                                  ,p_currency_id => null
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '6350'
                                  ,p_ob22_code => 'M2');
    
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_on_demand_companies
                                  ,p_currency_id => 980
                                  ,p_product_id => l_on_demand_product
                                  ,p_balance_account => '7020'
                                  ,p_ob22_code => '52');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_on_demand_companies
                                  ,p_currency_id => null
                                  ,p_product_id => l_on_demand_product
                                  ,p_balance_account => '7020'
                                  ,p_ob22_code => '53');
    
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_companies
                                  ,p_currency_id => 980
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '7021'
                                  ,p_ob22_code => 'A8');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_companies
                                  ,p_currency_id => null
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '7021'
                                  ,p_ob22_code => 'A9');
    
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_on_demand_nonbank
                                  ,p_currency_id => 980
                                  ,p_product_id => l_on_demand_product
                                  ,p_balance_account => '7070'
                                  ,p_ob22_code => '26');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_on_demand_nonbank
                                  ,p_currency_id => null
                                  ,p_product_id => l_on_demand_product
                                  ,p_balance_account => '7070'
                                  ,p_ob22_code => '27');
    
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id => l_group_tranche_nonbank
                                  ,p_currency_id => 980
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '7071'
                                  ,p_ob22_code => '85');
    deal_utl.set_deal_balance_acc_settings(
                                   p_account_type_code  => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT'
                                  ,p_deal_group_id      => l_group_tranche_nonbank
                                  ,p_currency_id => null
                                  ,p_product_id => l_tranche_product
                                  ,p_balance_account => '7071'
                                  ,p_ob22_code => '86');
                                  
    if l_qty > 0 then
        -- обновляем accounts 
        for i in (select * from mv_kf) loop
            bc.go(i.kf);
            for j in (
                with old_balance_settings as(
                    select y.*
                      from xmlTable('/ROOT/BALANCE' passing xmltype(l_data) columns
                                    account_type_id    number       path 'AccountCodeId'
                                   ,deal_group_id      number       path 'GroupId'
                                   ,currency_id        number       path 'CurrencyId'
                                   ,product_id         number       path 'ProductId'
                                   ,balance_account    varchar2(10) path 'BalanceAccount'
                                   ,ob22_code          varchar2(10) path 'OB22Code'
                                                                 ) y)
                        select distinct
                               a.acc, a.nls
                              ,b.balance_account
                              ,b.deal_group_id
                              ,b.product_id
                              ,b.ob22_code new_ob22_code
                              ,o.ob22_code old_ob22_code
                          from deal_balance_account_settings b
                              ,old_balance_settings o
                              ,accounts a
                              ,deal_account da
                              ,smb_deposit dpt
                              ,deal d    
                         where b.account_type_id = o.account_type_id
                           and b.deal_group_id = o.deal_group_id
                           and b.balance_account = o.balance_account
                           and b.product_id = o.product_id
                           and nvl(b.currency_id, -2) = nvl(o.currency_id, -2)
                           and b.balance_account in ('2600', '2610', '2650', '2651', '2608', '2618', '2658')
                           and b.balance_account = a.nbs
                           and o.ob22_code = a.ob22 
                           and a.acc = da.account_id
                           and da.deal_id = dpt.id 
                           and dpt.id = d.id
                           and b.product_id = d.product_id) loop
                   update accounts a set
                       ob22 = j.new_ob22_code
                     where a.acc = j.acc;
              end loop;             
         end loop;
    end if;
    commit;
end;
/
