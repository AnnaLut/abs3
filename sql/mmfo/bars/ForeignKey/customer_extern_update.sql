

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_EXTERN_UPDATE.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMEREXTERNUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN_UPDATE ADD CONSTRAINT FK_CUSTOMEREXTERNUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_EXTERN_UPDATE.sql ======
PROMPT ===================================================================================== 
