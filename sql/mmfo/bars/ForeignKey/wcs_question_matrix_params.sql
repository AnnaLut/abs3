

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_QUESTION_MATRIX_PARAMS.sql ==
PROMPT ===================================================================================== 


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




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_QUESTION_MATRIX_PARAMS.sql ==
PROMPT ===================================================================================== 
