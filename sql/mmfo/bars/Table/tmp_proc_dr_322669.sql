

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PROC_DR_322669.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PROC_DR_322669 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PROC_DR_322669 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PROC_DR_322669 
   (	NBS CHAR(4), 
	G67 VARCHAR2(15), 
	V67 VARCHAR2(15), 
	SOUR NUMBER(1,0), 
	NBSN CHAR(4), 
	G67N VARCHAR2(15), 
	V67N VARCHAR2(15), 
	NBSZ CHAR(4), 
	REZID NUMBER(38,0), 
	TT CHAR(3), 
	TTV CHAR(3), 
	IO NUMBER(1,0), 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PROC_DR_322669 ***
 exec bpa.alter_policies('TMP_PROC_DR_322669');


COMMENT ON TABLE BARS.TMP_PROC_DR_322669 IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.NBS IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.G67 IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.V67 IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.SOUR IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.NBSN IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.G67N IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.V67N IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.NBSZ IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.REZID IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.TT IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.TTV IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.IO IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_PROC_DR_322669.KF IS '';




PROMPT *** Create  constraint SYS_C00137917 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PROC_DR_322669 MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137918 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PROC_DR_322669 MODIFY (SOUR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137919 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PROC_DR_322669 MODIFY (REZID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137920 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PROC_DR_322669 MODIFY (IO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137921 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PROC_DR_322669 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137922 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PROC_DR_322669 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_PROC_DR_322669 ***
grant SELECT                                                                 on TMP_PROC_DR_322669 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PROC_DR_322669.sql =========*** En
PROMPT ===================================================================================== 
