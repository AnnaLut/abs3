PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_UPL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль UPL ***
declare
  l_mod  varchar2(3) := 'UPL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Выгрузка данных для синхронизации', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Некорректный тип данных для колонки %s: %s ', '', 1, 'NOT_CORRECT_DATATYPE');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Некоректний тип даних для колонки %s: %s ', '', 1, 'NOT_CORRECT_DATATYPE');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Для типа колонки %s не предусмотрена обработка', '', 1, 'NO_SUCH_DATATYPE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Для типа колонки %s не предусмотрена обработка', '', 1, 'NO_SUCH_DATATYPE');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Не существует директории оракла %s ', '', 1, 'NO_SUCH_ORADIR');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Не существует директории оракла %s ', '', 1, 'NO_SUCH_ORADIR');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Таблица не найдена %s для схемы %s', '', 1, 'NO_SUCH_TABLE');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Таблица не найдена %s для схемы %s', '', 1, 'NO_SUCH_TABLE');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не найден код выгружаемого файла %s', '', 1, 'NO_SUCH_FILE_ID');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не найден код выгружаемого файла %s', '', 1, 'NO_SUCH_FILE_ID');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Не описан запрос для файла с кодом %s', '', 1, 'NO_SQL_FOR_FILEID');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Не описан запрос для файла с кодом %s', '', 1, 'NO_SQL_FOR_FILEID');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Невозможно разобрать запрос %s', '', 1, 'CANN_NOT_PARSE_SQL');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Невозможно разобрать запрос %s', '', 1, 'CANN_NOT_PARSE_SQL');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Неcовместимые структуры, описанные для колонок и для запроса: %s', '', 1, 'UNCOMPATIBLE_STRUCTS');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Неcовместимые структуры, описанные для колонок и для запроса: %s', '', 1, 'UNCOMPATIBLE_STRUCTS');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'В системе не описан параметр ORACLE_DIR для выгрузки', '', 1, 'NO_ORADIR_PARAMETER');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'В системе не описан параметр ORACLE_DIR для выгрузки', '', 1, 'NO_ORADIR_PARAMETER');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'В системе не описан параметр REGION_PRFX(перфикс региона) для выгрузки', '', 1, 'NO_REGION_PRFX_PARAMETER');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'В системе не описан параметр REGION_PRFX(перфикс региона) для выгрузки', '', 1, 'NO_REGION_PRFX_PARAMETER');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Не найден код файла для выгрузки %s', '', 1, 'NO_SUCH_FILE_CODE');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Не найден код файла для выгрузки %s', '', 1, 'NO_SUCH_FILE_CODE');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '%s', '', 1, 'ERROR_MESS');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '%s', '', 1, 'ERROR_MESS');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Некорректное выполненние pl/sql <ДО> для запроса %s, %s', '', 1, 'NOT_CORRECT_SQL_BEFORE');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Некорректное выполненние pl/sql <ДО> для запроса %s, %s', '', 1, 'NOT_CORRECT_SQL_BEFORE');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Не установлен параметр для выгрузки - системный каталог выгрузки(SYS_DIR)', '', 1, 'NO_SYSDIR_PARAMETER');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Не установлен параметр для выгрузки - системный каталог выгрузки(SYS_DIR)', '', 1, 'NO_SYSDIR_PARAMETER');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Невозможно открыть файл для записи %s в директорию %s', '', 1, 'CANNOT_OPEN_FILE_FOR_W');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Невозможно открыть файл для записи %s в директорию %s', '', 1, 'CANNOT_OPEN_FILE_FOR_W');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'В системе не описан параметр FTP_PATH для выгрузки', '', 1, 'NO_FTPPATH_PARAM');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'В системе не описан параметр FTP_PATH для выгрузки', '', 1, 'NO_FTPPATH_PARAM');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'В системе не описан параметр ZIP_PATH для выгрузки', '', 1, 'NO_ZIPPATH_PARAM');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'В системе не описан параметр ZIP_PATH для выгрузки', '', 1, 'NO_ZIPPATH_PARAM');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'В системе не описан параметр FTP_DOMAIN для выгрузки', '', 1, 'NO_FTPDOMAIN_PARAM');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'В системе не описан параметр FTP_DOMAIN для выгрузки', '', 1, 'NO_FTPDOMAIN_PARAM');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'В системе не описан параметр FTP_PASSWORD для выгрузки', '', 1, 'NO_FTPPASSWORD_PARAM');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'В системе не описан параметр FTP_PASSWORD для выгрузки', '', 1, 'NO_FTPPASSWORD_PARAM');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'В системе не описан параметр FTPCLI_PATH для выгрузки', '', 1, 'NO_FTPCLIPATH_PARAM');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'В системе не описан параметр FTPCLI_PATH для выгрузки', '', 1, 'NO_FTPCLIPATH_PARAM');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'В системе не описан параметр ORACLE_ARC_DIR для выгрузки', '', 1, 'NO_ORAARCDIR_PARAMETER');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'В системе не описан параметр ORACLE_ARC_DIR для выгрузки', '', 1, 'NO_ORAARCDIR_PARAMETER');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Выгрузка за %s, группы %s уже запускалась и была успешно выполнена, статус %s', '', 1, 'WAS_YET_UPLOADED');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Выгрузка за %s, группы %s уже запускалась и была успешно выполнена, статус %s', '', 1, 'WAS_YET_UPLOADED');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Список файлов для архивации превышает 4Кb', '', 1, 'FILE_LIST_ISTOOLONG');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Список файлов для архивации превышает 4Кb', '', 1, 'FILE_LIST_ISTOOLONG');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Нет групповой информации', '', 1, 'NO_GROUP_INFORMATION');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Нет групповой информации', '', 1, 'NO_GROUP_INFORMATION');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Переданно некорректный формат даты (через параметр) %s', '', 1, 'NOT_CORRECT_DATE');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Переданно некорректный формат даты (через параметр) %s', '', 1, 'NOT_CORRECT_DATE');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'В системе не описан параметр UPL_INIT_ID(код группы для начальной выгрузки) для выгрузки', '', 1, 'NO_INITID_PARAM');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'В системе не описан параметр UPL_INIT_ID(код группы для начальной выгрузки) для выгрузки', '', 1, 'NO_INITID_PARAM');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'В системе не описан параметр UPL_INCR_ID(код группы для инкрементальной выгрузки) для выгрузки', '', 1, 'NO_INCRID_PARAM');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'В системе не описан параметр UPL_INCR_ID(код группы для инкрементальной выгрузки) для выгрузки', '', 1, 'NO_INCRID_PARAM');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Выгрузка за %s, группы %s все еще в стадии работы, статус %s', '', 1, 'STILL_UPLOADING');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Выгрузка за %s, группы %s все еще в стадии работы, статус %s', '', 1, 'STILL_UPLOADING');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Выгрузка за %s, группы %s завершилась с ошибками, статус %s', '', 1, 'UPLOADED_WITH_ERRORS');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Выгрузка за %s, группы %s завершилась с ошибками, статус %s', '', 1, 'UPLOADED_WITH_ERRORS');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Неизвестный статус завершения выгрузки за %s, группы %s завершилась с ошибками, статус %s', '', 1, 'UNKNOWN_STATUS');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Неизвестный статус завершения выгрузки за %s, группы %s завершилась с ошибками, статус %s', '', 1, 'UNKNOWN_STATUS');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Не знайдено банкiвської дати для вивантаження', '', 1, 'NO_BANKDATE_TO_UPLOAD');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Не знайдено банкiвської дати для вивантаження', '', 1, 'NO_BANKDATE_TO_UPLOAD');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Банкiвська дата %s вже була вивантажена', '', 1, 'BANKDATE_WAS_UPLOADED');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Банкiвська дата %s вже була вивантажена', '', 1, 'BANKDATE_WAS_UPLOADED');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Банкiвська дата %s в стадiї вивантаження', '', 1, 'BANKDATE_IN_UPLOADING');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Банкiвська дата %s в стадiї вивантаження', '', 1, 'BANKDATE_IN_UPLOADING');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Параметр %s для задания %s должен быть числовым значением', '', 1, 'NOT_NUMERIC');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Параметр %s для задания %s повинен бути числовим значенням', '', 1, 'NOT_NUMERIC');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Для задания %s не указан параметр группы выгрузки', '', 1, 'NO_GROUPID_FOR_JOB');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Для завданння %s не вказано параметр группи вивантаження', '', 1, 'NO_GROUPID_FOR_JOB');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Некорректный код региона %s', '', 1, 'NO_CORRECT_KF');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Некоректний код регіону %s', '', 1, 'NO_CORRECT_KF');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Невозможно выполнить действие не идентифицировав регион', '', 1, 'USER_NOT_LOGING');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Неможливо виконати дію без ідентифікації регіону', '', 1, 'USER_NOT_LOGING');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_UPL.sql =========*** Run *** ==
PROMPT ===================================================================================== 
