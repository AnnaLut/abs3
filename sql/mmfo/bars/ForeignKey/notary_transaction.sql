

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NOTARY_TRANSACTION.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NOTARY_TRAN_REF_ACCRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION ADD CONSTRAINT FK_NOTARY_TRAN_REF_ACCRED FOREIGN KEY (ACCREDITATION_ID)
	  REFERENCES BARS.NOTARY_ACCREDITATION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NOTARY_TRANSACTION.sql =========*
PROMPT ===================================================================================== 
