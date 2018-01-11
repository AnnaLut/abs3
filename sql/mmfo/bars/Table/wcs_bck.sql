

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_BCK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_BCK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_BCK'', ''CENTER'' , null, null, null, null);
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




PROMPT *** Create  constraint CC_WCSBCK_BCKNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK MODIFY (BCK_NAME CONSTRAINT CC_WCSBCK_BCKNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCK_CERVICEMETHOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK MODIFY (SERVICE_METHOD CONSTRAINT CC_WCSBCK_CERVICEMETHOD_NN NOT NULL ENABLE)';
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



PROMPT *** Create  grants  WCS_BCK ***
grant SELECT                                                                 on WCS_BCK         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_BCK         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK         to START1;
grant SELECT                                                                 on WCS_BCK         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_BCK.sql =========*** End *** =====
PROMPT ===================================================================================== 
