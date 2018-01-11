

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNER_TYPE_PRODUCTS.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PTNTYPEPRDS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS ADD CONSTRAINT FK_PTNTYPEPRDS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNER_TYPE_PRODUCTS.sql ===
PROMPT ===================================================================================== 
