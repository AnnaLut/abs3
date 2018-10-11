

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_DOC_IMPORT_AUTO.sql =========*** Run ***
PROMPT ===================================================================================== 



  CREATE OR REPLACE FORCE VIEW BARSAQ.V_DOC_IMPORT_auto 
  as
select * from doc_import d
              where case when confirmation_flag='Y' and booking_flag is null and removal_flag is null then 'Y'
                         else null
                    end  = 'Y'
                and d.flg_auto_pay = 1
               order by confirmation_date, ext_ref;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_DOC_IMPORT.sql =========*** End ***
PROMPT ===================================================================================== 

comment on table barsaq.v_doc_import_auto is 'Список документов корп2 для автоматической оплаты вертушкой';

grant select on barsaq.v_doc_import_auto to bars_access_defrole;