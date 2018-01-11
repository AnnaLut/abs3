

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BE_PATCHES_BODY_ARC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BE_PATCHES_BODY_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BE_PATCHES_BODY_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BE_PATCHES_BODY_ARC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BE_PATCHES_BODY_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BE_PATCHES_BODY_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.BE_PATCHES_BODY_ARC 
   (	PATH_NAME VARCHAR2(254), 
	INS_DATE DATE DEFAULT SYSDATE, 
	FILE_BODY BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (FILE_BODY) STORE AS BASICFILE (
  TABLESPACE BRSBESCRD ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BE_PATCHES_BODY_ARC ***
 exec bpa.alter_policies('BE_PATCHES_BODY_ARC');


COMMENT ON TABLE BARS.BE_PATCHES_BODY_ARC IS '¿ıË‚ ÚÂÎ Á‡ÔÎ‡ÚÓÍ (ÏÂÚ‡ËÌÙÓÏ‡ˆËˇ)';
COMMENT ON COLUMN BARS.BE_PATCHES_BODY_ARC.PATH_NAME IS 'Œ“ÕŒ—»“≈À‹Õ€… œ”“‹ » »Ãﬂ ‘¿…À¿ «¿œÀ¿“ »';
COMMENT ON COLUMN BARS.BE_PATCHES_BODY_ARC.INS_DATE IS 'ƒ‡Ú‡ ‚ÒÚ‡‚ÍË';
COMMENT ON COLUMN BARS.BE_PATCHES_BODY_ARC.FILE_BODY IS '“≈ÀŒ «¿œÀ¿“ » (—Œƒ≈–∆»ÃŒ≈ ‘¿…À¿)';




PROMPT *** Create  constraint PK_BEPATCHBODYARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_BODY_ARC ADD CONSTRAINT PK_BEPATCHBODYARC PRIMARY KEY (PATH_NAME, INS_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHBODYARC_PATHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_BODY_ARC MODIFY (PATH_NAME CONSTRAINT CC_BEPATCHBODYARC_PATHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHBODYARC_INSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_BODY_ARC MODIFY (INS_DATE CONSTRAINT CC_BEPATCHBODYARC_INSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BEPATCHBODYARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BEPATCHBODYARC ON BARS.BE_PATCHES_BODY_ARC (PATH_NAME, INS_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BE_PATCHES_BODY_ARC ***
grant SELECT                                                                 on BE_PATCHES_BODY_ARC to BARSREADER_ROLE;
grant SELECT                                                                 on BE_PATCHES_BODY_ARC to BARS_DM;
grant SELECT                                                                 on BE_PATCHES_BODY_ARC to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_PATCHES_BODY_ARC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BE_PATCHES_BODY_ARC.sql =========*** E
PROMPT ===================================================================================== 
