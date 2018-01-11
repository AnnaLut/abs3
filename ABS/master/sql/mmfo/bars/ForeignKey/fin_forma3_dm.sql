

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIN_FORMA3_DM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINFORMA3DM_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA3_DM ADD CONSTRAINT FK_FINFORMA3DM_ID FOREIGN KEY (ID)
	  REFERENCES BARS.FIN_FORMA3_REF (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIN_FORMA3_DM.sql =========*** En
PROMPT ===================================================================================== 
