

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OP0.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OP0 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OP0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.OP0 
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




PROMPT *** ALTER_POLICIES to OP0 ***
 exec bpa.alter_policies('OP0');


COMMENT ON TABLE BARS.OP0 IS '';
COMMENT ON COLUMN BARS.OP0.REF IS '';
COMMENT ON COLUMN BARS.OP0.TT IS '';
COMMENT ON COLUMN BARS.OP0.DK IS '';
COMMENT ON COLUMN BARS.OP0.ACC IS '';
COMMENT ON COLUMN BARS.OP0.FDAT IS '';
COMMENT ON COLUMN BARS.OP0.S IS '';
COMMENT ON COLUMN BARS.OP0.SQ IS '';
COMMENT ON COLUMN BARS.OP0.TXT IS '';
COMMENT ON COLUMN BARS.OP0.STMT IS '';
COMMENT ON COLUMN BARS.OP0.SOS IS '';
COMMENT ON COLUMN BARS.OP0.ID IS '';
COMMENT ON COLUMN BARS.OP0.KF IS '';
COMMENT ON COLUMN BARS.OP0.OTM IS '';




PROMPT *** Create  constraint SYS_C005917 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005918 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005927 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005926 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005925 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005924 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (STMT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005923 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (SQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005922 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005921 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005920 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005919 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP0 MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OP0 ***
grant SELECT                                                                 on OP0             to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OP0             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OP0.sql =========*** End *** =========
PROMPT ===================================================================================== 
