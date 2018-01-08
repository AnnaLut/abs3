

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_FILES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_FILES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_FILES 
   (	ID NUMBER(38,0), 
	FILE_NAME VARCHAR2(12), 
	FILE_DATE DATE, 
	ARC NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_FILES ***
 exec bpa.alter_policies('OBPC_FILES');


COMMENT ON TABLE BARS.OBPC_FILES IS 'Файлы принятые с ПЦ';
COMMENT ON COLUMN BARS.OBPC_FILES.ID IS 'Код файла';
COMMENT ON COLUMN BARS.OBPC_FILES.FILE_NAME IS 'Имя файла';
COMMENT ON COLUMN BARS.OBPC_FILES.FILE_DATE IS 'Дата приема';
COMMENT ON COLUMN BARS.OBPC_FILES.ARC IS 'Признак архивной записи (файл за прошлый год)';




PROMPT *** Create  constraint CC_OBPCFILES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_FILES MODIFY (ID CONSTRAINT CC_OBPCFILES_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCFILES_FILENAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_FILES MODIFY (FILE_NAME CONSTRAINT CC_OBPCFILES_FILENAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCFILES_FILEDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_FILES MODIFY (FILE_DATE CONSTRAINT CC_OBPCFILES_FILEDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCFILES_ARC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_FILES MODIFY (ARC CONSTRAINT CC_OBPCFILES_ARC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCFILES_ARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_FILES ADD CONSTRAINT CC_OBPCFILES_ARC CHECK (arc in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBPCFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_FILES ADD CONSTRAINT PK_OBPCFILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCFILES ON BARS.OBPC_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_FILES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_FILES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_FILES      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_FILES      to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_FILES      to OBPC_FILES;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_FILES      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OBPC_FILES      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_FILES.sql =========*** End *** ==
PROMPT ===================================================================================== 
