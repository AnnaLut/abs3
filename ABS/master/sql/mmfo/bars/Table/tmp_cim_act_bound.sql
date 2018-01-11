

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CIM_ACT_BOUND.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CIM_ACT_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CIM_ACT_BOUND ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CIM_ACT_BOUND 
   (	BOUND_ID NUMBER, 
	DIRECT NUMBER, 
	ACT_ID NUMBER, 
	CONTR_ID NUMBER, 
	S_VT NUMBER, 
	RATE_VK NUMBER(30,8), 
	S_VK NUMBER, 
	COMMENTS VARCHAR2(4000), 
	JOURNAL_NUM NUMBER, 
	JOURNAL_ID NUMBER, 
	CREATE_DATE DATE, 
	MODIFY_DATE DATE, 
	DELETE_DATE DATE, 
	UID_DEL_BOUND NUMBER, 
	UID_DEL_JOURNAL NUMBER, 
	BRANCH VARCHAR2(30), 
	BORG_REASON NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CIM_ACT_BOUND ***
 exec bpa.alter_policies('TMP_CIM_ACT_BOUND');


COMMENT ON TABLE BARS.TMP_CIM_ACT_BOUND IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.BOUND_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.DIRECT IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.ACT_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.CONTR_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.S_VT IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.RATE_VK IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.S_VK IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.COMMENTS IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.JOURNAL_NUM IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.JOURNAL_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.MODIFY_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.DELETE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.UID_DEL_BOUND IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.UID_DEL_JOURNAL IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CIM_ACT_BOUND.BORG_REASON IS '';




PROMPT *** Create  constraint SYS_C008160 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_ACT_BOUND MODIFY (DIRECT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008161 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_ACT_BOUND MODIFY (ACT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008162 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_ACT_BOUND MODIFY (CONTR_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008163 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_ACT_BOUND MODIFY (S_VT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008164 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_ACT_BOUND MODIFY (CREATE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008165 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_ACT_BOUND MODIFY (MODIFY_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008166 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_ACT_BOUND MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CIM_ACT_BOUND ***
grant SELECT                                                                 on TMP_CIM_ACT_BOUND to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CIM_ACT_BOUND to BARS_DM;
grant SELECT                                                                 on TMP_CIM_ACT_BOUND to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CIM_ACT_BOUND.sql =========*** End
PROMPT ===================================================================================== 
