

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SGN_DATA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SGNDATA_SGNTYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_DATA ADD CONSTRAINT FK_SGNDATA_SGNTYPE_ID FOREIGN KEY (SIGN_TYPE)
	  REFERENCES BARS.SGN_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SGN_DATA.sql =========*** End ***
PROMPT ===================================================================================== 
