PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль BL ***
declare
  l_mod  varchar2(3) := 'BL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Черный список', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Ошибка не определена! %s ', '', 1, 'BL_ERROR_UNKNOWN');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Помилка не визначена! %s ', '', 1, 'BL_ERROR_UNKNOWN');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'При вставке данных была обнаружена строка с идентичным идентификатором! %s %s ', '', 1, 'BL_ERROR_SEQUENCE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'При вставці даних був виявлений рядок з ідентичним ідентифікатором! %s %s', '', 1, 'BL_ERROR_SEQUENCE');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Не указан идентификатор %s!', '', 1, 'BL_ERROR_PRIMARY_KEY');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Не вказан ідентифікатор %s!', '', 1, 'BL_ERROR_PRIMARY_KEY');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не заполнен идентификатор при указании внешнего источника данных! %s ', '', 1, 'BL_ERROR_OUT_PRIMARY_KEY');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не вказан ідентифікатор при вказівці зовнішнього джерела даних! %s ', '', 1, 'BL_ERROR_OUT_PRIMARY_KEY');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Для лица с кодом ЄДРПОУ № %s  не заполнена Фамилия!', '', 1, 'BL_PRFM_NULL');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Для особи з кодом ЄДРПОУ № %s  не заповнено Призвище!', '', 1, 'BL_PRFM_NULL');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Для лица с кодом ЄДРПОУ № %s  не заполнено Имя!', '', 1, 'BL_PRIM_NULL');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Для особи з кодом ЄДРПОУ № %s  не заповнено Iм`я!', '', 1, 'BL_PRIM_NULL');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Не корректно задана серия паспорта! %s', '', 1, 'BL_PASS_SER_POOR');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Невірно заповнена серiя паспорта! %s', '', 1, 'BL_PASS_SER_POOR');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Не корректно задан номер паспорта! %s', '', 1, 'BL_PASS_NUM_POOR');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Невірно заповнен номер паспорта! %s', '', 1, 'BL_PASS_NUM_POOR');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Для лица с кодом ЄДРПОУ № %s  не заполнена "Дата рождения"!', '', 1, 'BL_BDAY_NULL');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Для особи з кодом ЄДРПОУ № %s  не заповнена "Дата народження"!', '', 1, 'BL_BDAY_NULL');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Для лица с кодом ЄДРПОУ № %s некорректно задана  "Дата рождения"!', '', 1, 'BL_BDAY_CHANGE');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Для особи з кодом ЄДРПОУ № %s некоректно задана "Дата народження"!', '', 1, 'BL_BDAY_CHANGE');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Для %s %s %s введен неверный код ЄДРПОУ № %s !', '', 1, 'BL_BAD_OKPO');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Для %s %s %s заповнен помилковий код ЄДРПОУ № %s !', '', 1, 'BL_BAD_OKPO');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Не заполнена Фамилия!', '', 1, 'BL_PRFM_NULL_SHOT');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Не заповнено Призвище!', '', 1, 'BL_PRFM_NULL_SHOT');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Не заполнено Имя!', '', 1, 'BL_PRIM_NULL_SHOT');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Не заповнено Iм`я!', '', 1, 'BL_PRIM_NULL_SHOT');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не корректно задана серия паспорта! %s', '', 1, 'BL_PASS_SER_POOR_SHOT');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Невірно заповнена серiя паспорта! %s', '', 1, 'BL_PASS_SER_POOR_SHOT');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Не корректно задан номер паспорта! %s', '', 1, 'BL_PASS_NUM_POOR_SHOT');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Невірно заповнен номер паспорта! %s', '', 1, 'BL_PASS_NUM_POOR_SHOT');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Не заполнена "Дата рождения"!', '', 1, 'BL_BDAY_NULL_SHOT');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Не заповнена "Дата народження"!', '', 1, 'BL_BDAY_NULL_SHOT');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Некорректно задана  "Дата рождения"!', '', 1, 'BL_BDAY_CHANGE_SHOT');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Некоректно задана "Дата народження"!', '', 1, 'BL_BDAY_CHANGE_SHOT');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Введен неверный код ЄДРПОУ № %s !', '', 1, 'BL_BAD_OKPO_SHOT');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Заповнен помилковий код ЄДРПОУ № %s !', '', 1, 'BL_BAD_OKPO_SHOT');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'При постановке лица в блок лист, найдены незаполненные следующие поля:  %s !', '', 1, 'BL_NULL_FIELDS');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'При постановці особи в блок лист , знайдені незаповнені наступні поля: %s !', '', 1, 'BL_NULL_FIELDS');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BL.sql =========*** Run *** ===
PROMPT ===================================================================================== 
