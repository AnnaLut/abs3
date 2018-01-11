

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_TMP_REZ.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_TMP_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_TMP_REZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TMP_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TMP_REZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_TMP_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_TMP_REZ 
   (	DAT DATE, 
	IDU NUMBER, 
	RNK NUMBER, 
	NMK VARCHAR2(35), 
	ID NUMBER, 
	CP_ID VARCHAR2(20), 
	KV NUMBER, 
	FIN NUMBER, 
	VR NUMBER, 
	PF NUMBER, 
	DOX NUMBER, 
	REF NUMBER, 
	G02 NUMBER, 
	G03 NUMBER, 
	G04 NUMBER, 
	G05 NUMBER, 
	G06 NUMBER, 
	G07 NUMBER, 
	G08 NUMBER, 
	G09 NUMBER, 
	G10 NUMBER, 
	G11 NUMBER, 
	G12 NUMBER, 
	G15 NUMBER, 
	G16 NUMBER, 
	G17 NUMBER, 
	G18 NUMBER, 
	RYN NUMBER, 
	EMI NUMBER, 
	VIDD NUMBER, 
	G19 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_TMP_REZ ***
 exec bpa.alter_policies('CP_TMP_REZ');


COMMENT ON TABLE BARS.CP_TMP_REZ IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.DAT IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.IDU IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.RNK IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.NMK IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.ID IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.CP_ID IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.KV IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.FIN IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.VR IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.PF IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.DOX IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.REF IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G02 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G03 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G04 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G05 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G06 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G07 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G08 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G09 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G10 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G11 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G12 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G15 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G16 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G17 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G18 IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.RYN IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.EMI IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.VIDD IS '';
COMMENT ON COLUMN BARS.CP_TMP_REZ.G19 IS '';




PROMPT *** Create  constraint PK_CP_TMP_REZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TMP_REZ ADD CONSTRAINT PK_CP_TMP_REZ PRIMARY KEY (IDU, DAT, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005291 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TMP_REZ MODIFY (DAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005292 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TMP_REZ MODIFY (IDU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005293 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TMP_REZ MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_TMP_REZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_TMP_REZ ON BARS.CP_TMP_REZ (IDU, DAT, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_TMP_REZ ***
grant SELECT                                                                 on CP_TMP_REZ      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TMP_REZ      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_TMP_REZ      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TMP_REZ      to START1;
grant SELECT                                                                 on CP_TMP_REZ      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_TMP_REZ.sql =========*** End *** ==
PROMPT ===================================================================================== 
