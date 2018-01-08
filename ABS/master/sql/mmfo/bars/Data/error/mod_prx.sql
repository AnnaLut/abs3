PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_PRX.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль PRX ***
declare
  l_mod  varchar2(3) := 'PRX';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'ПРАВЭКС', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Для операций зачислений на карту в TransMaster Реф=%s не найден доп.реквизит %s - номер технического карточного счета!', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Для операцій зарахувань на карту в TransMaster Реф=%s не знайдено доп.реквізит %s - номер технічного карткового рахунку!', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Найденая сума операции в OPER не совпадает с суммой проводки в OPLDOK!', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Знайдена сума операції в OPER не співпадає з сумою проводки в OPLDOK!', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Найденый код валюты в OPER не совпадает с кодом в OPLDOK!', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Знайдений код валюти в OPER не співпадає з кодом в OPLDOK!', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Отсутствует параметр %s - Транзитный счет в ОДБ Oracle для зачисления в TransMaster!', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Відсутній параметр %s - Транзитний рахунок в ОДБ Oracle для зарахувань в TransMaster!', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Операция не сбалансирована! Возможно операция не доплачена по стороне в другом банке!', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Операція не збалансована! Можливо операція не доплачена по стороні в іншому банку!', '', 1, '5');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Работать в банковском дне, меньшем чем банковский день ОДБ Oracle, запрещено!', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Працювати в банківському дні, меншому за банківський день ОДБ Oracle, заборонено!', '', 1, '10');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_PRX.sql =========*** Run *** ==
PROMPT ===================================================================================== 
