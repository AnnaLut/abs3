

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR_LANGS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR_LANGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ERR_LANGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ERR_LANGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ERR_LANGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR_LANGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR_LANGS 
   (	ERRLNG_CODE VARCHAR2(3), 
	ERRLNG_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR_LANGS ***
 exec bpa.alter_policies('ERR_LANGS');


COMMENT ON TABLE BARS.ERR_LANGS IS 'Язык отображения ошибки';
COMMENT ON COLUMN BARS.ERR_LANGS.ERRLNG_CODE IS 'Код языка';
COMMENT ON COLUMN BARS.ERR_LANGS.ERRLNG_NAME IS 'Название языка отображения';




PROMPT *** Create  constraint PK_ERRLANGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_LANGS ADD CONSTRAINT PK_ERRLANGS PRIMARY KEY (ERRLNG_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRLANGS_ERRLNGCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_LANGS MODIFY (ERRLNG_CODE CONSTRAINT CC_ERRLANGS_ERRLNGCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRLANGS_ERRLNGNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_LANGS MODIFY (ERRLNG_NAME CONSTRAINT CC_ERRLANGS_ERRLNGNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ERRLANGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ERRLANGS ON BARS.ERR_LANGS (ERRLNG_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ERR_LANGS ***
grant SELECT                                                                 on ERR_LANGS       to BARSREADER_ROLE;
grant SELECT                                                                 on ERR_LANGS       to BARS_DM;
grant SELECT                                                                 on ERR_LANGS       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ERR_LANGS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR_LANGS.sql =========*** End *** ===
PROMPT ===================================================================================== 
