

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_BRANCH_STAGE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_BRANCH_STAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_BRANCH_STAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_BRANCH_STAGE'', ''FILIAL'' , ''P'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''TMS_BRANCH_STAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_BRANCH_STAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_BRANCH_STAGE 
   (	BRANCH VARCHAR2(30 CHAR), 
	STAGE_ID NUMBER(5,0), 
	SYS_TIME DATE, 
	USER_ID NUMBER(38,0), 
	RUN_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_BRANCH_STAGE ***
 exec bpa.alter_policies('TMS_BRANCH_STAGE');


COMMENT ON TABLE BARS.TMS_BRANCH_STAGE IS '';
COMMENT ON COLUMN BARS.TMS_BRANCH_STAGE.BRANCH IS '';
COMMENT ON COLUMN BARS.TMS_BRANCH_STAGE.STAGE_ID IS '';
COMMENT ON COLUMN BARS.TMS_BRANCH_STAGE.SYS_TIME IS '';
COMMENT ON COLUMN BARS.TMS_BRANCH_STAGE.USER_ID IS '';
COMMENT ON COLUMN BARS.TMS_BRANCH_STAGE.RUN_ID IS '';




PROMPT *** Create  constraint SYS_C0035432 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_BRANCH_STAGE MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035435 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_BRANCH_STAGE MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035434 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_BRANCH_STAGE MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035433 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_BRANCH_STAGE MODIFY (STAGE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_BRANCH_STAGE.sql =========*** End 
PROMPT ===================================================================================== 
