

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REFSYNC_OPLDOK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REFSYNC_OPLDOK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REFSYNC_OPLDOK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_REFSYNC_OPLDOK 
   (	REF NUMBER(38,0), 
	TT CHAR(3), 
	DK NUMBER(1,0), 
	ACC NUMBER(38,0), 
	FDAT DATE, 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	TXT VARCHAR2(70), 
	STMT NUMBER(38,0), 
	SOS NUMBER(1,0), 
	ID NUMBER(38,0), 
	KF VARCHAR2(6), 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REFSYNC_OPLDOK ***
 exec bpa.alter_policies('TMP_REFSYNC_OPLDOK');


COMMENT ON TABLE BARS.TMP_REFSYNC_OPLDOK IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.REF IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.TT IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.DK IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.ACC IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.S IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.SQ IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.TXT IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.STMT IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.SOS IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.ID IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.KF IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.ACTION IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.CHANGE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_REFSYNC_OPLDOK.SYSTEM_CHANGE_NUMBER IS '';




PROMPT *** Create  constraint SYS_C0010243 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010244 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010245 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010246 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010247 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010248 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010249 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (SQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010250 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (STMT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010251 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010252 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010253 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFSYNC_OPLDOK MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFSYNC_OPLDOK ***
grant SELECT                                                                 on TMP_REFSYNC_OPLDOK to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REFSYNC_OPLDOK to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REFSYNC_OPLDOK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REFSYNC_OPLDOK.sql =========*** En
PROMPT ===================================================================================== 
