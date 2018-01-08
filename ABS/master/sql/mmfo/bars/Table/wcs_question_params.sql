

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_QUESTION_PARAMS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_QUESTION_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_QUESTION_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_QUESTION_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_QUESTION_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_QUESTION_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_QUESTION_PARAMS 
   (	QUESTION_ID VARCHAR2(100), 
	TEXT_LENG_MIN VARCHAR2(4000), 
	TEXT_LENG_MAX VARCHAR2(4000), 
	TEXT_VAL_DEFAULT VARCHAR2(4000), 
	TEXT_WIDTH NUMBER, 
	TEXT_ROWS NUMBER, 
	NMBDEC_VAL_MIN VARCHAR2(4000), 
	NMBDEC_VAL_MAX VARCHAR2(4000), 
	NMBDEC_VAL_DEFAULT VARCHAR2(4000), 
	DAT_VAL_MIN VARCHAR2(4000), 
	DAT_VAL_MAX VARCHAR2(4000), 
	DAT_VAL_DEFAULT VARCHAR2(4000), 
	LIST_SID_DEFAULT VARCHAR2(4000), 
	REFER_SID_DEFAULT VARCHAR2(4000), 
	BOOL_VAL_DEFAULT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_QUESTION_PARAMS ***
 exec bpa.alter_policies('WCS_QUESTION_PARAMS');


COMMENT ON TABLE BARS.WCS_QUESTION_PARAMS IS 'Парамерты вопроса (мин, макс, дефолтное значение)';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.TEXT_VAL_DEFAULT IS 'Дефолтное значение текстового поля';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.TEXT_WIDTH IS 'Ширина текстового поля';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.TEXT_ROWS IS 'Кол-во рядков текстового поля';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.NMBDEC_VAL_MIN IS 'Минимальное значение числа';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.NMBDEC_VAL_MAX IS 'Максимальное значение числа';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.NMBDEC_VAL_DEFAULT IS 'Дефолтное значение числа';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.DAT_VAL_MIN IS 'Минимальное значение даты';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.DAT_VAL_MAX IS 'Максимальное значение даты';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.DAT_VAL_DEFAULT IS 'Дефолтное значение даты';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.LIST_SID_DEFAULT IS 'Дефолтное значение выбраное из списка';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.REFER_SID_DEFAULT IS 'Дефолтное значение выбраное из справочника';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.BOOL_VAL_DEFAULT IS 'Дефолтное значение булевого вопроса';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.TEXT_LENG_MIN IS 'Минимальная длина текстового поля';
COMMENT ON COLUMN BARS.WCS_QUESTION_PARAMS.TEXT_LENG_MAX IS 'Максимальная длина текстового поля';




PROMPT *** Create  constraint PK_QUESTIONPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_PARAMS ADD CONSTRAINT PK_QUESTIONPARAMS PRIMARY KEY (QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_QUESTPARS_QUESTID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_PARAMS ADD CONSTRAINT FK_QUESTPARS_QUESTID_QUEST_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_QUESTIONPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_QUESTIONPARAMS ON BARS.WCS_QUESTION_PARAMS (QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_QUESTION_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_QUESTION_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_QUESTION_PARAMS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_QUESTION_PARAMS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_QUESTION_PARAMS.sql =========*** E
PROMPT ===================================================================================== 
