

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_FILES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_FILES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_FILES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_FILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_FILES 
   (	FILE_NAME VARCHAR2(12), 
	FILE_DATE DATE, 
	K_NAME VARCHAR2(12), 
	K_DATE DATE, 
	K_ERR VARCHAR2(4), 
	K_COMMENT VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_FILES ***
 exec bpa.alter_policies('SV_FILES');


COMMENT ON TABLE BARS.SV_FILES IS 'Файли P8*';
COMMENT ON COLUMN BARS.SV_FILES.FILE_NAME IS 'Імя файлу';
COMMENT ON COLUMN BARS.SV_FILES.FILE_DATE IS 'Дата файлу';
COMMENT ON COLUMN BARS.SV_FILES.K_NAME IS 'Квитанція';
COMMENT ON COLUMN BARS.SV_FILES.K_DATE IS 'Дата квитанції';
COMMENT ON COLUMN BARS.SV_FILES.K_ERR IS 'Код помилки';
COMMENT ON COLUMN BARS.SV_FILES.K_COMMENT IS 'Коментар';




PROMPT *** Create  constraint PK_SVFILES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_FILES ADD CONSTRAINT PK_SVFILES_ID PRIMARY KEY (FILE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_FILES MODIFY (FILE_NAME CONSTRAINT CC_SVFILES_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_FILES MODIFY (FILE_DATE CONSTRAINT CC_SVFILES_FILEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVFILES_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVFILES_ID ON BARS.SV_FILES (FILE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_FILES ***
grant SELECT                                                                 on SV_FILES        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_FILES        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SV_FILES        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_FILES        to RPBN002;
grant SELECT                                                                 on SV_FILES        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_FILES.sql =========*** End *** ====
PROMPT ===================================================================================== 
