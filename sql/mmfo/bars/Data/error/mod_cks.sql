PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CKS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль CKS ***
declare
  l_mod  varchar2(3) := 'CKS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Центральная кредитная система', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Не получена сессия для анкеты', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Не отримано сесiю для анкети', '', 1, '1');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не найден кл с указаным РНК', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не знайдено кл. з указаним РНК', '', 1, '5');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Договор не найден.', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Договір не знайдено.', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Запуcк процедуры должен выполнятьcя только пользователем отделения.', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Виклик процедури повинен виконуватися тільки користувачем відділення.', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Запроc не найден.', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Запит не знайдено.', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'У клиента неудовлетворительное финансовае состояние.', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Кліент має незадовільний фінансовий стан.', '', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Ид.код ФЛ не соотв. дате рождения.', '', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Iд.код ФО не вiдпов. датi народження.', '', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'НЕжелательный Клиент.', '', 1, '15');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'НЕбажаний Клiєнт.', '', 1, '15');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'НЕреальный возраст заемщика.', '', 1, '16');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'НЕреальний вiк позичальника.', '', 1, '16');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Количество детей д.б. >=0', '', 1, '17');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Кiлькiсть дiтей має бути >=0', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Нереальный срок проживания', '', 1, '18');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Нереальний термiн проживання', '', 1, '18');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Нереальный срок стажа.', '', 1, '19');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Нереальний термiн стажу.', '', 1, '19');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Начальная Сумма кредита д.б. >0.', '', 1, '20');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Початкова Сума кредиту має бути >0.', '', 1, '20');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Cумма кредита (грн) больше MAX-допустимой.', '', 1, '21');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Cума кредиту (грн) бiльше MAX-допустимої.', '', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'НЕреальный срок кредита.', '', 1, '22');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'НЕреальний термiн кредиту.', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Срок кредита больше MAX-допустимого.', '', 1, '23');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Термiн кредиту бiльше MAX-допустимого.', '', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Чистый доход <= 0.', '', 1, '24');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Чистий дохiд <= 0.', '', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'НЕкорректное ФИО.', '', 1, '25');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'НЕкоректне ПIБ.', '', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'НЕкорректные реквизиты док.', '', 1, '26');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'НЕкоректнi реквизити док.', '', 1, '26');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Пл.инструк:ош.ОКПО.', '', 1, '27');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Пл.iнструк:пом.ЗКПО.', '', 1, '27');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Пл.инструк:ош.МФО.', '', 1, '28');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Пл.iнструк:пом.МФО.', '', 1, '28');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Пл.инструк:ош.счет.', '', 1, '29');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Пл.iнструк:пом.рах.', '', 1, '29');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Ош.код валюты.', '', 1, '30');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Помилк.код валюти.', '', 1, '30');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Ош.описания операции ZAL', '', 1, '31');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Помилка опису операцiї ZAL', '', 1, '31');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Пл.инструк:ош.получатель.', '', 1, '32');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Пл.iнструк:пом.отримувач.', '', 1, '32');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CKS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
