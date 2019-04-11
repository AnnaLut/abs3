PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/PROCESS_WORKFLOW_DEPENDENCY.sql == *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''PROCESS_WORKFLOW_DEPENDENCY'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS_WORKFLOW_DEPENDENCY'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS_WORKFLOW_DEPENDENCY'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table PROCESS_WORKFLOW_DEPENDENCY ***
begin 
   execute immediate '
   CREATE TABLE PROCESS_WORKFLOW_DEPENDENCY  
   (
      PRIMARY_ACTIVITY_ID   NUMBER(38) NOT NULL,
      FOLLOWING_ACTIVITY_ID NUMBER(38) NOT NULL
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to PROCESS_WORKFLOW_DEPENDENCY ***
exec bpa.alter_policies('PROCESS_WORKFLOW_DEPENDENCY');

COMMENT ON TABLE  BARS.PROCESS_WORKFLOW_DEPENDENCY                       IS 'Залежність кроків';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW_DEPENDENCY.PRIMARY_ACTIVITY_ID   IS 'Головний крок';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW_DEPENDENCY.FOLLOWING_ACTIVITY_ID IS 'Наступний крок';

PROMPT *** Create unique index UIX_PROC_WORKFLOW_DEPENDENCY ***
begin   
   execute immediate '
   CREATE UNIQUE INDEX BARS.UIX_PROC_WORKFLOW_DEPENDENCY ON BARS.PROCESS_WORKFLOW_DEPENDENCY (PRIMARY_ACTIVITY_ID, FOLLOWING_ACTIVITY_ID) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create index IDX_PROC_WRKFLOW_DEP_FOLLOWER ***
begin   
   execute immediate '
   CREATE INDEX BARS.IDX_PROC_WRKFLOW_DEP_FOLLOWER ON BARS.PROCESS_WORKFLOW_DEPENDENCY (FOLLOWING_ACTIVITY_ID) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  PROCESS_WORKFLOW_DEPENDENCY ***
grant SELECT, INSERT, UPDATE, DELETE on PROCESS_WORKFLOW_DEPENDENCY to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/PROCESS_WORKFLOW_DEPENDENCY.sql == *** End ***
PROMPT ===================================================================================== 
