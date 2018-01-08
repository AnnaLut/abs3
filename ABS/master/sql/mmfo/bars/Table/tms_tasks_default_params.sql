

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_TASKS_DEFAULT_PARAMS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_TASKS_DEFAULT_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_TASKS_DEFAULT_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_TASKS_DEFAULT_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_TASKS_DEFAULT_PARAMS 
   (	TASK_ID NUMBER(*,0), 
	PARAM_NAME VARCHAR2(30), 
	PARAM_VALUE VARCHAR2(500), 
	PARAM_TYPE VARCHAR2(50), 
	PARAM_POSITION NUMBER(*,0), 
	PARAM_INITIALIZATION VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_TASKS_DEFAULT_PARAMS ***
 exec bpa.alter_policies('TMS_TASKS_DEFAULT_PARAMS');


COMMENT ON TABLE BARS.TMS_TASKS_DEFAULT_PARAMS IS '';
COMMENT ON COLUMN BARS.TMS_TASKS_DEFAULT_PARAMS.TASK_ID IS '';
COMMENT ON COLUMN BARS.TMS_TASKS_DEFAULT_PARAMS.PARAM_NAME IS '';
COMMENT ON COLUMN BARS.TMS_TASKS_DEFAULT_PARAMS.PARAM_VALUE IS '';
COMMENT ON COLUMN BARS.TMS_TASKS_DEFAULT_PARAMS.PARAM_TYPE IS '';
COMMENT ON COLUMN BARS.TMS_TASKS_DEFAULT_PARAMS.PARAM_POSITION IS '';
COMMENT ON COLUMN BARS.TMS_TASKS_DEFAULT_PARAMS.PARAM_INITIALIZATION IS '';




PROMPT *** Create  constraint FK_TASK_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASKS_DEFAULT_PARAMS ADD CONSTRAINT FK_TASK_ID FOREIGN KEY (TASK_ID)
	  REFERENCES BARS.TMS_LIST_TASKS (TASK_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMS_TASKS_DEFAULT_PARAMS ***
grant SELECT                                                                 on TMS_TASKS_DEFAULT_PARAMS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_TASKS_DEFAULT_PARAMS.sql =========
PROMPT ===================================================================================== 
