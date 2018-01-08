

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REE2A.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REE2A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REE2A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REE2A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REE2A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REE2A ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REE2A 
   (	OKPO VARCHAR2(8), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(15), 
	NOM NUMBER, 
	CP_ID VARCHAR2(20), 
	KUPON NUMBER, 
	ZASTAVA NUMBER, 
	REF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REE2A ***
 exec bpa.alter_policies('CP_REE2A');


COMMENT ON TABLE BARS.CP_REE2A IS '';
COMMENT ON COLUMN BARS.CP_REE2A.OKPO IS '';
COMMENT ON COLUMN BARS.CP_REE2A.MFO IS '';
COMMENT ON COLUMN BARS.CP_REE2A.NLS IS '';
COMMENT ON COLUMN BARS.CP_REE2A.NOM IS '';
COMMENT ON COLUMN BARS.CP_REE2A.CP_ID IS '';
COMMENT ON COLUMN BARS.CP_REE2A.KUPON IS '';
COMMENT ON COLUMN BARS.CP_REE2A.ZASTAVA IS '';
COMMENT ON COLUMN BARS.CP_REE2A.REF IS '';




PROMPT *** Create  constraint XPK_CP_REE2A ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2A ADD CONSTRAINT XPK_CP_REE2A PRIMARY KEY (CP_ID, MFO, ZASTAVA, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005164 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2A MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005165 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2A MODIFY (CP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005166 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2A MODIFY (ZASTAVA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005167 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2A MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_REE2A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_REE2A ON BARS.CP_REE2A (CP_ID, MFO, ZASTAVA, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_REE2A ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REE2A        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_REE2A        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REE2A        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REE2A.sql =========*** End *** ====
PROMPT ===================================================================================== 
