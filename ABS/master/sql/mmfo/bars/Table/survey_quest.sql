

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_QUEST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_QUEST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_QUEST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SURVEY_QUEST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_QUEST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_QUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_QUEST 
   (	QUEST_ID NUMBER(38,0), 
	QUEST_NAME VARCHAR2(250), 
	SURVEY_ID NUMBER(38,0), 
	QGRP_ID NUMBER(38,0), 
	QFMT_ID NUMBER(38,0), 
	QUEST_ORD NUMBER(8,0), 
	QUEST_MULTI NUMBER(1,0), 
	EXTRN_TABNAME VARCHAR2(30), 
	EXTRN_TABKEY VARCHAR2(30), 
	EXTRN_TABVALUE VARCHAR2(30), 
	LIST_ID NUMBER(38,0), 
	QUEST_ID_P NUMBER(38,0), 
	DEFAULT_VAL VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_QUEST ***
 exec bpa.alter_policies('SURVEY_QUEST');


COMMENT ON TABLE BARS.SURVEY_QUEST IS 'Вопросы из анкет клиентов';
COMMENT ON COLUMN BARS.SURVEY_QUEST.QUEST_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.SURVEY_QUEST.QUEST_NAME IS 'Текст вопроса';
COMMENT ON COLUMN BARS.SURVEY_QUEST.SURVEY_ID IS 'Код анкеты';
COMMENT ON COLUMN BARS.SURVEY_QUEST.QGRP_ID IS 'Код группы вопросов';
COMMENT ON COLUMN BARS.SURVEY_QUEST.QFMT_ID IS 'Код формата';
COMMENT ON COLUMN BARS.SURVEY_QUEST.QUEST_ORD IS 'Порядок вопроса в группе';
COMMENT ON COLUMN BARS.SURVEY_QUEST.QUEST_MULTI IS 'Признак неоднозначного ответа';
COMMENT ON COLUMN BARS.SURVEY_QUEST.EXTRN_TABNAME IS 'Наименование баз.спр-ка';
COMMENT ON COLUMN BARS.SURVEY_QUEST.EXTRN_TABKEY IS 'Ключ из баз.спр-ка';
COMMENT ON COLUMN BARS.SURVEY_QUEST.EXTRN_TABVALUE IS 'Семантика из баз.спр-ка';
COMMENT ON COLUMN BARS.SURVEY_QUEST.LIST_ID IS 'Идентификатор списка';
COMMENT ON COLUMN BARS.SURVEY_QUEST.QUEST_ID_P IS 'Программный код вопроса';
COMMENT ON COLUMN BARS.SURVEY_QUEST.DEFAULT_VAL IS '';




PROMPT *** Create  constraint PK_SURVEYQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT PK_SURVEYQUEST PRIMARY KEY (QUEST_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQUEST_QUESTMULTI ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT CC_SURVEYQUEST_QUESTMULTI CHECK (quest_multi IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQUEST_QUESTMULTI_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST MODIFY (QUEST_MULTI CONSTRAINT CC_SURVEYQUEST_QUESTMULTI_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQUEST_QFMTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST MODIFY (QFMT_ID CONSTRAINT CC_SURVEYQUEST_QFMTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQUEST_QGRPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST MODIFY (QGRP_ID CONSTRAINT CC_SURVEYQUEST_QGRPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQUEST_SURVEYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST MODIFY (SURVEY_ID CONSTRAINT CC_SURVEYQUEST_SURVEYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQUEST_QUESTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST MODIFY (QUEST_NAME CONSTRAINT CC_SURVEYQUEST_QUESTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SURVEYQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT UK_SURVEYQUEST UNIQUE (QGRP_ID, QUEST_ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT CC_SURVEYQUEST CHECK ( (qfmt_id = 1 AND list_id IS NOT NULL AND extrn_tabname IS NULL AND extrn_tabkey IS NULL AND extrn_tabvalue IS NULL) 
    OR 
    (qfmt_id = 2 AND list_id IS NULL AND extrn_tabname IS NOT NULL AND extrn_tabkey IS NOT NULL AND extrn_tabvalue IS NOT NULL AND quest_multi = 0) 
    OR 
    (qfmt_id IN (3, 4, 5) AND list_id IS NULL AND extrn_tabname IS NULL AND extrn_tabkey IS NULL AND extrn_tabvalue IS NULL AND quest_multi = 0) 
	) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQUEST_SURVEYOPTLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT FK_SURVEYQUEST_SURVEYOPTLIST FOREIGN KEY (LIST_ID)
	  REFERENCES BARS.SURVEY_OPT_LIST (LIST_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQUEST_SURVEYQGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT FK_SURVEYQUEST_SURVEYQGRP FOREIGN KEY (SURVEY_ID, QGRP_ID)
	  REFERENCES BARS.SURVEY_QGRP (SURVEY_ID, GRP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQUEST_SURVEYQFMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT FK_SURVEYQUEST_SURVEYQFMT FOREIGN KEY (QFMT_ID)
	  REFERENCES BARS.SURVEY_QFMT (FMT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQUEST_SURVEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT FK_SURVEYQUEST_SURVEY FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.SURVEY (SURVEY_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQUEST_QUESTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST MODIFY (QUEST_ID CONSTRAINT CC_SURVEYQUEST_QUESTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SURVEYQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SURVEYQUEST ON BARS.SURVEY_QUEST (QGRP_ID, QUEST_ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYQUEST ON BARS.SURVEY_QUEST (QUEST_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SURVEYQUEST ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SURVEYQUEST ON BARS.SURVEY_QUEST (SURVEY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_SURVEYQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I2_SURVEYQUEST ON BARS.SURVEY_QUEST (SURVEY_ID, DECODE(TO_CHAR(QUEST_ID_P),NULL,QUEST_ID,QUEST_ID_P)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_QUEST ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_QUEST    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY_QUEST    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_QUEST    to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_QUEST    to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_QUEST    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SURVEY_QUEST    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_QUEST.sql =========*** End *** 
PROMPT ===================================================================================== 
