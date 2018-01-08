PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_NAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль NAL ***
declare
  l_mod  varchar2(3) := 'NAL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Налоговый учет', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Открыто больше 1 счета НУ с одним P080: %s: %s: %s -> Проверьте справочник <<двойников>>', 'Проверьте справочник <<двойников>>', 1, 'NAL_DUPACCN');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Вiдкрито бiльше 1 рахунка ПО з одним P080: %s: %s: %s ->Перевiрте довiдник <<двiйникiв>>', 'Перевiрте довiдник <<двiйникiв>>', 1, 'NAL_DUPACCN');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Не найдено  МФО', '', 1, 'NAL_OURMFO');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Не знайдено МФО', '', 1, 'NAL_OURMFO');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Нет или закрыт контрсчет для активов (валовые доходы)', '', 1, 'NAL_NU_KS6');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Немає або закрито контррахунок для активiв (валовi доходи)', '', 1, 'NAL_NU_KS6');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Нет или закрыт контрсчет для пасивов (валовые расходы)', '', 1, 'NAL_NU_KS7');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Немає або закрито контррахунок для пасивiв (валовi витрати)', '', 1, 'NAL_NU_KS7');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не задан бал. счет в плане счетов', '', 1, 'NAL_NBS_PS');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не задано бал.рахунок в планi рахункiв', '', 1, 'NAL_NBS_PS');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Не удалось открыть счет', '', 1, 'NAL_ACC_ERR');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Не змогли вiдкрити рахунок', '', 1, 'NAL_ACC_ERR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_NAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 
