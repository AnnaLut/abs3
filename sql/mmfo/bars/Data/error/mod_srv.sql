PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SRV.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль SRV ***
declare
  l_mod  varchar2(3) := 'SRV';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Анкеты клиентов', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'недопустимо заполнение анкеты № %s клиентом с РНК = %s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'неприпустимо заповнення анкети № %s клієнтом з РНК = %s', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'некорректно задан флаг отказа от анкетирования (%s)', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'некоректно заданий флаг відмови від анкетування (%s)', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'SURVEY(start_session): %s', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'SURVEY(start_session): %s', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Не найдена сессия анкетирования №%s', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Не знайдено сесію анкетування №%s', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не найден вопрос №%s', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не знайдено питання №%s', '', 1, '5');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Несоответствие анкет для сессии и вопроса', '', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Невідповідність анкет для сесії і питання', '', 1, '6');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Клиент отказался от анкетирования', '', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Клієнт відмовився від анкетування', '', 1, '7');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Не найден вариант ответа № %s на вопрос №%s', '', 1, '8');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Не знайдено варіант відповіді № %s на питання №%s', '', 1, '8');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Не соблюдено требование однозначности ответа на вопрос №%s', '', 1, '9');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Не дотримана вимога однозначності відповіді на питання №%s', '', 1, '9');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Ошибка записи ответа на вопрос №%s : %s', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Помилка запису відповіді на питання №%s : %s', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Вопрос № %s не существует или не соответствует анкете № %s', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Питання № %s не існує або не відповідає анкеті № %s', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Некорректно задан формат родительского вопроса № %s', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Некоректно задано формат родительского питаня № %s', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Ответ № %s не существует или не соответствует вопросу № %s', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Відповідь № %s не існує або не відповідає питанню № %s', '', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Сессия № %s уже закрыта', '', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Сесію № %s вже закрито', '', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Ошибка при закрытии сессии № %s', '', 1, '15');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Помилка при закритті сесії № %s', '', 1, '15');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SRV.sql =========*** Run *** ==
PROMPT ===================================================================================== 
