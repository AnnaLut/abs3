

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCANCOPY_QUESTION_TYPES.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCANCOPY_QUESTION_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCANCOPY_QUESTION_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCANCOPY_QUESTION_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCANCOPY_QUESTION_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCANCOPY_QUESTION_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCANCOPY_QUESTION_TYPES 
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




PROMPT *** ALTER_POLICIES to WCS_SCANCOPY_QUESTION_TYPES ***
 exec bpa.alter_policies('WCS_SCANCOPY_QUESTION_TYPES');


COMMENT ON TABLE BARS.WCS_SCANCOPY_QUESTION_TYPES IS 'Типы сканкопий субпродукта';
COMMENT ON COLUMN BARS.WCS_SCANCOPY_QUESTION_TYPES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SCANCOPY_QUESTION_TYPES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_SCOPYQUESTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTION_TYPES ADD CONSTRAINT PK_SCOPYQUESTTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCOPYQUESTTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTION_TYPES MODIFY (NAME CONSTRAINT CC_SCOPYQUESTTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCOPYQUESTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCOPYQUESTTYPES ON BARS.WCS_SCANCOPY_QUESTION_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCANCOPY_QUESTION_TYPES ***
grant SELECT                                                                 on WCS_SCANCOPY_QUESTION_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SCANCOPY_QUESTION_TYPES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCANCOPY_QUESTION_TYPES.sql ======
PROMPT ===================================================================================== 
