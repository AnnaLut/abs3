

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_CHK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFTIPCHK_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_CHK ADD CONSTRAINT FK_STAFFTIPCHK_STAFFTIPS FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPCHK_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_CHK ADD CONSTRAINT FK_STAFFTIPCHK_CHKLIST FOREIGN KEY (CHKID)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_CHK.sql =========*** End
PROMPT ===================================================================================== 
