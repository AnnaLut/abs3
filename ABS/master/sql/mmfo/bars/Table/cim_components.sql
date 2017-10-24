

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_COMPONENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_COMPONENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_COMPONENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_COMPONENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_COMPONENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_COMPONENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_COMPONENTS 
   (	FILE_NAME VARCHAR2(128), 
	VERSION VARCHAR2(12), 
	INSTALL_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_COMPONENTS ***
 exec bpa.alter_policies('CIM_COMPONENTS');


COMMENT ON TABLE BARS.CIM_COMPONENTS IS 'Компоненти модуля CIM';
COMMENT ON COLUMN BARS.CIM_COMPONENTS.FILE_NAME IS 'НАзва файла';
COMMENT ON COLUMN BARS.CIM_COMPONENTS.VERSION IS 'Версія компонента (файла)';
COMMENT ON COLUMN BARS.CIM_COMPONENTS.INSTALL_DATE IS 'Дата та час установки';




PROMPT *** Create  constraint PK_CIMCOMPONENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_COMPONENTS ADD CONSTRAINT PK_CIMCOMPONENTS PRIMARY KEY (FILE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCOMPONENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCOMPONENTS ON BARS.CIM_COMPONENTS (FILE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_COMPONENTS ***
grant SELECT                                                                 on CIM_COMPONENTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_COMPONENTS  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_COMPONENTS.sql =========*** End **
PROMPT ===================================================================================== 
