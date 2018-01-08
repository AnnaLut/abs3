

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CALL_TAB_NAME.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CALL_TAB_NAME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CALL_TAB_NAME'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CALL_TAB_NAME'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CALL_TAB_NAME ***
begin 
  execute immediate '
  CREATE TABLE BARS.CALL_TAB_NAME 
   (	NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CALL_TAB_NAME ***
 exec bpa.alter_policies('CALL_TAB_NAME');


COMMENT ON TABLE BARS.CALL_TAB_NAME IS 'Список таблиц для вызова';
COMMENT ON COLUMN BARS.CALL_TAB_NAME.NAME IS 'Имя таблицы';




PROMPT *** Create  constraint SYS_C00138707 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CALL_TAB_NAME MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CALLTABNAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.CALL_TAB_NAME ADD CONSTRAINT PK_CALLTABNAME PRIMARY KEY (NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CALLTABNAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CALLTABNAME ON BARS.CALL_TAB_NAME (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CALL_TAB_NAME ***
grant SELECT                                                                 on CALL_TAB_NAME   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CALL_TAB_NAME.sql =========*** End ***
PROMPT ===================================================================================== 
