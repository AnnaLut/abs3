

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_BLANK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTBLANK_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_DOCSCHEME FOREIGN KEY (DOC_SCHEME_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_DPTDPTALL2 FOREIGN KEY (KF, DEPOSIT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_DPTBLANK2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_DPTBLANK2 FOREIGN KEY (KF, ID_FAULTY)
	  REFERENCES BARS.DPT_BLANK (KF, ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_BLANK.sql =========*** End **
PROMPT ===================================================================================== 
