

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_TASK_STATUSES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_TASK_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_TASK_STATUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_TASK_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_TASK_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_TASK_STATUSES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	DAYS_FROM NUMBER, 
	DAYS_TO NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_TASK_STATUSES ***
 exec bpa.alter_policies('INS_TASK_STATUSES');


COMMENT ON TABLE BARS.INS_TASK_STATUSES IS 'Статуси завдань по платіжним графікам по договорам страхування';
COMMENT ON COLUMN BARS.INS_TASK_STATUSES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_TASK_STATUSES.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.INS_TASK_STATUSES.DAYS_FROM IS 'Cповіщення починаючи з дня';
COMMENT ON COLUMN BARS.INS_TASK_STATUSES.DAYS_TO IS 'Cповіщення закінчуючи днем';




PROMPT *** Create  constraint PK_INSTASKSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TASK_STATUSES ADD CONSTRAINT PK_INSTASKSTATUSES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSTASKSTATUSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSTASKSTATUSES ON BARS.INS_TASK_STATUSES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_TASK_STATUSES.sql =========*** End
PROMPT ===================================================================================== 
