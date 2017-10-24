

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_REBRANCH_FILE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_REBRANCH_FILE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_REBRANCH_FILE ("ID", "FILE_NAME", "FILE_DATE", "FILE_N", "FILE_STATUS", "ERR_TEXT") AS 
  select t.id, t.file_name, t.file_date, t.file_n,
       decode(t.file_status,
               0,
               'Імпортовано в БД',
               1,
               'Файл розпарсено',
               2,
               'Опрацьовано',
               3,
               'Помилки при обробці') file_status , t.err_text
  from ow_files t
 where t.file_type = 'REBRANCH';

PROMPT *** Create  grants  V_OW_REBRANCH_FILE ***
grant SELECT                                                                 on V_OW_REBRANCH_FILE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_REBRANCH_FILE.sql =========*** End
PROMPT ===================================================================================== 
