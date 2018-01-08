

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_INHERIT_TAX.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTINHERITTAX ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERIT_TAX ADD CONSTRAINT FK_DPTINHERITTAX FOREIGN KEY (DPT_ID, INHERIT_CUSTID)
	  REFERENCES BARS.DPT_INHERITORS (DPT_ID, INHERIT_CUSTID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_INHERIT_TAX.sql =========*** 
PROMPT ===================================================================================== 
