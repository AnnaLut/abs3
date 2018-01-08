

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_STATE_HISTORY_ACTION.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_STATE_HISTORY_ACTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_STATE_HISTORY_ACTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_STATE_HISTORY_ACTION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_STATE_HISTORY_ACTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_STATE_HISTORY_ACTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_STATE_HISTORY_ACTION 
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




PROMPT *** ALTER_POLICIES to WCS_STATE_HISTORY_ACTION ***
 exec bpa.alter_policies('WCS_STATE_HISTORY_ACTION');


COMMENT ON TABLE BARS.WCS_STATE_HISTORY_ACTION IS 'Действия над состоянием заявки';
COMMENT ON COLUMN BARS.WCS_STATE_HISTORY_ACTION.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_STATE_HISTORY_ACTION.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_STATEHISTACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STATE_HISTORY_ACTION ADD CONSTRAINT PK_STATEHISTACT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STATEHISTACT_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STATE_HISTORY_ACTION MODIFY (NAME CONSTRAINT CC_STATEHISTACT_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STATEHISTACT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STATEHISTACT ON BARS.WCS_STATE_HISTORY_ACTION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_STATE_HISTORY_ACTION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_STATE_HISTORY_ACTION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_STATE_HISTORY_ACTION to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_STATE_HISTORY_ACTION to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_STATE_HISTORY_ACTION.sql =========
PROMPT ===================================================================================== 
