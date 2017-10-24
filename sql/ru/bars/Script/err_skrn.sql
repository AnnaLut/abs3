PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SKR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль SKR ***
declare
  l_mod  varchar2(3) := 'SKR';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Депозитні скриньки', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'skrn.p_tariff: Ошибочные даты аренди (начало: %s, окончание: %s).', '', 1, 'RENT_DATE_INCORRECT');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'skrn.p_tariff: Помилкові дати оренди (початок: %s, завершення: %s).', '', 1, 'RENT_DATE_INCORRECT');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'skrn.p_tariff: Тариф (код = %s) не найден (отсутствует в справочнике, дата ввода больше текущей, неправильно заполнен).', '', 1, 'TARIF_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'skrn.p_tariff: Тариф (код = %s) не знайдено (відсутній у довіднику, дата вводу більша за поточну, некоректно заповнений)', '', 1, 'TARIF_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'skrn.p_oper_zalog: Нулевая сумма залога по сейфу сист. № = %s.', '', 1, 'ZERO_BAIL_SUM');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'skrn.p_oper_zalog: Нульова сума застави по сейфу сист. № = %s.', '', 1, 'ZERO_BAIL_SUM');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'skrn.p_oper_zalog: Ключ выдан по сейфу сист. № = %s.', '', 1, 'KEY_GIVEN');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'skrn.p_oper_zalog: Ключ виданий по сейфу сист. № = %s.', '', 1, 'KEY_GIVEN');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'skrn.p_oper_zalog: Ключ возвращен по сейфу сист. № = %s.', '', 1, 'KEY_RETURNED');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'skrn.p_oper_zalog: Ключ вже повернуто по сейфу сист. № = %s.', '', 1, 'KEY_RETURNED');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'skrn.p_oper_arenda: Нулевая арендная плата по договору сист. № = %s.', '', 1, 'ZERO_RENT');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'skrn.p_oper_arenda: Нульова орендна плата по договору сист. № = %s.', '', 1, 'ZERO_RENT');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'skrn.p_oper_arenda_period: Нулевая арендная плата по договору сейф сист. № = %s.', '', 1, 'ZERO_RENT_SKR');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'skrn.p_oper_arenda_period: Нульова орендна плата по договору сейф сист. № = %s.', '', 1, 'ZERO_RENT_SKR');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'skrn.p_dep_skrn: Соглашение сист. № = %s не найдено или уже закрыто.', '', 1, 'DEAL_CLOSED_ND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'skrn.p_dep_skrn: Угода сист. № = %s не знайдена або вже закрита.', '', 1, 'DEAL_CLOSED_ND');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'skrn.p_dep_skrn: Не найдено активных соглашений по сейфу сист. № = %s.', '', 1, 'DEAL_CLOSED_NSK');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'skrn.p_dep_skrn: Не знайдено активних угод по сейфу сист. № = %s.', '', 1, 'DEAL_CLOSED_NSK');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'skrn.p_dep_skrn: Не найдено сейф сист. № = %s.', '', 1, 'SAFE_NOT_FOUND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'skrn.p_dep_skrn: Не знайдено сейф сист. № = %s.', '', 1, 'SAFE_NOT_FOUND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'skrn.p_dep_skrn: Не найден счет %s.', '', 1, 'ACCOUNT_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'skrn.p_dep_skrn: Не знайдено рахунок %s.', '', 1, 'ACCOUNT_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'skrn.p_dep_skrn: Сейф сист. № %s закрывать нельзя. Есть остаток на счете залога.', '', 1, 'BAIL_NOT_EMPTY');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'skrn.p_dep_skrn: Сейф сист. № %s закривати не можна. Є залишок на рахунку застави.', '', 1, 'BAIL_NOT_EMPTY');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'skrn.p_dep_skrn: Невозможно закрыть соглашение по сейфу сист. № %s. Ключ не был возвращен.', '', 1, 'KEY_NOT_RETURNED');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'skrn.p_dep_skrn: Неможливо закрити угоду по сейфу сист. № %s. Потрібно повернути ключ.', '', 1, 'KEY_NOT_RETURNED');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'skrn.p_dep_skrn: Код операции %s неопределен.', '', 1, 'MOD_NOT_FOUND');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'skrn.p_dep_skrn: Код операції %s невизначений.', '', 1, 'MOD_NOT_FOUND');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'skrn.init: Параметр %s не найден.', '', 1, 'PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'skrn.init: Параметр %s не знайдено.', '', 1, 'PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Невозможно закрыть счет 3600* по договору (сейф сист. №%s). У него ненулевые остатки или дата последнего движения не меньше текущей банковской даты.', '', 1, 'CANNOT_CLOSE_ACCOUNT_SKRN');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Неможливо закрити рахунок 3600* по договору (сейф сист. №%s). У нього ненульові залишки або дата останнього руху не менше поточної банківською датою.', '', 1, 'CANNOT_CLOSE_ACCOUNT_SKRN');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Неверные даты пролонгации по договору №%s', '', 1, 'PROLONG_DATES_ERROR');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Некоректні дати пролонгації по договору №%s', '', 1, 'PROLONG_DATES_ERROR');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Недопустимая операция по импортированому договору №%s', '', 1, 'IMPORTED_MODE_ERROR');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Недопустима операція по імпортованому договору №%s', '', 1, 'IMPORTED_MODE_ERROR');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Счет клиента не заполнено или заполнено неверно для договора №%s', '', 1, 'NOT_NLK_CLIENT');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Рахунок клієнта не заповнено або заповнено не вірно для договору №%s', '', 1, 'NOT_NLK_CLIENT');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Сейф №%s уже существует!', '', 1, 'SKRYNKA_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Скринька №%s вже існує!', '', 1, 'SKRYNKA_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, 'По сейфу №%s существует активный договор №%s!', '', 1, 'SKRYNKA_HAS_ND');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, 'По сейфу №%s існує активний договір №%s!', '', 1, 'SKRYNKA_HAS_ND');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, 'Невозможно закрыть счет acc = %s. У него ненулевые остатки или дата последнего движения не меньше текущей банковской даты.', '', 1, 'CANNOT_CLOSE_ACCOUNT');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, 'Неможливо закрити рахунок acc = %s. У нього ненульові залишки або дата останнього руху не менше поточної банківською датою.', '', 1, 'CANNOT_CLOSE_ACCOUNT');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, 'Невозможно удалить сейф №%s. По нему есть закрытые договора!', '', 1, 'THERE_ARE_CLOSED_ND');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, 'Неможливо видалити сейф №%s. По ньому є закриті договори!', '', 1, 'THERE_ARE_CLOSED_ND');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, 'Не удалось открыть договор по сейфу №%s!', '', 1, 'DEAL_NOT_CREATED');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, 'Не вдалося відкрити договір по сейфу №%s!', '', 1, 'DEAL_NOT_CREATED');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, 'Счет %s(980) уже существует!', '', 1, 'ACCOUNT_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'Рахунок %s(980) вже існує!!', '', 1, 'ACCOUNT_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, 'Уже существует подписаный договор №%s (шаблон %s )!', '', 1, 'DOC_SIGNED');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, 'Вже існує підписаний договір №%s (шаблон %s )!!', '', 1, 'DOC_SIGNED');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, 'Уже существует пролонгированный договор №%s !', '', 1, 'PROLONGED_CONTRACT');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, 'Вже існує пролонгований договір №%s !!', '', 1, 'PROLONGED_CONTRACT');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, 'Не указан номер телефона клиента по сейфу №%s!', '', 1, 'NOT_PHONE_CLIENT');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, 'Не вказаний номер телефона кліента по сейфу №%s!', '', 1, 'NOT_PHONE_CLIENT');
  commit;
end;
/
 show err;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SKR.sql =========*** Run *** ==
PROMPT ===================================================================================== 