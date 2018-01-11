

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BE_LIBS_BODY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BELIBSBODY_BELIBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_BODY ADD CONSTRAINT FK_BELIBSBODY_BELIBS FOREIGN KEY (PATH_NAME)
	  REFERENCES BARS.BE_LIBS (PATH_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BE_LIBS_BODY.sql =========*** End
PROMPT ===================================================================================== 
