

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CASH_CHKGROUPS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_CASHCHKGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_CHKGROUPS ADD CONSTRAINT XFK_CASHCHKGROUPS FOREIGN KEY (CHK)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CASH_CHKGROUPS.sql =========*** E
PROMPT ===================================================================================== 
