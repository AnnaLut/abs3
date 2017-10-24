

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OP1.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OP1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OP1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.OP1 
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
	OTM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OP1 ***
 exec bpa.alter_policies('OP1');


COMMENT ON TABLE BARS.OP1 IS '';
COMMENT ON COLUMN BARS.OP1.REF IS '';
COMMENT ON COLUMN BARS.OP1.TT IS '';
COMMENT ON COLUMN BARS.OP1.DK IS '';
COMMENT ON COLUMN BARS.OP1.ACC IS '';
COMMENT ON COLUMN BARS.OP1.FDAT IS '';
COMMENT ON COLUMN BARS.OP1.S IS '';
COMMENT ON COLUMN BARS.OP1.SQ IS '';
COMMENT ON COLUMN BARS.OP1.TXT IS '';
COMMENT ON COLUMN BARS.OP1.STMT IS '';
COMMENT ON COLUMN BARS.OP1.SOS IS '';
COMMENT ON COLUMN BARS.OP1.ID IS '';
COMMENT ON COLUMN BARS.OP1.KF IS '';
COMMENT ON COLUMN BARS.OP1.OTM IS '';




PROMPT *** Create  constraint SYS_C008065 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008066 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008075 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008074 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008073 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008072 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (STMT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008071 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (SQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008070 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008069 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008068 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008067 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP1 MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OP1 ***
grant SELECT                                                                 on OP1             to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OP1             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OP1.sql =========*** End *** =========
PROMPT ===================================================================================== 
