

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_UKRPOSHTA_METR_BACKUP.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_UKRPOSHTA_METR_BACKUP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_UKRPOSHTA_METR_BACKUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_UKRPOSHTA_METR_BACKUP 
   (	METR NUMBER, 
	ACC NUMBER(38,0), 
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




PROMPT *** ALTER_POLICIES to TMP_UKRPOSHTA_METR_BACKUP ***
 exec bpa.alter_policies('TMP_UKRPOSHTA_METR_BACKUP');


COMMENT ON TABLE BARS.TMP_UKRPOSHTA_METR_BACKUP IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.METR IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.ACC IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.ID IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.BDAT IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.IR IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.BR IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.OP IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.IDU IS '';
COMMENT ON COLUMN BARS.TMP_UKRPOSHTA_METR_BACKUP.KF IS '';




PROMPT *** Create  constraint SYS_C00137383 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_UKRPOSHTA_METR_BACKUP MODIFY (METR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137384 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_UKRPOSHTA_METR_BACKUP MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137385 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_UKRPOSHTA_METR_BACKUP MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137386 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_UKRPOSHTA_METR_BACKUP MODIFY (BDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137387 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_UKRPOSHTA_METR_BACKUP MODIFY (IDU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137388 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_UKRPOSHTA_METR_BACKUP MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_UKRPOSHTA_METR_BACKUP ***
grant SELECT                                                                 on TMP_UKRPOSHTA_METR_BACKUP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_UKRPOSHTA_METR_BACKUP.sql ========
PROMPT ===================================================================================== 
