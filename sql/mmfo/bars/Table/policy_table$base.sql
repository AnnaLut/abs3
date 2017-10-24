

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE$BASE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_TABLE$BASE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_TABLE$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_TABLE$BASE 
   (	TABLE_NAME VARCHAR2(30), 
	SELECT_POLICY VARCHAR2(10), 
	INSERT_POLICY VARCHAR2(10), 
	UPDATE_POLICY VARCHAR2(10), 
	DELETE_POLICY VARCHAR2(10), 
	REPL_TYPE VARCHAR2(10), 
	POLICY_GROUP VARCHAR2(30), 
	OWNER VARCHAR2(30), 
	POLICY_COMMENT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_TABLE$BASE ***
 exec bpa.alter_policies('POLICY_TABLE$BASE');


COMMENT ON TABLE BARS.POLICY_TABLE$BASE IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.SELECT_POLICY IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.INSERT_POLICY IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.UPDATE_POLICY IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.DELETE_POLICY IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.REPL_TYPE IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.POLICY_GROUP IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.OWNER IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE$BASE.POLICY_COMMENT IS '';




PROMPT *** Create  constraint SYS_C006658 ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE$BASE MODIFY (OWNER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_TABLE$BASE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_TABLE$BASE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TABLE$BASE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_TABLE$BASE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE$BASE.sql =========*** End
PROMPT ===================================================================================== 
