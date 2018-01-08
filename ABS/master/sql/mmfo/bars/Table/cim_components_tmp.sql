

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_COMPONENTS_TMP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_COMPONENTS_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_COMPONENTS_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_COMPONENTS_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_COMPONENTS_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_COMPONENTS_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CIM_COMPONENTS_TMP 
   (	FILE_NAME VARCHAR2(128), 
	VERSION VARCHAR2(12)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_COMPONENTS_TMP ***
 exec bpa.alter_policies('CIM_COMPONENTS_TMP');


COMMENT ON TABLE BARS.CIM_COMPONENTS_TMP IS 'Компоненти модуля CIM';
COMMENT ON COLUMN BARS.CIM_COMPONENTS_TMP.FILE_NAME IS 'НАзва файла';
COMMENT ON COLUMN BARS.CIM_COMPONENTS_TMP.VERSION IS 'Версія компонента (файла)';




PROMPT *** Create  constraint PK_CIMCOMPONENTS_TMP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_COMPONENTS_TMP ADD CONSTRAINT PK_CIMCOMPONENTS_TMP PRIMARY KEY (FILE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCOMPONENTS_TMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCOMPONENTS_TMP ON BARS.CIM_COMPONENTS_TMP (FILE_NAME) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_COMPONENTS_TMP ***
grant SELECT                                                                 on CIM_COMPONENTS_TMP to BARSREADER_ROLE;
grant SELECT                                                                 on CIM_COMPONENTS_TMP to BARS_DM;
grant SELECT                                                                 on CIM_COMPONENTS_TMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_COMPONENTS_TMP.sql =========*** En
PROMPT ===================================================================================== 
