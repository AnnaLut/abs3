

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CIM_FANTOMS_BOUND.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CIM_FANTOMS_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CIM_FANTOMS_BOUND ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CIM_FANTOMS_BOUND 
   (	BOUND_ID NUMBER, 
	DIRECT NUMBER, 
	FANTOM_ID NUMBER, 
	CONTR_ID NUMBER, 
	PAY_FLAG NUMBER, 
	S NUMBER, 
	S_CV NUMBER, 
	RATE NUMBER(30,8), 
	COMISS NUMBER, 
	COMMENTS VARCHAR2(4000), 
	JOURNAL_ID NUMBER, 
	JOURNAL_NUM NUMBER, 
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




PROMPT *** ALTER_POLICIES to TMP_CIM_FANTOMS_BOUND ***
 exec bpa.alter_policies('TMP_CIM_FANTOMS_BOUND');


COMMENT ON TABLE BARS.TMP_CIM_FANTOMS_BOUND IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.BOUND_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.DIRECT IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.FANTOM_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.CONTR_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.PAY_FLAG IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.S IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.S_CV IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.RATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.COMISS IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.COMMENTS IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.JOURNAL_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.JOURNAL_NUM IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.MODIFY_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.DELETE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.UID_DEL_BOUND IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.UID_DEL_JOURNAL IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CIM_FANTOMS_BOUND.BORG_REASON IS '';




PROMPT *** Create  constraint SYS_C008152 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_FANTOMS_BOUND MODIFY (BOUND_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008153 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_FANTOMS_BOUND MODIFY (DIRECT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008154 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_FANTOMS_BOUND MODIFY (FANTOM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008155 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_FANTOMS_BOUND MODIFY (PAY_FLAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008156 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_FANTOMS_BOUND MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008157 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_FANTOMS_BOUND MODIFY (CREATE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008158 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_FANTOMS_BOUND MODIFY (MODIFY_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008159 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_FANTOMS_BOUND MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CIM_FANTOMS_BOUND ***
grant SELECT                                                                 on TMP_CIM_FANTOMS_BOUND to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CIM_FANTOMS_BOUND to BARS_DM;
grant SELECT                                                                 on TMP_CIM_FANTOMS_BOUND to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CIM_FANTOMS_BOUND.sql =========***
PROMPT ===================================================================================== 
