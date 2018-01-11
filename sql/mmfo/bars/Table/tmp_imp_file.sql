

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_IMP_FILE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_IMP_FILE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_IMP_FILE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_IMP_FILE 
   (	ID NUMBER, 
	LINE VARCHAR2(4000)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_IMP_FILE ***
 exec bpa.alter_policies('TMP_IMP_FILE');


COMMENT ON TABLE BARS.TMP_IMP_FILE IS '';
COMMENT ON COLUMN BARS.TMP_IMP_FILE.ID IS '';
COMMENT ON COLUMN BARS.TMP_IMP_FILE.LINE IS '';



PROMPT *** Create  grants  TMP_IMP_FILE ***
grant SELECT                                                                 on TMP_IMP_FILE    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IMP_FILE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_IMP_FILE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_IMP_FILE.sql =========*** End *** 
PROMPT ===================================================================================== 
