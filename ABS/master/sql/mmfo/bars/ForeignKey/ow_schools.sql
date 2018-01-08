

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_SCHOOLS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SCHOOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SCHOOLS ADD CONSTRAINT FK_SCHOOLTYPES FOREIGN KEY (SCHOOLTYPEID)
	  REFERENCES BARS.OW_SCHOOLTYPES (SCHOOLTYPEID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_SCHOOLS.sql =========*** End *
PROMPT ===================================================================================== 
