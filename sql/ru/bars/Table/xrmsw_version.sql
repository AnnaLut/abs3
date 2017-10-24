

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_VERSION.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_VERSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_VERSION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_VERSION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_VERSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_VERSION 
   (	VERSION_DATE DATE, 
	INSTALL_DATE DATE DEFAULT sysdate, 
	VERSION_ID VARCHAR2(10), 
	CHANGETYPE VARCHAR2(10), 
	DESCRIPTION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XRMSW_VERSION ***
 exec bpa.alter_policies('XRMSW_VERSION');


COMMENT ON TABLE BARS.XRMSW_VERSION IS 'Версії ПЗ інтеграція з ЄВ';
COMMENT ON COLUMN BARS.XRMSW_VERSION.VERSION_DATE IS 'Дата релізу';
COMMENT ON COLUMN BARS.XRMSW_VERSION.INSTALL_DATE IS 'Дата встановлення на БД';
COMMENT ON COLUMN BARS.XRMSW_VERSION.VERSION_ID IS 'Номер версії ПЗ';
COMMENT ON COLUMN BARS.XRMSW_VERSION.CHANGETYPE IS 'Тип змін (web, sql, web+sql)';
COMMENT ON COLUMN BARS.XRMSW_VERSION.DESCRIPTION IS 'Коментар до версії';




PROMPT *** Create  constraint SYS_C003257661 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_VERSION MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003257660 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_VERSION MODIFY (CHANGETYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003257659 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_VERSION MODIFY (VERSION_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_XRMVERSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_XRMVERSION ON BARS.XRMSW_VERSION (VERSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XRMSW_VERSION ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on XRMSW_VERSION   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_VERSION.sql =========*** End ***
PROMPT ===================================================================================== 
