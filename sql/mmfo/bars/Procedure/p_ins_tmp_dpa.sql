

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INS_TMP_DPA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INS_TMP_DPA ***

  CREATE OR REPLACE PROCEDURE BARS.P_INS_TMP_DPA (p_msg_v    VARCHAR2
                                         ,p_msg_clob CLOB
                                         ,p_xml_ xmltype default null) IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

  INSERT INTO TMP_DPA_LOG
    (rdate
    ,msg_v
    ,msg_clob
    ,xml_
    )
  VALUES
    (SYSDATE
    ,p_msg_v
    ,p_msg_clob
    ,p_xml_);
  COMMIT;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INS_TMP_DPA.sql =========*** End
PROMPT ===================================================================================== 
