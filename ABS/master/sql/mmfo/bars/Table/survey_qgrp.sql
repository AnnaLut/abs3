

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_QGRP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_QGRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_QGRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SURVEY_QGRP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_QGRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_QGRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_QGRP 
   (	GRP_ID NUMBER(38,0), 
	GRP_NUMBER NUMBER(38,0), 
	GRP_NAME VARCHAR2(100), 
	GRP_ORD NUMBER(8,0), 
	SURVEY_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_QGRP ***
 exec bpa.alter_policies('SURVEY_QGRP');


COMMENT ON TABLE BARS.SURVEY_QGRP IS 'Группы вопросов из анкет клиентов';
COMMENT ON COLUMN BARS.SURVEY_QGRP.GRP_ID IS 'Идентификатор группы';
COMMENT ON COLUMN BARS.SURVEY_QGRP.GRP_NUMBER IS 'Номер группы';
COMMENT ON COLUMN BARS.SURVEY_QGRP.GRP_NAME IS 'Наименование группы';
COMMENT ON COLUMN BARS.SURVEY_QGRP.GRP_ORD IS 'Порядок следования группы в анкете';
COMMENT ON COLUMN BARS.SURVEY_QGRP.SURVEY_ID IS 'Идентификатор анкеты';




PROMPT *** Create  constraint PK_SURVEYQGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QGRP ADD CONSTRAINT PK_SURVEYQGRP PRIMARY KEY (GRP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SURVEYQGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QGRP ADD CONSTRAINT UK_SURVEYQGRP UNIQUE (SURVEY_ID, GRP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQGRP_SURVEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QGRP ADD CONSTRAINT FK_SURVEYQGRP_SURVEY FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.SURVEY (SURVEY_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQGRP_GRPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QGRP MODIFY (GRP_ID CONSTRAINT CC_SURVEYQGRP_GRPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQGRP_GRPNUMBER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QGRP MODIFY (GRP_NUMBER CONSTRAINT CC_SURVEYQGRP_GRPNUMBER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQGRP_GRPNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QGRP MODIFY (GRP_NAME CONSTRAINT CC_SURVEYQGRP_GRPNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQGRP_SURVEYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QGRP MODIFY (SURVEY_ID CONSTRAINT CC_SURVEYQGRP_SURVEYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYQGRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYQGRP ON BARS.SURVEY_QGRP (GRP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SURVEYQGRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SURVEYQGRP ON BARS.SURVEY_QGRP (SURVEY_ID, GRP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_QGRP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_QGRP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY_QGRP     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_QGRP     to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_QGRP     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_QGRP.sql =========*** End *** =
PROMPT ===================================================================================== 
