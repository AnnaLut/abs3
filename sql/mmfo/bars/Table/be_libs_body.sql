

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BE_LIBS_BODY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BE_LIBS_BODY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BE_LIBS_BODY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BE_LIBS_BODY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BE_LIBS_BODY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BE_LIBS_BODY ***
begin 
  execute immediate '
  CREATE TABLE BARS.BE_LIBS_BODY 
   (	PATH_NAME VARCHAR2(254), 
	FILE_BODY BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (FILE_BODY) STORE AS BASICFILE (
  TABLESPACE BRSBELIBD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BE_LIBS_BODY ***
 exec bpa.alter_policies('BE_LIBS_BODY');


COMMENT ON TABLE BARS.BE_LIBS_BODY IS '›Ú‡ÎÓÌ ÚÂÎ ·Ë·ÎËÓÚÂÍ (ÏÂÚ‡ËÌÙÓÏ‡ˆËˇ)';
COMMENT ON COLUMN BARS.BE_LIBS_BODY.PATH_NAME IS 'Œ“ÕŒ—»“≈À‹Õ€… œ”“‹ » »Ãﬂ ‘¿…À¿ ¡»¡À»Œ“≈ »';
COMMENT ON COLUMN BARS.BE_LIBS_BODY.FILE_BODY IS '“≈ÀŒ ¡»¡À»Œ“≈ » (—Œƒ≈–∆»ÃŒ≈ ‘¿…À¿)';




PROMPT *** Create  constraint PK_BELIBSBODY ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_BODY ADD CONSTRAINT PK_BELIBSBODY PRIMARY KEY (PATH_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBSBODY_PATHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_BODY MODIFY (PATH_NAME CONSTRAINT CC_BELIBSBODY_PATHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BELIBSBODY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BELIBSBODY ON BARS.BE_LIBS_BODY (PATH_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BE_LIBS_BODY ***
grant SELECT                                                                 on BE_LIBS_BODY    to BARSREADER_ROLE;
grant SELECT                                                                 on BE_LIBS_BODY    to BARS_DM;
grant SELECT                                                                 on BE_LIBS_BODY    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_LIBS_BODY    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BE_LIBS_BODY.sql =========*** End *** 
PROMPT ===================================================================================== 
