

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ESCR_REGISTER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REG_KIND_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REGISTER ADD CONSTRAINT FK_REG_KIND_ID FOREIGN KEY (REG_KIND_ID)
	  REFERENCES BARS.ESCR_REG_KIND (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REG_STATUS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REGISTER ADD CONSTRAINT FK_REG_STATUS_ID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.ESCR_REG_STATUS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ESCR_REGISTER.sql =========*** En
PROMPT ===================================================================================== 
