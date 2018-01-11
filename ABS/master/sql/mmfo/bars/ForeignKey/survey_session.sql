

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_SESSION.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SURVEYSESSION_STAFF$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT FK_SURVEYSESSION_STAFF$BASE FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYSESSION_SURVEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT FK_SURVEYSESSION_SURVEY FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.SURVEY (SURVEY_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYSESSION_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT FK_SURVEYSESSION_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYSESSION_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT FK_SURVEYSESSION_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYSESSION_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT FK_SURVEYSESSION_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_SESSION.sql =========*** E
PROMPT ===================================================================================== 
