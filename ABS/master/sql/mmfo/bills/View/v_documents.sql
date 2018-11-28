
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_documents.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_DOCUMENTS ("DOC_ID", "REC_ID", "TYPE_ID", "TYPE_CODE", "TYPE_DESCRIPTION", "STATUS", "STATUS_NAME", "LAST_DT", "LAST_USER", "FILENAME", "EXT_ID", "DESCRIPT") AS 
  select doc_id,
       rec_id,
       d.doc_type type_id,
       dt.code type_code,
       dt.description type_description,
       d.status,
       ds.name status_name,
       last_dt,
       last_user,
       filename,
       ext_id,
       descript
from documents d
join dict_doc_types dt on d.doc_type = dt.id
join dict_status ds on d.status = ds.code and ds.type = 'D'
;
 show err;
 
PROMPT *** Create  grants  V_DOCUMENTS ***
grant SELECT                                                                 on V_DOCUMENTS     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_documents.sql =========*** End *** =
 PROMPT ===================================================================================== 
 