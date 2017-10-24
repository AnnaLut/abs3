

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBUR_VIEW_QUEQUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view NBUR_VIEW_QUEQUE ***

  CREATE OR REPLACE FORCE VIEW BARS.NBUR_VIEW_QUEQUE ("ID", "REPORT_DATE", "KF", "DATE_START", "USER_ID", "PROC_TYPE", "FILE_CODE", "FIO", "STATUS") AS 
  SELECT a."ID",
          a."REPORT_DATE",
          a."KF",
          a."DATE_START",
          a."USER_ID",
          a."PROC_TYPE",
          b.file_code,
          c.fio,
          DECODE (
             a.STATUS,
             0,    'Очікування (близько '
                || DECODE (a.proc_type,
                           1, f_nbur_get_wait_time (1),
                           f_nbur_get_wait_time (2))
                || ' хв.)',
             'Формування')
             status
     FROM NBUR_QUEUE_FORMS a, nbur_ref_files b, staff$base c
    WHERE a.id = b.id AND a.user_id = c.id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBUR_VIEW_QUEQUE.sql =========*** End *
PROMPT ===================================================================================== 
