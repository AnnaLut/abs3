

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BE_PATCHES_BODY_ARC.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BEPATCHBODYARC_BEPATCHESARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_BODY_ARC ADD CONSTRAINT FK_BEPATCHBODYARC_BEPATCHESARC FOREIGN KEY (PATH_NAME, INS_DATE)
	  REFERENCES BARS.BE_PATCHES_ARC (PATH_NAME, INS_DATE) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BE_PATCHES_BODY_ARC.sql =========
PROMPT ===================================================================================== 