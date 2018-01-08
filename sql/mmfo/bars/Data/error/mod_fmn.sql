PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_FMN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль FMN ***
declare
  l_mod  varchar2(3) := 'FMN';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Фин.мониторинг', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Не установлен параметр $(PAR)', '', 1, 'FM_PARAM_NOT_SET');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Не встановлено параметр $(PAR)', '', 1, 'FM_PARAM_NOT_SET');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Неизвестный параметр $(PAR) для правила', '', 1, 'FM_PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Нев?домий параметр $(PAR) для правила', '', 1, 'FM_PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Запрещено редактирование последней пары значений «рівень ризику», «дата встановлення»!', '', 1, 'FM_PARAM_NOT_EDIT');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Заборонено редагування останньої пари значень «рівень ризику», «дата встановлення»!', '', 1, 'FM_PARAM_NOT_EDIT');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Проверьте, не заполнено поле «дата встановлення»!', '', 1, 'FM_PARAM_NOT_FILLED_DT');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Перевірте, не заповнене поле «дата встановлення»!', '', 1, 'FM_PARAM_NOT_FILLED_DT');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Проверьте, значение «дати встановлення» должно быть больше или равно дате создания карточки клиента и меньше даты последнего изменения уровня риска, и не больше 01.01.2012 г.', '', 1, 'FM_PARAM_INCORREC_DATE');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Перевірте, значення «дати встановлення» має бути більшим або рівним дати створення картки клієнта та меншим дати останньої зміни рівня ризику, та не перевищувати 01.01.2012 р.', '', 1, 'FM_PARAM_INCORREC_DATE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_FMN.sql =========*** Run *** ==
PROMPT ===================================================================================== 
