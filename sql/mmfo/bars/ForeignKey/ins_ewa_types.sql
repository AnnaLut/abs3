

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_EWA_TYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EWATYPE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_EWA_TYPES ADD CONSTRAINT FK_EWATYPE_TYPE FOREIGN KEY (EXT_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_EWA_TYPES.sql =========*** En
PROMPT ===================================================================================== 
