

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_EWA_DOCUMENT_TYPES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EWADOCTYPE_DOCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_EWA_DOCUMENT_TYPES ADD CONSTRAINT FK_EWADOCTYPE_DOCTYPE FOREIGN KEY (EXT_ID)
	  REFERENCES BARS.PASSP (PASSP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_EWA_DOCUMENT_TYPES.sql ======
PROMPT ===================================================================================== 
