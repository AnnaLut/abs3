

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_FOR_UNCRYPT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_FOR_UNCRYPT ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_FOR_UNCRYPT ("ID", "SESSION_TYPE", "REQUEST_ID", "REQUEST_DATA", "RESPONSE_DATA", "STATE", "REQUEST_XML_DATA", "RESPONSE_XML_DATA", "METHOD") AS 
  select s.id,
       st.session_type_code session_type,
       s.request_id,
       s.request_data,
       s.response_data,
       ss.state_code state,
       s.request_xml_data,
       s.response_xml_data,
       st.pfu_method_code method
from   pfu.pfu_session s
join   pfu.pfu_session_state ss on ss.id = s.state_id
left join pfu.pfu_session_type st on st.id = s.session_type_id
where  ss.state_code = 'NEW';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_FOR_UNCRYPT.sql =========*** End *
PROMPT ===================================================================================== 
