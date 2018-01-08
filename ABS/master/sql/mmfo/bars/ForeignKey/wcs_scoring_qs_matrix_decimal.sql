

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SCORING_QS_MATRIX_DECIMAL.sql
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SCORQSMTXDEC_SCORQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT FK_SCORQSMTXDEC_SCORQUESTS FOREIGN KEY (SCORING_ID, QUESTION_ID)
	  REFERENCES BARS.WCS_SCORING_QUESTIONS (SCORING_ID, QUESTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDEC_QUESTMTXPARS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT FK_SCORQSMTXDEC_QUESTMTXPARS FOREIGN KEY (QUESTION_ID, AXIS_QID)
	  REFERENCES BARS.WCS_QUESTION_MATRIX_PARAMS (QUESTION_ID, AXIS_QID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDEC_MINS_STS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT FK_SCORQSMTXDEC_MINS_STS_ID FOREIGN KEY (MIN_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDEC_MAXS_STS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT FK_SCORQSMTXDEC_MAXS_STS_ID FOREIGN KEY (MAX_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SCORING_QS_MATRIX_DECIMAL.sql
PROMPT ===================================================================================== 
