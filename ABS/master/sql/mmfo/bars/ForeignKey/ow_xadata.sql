

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_XADATA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWXADATA_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XADATA ADD CONSTRAINT FK_OWXADATA_STAFF FOREIGN KEY (UNFORM_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_XADATA.sql =========*** End **
PROMPT ===================================================================================== 
