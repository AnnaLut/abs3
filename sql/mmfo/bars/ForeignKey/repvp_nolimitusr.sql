

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REPVP_NOLIMITUSR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_REPVPNOLIMITUSR ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPVP_NOLIMITUSR ADD CONSTRAINT XFK_REPVPNOLIMITUSR FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REPVP_NOLIMITUSR.sql =========***
PROMPT ===================================================================================== 
