

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_ANSWER_OPT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_ANSWER_OPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_ANSWER_OPT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SURVEY_ANSWER_OPT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_ANSWER_OPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_ANSWER_OPT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_ANSWER_OPT 
   (	OPT_ID NUMBER(38,0), 
	OPT_VAL VARCHAR2(250), 
	OPT_ORD NUMBER(8,0), 
	OPT_DFLT NUMBER(1,0), 
	LIST_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_ANSWER_OPT ***
 exec bpa.alter_policies('SURVEY_ANSWER_OPT');


COMMENT ON TABLE BARS.SURVEY_ANSWER_OPT IS 'Варианты ответов на вопросы из анкет клиентов';
COMMENT ON COLUMN BARS.SURVEY_ANSWER_OPT.OPT_ID IS 'Идентификатор варианта ответа';
COMMENT ON COLUMN BARS.SURVEY_ANSWER_OPT.OPT_VAL IS 'Текст варианта ответа';
COMMENT ON COLUMN BARS.SURVEY_ANSWER_OPT.OPT_ORD IS '№ п/п варианта ответа';
COMMENT ON COLUMN BARS.SURVEY_ANSWER_OPT.OPT_DFLT IS 'Признак ответа по умолчанию';
COMMENT ON COLUMN BARS.SURVEY_ANSWER_OPT.LIST_ID IS 'Идентификатор списка';




PROMPT *** Create  constraint CC_SURVEYANSWOPT_OPTDFLT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER_OPT ADD CONSTRAINT CC_SURVEYANSWOPT_OPTDFLT CHECK (opt_dflt IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SURVEYANSWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER_OPT ADD CONSTRAINT PK_SURVEYANSWOPT PRIMARY KEY (OPT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SURVEYANSWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER_OPT ADD CONSTRAINT UK_SURVEYANSWOPT UNIQUE (LIST_ID, OPT_ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWOPT_OPTVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER_OPT MODIFY (OPT_VAL CONSTRAINT CC_SURVEYANSWOPT_OPTVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWOPT_OPTORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER_OPT MODIFY (OPT_ORD CONSTRAINT CC_SURVEYANSWOPT_OPTORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWOPT_OPTDFLT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER_OPT MODIFY (OPT_DFLT CONSTRAINT CC_SURVEYANSWOPT_OPTDFLT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWOPT_LISTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER_OPT MODIFY (LIST_ID CONSTRAINT CC_SURVEYANSWOPT_LISTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SURVEYANSWOPT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SURVEYANSWOPT ON BARS.SURVEY_ANSWER_OPT (LIST_ID, OPT_ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYANSWOPT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYANSWOPT ON BARS.SURVEY_ANSWER_OPT (OPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_SURVEYANSWOPT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I2_SURVEYANSWOPT ON BARS.SURVEY_ANSWER_OPT (DECODE(OPT_DFLT,1,LIST_ID,NULL), DECODE(OPT_DFLT,1,1,NULL)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_ANSWER_OPT ***
grant SELECT                                                                 on SURVEY_ANSWER_OPT to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_ANSWER_OPT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY_ANSWER_OPT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_ANSWER_OPT to DPT_ADMIN;
grant SELECT                                                                 on SURVEY_ANSWER_OPT to RCC_DEAL;
grant SELECT                                                                 on SURVEY_ANSWER_OPT to START1;
grant SELECT                                                                 on SURVEY_ANSWER_OPT to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_ANSWER_OPT to WR_ALL_RIGHTS;
grant SELECT                                                                 on SURVEY_ANSWER_OPT to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on SURVEY_ANSWER_OPT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_ANSWER_OPT.sql =========*** End
PROMPT ===================================================================================== 
