

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_QUESTION_MATRIX_PARAMS.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_QUESTION_MATRIX_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_QUESTION_MATRIX_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_QUESTION_MATRIX_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_QUESTION_MATRIX_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_QUESTION_MATRIX_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_QUESTION_MATRIX_PARAMS 
   (	QUESTION_ID VARCHAR2(100), 
	AXIS_QID VARCHAR2(100), 
	ORD NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_QUESTION_MATRIX_PARAMS ***
 exec bpa.alter_policies('WCS_QUESTION_MATRIX_PARAMS');


COMMENT ON TABLE BARS.WCS_QUESTION_MATRIX_PARAMS IS 'Описание вопроса матрицы';
COMMENT ON COLUMN BARS.WCS_QUESTION_MATRIX_PARAMS.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_QUESTION_MATRIX_PARAMS.AXIS_QID IS 'Идентификатор вопроса - ось матрицы';
COMMENT ON COLUMN BARS.WCS_QUESTION_MATRIX_PARAMS.ORD IS 'Порядок отображения';




PROMPT *** Create  constraint PK_QUESTMATRIXPARS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_MATRIX_PARAMS ADD CONSTRAINT PK_QUESTMATRIXPARS PRIMARY KEY (QUESTION_ID, AXIS_QID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_QUESTMATRIXPARS_QID_Q_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_MATRIX_PARAMS ADD CONSTRAINT FK_QUESTMATRIXPARS_QID_Q_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_QUESTMATRIXPARS_AXQID_Q_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_MATRIX_PARAMS ADD CONSTRAINT FK_QUESTMATRIXPARS_AXQID_Q_ID FOREIGN KEY (AXIS_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_QUESTMATRIXPARS_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_MATRIX_PARAMS MODIFY (ORD CONSTRAINT CC_QUESTMATRIXPARS_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_QUESTMATRIXPARS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_QUESTMATRIXPARS ON BARS.WCS_QUESTION_MATRIX_PARAMS (QUESTION_ID, AXIS_QID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_QUESTION_MATRIX_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_QUESTION_MATRIX_PARAMS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_QUESTION_MATRIX_PARAMS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_QUESTION_MATRIX_PARAMS.sql =======
PROMPT ===================================================================================== 
