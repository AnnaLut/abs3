

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZB1.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZB1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZB1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZB1 
   (	FN CHAR(12), 
	DAT DATE, 
	REF NUMBER(38,0), 
	KV NUMBER(3,0), 
	N NUMBER(10,0), 
	SDE NUMBER(24,0), 
	SKR NUMBER(24,0), 
	DATK DATE, 
	DAT_2 DATE, 
	OTM NUMBER(1,0), 
	SIGN RAW(128), 
	SIGN_KEY CHAR(6), 
	SSP_SIGN_KEY CHAR(6), 
	SSP_SIGN RAW(128), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZB1 ***
 exec bpa.alter_policies('ZB1');


COMMENT ON TABLE BARS.ZB1 IS '';
COMMENT ON COLUMN BARS.ZB1.FN IS '';
COMMENT ON COLUMN BARS.ZB1.DAT IS '';
COMMENT ON COLUMN BARS.ZB1.REF IS '';
COMMENT ON COLUMN BARS.ZB1.KV IS '';
COMMENT ON COLUMN BARS.ZB1.N IS '';
COMMENT ON COLUMN BARS.ZB1.SDE IS '';
COMMENT ON COLUMN BARS.ZB1.SKR IS '';
COMMENT ON COLUMN BARS.ZB1.DATK IS '';
COMMENT ON COLUMN BARS.ZB1.DAT_2 IS '';
COMMENT ON COLUMN BARS.ZB1.OTM IS '';
COMMENT ON COLUMN BARS.ZB1.SIGN IS '';
COMMENT ON COLUMN BARS.ZB1.SIGN_KEY IS '';
COMMENT ON COLUMN BARS.ZB1.SSP_SIGN_KEY IS '';
COMMENT ON COLUMN BARS.ZB1.SSP_SIGN IS '';
COMMENT ON COLUMN BARS.ZB1.KF IS '';




PROMPT *** Create  constraint SYS_C007620 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZB1 MODIFY (FN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007621 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZB1 MODIFY (DAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007622 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZB1 MODIFY (SDE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007623 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZB1 MODIFY (SKR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007624 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZB1 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZB1 ***
grant SELECT                                                                 on ZB1             to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZB1             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZB1.sql =========*** End *** =========
PROMPT ===================================================================================== 
