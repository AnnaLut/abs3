

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN_LOG.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INT_RATN_LOG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INT_RATN_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INT_RATN_LOG 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	BDAT DATE, 
	IR NUMBER, 
	BR NUMBER(38,0), 
	OP NUMBER(4,0), 
	IDU NUMBER(38,0), 
	KF VARCHAR2(6), 
	ROW_ID NUMBER(4,0), 
	COL VARCHAR2(20), 
	DAT DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INT_RATN_LOG ***
 exec bpa.alter_policies('TMP_INT_RATN_LOG');


COMMENT ON TABLE BARS.TMP_INT_RATN_LOG IS 'Лог истории % ставки';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.BDAT IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.IR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.BR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.OP IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.IDU IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.KF IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.ROW_ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.COL IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_LOG.DAT IS '';




PROMPT *** Create  constraint SYS_C00136953 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_LOG MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136954 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_LOG MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136955 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_LOG MODIFY (BDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136956 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_LOG MODIFY (IDU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136957 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_LOG MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136958 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_LOG MODIFY (ROW_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INT_RATN_LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INT_RATN_LOG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_INT_RATN_LOG to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INT_RATN_LOG to START1;
grant SELECT                                                                 on TMP_INT_RATN_LOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN_LOG.sql =========*** End 
PROMPT ===================================================================================== 
