

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FINMON_WF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FINMON_WF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FINMON_WF ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FINMON_WF 
   (	WORD_FORM VARCHAR2(350)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FINMON_WF ***
 exec bpa.alter_policies('TMP_FINMON_WF');


COMMENT ON TABLE BARS.TMP_FINMON_WF IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_WF.WORD_FORM IS '';



PROMPT *** Create  grants  TMP_FINMON_WF ***
grant SELECT                                                                 on TMP_FINMON_WF   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FINMON_WF   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FINMON_WF   to START1;
grant SELECT                                                                 on TMP_FINMON_WF   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FINMON_WF.sql =========*** End ***
PROMPT ===================================================================================== 
