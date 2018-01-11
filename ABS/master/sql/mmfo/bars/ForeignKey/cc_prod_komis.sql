

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_PROD_KOMIS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_PROD_KOMIS_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROD_KOMIS ADD CONSTRAINT FK_CC_PROD_KOMIS_K FOREIGN KEY (KOMIS)
	  REFERENCES BARS.CC_RAZ_KOMIS (KOMIS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_PROD_KOMIS.sql =========*** En
PROMPT ===================================================================================== 
