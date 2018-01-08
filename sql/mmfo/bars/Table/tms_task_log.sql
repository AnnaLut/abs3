

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_TASK_LOG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_TASK_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_TASK_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_TASK_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_TASK_LOG 
   (	ID_GROUP_LOG NUMBER(*,0), 
	ID_TASK NUMBER(*,0), 
	TASK_ACTIVE VARCHAR2(3), 
	START_TIME TIMESTAMP (3), 
	DURATION INTERVAL DAY (2) TO SECOND (6), 
	STATUS_TASK VARCHAR2(50), 
	ERR_MSG VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_TASK_LOG ***
 exec bpa.alter_policies('TMS_TASK_LOG');


COMMENT ON TABLE BARS.TMS_TASK_LOG IS '';
COMMENT ON COLUMN BARS.TMS_TASK_LOG.START_TIME IS '';
COMMENT ON COLUMN BARS.TMS_TASK_LOG.DURATION IS '';
COMMENT ON COLUMN BARS.TMS_TASK_LOG.STATUS_TASK IS '';
COMMENT ON COLUMN BARS.TMS_TASK_LOG.ERR_MSG IS '';
COMMENT ON COLUMN BARS.TMS_TASK_LOG.ID_GROUP_LOG IS '';
COMMENT ON COLUMN BARS.TMS_TASK_LOG.ID_TASK IS '';
COMMENT ON COLUMN BARS.TMS_TASK_LOG.TASK_ACTIVE IS '';



PROMPT *** Create  grants  TMS_TASK_LOG ***
grant SELECT                                                                 on TMS_TASK_LOG    to BARSREADER_ROLE;
grant SELECT                                                                 on TMS_TASK_LOG    to BARS_DM;
grant SELECT                                                                 on TMS_TASK_LOG    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_TASK_LOG.sql =========*** End *** 
PROMPT ===================================================================================== 
