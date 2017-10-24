

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_BCK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_BCK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_BCK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_BCK ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_BCK 
   (	BCK_ID NUMBER(38,0), 
	BCK_NAME VARCHAR2(128), 
	SERVICE_METHOD VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_BCK ***
 exec bpa.alter_policies('WCS_BCK');


COMMENT ON TABLE BARS.WCS_BCK IS 'Таблица кредитных бюро, поддерживаемых системой';
COMMENT ON COLUMN BARS.WCS_BCK.BCK_ID IS 'Идентификатор кредитного бюро';
COMMENT ON COLUMN BARS.WCS_BCK.BCK_NAME IS 'Наименование кредитного бюро';
COMMENT ON COLUMN BARS.WCS_BCK.SERVICE_METHOD IS 'Имя метода веб-сервиса';




PROMPT *** Create  constraint CC_WCSBCK_CERVICEMETHOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK ADD CONSTRAINT CC_WCSBCK_CERVICEMETHOD_NN CHECK (SERVICE_METHOD IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCK_BCKNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK ADD CONSTRAINT CC_WCSBCK_BCKNAME_NN CHECK (BCK_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSBCK ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK ADD CONSTRAINT PK_WCSBCK PRIMARY KEY (BCK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177028 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK MODIFY (BCK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSBCK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSBCK ON BARS.WCS_BCK (BCK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_BCK.sql =========*** End *** =====
PROMPT ===================================================================================== 
