

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BE_PATCHES_BODY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BEPATCHBODY_BEPATCHES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_BODY ADD CONSTRAINT FK_BEPATCHBODY_BEPATCHES FOREIGN KEY (PATH_NAME)
	  REFERENCES BARS.BE_PATCHES (PATH_NAME) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BE_PATCHES_BODY.sql =========*** 
PROMPT ===================================================================================== 
