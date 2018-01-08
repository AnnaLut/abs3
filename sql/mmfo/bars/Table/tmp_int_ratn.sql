

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INT_RATN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INT_RATN ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INT_RATN 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	BDAT DATE, 
	IR NUMBER, 
	BR NUMBER(38,0), 
	OP NUMBER(4,0), 
	IDU NUMBER(38,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INT_RATN ***
 exec bpa.alter_policies('TMP_INT_RATN');


COMMENT ON TABLE BARS.TMP_INT_RATN IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN.ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN.BDAT IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN.IR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN.BR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN.OP IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN.IDU IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN.KF IS '';




PROMPT *** Create  constraint SYS_C00136948 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136949 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136950 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN MODIFY (BDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136951 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN MODIFY (IDU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136952 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_INTRATN_TMP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_INTRATN_TMP ON BARS.TMP_INT_RATN (BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTRATN_TMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTRATN_TMP ON BARS.TMP_INT_RATN (ACC, ID, BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_INTRATN_TMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_INTRATN_TMP ON BARS.TMP_INT_RATN (KF, ACC, ID, BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INT_RATN ***
grant SELECT                                                                 on TMP_INT_RATN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN.sql =========*** End *** 
PROMPT ===================================================================================== 
