

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_PAYMENT_TYPE_QUESTIONS.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_PAYMENT_TYPE_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_PAYMENT_TYPE_QUESTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PAYMENT_TYPE_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PAYMENT_TYPE_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_PAYMENT_TYPE_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_PAYMENT_TYPE_QUESTIONS 
   (	TYPE_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_PAYMENT_TYPE_QUESTIONS ***
 exec bpa.alter_policies('WCS_PAYMENT_TYPE_QUESTIONS');


COMMENT ON TABLE BARS.WCS_PAYMENT_TYPE_QUESTIONS IS 'Связь системных вопросов и типов выдачи';
COMMENT ON COLUMN BARS.WCS_PAYMENT_TYPE_QUESTIONS.TYPE_ID IS 'Идентификатор способа выдачи';
COMMENT ON COLUMN BARS.WCS_PAYMENT_TYPE_QUESTIONS.QUESTION_ID IS 'Идентификатор вопроса';




PROMPT *** Create  constraint PK_PMTTYPEQS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PAYMENT_TYPE_QUESTIONS ADD CONSTRAINT PK_PMTTYPEQS PRIMARY KEY (TYPE_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPPAYMENTS_TID_PMTTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PAYMENT_TYPE_QUESTIONS ADD CONSTRAINT FK_SBPPAYMENTS_TID_PMTTS_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_PAYMENT_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPPAYMENTS_QID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PAYMENT_TYPE_QUESTIONS ADD CONSTRAINT FK_SBPPAYMENTS_QID_QUESTS_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PMTTYPEQS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PMTTYPEQS ON BARS.WCS_PAYMENT_TYPE_QUESTIONS (TYPE_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_PAYMENT_TYPE_QUESTIONS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_PAYMENT_TYPE_QUESTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PAYMENT_TYPE_QUESTIONS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_PAYMENT_TYPE_QUESTIONS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_PAYMENT_TYPE_QUESTIONS.sql =======
PROMPT ===================================================================================== 
