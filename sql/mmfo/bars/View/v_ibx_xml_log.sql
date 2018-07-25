
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_ibx_xml_log.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_IBX_XML_LOG ("PAY_ID", "DATE_IN", "RQ_CLOB", "RS_CLOB") AS 
  select "PAY_ID","DATE_IN","RQ_CLOB","RS_CLOB"
from (
select
substr(ext_ref,1,instr(ext_ref,' ')-1) pay_id
,to_date( substr (ext_ref,instr(ext_ref,' ')+1),'dd/mm/yyyy HH24:MI:SS') date_in
,rq_clob,rs_clob
from test_ibx_xml)
order by date_in desc
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_ibx_xml_log.sql =========*** End *** 
 PROMPT ===================================================================================== 
 