

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BE_PATCHES_BODY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BE_PATCHES_BODY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BE_PATCHES_BODY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BE_PATCHES_BODY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BE_PATCHES_BODY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BE_PATCHES_BODY ***
begin 
  execute immediate '
  CREATE TABLE BARS.BE_PATCHES_BODY 
   (	PATH_NAME VARCHAR2(254), 
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




PROMPT *** ALTER_POLICIES to BE_PATCHES_BODY ***
 exec bpa.alter_policies('BE_PATCHES_BODY');


COMMENT ON TABLE BARS.BE_PATCHES_BODY IS '›Ú‡ÎÓÌ ÚÂÎ Á‡ÔÎ‡ÚÓÍ (ÒÓ‰ÂÊËÏÓÂ Ù‡ÈÎÓ‚)';
COMMENT ON COLUMN BARS.BE_PATCHES_BODY.PATH_NAME IS 'Œ“ÕŒ—»“≈À‹Õ€… œ”“‹ » »Ãﬂ ‘¿…À¿ «¿œÀ¿“ »';
COMMENT ON COLUMN BARS.BE_PATCHES_BODY.FILE_BODY IS '“≈ÀŒ «¿œÀ¿“ » (—Œƒ≈–∆»ÃŒ≈ ‘¿…À¿)';




PROMPT *** Create  constraint PK_BEPATCHBODY ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_BODY ADD CONSTRAINT PK_BEPATCHBODY PRIMARY KEY (PATH_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BEPATCHBODY_BEPATCHES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_BODY ADD CONSTRAINT FK_BEPATCHBODY_BEPATCHES FOREIGN KEY (PATH_NAME)
	  REFERENCES BARS.BE_PATCHES (PATH_NAME) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHBODY_PATHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_BODY MODIFY (PATH_NAME CONSTRAINT CC_BEPATCHBODY_PATHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BEPATCHBODY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BEPATCHBODY ON BARS.BE_PATCHES_BODY (PATH_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BE_PATCHES_BODY ***
grant SELECT                                                                 on BE_PATCHES_BODY to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_PATCHES_BODY to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BE_PATCHES_BODY.sql =========*** End *
PROMPT ===================================================================================== 
