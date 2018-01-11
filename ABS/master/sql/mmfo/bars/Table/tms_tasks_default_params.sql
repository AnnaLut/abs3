

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



PROMPT *** Create  grants  TMS_TASKS_DEFAULT_PARAMS ***
grant SELECT                                                                 on TMS_TASKS_DEFAULT_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on TMS_TASKS_DEFAULT_PARAMS to BARS_DM;
grant SELECT                                                                 on TMS_TASKS_DEFAULT_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_TASKS_DEFAULT_PARAMS.sql =========
PROMPT ===================================================================================== 
