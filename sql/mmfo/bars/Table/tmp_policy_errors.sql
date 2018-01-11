

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_POLICY_ERRORS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_POLICY_ERRORS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_POLICY_ERRORS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_POLICY_ERRORS 
   (	SQL_CALL VARCHAR2(128), 
	ERROR_MSG VARCHAR2(4000)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_POLICY_ERRORS ***
 exec bpa.alter_policies('TMP_POLICY_ERRORS');


COMMENT ON TABLE BARS.TMP_POLICY_ERRORS IS '';
COMMENT ON COLUMN BARS.TMP_POLICY_ERRORS.SQL_CALL IS '';
COMMENT ON COLUMN BARS.TMP_POLICY_ERRORS.ERROR_MSG IS '';




PROMPT *** Create  constraint CC_TMPPOLICYERRORS_SQLCALL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_POLICY_ERRORS MODIFY (SQL_CALL CONSTRAINT CC_TMPPOLICYERRORS_SQLCALL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_POLICY_ERRORS ***
grant SELECT                                                                 on TMP_POLICY_ERRORS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_POLICY_ERRORS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_POLICY_ERRORS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_POLICY_ERRORS.sql =========*** End
PROMPT ===================================================================================== 
