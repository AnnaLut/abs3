

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_FILE_TYPE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_FILE_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_FILE_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_FILE_TYPE'', ''FILIAL'' , null, ''E'', null, null);
               bpa.alter_policy_info(''OW_FILE_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_FILE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_FILE_TYPE 
   (	FILE_TYPE VARCHAR2(30), 
	NAME VARCHAR2(100), 
	IO VARCHAR2(1), 
	PRIORITY NUMBER(10,0), 
	TYPE NUMBER(1,0), 
	OFFSET NUMBER, 
	OFFSETEXPIRE VARCHAR2(8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_FILE_TYPE ***
 exec bpa.alter_policies('OW_FILE_TYPE');


COMMENT ON TABLE BARS.OW_FILE_TYPE IS 'W4. Типы файлов для импорта';
COMMENT ON COLUMN BARS.OW_FILE_TYPE.FILE_TYPE IS '';
COMMENT ON COLUMN BARS.OW_FILE_TYPE.NAME IS '';
COMMENT ON COLUMN BARS.OW_FILE_TYPE.IO IS 'Направление: I-входящие файлы, O-исходящие файлы';
COMMENT ON COLUMN BARS.OW_FILE_TYPE.PRIORITY IS 'Приоритет обработки';
COMMENT ON COLUMN BARS.OW_FILE_TYPE.TYPE IS 'Тип файла: 1-файл документов ПЦ (надо платить)';
COMMENT ON COLUMN BARS.OW_FILE_TYPE.OFFSET IS '';
COMMENT ON COLUMN BARS.OW_FILE_TYPE.OFFSETEXPIRE IS '';




PROMPT *** Create  constraint CC_OWFILETYPE_IO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILE_TYPE ADD CONSTRAINT CC_OWFILETYPE_IO_NN CHECK (io is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILETYPE_PRIORITY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILE_TYPE ADD CONSTRAINT CC_OWFILETYPE_PRIORITY_NN CHECK (priority is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILETYPE_IO ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILE_TYPE ADD CONSTRAINT CC_OWFILETYPE_IO CHECK (io in (''I'',''O'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWFILETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILE_TYPE ADD CONSTRAINT PK_OWFILETYPE PRIMARY KEY (FILE_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWFILETYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWFILETYPE ON BARS.OW_FILE_TYPE (FILE_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_FILE_TYPE ***
grant SELECT                                                                 on OW_FILE_TYPE    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_FILE_TYPE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_FILE_TYPE    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_FILE_TYPE    to OW;
grant SELECT                                                                 on OW_FILE_TYPE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_FILE_TYPE.sql =========*** End *** 
PROMPT ===================================================================================== 
