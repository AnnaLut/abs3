PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ARC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль ARC ***
declare
  l_mod  varchar2(3) := 'ARC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Архивация данных', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Параметр %s не найден', '', 1, 'PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Параметр %s не знайдений', '', 1, 'PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Ошибка в значении параметра %s', '', 1, 'INVALID_PARAM_VALUE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Помилка в значенні параметру %s', '', 1, 'INVALID_PARAM_VALUE');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Неверно указано состояние области маркирования (состояние %s)', '', 1, 'INVALID_MARKAREA_STATE');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Невірно вказаний стан області маркіровки (стан %s)', '', 1, 'INVALID_MARKAREA_STATE');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Неверно указано новое состояние области маркирования (состояния текущее %s, новое %s)', '', 1, 'INVALID_MARKAREA_NEWSTATE');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Невірно вказаний новий стан області маркіровки (поточний стан %s, новий стан %s)', '', 1, 'INVALID_MARKAREA_NEWSTATE');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Невозможно очистить области маркирования - есть активные процессы', '', 1, 'MARKAREA_BUSY');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Неможливо очистити області маркіровки - є активні процеси', '', 1, 'MARKAREA_BUSY');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Невозможно выполнить операцию при текущем состоянии области маркирования', '', 1, 'INVALID_MARKAREA_CSTATE');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Неможливо виконати операцію при поточному стані області маркіровки', '', 1, 'INVALID_MARKAREA_CSTATE');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Модуль %s не найден', '', 1, 'MODULE_NOT_FOUND');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Модуль %s не знайдений', '', 1, 'MODULE_NOT_FOUND');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Модуль %s уже существует', '', 1, 'MODULE_EXISTS');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Модуль %s вже існує', '', 1, 'MODULE_EXISTS');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Нет прав на выполнение модуля %s', '', 1, 'MODULE_NOT_EXEC');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Немає прав на виконання модуля %s', '', 1, 'MODULE_NOT_EXEC');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Не найдена процедура маркирования для модуля "%s"', '', 1, 'MARKPROC_NOT_FOUND');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Не знайдена процедура маркування для модуля "%s"', '', 1, 'MARKPROC_NOT_FOUND');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Для модуля "%s" не определен ни один объект', '', 1, 'NO_OBJECT_IN_MODULE');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Для модуля "%s" не визначен жодний об''єкт', '', 1, 'NO_OBJECT_IN_MODULE');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Объект %s не найден', '', 1, 'OBJECT_NOT_FOUND');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Об''єкт %s не знайдений', '', 1, 'OBJECT_NOT_FOUND');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Объект %s уже существует', '', 1, 'OBJECT_EXISTS');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Об''єкт %s вже існує', '', 1, 'OBJECT_EXISTS');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Не найдена таблица маркирования "%s" для объекта "%s"', '', 1, 'OBJECT_MARKTAB_NOT_EXISTS');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Не знайдена таблиця маркування "%s" для об''єкту "%s"', '', 1, 'OBJECT_MARKTAB_NOT_EXISTS');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Не найдена процедура переноса "%s" для  объекта "%s"', '', 1, 'OBJECT_MOVEPROC_NOT_EXISTS');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Не знайдена процедура переносу "%s" для об''єкту "%s"', '', 1, 'OBJECT_MOVEPROC_NOT_EXISTS');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Для объекта "%s" не определена ни одна архивная таблица', '', 1, 'OBJECT_HISTTAB_NOT_EXISTS');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Для об''єкту "%s" не визначена жодна архивна таблиця', '', 1, 'OBJECT_HISTTAB_NOT_EXISTS');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Для объекта "%s" не определена ни одна исходная таблица', '', 1, 'OBJECT_SRCTAB_NOT_DEFINED');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Для об''єкту "%s" не визначена жодна базова таблиця', '', 1, 'OBJECT_SRCTAB_NOT_DEFINED');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Не найдена исходная таблица "%s"', '', 1, 'OBJECT_SRCTAB_NOT_EXISTS');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Не найдена таблица базова "%s"', '', 1, 'OBJECT_SRCTAB_NOT_EXISTS');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Не найдено ключевое поле "%s" исходной таблицы "%s"', '', 1, 'OBJECT_SRCTABKEY_NOT_EXISTS');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Не знайдено ключове поле "%s" базової таблицi "%s"', '', 1, 'OBJECT_SRCTABKEY_NOT_EXISTS');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Не найдена архивная таблица "%s"', '', 1, 'OBJECT_HTAB_NOT_EXISTS');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Не знайдена архивна таблиця "%s"', '', 1, 'OBJECT_HTAB_NOT_EXISTS');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Не найдена таблица списка реквизитов "%s" для архивной таблицы "%s"', '', 1, 'OBJECT_HTAB_FLTR_NOT_EXISTS');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Не знайдена таблиця списка реквизитiв "%s" для архивної таблицi "%s"', '', 1, 'OBJECT_HTAB_FLTR_NOT_EXISTS');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Не найдено ключевое поле "%s" исходного представления "%s"', '', 1, 'OBJECT_HTAB_SKEY_NOT_EXISTS');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Не знайдено ключове поле "%s" базової таблицi "%s"', '', 1, 'OBJECT_HTAB_SKEY_NOT_EXISTS');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Не указано ключевое поле "%s" исходного представления "%s"', '', 1, 'OBJECT_HTAB_SKEY_NULL');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, 'Не вказане ключове поле "%s" базової таблицi "%s"', '', 1, 'OBJECT_HTAB_SKEY_NULL');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Нет привилегии "%s" для архивной таблицы "%s"', '', 1, 'OBJECT_HTAB_GRNT_NOT_EXISTS');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'Немає привилегiї "%s" для архивної таблицi "%s"', '', 1, 'OBJECT_HTAB_GRNT_NOT_EXISTS');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Не совпадает структура исходного представления "%s" и архивной таблицы "%s"', '', 1, 'OBJECT_HTAB_SRCV_INCONS');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Не спiвпадає структура базової таблицi "%s" та архивної таблицi "%s"', '', 1, 'OBJECT_HTAB_SRCV_INCONS');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Не задана дата архивации', '', 1, 'ARCDATE_NOT_DEFINED');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, 'Не вказана дата архівації', '', 1, 'ARCDATE_NOT_DEFINED');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Найдены активные процессы архивации', '', 1, 'BUSY_STEP_FOUND');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Знайдені активні процеси архівації', '', 1, 'BUSY_STEP_FOUND');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, 'Недопустимое состояние шага', '', 1, 'INVALID_STEP_STATE');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, 'Неприпустимий стан кроку', '', 1, 'INVALID_STEP_STATE');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, 'Параметры шага не заданы', '', 1, 'STEP_PARAM_NOT_DEFINED');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, 'Параметри кроку не задані', '', 1, 'STEP_PARAM_NOT_DEFINED');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, 'Нарушение целостности состояния [%s] [%s] [%s] [%s]', '', 1, 'INCONSISTENT_STEP_STATE');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, 'Порушення цілісності стану [%s] [%s] [%s] [%s]', '', 1, 'INCONSISTENT_STEP_STATE');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, 'Количество строк не соответствует фактическому', '', 1, 'INVALID_MARKOBJ_ROWS');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'Кількість рядків не відповідає фактичній', '', 1, 'INVALID_MARKOBJ_ROWS');

    bars_error.add_message(l_mod, 150, l_exc, l_rus, 'Несоответствует структура таблиц %s и %s', '', 1, 'INCONSISTENT_TABLES');
    bars_error.add_message(l_mod, 150, l_exc, l_ukr, 'Не співпадає структура таблиць %s та %s', '', 1, 'INCONSISTENT_TABLES');

    bars_error.add_message(l_mod, 201, l_exc, l_rus, 'Счет %s / %s (%s) уже промаркирован', '', 1, 'ACC_ALREADY_MARKED');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, 'Рахунок %s / %s (%s) вже промаркірований', '', 1, 'ACC_ALREADY_MARKED');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, 'Документ № %s уже промаркирован', '', 1, 'DOC_ALREADY_MARKED');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, 'Документ № %s вже промаркірований', '', 1, 'DOC_ALREADY_MARKED');

    bars_error.add_message(l_mod, 203, l_exc, l_rus, 'Депозитный договор физического лица №%s (%s) в подразделении %s уже промаркирован', '', 1, 'DPT_ALREADY_MARKED');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, 'Депозитний договір фізичної особи №%s (%s) в підрозділі %s вже промаркірований', '', 1, 'DPT_ALREADY_MARKED');

    bars_error.add_message(l_mod, 204, l_exc, l_rus, 'Социальный договор физического лица № %s (%s) в подразделении %s уже промаркирован', '', 1, 'SOC_ALREADY_MARKED');
    bars_error.add_message(l_mod, 204, l_exc, l_ukr, 'Соціальний договір фізичної особи №%s (%s) в підрозділі %s вже промаркірований', '', 1, 'SOC_ALREADY_MARKED');

    bars_error.add_message(l_mod, 205, l_exc, l_rus, 'Депозитный договор юридического лица №%s уже промаркирован', '', 1, 'DPU_ALREADY_MARKED');
    bars_error.add_message(l_mod, 205, l_exc, l_ukr, 'Депозитний договір юридичної особи №%s вже промаркірований', '', 1, 'DPU_ALREADY_MARKED');

    bars_error.add_message(l_mod, 206, l_exc, l_rus, 'Документ № %s не завизирован', '', 1, 'INVALID_DOC_STATE_VISA');
    bars_error.add_message(l_mod, 206, l_exc, l_ukr, 'Документ № %s не завізований', '', 1, 'INVALID_DOC_STATE_VISA');

    bars_error.add_message(l_mod, 207, l_exc, l_rus, 'Документ № %s не подписан', '', 1, 'INVALID_DOC_STATE_SIGN');
    bars_error.add_message(l_mod, 207, l_exc, l_ukr, 'Документ № %s не підписаний', '', 1, 'INVALID_DOC_STATE_SIGN');

    bars_error.add_message(l_mod, 208, l_exc, l_rus, 'Документ № %s не передан в ОДБ Oracle', '', 1, 'INVALID_DOC_STATE_ODB');
    bars_error.add_message(l_mod, 208, l_exc, l_ukr, 'Документ № %s не переданий в ОДБ Oracle', '', 1, 'INVALID_DOC_STATE_ODB');

    bars_error.add_message(l_mod, 9999, l_exc, l_rus, 'Внутренняя ошибка модуля %s %s %s %s', '', 1, 'INTERNAL_ERROR');
    bars_error.add_message(l_mod, 9999, l_exc, l_ukr, 'Внутрішня помилка модуля %s %s %s %s', '', 1, 'INTERNAL_ERROR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ARC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
