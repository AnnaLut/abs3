

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_SESSION_FOR_DECRYPT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_SESSION_FOR_DECRYPT ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_SESSION_FOR_DECRYPT ("ID", "SESSION_TYPE", "REQUEST_ID", "REQUEST_DATA", "RESPONSE_DATA", "STATE", "REQUEST_XML_DATA", "RESPONSE_XML_DATA", "METHOD") AS 
  SELECT s.id,
          st.session_type_name,
          "REQUEST_ID",
          "REQUEST_DATA",
          "RESPONSE_DATA",
          ss.state_name,
          "REQUEST_XML_DATA",
          "RESPONSE_XML_DATA",
          st.pfu_method_code
     FROM pfu_session s, pfu_session_type st, pfu_session_state ss
    WHERE     s.session_type_id = st.id
          AND s.state_id = ss.id
          AND ss.state_code = 'RESPONDED';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_SESSION_FOR_DECRYPT.sql =========*
PROMPT ===================================================================================== 
