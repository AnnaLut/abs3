

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_DOMAIN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_DOMAIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_DOMAIN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_DOMAIN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_DOMAIN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_DOMAIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_DOMAIN 
   (	ATTRIBUTE_ID NUMBER(5,0), 
	DATA_SOURCE VARCHAR2(4000), 
	KEY_COLUMN VARCHAR2(30 CHAR), 
	CODE_EXPRESSION VARCHAR2(4000), 
	NAME_EXPRESSION VARCHAR2(4000), 
	WHERE_CLAUSE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_DOMAIN ***
 exec bpa.alter_policies('ATTRIBUTE_DOMAIN');


COMMENT ON TABLE BARS.ATTRIBUTE_DOMAIN IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_DOMAIN.ATTRIBUTE_ID IS 'Ідентифікатор атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_DOMAIN.DATA_SOURCE IS 'Назва таблиці, де зберігаються допустимі значення атрибуту (або текст SQL-запиту, що може бути використаний замість таблиці)';
COMMENT ON COLUMN BARS.ATTRIBUTE_DOMAIN.KEY_COLUMN IS 'Назва колонки, що являтиме собою ідентифікатор набору допустимих значень - саме це значення зберігатиметься в якості значення атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_DOMAIN.CODE_EXPRESSION IS 'Назва колонки, що представлятиме код з набору допустимих значень - даний код може відображатися в інтерфейсах користувача при виборі значення атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_DOMAIN.NAME_EXPRESSION IS 'Назва колонки, що відображає назву значень атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_DOMAIN.WHERE_CLAUSE IS 'Частина SQL-команди, що буде розміщена у фразі WHERE SQL-запиту. Використовується для накладення фільтру на набір допустимих значень атрибуту';




PROMPT *** Create  constraint PK_ATTRIBUTE_DOMAIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DOMAIN ADD CONSTRAINT PK_ATTRIBUTE_DOMAIN PRIMARY KEY (ATTRIBUTE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005489 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DOMAIN MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005490 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DOMAIN MODIFY (DATA_SOURCE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005491 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DOMAIN MODIFY (KEY_COLUMN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005492 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DOMAIN MODIFY (NAME_EXPRESSION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_DOMAIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTE_DOMAIN ON BARS.ATTRIBUTE_DOMAIN (ATTRIBUTE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_DOMAIN ***
grant SELECT                                                                 on ATTRIBUTE_DOMAIN to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_DOMAIN.sql =========*** End 
PROMPT ===================================================================================== 
