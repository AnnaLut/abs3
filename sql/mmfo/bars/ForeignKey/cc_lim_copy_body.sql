

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_LIM_COPY_BODY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_LIM_COPY_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY_BODY ADD CONSTRAINT FK_CC_LIM_COPY_ID FOREIGN KEY (ID)
	  REFERENCES BARS.CC_LIM_COPY_HEADER (ID) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_LIM_COPY_BODY.sql =========***
PROMPT ===================================================================================== 
