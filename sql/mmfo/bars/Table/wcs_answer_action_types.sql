

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_ANSWER_ACTION_TYPES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_ANSWER_ACTION_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_ANSWER_ACTION_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_ANSWER_ACTION_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_ANSWER_ACTION_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_ANSWER_ACTION_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_ANSWER_ACTION_TYPES 
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




PROMPT *** ALTER_POLICIES to WCS_ANSWER_ACTION_TYPES ***
 exec bpa.alter_policies('WCS_ANSWER_ACTION_TYPES');


COMMENT ON TABLE BARS.WCS_ANSWER_ACTION_TYPES IS 'Типы действий над ответом';
COMMENT ON COLUMN BARS.WCS_ANSWER_ACTION_TYPES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_ANSWER_ACTION_TYPES.NAME IS 'Наименование';




PROMPT *** Create  constraint CC_ANSWACTTPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_ANSWER_ACTION_TYPES MODIFY (NAME CONSTRAINT CC_ANSWACTTPS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ANSWACTTPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_ANSWER_ACTION_TYPES ADD CONSTRAINT PK_ANSWACTTPS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ANSWACTTPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ANSWACTTPS ON BARS.WCS_ANSWER_ACTION_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_ANSWER_ACTION_TYPES ***
grant SELECT                                                                 on WCS_ANSWER_ACTION_TYPES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_ANSWER_ACTION_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_ANSWER_ACTION_TYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_ANSWER_ACTION_TYPES to START1;
grant SELECT                                                                 on WCS_ANSWER_ACTION_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_ANSWER_ACTION_TYPES.sql =========*
PROMPT ===================================================================================== 
