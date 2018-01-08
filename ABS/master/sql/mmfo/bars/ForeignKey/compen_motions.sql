

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/COMPEN_MOTIONS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_COMPEN_MOTIONS_PORTFOLIO ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN_MOTIONS ADD CONSTRAINT FK_COMPEN_MOTIONS_PORTFOLIO FOREIGN KEY (ID_COMPEN)
	  REFERENCES BARS.COMPEN_PORTFOLIO (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/COMPEN_MOTIONS.sql =========*** E
PROMPT ===================================================================================== 
