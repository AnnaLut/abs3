

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SGN_EXT_STORE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SGNEXTSTORE_SGNDATA_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_EXT_STORE ADD CONSTRAINT FK_SGNEXTSTORE_SGNDATA_REF FOREIGN KEY (SIGN_ID)
	  REFERENCES BARS.SGN_DATA (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SGN_EXT_STORE.sql =========*** En
PROMPT ===================================================================================== 
