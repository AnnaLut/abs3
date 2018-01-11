

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SREZ_ID_NBS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SREZ_ID_NBS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZ_ID_NBS ADD CONSTRAINT FK_SREZ_ID_NBS_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZ_ID_NBS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZ_ID_NBS ADD CONSTRAINT FK_SREZ_ID_NBS_ID FOREIGN KEY (ID)
	  REFERENCES BARS.SREZ_ID (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SREZ_ID_NBS.sql =========*** End 
PROMPT ===================================================================================== 
