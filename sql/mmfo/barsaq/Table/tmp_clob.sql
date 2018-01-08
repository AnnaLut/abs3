

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_CLOB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_CLOB ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_CLOB 
   (	ACLOB CLOB
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_CLOB IS '';
COMMENT ON COLUMN BARSAQ.TMP_CLOB.ACLOB IS '';



PROMPT *** Create  grants  TMP_CLOB ***
grant SELECT                                                                 on TMP_CLOB        to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_CLOB.sql =========*** End *** ==
PROMPT ===================================================================================== 
