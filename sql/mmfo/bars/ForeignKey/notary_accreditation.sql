

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NOTARY_ACCREDITATION.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NOTARY_ACCRED_REF_NOTARY ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_ACCREDITATION ADD CONSTRAINT FK_NOTARY_ACCRED_REF_NOTARY FOREIGN KEY (NOTARY_ID)
	  REFERENCES BARS.NOTARY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NOTARY_ACCREDITATION.sql ========
PROMPT ===================================================================================== 
