

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_TABLE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_TABLE ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_TABLE 
   (	TABLE_NAME VARCHAR2(30), 
	SELECT_POLICY VARCHAR2(10), 
	INSERT_POLICY VARCHAR2(10), 
	UPDATE_POLICY VARCHAR2(10), 
	DELETE_POLICY VARCHAR2(10), 
	REPL_TYPE VARCHAR2(10), 
	POLICY_GROUP VARCHAR2(30) DEFAULT ''FILIAL'', 
	OWNER VARCHAR2(30) DEFAULT ''BARS'', 
	POLICY_COMMENT VARCHAR2(4000), 
	CHANGE_TIME DATE, 
	APPLY_TIME DATE, 
	WHO_ALTER VARCHAR2(256), 
	WHO_CHANGE VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_TABLE ***
 exec bpa.alter_policies('POLICY_TABLE');


COMMENT ON TABLE BARS.POLICY_TABLE IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.SELECT_POLICY IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.INSERT_POLICY IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.UPDATE_POLICY IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.DELETE_POLICY IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.REPL_TYPE IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.POLICY_GROUP IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.OWNER IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.POLICY_COMMENT IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.APPLY_TIME IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.WHO_ALTER IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE.WHO_CHANGE IS '';




PROMPT *** Create  constraint PK_POLICYTABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE ADD CONSTRAINT PK_POLICYTABLE PRIMARY KEY (OWNER, TABLE_NAME, POLICY_GROUP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYTABLE_TABLENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE MODIFY (TABLE_NAME CONSTRAINT CC_POLICYTABLE_TABLENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYTABLE_POLICYGROUP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE MODIFY (POLICY_GROUP CONSTRAINT CC_POLICYTABLE_POLICYGROUP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008583 ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE MODIFY (OWNER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_POLICYTABLE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_POLICYTABLE ON BARS.POLICY_TABLE (OWNER, TABLE_NAME, POLICY_GROUP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_TABLE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_TABLE    to ABS_ADMIN;
grant SELECT                                                                 on POLICY_TABLE    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TABLE    to BARS_DM;
grant SELECT                                                                 on POLICY_TABLE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE.sql =========*** End *** 
PROMPT ===================================================================================== 
