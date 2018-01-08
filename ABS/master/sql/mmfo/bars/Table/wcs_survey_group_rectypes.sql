

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SURVEY_GROUP_RECTYPES.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SURVEY_GROUP_RECTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SURVEY_GROUP_RECTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEY_GROUP_RECTYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEY_GROUP_RECTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SURVEY_GROUP_RECTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SURVEY_GROUP_RECTYPES 
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




PROMPT *** ALTER_POLICIES to WCS_SURVEY_GROUP_RECTYPES ***
 exec bpa.alter_policies('WCS_SURVEY_GROUP_RECTYPES');


COMMENT ON TABLE BARS.WCS_SURVEY_GROUP_RECTYPES IS 'Типы информационных запросов';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_RECTYPES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_RECTYPES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_SURGRPRECTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_RECTYPES ADD CONSTRAINT PK_SURGRPRECTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURGRPRECTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_RECTYPES MODIFY (NAME CONSTRAINT CC_SURGRPRECTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURGRPRECTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURGRPRECTYPES ON BARS.WCS_SURVEY_GROUP_RECTYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SURVEY_GROUP_RECTYPES ***
grant SELECT                                                                 on WCS_SURVEY_GROUP_RECTYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SURVEY_GROUP_RECTYPES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SURVEY_GROUP_RECTYPES.sql ========
PROMPT ===================================================================================== 
