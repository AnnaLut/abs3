

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CIG_SEND_HISTORY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CIG_SEND_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CIG_SEND_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CIG_SEND_HISTORY 
   (	DOG_ID NUMBER(38,0), 
	SEND_DATE DATE, 
	BATCH_ID NUMBER, 
	SEND_ID NUMBER, 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CIG_SEND_HISTORY ***
 exec bpa.alter_policies('TMP_CIG_SEND_HISTORY');


COMMENT ON TABLE BARS.TMP_CIG_SEND_HISTORY IS '';
COMMENT ON COLUMN BARS.TMP_CIG_SEND_HISTORY.DOG_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIG_SEND_HISTORY.SEND_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIG_SEND_HISTORY.BATCH_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIG_SEND_HISTORY.SEND_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIG_SEND_HISTORY.BRANCH IS '';




PROMPT *** Create  constraint SYS_C0035378 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_SEND_HISTORY MODIFY (SEND_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035379 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_SEND_HISTORY MODIFY (BATCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035380 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_SEND_HISTORY MODIFY (SEND_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035381 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_SEND_HISTORY MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CIG_SEND_HISTORY ***
grant SELECT                                                                 on TMP_CIG_SEND_HISTORY to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CIG_SEND_HISTORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CIG_SEND_HISTORY.sql =========*** 
PROMPT ===================================================================================== 
