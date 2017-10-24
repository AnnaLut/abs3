

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPLD_MIL_0107.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPLD_MIL_0107 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPLD_MIL_0107 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPLD_MIL_0107 
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
	KF VARCHAR2(6), 
	OTM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPLD_MIL_0107 ***
 exec bpa.alter_policies('TMP_OPLD_MIL_0107');


COMMENT ON TABLE BARS.TMP_OPLD_MIL_0107 IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.REF IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.TT IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.DK IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.ACC IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.S IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.SQ IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.TXT IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.STMT IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.SOS IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.KF IS '';
COMMENT ON COLUMN BARS.TMP_OPLD_MIL_0107.OTM IS '';




PROMPT *** Create  constraint SYS_C003047589 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047588 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047587 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (STMT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047586 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (SQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047585 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047584 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047583 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047582 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047581 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003047580 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLD_MIL_0107 MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPLD_MIL_0107.sql =========*** End
PROMPT ===================================================================================== 
