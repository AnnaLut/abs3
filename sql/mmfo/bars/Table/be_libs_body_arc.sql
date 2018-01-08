

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BE_LIBS_BODY_ARC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BE_LIBS_BODY_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BE_LIBS_BODY_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BE_LIBS_BODY_ARC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BE_LIBS_BODY_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BE_LIBS_BODY_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.BE_LIBS_BODY_ARC 
   (	PATH_NAME VARCHAR2(254), 
	INS_DATE DATE DEFAULT SYSDATE, 
	FILE_BODY BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (FILE_BODY) STORE AS BASICFILE (
  TABLESPACE BRSBELIBD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BE_LIBS_BODY_ARC ***
 exec bpa.alter_policies('BE_LIBS_BODY_ARC');


COMMENT ON TABLE BARS.BE_LIBS_BODY_ARC IS '¿ıË‚ ÚÂÎ ·Ë·ÎËÓÚÂÍ (ÒÓ‰ÂÊËÏÓÂ Ù‡ÈÎÓ‚)';
COMMENT ON COLUMN BARS.BE_LIBS_BODY_ARC.PATH_NAME IS 'Œ“ÕŒ—»“≈À‹Õ€… œ”“‹ » »Ãﬂ ‘¿…À¿ ¡»¡À»Œ“≈ »';
COMMENT ON COLUMN BARS.BE_LIBS_BODY_ARC.INS_DATE IS '';
COMMENT ON COLUMN BARS.BE_LIBS_BODY_ARC.FILE_BODY IS '“≈ÀŒ ¡»¡À»Œ“≈ » (—Œƒ≈–∆»ÃŒ≈ ‘¿…À¿)';




PROMPT *** Create  constraint PK_BELIBSBODYARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_BODY_ARC ADD CONSTRAINT PK_BELIBSBODYARC PRIMARY KEY (PATH_NAME, INS_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBSBODYARC_PATHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_BODY_ARC MODIFY (PATH_NAME CONSTRAINT CC_BELIBSBODYARC_PATHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBSBODYARC_INSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_BODY_ARC MODIFY (INS_DATE CONSTRAINT CC_BELIBSBODYARC_INSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BELIBSBODYARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BELIBSBODYARC ON BARS.BE_LIBS_BODY_ARC (PATH_NAME, INS_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BE_LIBS_BODY_ARC ***
grant SELECT                                                                 on BE_LIBS_BODY_ARC to BARSREADER_ROLE;
grant SELECT                                                                 on BE_LIBS_BODY_ARC to BARS_DM;
grant SELECT                                                                 on BE_LIBS_BODY_ARC to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_LIBS_BODY_ARC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BE_LIBS_BODY_ARC.sql =========*** End 
PROMPT ===================================================================================== 
