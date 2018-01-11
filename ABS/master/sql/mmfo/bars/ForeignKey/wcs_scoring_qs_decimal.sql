

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SCORING_QS_DECIMAL.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SCORQSDEC_SCORQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DECIMAL ADD CONSTRAINT FK_SCORQSDEC_SCORQUESTS FOREIGN KEY (SCORING_ID, QUESTION_ID)
	  REFERENCES BARS.WCS_SCORING_QUESTIONS (SCORING_ID, QUESTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSDEC_MINS_STYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DECIMAL ADD CONSTRAINT FK_SCORQSDEC_MINS_STYPES_ID FOREIGN KEY (MIN_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSDEC_MAXS_STYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DECIMAL ADD CONSTRAINT FK_SCORQSDEC_MAXS_STYPES_ID FOREIGN KEY (MAX_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SCORING_QS_DECIMAL.sql ======
PROMPT ===================================================================================== 
