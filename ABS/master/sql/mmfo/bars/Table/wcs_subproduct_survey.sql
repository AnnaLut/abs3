

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_SURVEY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_SURVEY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SURVEY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SURVEY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SURVEY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_SURVEY ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_SURVEY 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	SURVEY_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_SURVEY ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_SURVEY');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_SURVEY IS 'Анкета клиента';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_SURVEY.SUBPRODUCT_ID IS 'Идентификатор субродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_SURVEY.SURVEY_ID IS 'Идентификатор анкеты';




PROMPT *** Create  constraint PK_SUBPRODUCTSURVEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SURVEY ADD CONSTRAINT PK_SUBPRODUCTSURVEY PRIMARY KEY (SUBPRODUCT_ID, SURVEY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SUBPRODUCTSURVEY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SUBPRODUCTSURVEY ON BARS.WCS_SUBPRODUCT_SURVEY (SUBPRODUCT_ID, SURVEY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_SURVEY ***
grant SELECT                                                                 on WCS_SUBPRODUCT_SURVEY to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_SURVEY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_SURVEY to BARS_DM;
grant SELECT                                                                 on WCS_SUBPRODUCT_SURVEY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_SURVEY.sql =========***
PROMPT ===================================================================================== 
