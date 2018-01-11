

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_CHK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFCHK_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK ADD CONSTRAINT FK_STAFFCHK_STAFF2 FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFCHK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK ADD CONSTRAINT FK_STAFFCHK_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFCHK_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK ADD CONSTRAINT FK_STAFFCHK_CHKLIST FOREIGN KEY (CHKID)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_CHK.sql =========*** End **
PROMPT ===================================================================================== 
