

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CIM_VMD_BOUND.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CIM_VMD_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CIM_VMD_BOUND ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CIM_VMD_BOUND 
   (	BOUND_ID NUMBER, 
	DIRECT NUMBER, 
	VMD_ID NUMBER, 
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




PROMPT *** ALTER_POLICIES to TMP_CIM_VMD_BOUND ***
 exec bpa.alter_policies('TMP_CIM_VMD_BOUND');


COMMENT ON TABLE BARS.TMP_CIM_VMD_BOUND IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.BOUND_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.DIRECT IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.VMD_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.CONTR_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.S_VT IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.RATE_VK IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.S_VK IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.COMMENTS IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.JOURNAL_NUM IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.JOURNAL_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.MODIFY_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.DELETE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.UID_DEL_BOUND IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.UID_DEL_JOURNAL IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CIM_VMD_BOUND.BORG_REASON IS '';




PROMPT *** Create  constraint SYS_C005523 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_VMD_BOUND MODIFY (DIRECT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005524 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_VMD_BOUND MODIFY (VMD_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005525 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_VMD_BOUND MODIFY (CONTR_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005526 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_VMD_BOUND MODIFY (S_VT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005527 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_VMD_BOUND MODIFY (CREATE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005528 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_VMD_BOUND MODIFY (MODIFY_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005529 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIM_VMD_BOUND MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CIM_VMD_BOUND ***
grant SELECT                                                                 on TMP_CIM_VMD_BOUND to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CIM_VMD_BOUND.sql =========*** End
PROMPT ===================================================================================== 
