

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_ROW_UPD.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTFILEROWUPD_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD ADD CONSTRAINT FK_DPTFILEROWUPD_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEROWUPD_DPTFILEROW ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD ADD CONSTRAINT FK_DPTFILEROWUPD_DPTFILEROW FOREIGN KEY (ROW_ID)
	  REFERENCES BARS.DPT_FILE_ROW (INFO_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEROWUPD_STAFF$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD ADD CONSTRAINT FK_DPTFILEROWUPD_STAFF$BASE FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_ROW_UPD.sql =========***
PROMPT ===================================================================================== 
