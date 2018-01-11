PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ADM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль ADM ***
declare
  l_mod  varchar2(3) := 'ADM';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Администрирование', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Profile %s not found', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Профиль %s не найден', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Профіль %s не існує', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Incorrect profiles synchronization type', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Неверный тип синхронизации профилей', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Невірний тип синхронізації профілів', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Incorrect profiles synchronization action type', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Неверный тип действия синхронизации профилей', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Невірний тип дії синхронізації профілів', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Profile %s already exists', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Профиль %s уже существует', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Профіль %s вже існує', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Password authentification function %s not found', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Функция проверки пароля %s не найдена', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Функцію перевірки пароля %s не знайдено', '', 1, '5');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'Impossible drop remote database user', '', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Нельзя удалить пользователя удаленной базы данных', '', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Неможливо видалити користувача віддаленої бази даних', '', 1, '6');

    bars_error.add_message(l_mod, 7, l_exc, l_geo, 'Record not found!', '', 1, 'RECORD_NOT_FOUND');
    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Запись не найдена!', '', 1, 'RECORD_NOT_FOUND');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Запис не знайдено!', '', 1, 'RECORD_NOT_FOUND');

    bars_error.add_message(l_mod, 8, l_exc, l_geo, 'User with ID %s not found', '', 1, 'USER_NOT_FOUND');
    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Пользователь с ид. %s не найден', '', 1, 'USER_NOT_FOUND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Користувача з ід. %s не знайдено', '', 1, 'USER_NOT_FOUND');

    bars_error.add_message(l_mod, 9, l_exc, l_geo, 'User not account manager', '', 1, 'USER_NOT_ACCOWN');
    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Пользователь не является ответ.исполнителем', '', 1, 'USER_NOT_ACCOWN');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Користувач не є відпов. виконавцем', '', 1, 'USER_NOT_ACCOWN');

    bars_error.add_message(l_mod, 10, l_exc, l_geo, 'Impossible drop user %s', '', 1, 'NO_DELETE_THIS_USER');
    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Удаление пользователя %s невозможно', '', 1, 'NO_DELETE_THIS_USER');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Видалення користувача %s неможливе', '', 1, 'NO_DELETE_THIS_USER');

    bars_error.add_message(l_mod, 11, l_exc, l_geo, 'Impossible drop remote branch user', '', 1, 'DELETE_REMOTE_BRANCH_USER');
    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Удаление пользователя удаленного отделения невозможно', '', 1, 'DELETE_REMOTE_BRANCH_USER');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Видалення користувача віддаленого відділення неможливе', '', 1, 'DELETE_REMOTE_BRANCH_USER');

    bars_error.add_message(l_mod, 12, l_exc, l_geo, 'Sign "account manager" set incorrectly', '', 1, 'INVALID_USERTYPE_PARAMETER');
    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Неверно задан признак ответ. исполнителя', '', 1, 'INVALID_USERTYPE_PARAMETER');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Невірно задана ознака відпов. виконавця', '', 1, 'INVALID_USERTYPE_PARAMETER');

    bars_error.add_message(l_mod, 13, l_exc, l_geo, 'Sign "settle"/"forbid" set incorrectly', '', 1, 'INVALID_GRANT_PARAM');
    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Неверно указан признак разрешить/запретить', '', 1, 'INVALID_GRANT_PARAM');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Невірно вказана ознака дозволити/заборонити', '', 1, 'INVALID_GRANT_PARAM');

    bars_error.add_message(l_mod, 14, l_exc, l_geo, 'Droping user %s is denied', '', 1, 'CANT_DELETE_SPECIAL_USER');
    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Удаление пользователя %s запрещено', '', 1, 'CANT_DELETE_SPECIAL_USER');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Видалення користувача %s заборонено', '', 1, 'CANT_DELETE_SPECIAL_USER');

    bars_error.add_message(l_mod, 15, l_exc, l_geo, 'Impossible create user - licenses limit is attained', '', 1, 'USERLIMIT_EXCEED');
    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Невозможно создать пользователя - достигнут предел лицензий', '', 1, 'USERLIMIT_EXCEED');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Неможливо створити користувача - досягнуто ліміт ліцензій', '', 1, 'USERLIMIT_EXCEED');

    bars_error.add_message(l_mod, 16, l_exc, l_geo, 'User with ID %s already exists', '', 1, 'USER_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Пользователь с ид. %s уже существует', '', 1, 'USER_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Користувач з ід. %s вже існує', '', 1, 'USER_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 17, l_exc, l_geo, 'Сurrent user not permitted to do this, granting or revoking was done by this account', '', 1, 'NOTPERMITED_WITH_THIS_USER');
    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Даное действие не может быть выполнено текущим пользователем, поскольку от его имени было выполнено выдачу/аннулироование данного ресурса', '', 1, 'NOTPERMITED_WITH_THIS_USER');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Дана дія не може бути виконана поточним користувачем, оскільки від його імені було виконано видачу/аннулювання данного ресурсу', '', 1, 'NOTPERMITED_WITH_THIS_USER');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Некорректный тип данных %s для параметра %s. Должен быть из справочника meta_coltypes', '', 1, 'NOT_CORRECT_PARAM_TYPE');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Некоректний тип даних %s для параметру %s. ДПовинен бути із довідника meta_coltypes', '', 1, 'NOT_CORRECT_PARAM_TYPE');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Некорректное значение параметра функции <редактируемый> для параметра %s. Должен быть 1 или 0', '', 1, 'NOT_CORRECT_EDITABLE_VALUE');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Некоректне значення параметру функції <редагування> для параметру %s. Повинно бути 1 або 0', '', 1, 'NOT_CORRECT_EDITABLE_VALUE');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Некорректное значение параметра функции <для архивации> для параметра %s. Должен быть 1 или 0', '', 1, 'NOT_CORRECT_ARCH_VALUE');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Некоректне значення параметру функції <для архівації> для параметру %s. Повинно бути 1 або 0', '', 1, 'NOT_CORRECT_ARCH_VALUE');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Не существует АРМ-а с кодом %s.', '', 1, 'NO_SUCH_ARM');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Не існує такого АРМ-у з кодом  %s. ', '', 1, 'NO_SUCH_ARM');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не существует функции с кодом %s.', '', 1, 'NO_SUCH_FUNCID');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Не існує такої функції з кодом  %s. ', '', 1, 'NO_SUCH_FUNCID');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ADM.sql =========*** Run *** ==
PROMPT ===================================================================================== 
