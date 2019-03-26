

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DEB_REG_TMP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DEBREGTMP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_REG_TMP ADD CONSTRAINT FK_DEBREGTMP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DEB_REG_TMP.sql =========*** End 
PROMPT ===================================================================================== 