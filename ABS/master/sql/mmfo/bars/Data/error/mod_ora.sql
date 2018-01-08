PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ORA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль ORA ***
declare
  l_mod  varchar2(3) := 'ORA';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Oracle', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Вставляемая запись не соответствует требованиям уникальности', 'Введите уникальные данные', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Рядок, що додається не відповідає вимогам унікальності', 'Спробуйте ввести інші дані', 1, '1');

    bars_error.add_message(l_mod, 1400, l_exc, l_rus, 'Некоторые из обязательных полей пустые', '', 1, '1400');
    bars_error.add_message(l_mod, 1400, l_exc, l_ukr, 'Не всі обов''язкові поля заповнено', '', 1, '1400');

    bars_error.add_message(l_mod, 2291, l_exc, l_rus, 'Попытка создать запись с несуществующим ключевым значением связанного справочника', 'Введите правильное значение ключа.', 1, '2291');
    bars_error.add_message(l_mod, 2291, l_exc, l_ukr, 'Спроба додавання неіснуючого ключового значення підпорядкованого довідника.', 'Оберіть правильне значення ключа.', 1, '2291');

    bars_error.add_message(l_mod, 20000, l_exc, l_rus, 'Нет соединения с сервером (-20000)', '', 1, 'MISSING_CONNECTION_20000');
    bars_error.add_message(l_mod, 20000, l_exc, l_ukr, 'Відсутнє з''єднання з сервером (-20000)', '', 1, 'MISSING_CONNECTION_20000');

    bars_error.add_message(l_mod, 20097, l_exc, l_rus, 'Нет соединения с сервером (-20097)', '', 1, 'MISSING_CONNECTION');
    bars_error.add_message(l_mod, 20097, l_exc, l_ukr, 'Відсутнє з''єднання з сервером (-20097)', '', 1, 'MISSING_CONNECTION');

    bars_error.add_message(l_mod, 31011, l_exc, l_rus, 'Нет соединения с сервером (-31011)', '', 1, 'MISSING_CONNECTION_W');
    bars_error.add_message(l_mod, 31011, l_exc, l_ukr, 'Відсутнє з''єднання з сервером (-31011)', '', 1, 'MISSING_CONNECTION_W');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ORA.sql =========*** Run *** ==
PROMPT ===================================================================================== 
