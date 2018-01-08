

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SYNC_METADATA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SYNC_METADATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SYNC_METADATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SYNC_METADATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SYNC_METADATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SYNC_METADATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.SYNC_METADATA 
   (	SERVICE_NAME VARCHAR2(32), 
	DIRECT VARCHAR2(8), 
	BUF_TABLE VARCHAR2(32), 
	QUERY VARCHAR2(4000), 
	QUERY_NAMES VARCHAR2(1024), 
	QUERY_TYPES VARCHAR2(1024), 
	PRE_FUNC VARCHAR2(4000), 
	POST_FUNC VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SYNC_METADATA ***
 exec bpa.alter_policies('SYNC_METADATA');


COMMENT ON TABLE BARS.SYNC_METADATA IS 'Налаштування WEB-сервісів обміну даними';
COMMENT ON COLUMN BARS.SYNC_METADATA.SERVICE_NAME IS 'Напрям передачі даних через  WEB-сервіс ( INIT / RESPONSE )';
COMMENT ON COLUMN BARS.SYNC_METADATA.DIRECT IS 'Назва WEB-сервісу';
COMMENT ON COLUMN BARS.SYNC_METADATA.BUF_TABLE IS 'Назва таблиці для зберігання даних, які надійшли через WEB-сервіс';
COMMENT ON COLUMN BARS.SYNC_METADATA.QUERY IS 'Скрипт вибірки даних для відправки через WEB-сервіс';
COMMENT ON COLUMN BARS.SYNC_METADATA.QUERY_NAMES IS 'Імена полів даних скрипта вибірки даних для відправки через WEB-сервіс';
COMMENT ON COLUMN BARS.SYNC_METADATA.QUERY_TYPES IS 'Типи полів даних скрипта вибірки даних для відправки через WEB-сервіс (str, num, date)';
COMMENT ON COLUMN BARS.SYNC_METADATA.PRE_FUNC IS 'Скрипт виклику функції перед відправкою даних через WEB-сервіс відповідачем';
COMMENT ON COLUMN BARS.SYNC_METADATA.POST_FUNC IS 'Скрипт виклику функції після відправки даних через WEB-сервіс відповідачем';




PROMPT *** Create  constraint PK_SYNCMETADATA_SNAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_METADATA ADD CONSTRAINT PK_SYNCMETADATA_SNAME PRIMARY KEY (SERVICE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCMETADATA_DIRECT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_METADATA ADD CONSTRAINT CC_SYNCMETADATA_DIRECT CHECK (direct in (''INIT'', ''RESPONSE'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SYNCMETADATA_SNAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SYNCMETADATA_SNAME ON BARS.SYNC_METADATA (SERVICE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SYNC_METADATA ***
grant SELECT                                                                 on SYNC_METADATA   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SYNC_METADATA   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SYNC_METADATA.sql =========*** End ***
PROMPT ===================================================================================== 
