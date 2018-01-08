

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SURVEYS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SURVEYS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SURVEYS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEYS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEYS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SURVEYS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SURVEYS 
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




PROMPT *** ALTER_POLICIES to WCS_SURVEYS ***
 exec bpa.alter_policies('WCS_SURVEYS');


COMMENT ON TABLE BARS.WCS_SURVEYS IS 'Карты-анкеты';
COMMENT ON COLUMN BARS.WCS_SURVEYS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SURVEYS.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_WCSSURVEYS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEYS ADD CONSTRAINT PK_WCSSURVEYS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSURVEYS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEYS MODIFY (NAME CONSTRAINT CC_WCSSURVEYS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSURVEYS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSURVEYS ON BARS.WCS_SURVEYS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SURVEYS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SURVEYS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SURVEYS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SURVEYS     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SURVEYS.sql =========*** End *** =
PROMPT ===================================================================================== 
