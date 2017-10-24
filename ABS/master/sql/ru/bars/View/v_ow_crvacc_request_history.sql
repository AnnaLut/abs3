

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_CRVACC_REQUEST_HISTORY.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_CRVACC_REQUEST_HISTORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_CRVACC_REQUEST_HISTORY ("REQUEST_ID", "REQUEST_NAME", "ACC", "FILE_NAME", "FILE_DATE", "TICK_NAME", "TICK_DATE", "TICK_STATUS", "RESP_CLASS", "RESP_CODE", "RESP_TEXT") AS 
  select r.id, r.name, d.acc,
       f.file_name, f.file_date,
       f.tick_name, f.tick_date, f.tick_status,
       d.resp_class, d.resp_code, d.resp_text
 from ow_xadata d, ow_xafiles f, ow_crv_request r
 where d.file_name = f.file_name
   and f.file_type = r.id
union
select r.id, r.name, c.acc,
       null, null, null, null, null, null, null, null
  from ow_crvacc_request c, ow_crv_request r
 where c.request_id = r.id;

PROMPT *** Create  grants  V_OW_CRVACC_REQUEST_HISTORY ***
grant SELECT                                                                 on V_OW_CRVACC_REQUEST_HISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_CRVACC_REQUEST_HISTORY to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_CRVACC_REQUEST_HISTORY.sql =======
PROMPT ===================================================================================== 
