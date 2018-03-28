PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/data/error/mod_msp.sql =========*** Run *** ==
PROMPT ===================================================================================== 

PROMPT *** Create grant ***
grant execute on bars_error to MSP;
grant execute on bars_audit to MSP;
grant execute on bars_login to MSP;

PROMPT *** Create/replace ERR модуль MSP ***
declare
  l_mod  varchar2(3) := 'MSP';
  l_ukr  varchar2(3) := 'UKR';
  l_rus  varchar2(3) := 'RUS';
  l_eng  varchar2(3) := 'ENG';
  l_exc  number := -20000;
begin
  bars.bars_error.add_module(l_mod,'Міністерство Соціальної Політики',1);
  bars.bars_error.add_lang(l_rus,'Русский');
  bars.bars_error.add_lang(l_ukr,'Українська');
  bars.bars_error.add_lang(l_eng,'English');

  -- msp_utl
  bars.bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Помилка оновлення статуса файла. Відсутній файл з таким кодом p_file_id=%s', '', 1, 'UNKNOWN_FILE_STATUS');
  bars.bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Ошибка обновления статуса файла. Отсутствует файл с таким кодом p_file_id=%s', '', 1, 'UNKNOWN_FILE_STATUS');
  bars.bars_error.add_message(l_mod, 1, l_exc, l_eng, 'Error updating file status. Missing file with code p_file_id=%s', '', 1, 'UNKNOWN_FILE_STATUS');

  bars.bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Помилка оновлення статуса файла. %s', '', 1, 'ERRUPD_FILE_STATUS');
  bars.bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Ошибка обновления статуса файла. %s', '', 1, 'ERRUPD_FILE_STATUS');
  bars.bars_error.add_message(l_mod, 2, l_exc, l_eng, 'Error updating file status. %s', '', 1, 'ERRUPD_FILE_STATUS');

  bars.bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Помилка оновлення статуса інформаційного рядка файла. Відсутній запис з таким кодом p_file_record_id=%s', '', 1, 'UNKNOWN_FILEREC_STATUS');
  bars.bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Ошибка обновления статуса информационной строки файла. Отсутствует запись с таким кодом p_file_record_id=%s', '', 1, 'UNKNOWN_FILEREC_STATUS');
  bars.bars_error.add_message(l_mod, 3, l_exc, l_eng, 'Error updating file record status. Missing record with code p_file_record_id=%s', '', 1, 'UNKNOWN_FILEREC_STATUS');

  bars.bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Помилка оновлення статуса інформаційного рядка файла. %s', '', 1, 'ERRUPD_FILEREC_STATUS');
  bars.bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Ошибка обновления статуса информационной строки файла. %s', '', 1, 'ERRUPD_FILEREC_STATUS');
  bars.bars_error.add_message(l_mod, 4, l_exc, l_eng, 'Error updating file record status. %s', '', 1, 'ERRUPD_FILEREC_STATUS');

  bars.bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Помилка в процедурі перевірки файлу списку на зарахування соціальних виплат. %s', '', 1, 'ERROR_CHECKING_FILEREC');
  bars.bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Ошибка в процедуре проверки файла списка на зачисление социальных выплат. %s', '', 1, 'ERROR_CHECKING_FILEREC');
  bars.bars_error.add_message(l_mod, 5, l_exc, l_eng, 'Error checking file record. %s', '', 1, 'ERROR_CHECKING_FILEREC');

  bars.bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Помилка збереження даних заголовка файла. %s', '', 1, 'ERROR_CREATE_FILE');
  bars.bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Ошибка сохранения данных заголовка файла. %s', '', 1, 'ERROR_CREATE_FILE');
  bars.bars_error.add_message(l_mod, 6, l_exc, l_eng, 'Error create file. %s', '', 1, 'ERROR_CREATE_FILE');

  bars.bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Помилка збереження даних інформаційного рядка файла. %s', '', 1, 'ERROR_CREATE_FILEREC');
  bars.bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Ошибка сохранения данных информационной строки файла. %s', '', 1, 'ERROR_CREATE_FILEREC');
  bars.bars_error.add_message(l_mod, 7, l_exc, l_eng, 'Error create file record. %s', '', 1, 'ERROR_CREATE_FILEREC');

  bars.bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Помилка збереження даних інформаційного рядка файла. Відсутній запис з таким кодом p_file_id=%s', '', 1, 'UNKNOWN_FILE_RECORD');
  bars.bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Ошибка сохранения данных информационной строки файла. Отсутствует запись с таким кодом p_file_id=%s', '', 1, 'UNKNOWN_FILE_RECORD');
  bars.bars_error.add_message(l_mod, 8, l_exc, l_eng, 'Error create file record. Missing record with code p_file_id=%s', '', 1, 'UNKNOWN_FILE_RECORD');

  bars.bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Помилка побудови заголовка файла. Відсутній файл з таким кодом p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_HEADER');
  bars.bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Ошибка построения заголовка файла. Отсутствует файл с таким кодом p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_HEADER');
  bars.bars_error.add_message(l_mod, 9, l_exc, l_eng, 'Error create file report header. Missing file with code p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_HEADER');

  bars.bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Помилка побудови заголовка файла. %s', '', 1, 'ERROR_MATCHING_HEADER');
  bars.bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Ошибка построения заголовка файла. %s', '', 1, 'ERROR_MATCHING_HEADER');
  bars.bars_error.add_message(l_mod, 10, l_exc, l_eng, 'Error create file report header. %s', '', 1, 'ERROR_MATCHING_HEADER');

  bars.bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Помилка побудови файла. Відсутній файл з таким кодом p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_BODY');
  bars.bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Ошибка построения файла. Отсутствует файл с таким кодом p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_BODY');
  bars.bars_error.add_message(l_mod, 11, l_exc, l_eng, 'Error create file report. Missing file with code p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_BODY');

  bars.bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Помилка побудови файла. %s', '', 1, 'ERROR_MATCHING_BODY');
  bars.bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Ошибка построения файла. %s', '', 1, 'ERROR_MATCHING_BODY');
  bars.bars_error.add_message(l_mod, 12, l_exc, l_eng, 'Error create file report. %s', '', 1, 'ERROR_MATCHING_BODY');

  bars.bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Помилка формування квитанції. Функціональність для даного типу квитанції не реалізована. p_matching_tp=%s', '', 1, 'UNKNOWN_MATCHING');
  bars.bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Ошибка формирования квитанции. Функциональность для данного типа квитанции не реализована. p_matching_tp=%s', '', 1, 'UNKNOWN_MATCHING');
  bars.bars_error.add_message(l_mod, 13, l_exc, l_eng, 'Error create matching report. Missing implementation for p_matching_tp=%s', '', 1, 'UNKNOWN_MATCHING');

  bars.bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Помилка формування квитанції-%s. %s', '', 1, 'ERROR_MATCHING');
  bars.bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Ошибка построения квитанции-%s. %s', '', 1, 'ERROR_MATCHING');
  bars.bars_error.add_message(l_mod, 14, l_exc, l_eng, 'Error create matching report-%s. %s', '', 1, 'ERROR_MATCHING');

  bars.bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Помилка запису сформованих даних по файлу. Відсутній запис з таким кодом p_content_id=%s', '', 1, 'UNKNOWN_FILE_CONTENT');
  bars.bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Ошибка записи сформированых данных по файлу. Отсутствует запись с таким кодом p_content_id=%s', '', 1, 'UNKNOWN_FILE_CONTENT');
  bars.bars_error.add_message(l_mod, 15, l_exc, l_eng, 'Error write file content. Missing record with code p_content_id=%s', '', 1, 'UNKNOWN_FILE_CONTENT');

  bars.bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Помилка запису сформованих даних по файлу. Не задані, або не вірно задані параметри p_content_type_id=%s, p_file_id=%s', '', 1, 'UNKNOWN_FILECONTENT_PARAMETER');
  bars.bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Ошибка записи сформированых данных по файлу. Не заданы, или не верно заданы параметры p_content_type_id=%s, p_file_id=%s', '', 1, 'UNKNOWN_FILECONTENT_PARAMETER');
  bars.bars_error.add_message(l_mod, 16, l_exc, l_eng, 'Error write file content. No parameters specified p_content_type_id=%s, p_file_id=%s', '', 1, 'UNKNOWN_FILECONTENT_PARAMETER');

  bars.bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Помилка запису сформованих даних по файлу. %s', '', 1, 'ERRWRITE_FILE_CONTENT');
  bars.bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Ошибка записи сформированых данных по файлу. %s', '', 1, 'ERRWRITE_FILE_CONTENT');
  bars.bars_error.add_message(l_mod, 17, l_exc, l_eng, 'Error write file content. %s', '', 1, 'ERRWRITE_FILE_CONTENT');

  commit;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/data/err/mod_msp.sql =========*** Run *** ==
PROMPT ===================================================================================== 
