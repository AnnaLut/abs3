

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_REPORT_PARAMS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_REPORT_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_REPORT_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_REPORT_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_REPORT_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_REPORT_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_REPORT_PARAMS 
   (	REPORT_ID NUMBER, 
	PARAM_ID NUMBER, 
	NAME VARCHAR2(128), 
	TYPE_ID VARCHAR2(30), 
	PARAM_NAME VARCHAR2(30), 
	DEFAULT_VALUE VARCHAR2(4000), 
	REQUIRED NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_REPORT_PARAMS ***
 exec bpa.alter_policies('CIM_REPORT_PARAMS');


COMMENT ON TABLE BARS.CIM_REPORT_PARAMS IS 'Параметри звітів для модуля CIM v 1.00.02';
COMMENT ON COLUMN BARS.CIM_REPORT_PARAMS.REPORT_ID IS 'ID звіту';
COMMENT ON COLUMN BARS.CIM_REPORT_PARAMS.PARAM_ID IS 'Номер параметру';
COMMENT ON COLUMN BARS.CIM_REPORT_PARAMS.NAME IS 'Найменування параметру';
COMMENT ON COLUMN BARS.CIM_REPORT_PARAMS.TYPE_ID IS 'Тип параметру (допустимі значення: Date, Varchar2, Number, Integer, CheckBox)';
COMMENT ON COLUMN BARS.CIM_REPORT_PARAMS.PARAM_NAME IS 'Імя параметру у звіті FastReport';
COMMENT ON COLUMN BARS.CIM_REPORT_PARAMS.DEFAULT_VALUE IS 'Значення параметру по замовченню';
COMMENT ON COLUMN BARS.CIM_REPORT_PARAMS.REQUIRED IS 'Обов`язковий для заповнення (допустимі значення:1 / null)';




PROMPT *** Create  constraint CC_CIMREPPAR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORT_PARAMS MODIFY (REPORT_ID CONSTRAINT CC_CIMREPPAR_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMREPPAR_PARID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORT_PARAMS MODIFY (PARAM_ID CONSTRAINT CC_CIMREPPAR_PARID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMREPPAR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORT_PARAMS MODIFY (NAME CONSTRAINT CC_CIMREPPAR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMREPPAR_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORT_PARAMS MODIFY (TYPE_ID CONSTRAINT CC_CIMREPPAR_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMREPPARS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORT_PARAMS ADD CONSTRAINT PK_CIMREPPARS PRIMARY KEY (REPORT_ID, PARAM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMREPPARS_REPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORT_PARAMS ADD CONSTRAINT FK_CIMREPPARS_REPS FOREIGN KEY (REPORT_ID)
	  REFERENCES BARS.CIM_REPORTS_LIST (REPORT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMREPPARS_TYPE_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORT_PARAMS ADD CONSTRAINT CC_CIMREPPARS_TYPE_CC CHECK (type_id in (''Date'',''Varchar2'',''Number'', ''Integer'', ''CheckBox'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMREPPARS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMREPPARS ON BARS.CIM_REPORT_PARAMS (REPORT_ID, PARAM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_REPORT_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_REPORT_PARAMS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_REPORT_PARAMS to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_REPORT_PARAMS.sql =========*** End
PROMPT ===================================================================================== 
