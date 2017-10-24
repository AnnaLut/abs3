

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_JOB_STATUSES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_JOB_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_JOB_STATUSES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_JOB_STATUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_JOB_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_JOB_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_JOB_STATUSES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_JOB_STATUSES ***
 exec bpa.alter_policies('WCS_JOB_STATUSES');


COMMENT ON TABLE BARS.WCS_JOB_STATUSES IS 'Статусы JOBов';
COMMENT ON COLUMN BARS.WCS_JOB_STATUSES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_JOB_STATUSES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_JOBSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOB_STATUSES ADD CONSTRAINT PK_JOBSTATUSES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_JOBSTATUSES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOB_STATUSES MODIFY (NAME CONSTRAINT CC_JOBSTATUSES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_JOBSTATUSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_JOBSTATUSES ON BARS.WCS_JOB_STATUSES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_JOB_STATUSES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_JOB_STATUSES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_JOB_STATUSES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_JOB_STATUSES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_JOB_STATUSES.sql =========*** End 
PROMPT ===================================================================================== 
