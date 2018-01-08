

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TARIF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TARIF 
   (	KOD NUMBER(38,0), 
	KV NUMBER(3,0), 
	NAME VARCHAR2(50), 
	TAR NUMBER(24,0), 
	PR NUMBER(20,4), 
	SMIN NUMBER(24,0), 
	SMAX NUMBER(24,0), 
	TIP NUMBER(1,0), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TARIF ***
 exec bpa.alter_policies('TMP_TARIF');


COMMENT ON TABLE BARS.TMP_TARIF IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.KOD IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.KV IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.NAME IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.TAR IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.PR IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.SMIN IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.SMAX IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.TIP IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.NBS IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_TARIF.KF IS '';




PROMPT *** Create  constraint SYS_C007025 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TARIF MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007026 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TARIF MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007027 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TARIF MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007028 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TARIF MODIFY (TAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007029 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TARIF MODIFY (PR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007030 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TARIF MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_TARIF ***
grant SELECT                                                                 on TMP_TARIF       to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_TARIF       to BARS_DM;
grant SELECT                                                                 on TMP_TARIF       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TARIF.sql =========*** End *** ===
PROMPT ===================================================================================== 
