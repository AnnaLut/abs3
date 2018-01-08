

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PFU_EPP_KILLED.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PFU_EPP_KILLED_TYPEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_EPP_KILLED ADD CONSTRAINT FK_PFU_EPP_KILLED_TYPEID FOREIGN KEY (KILL_TYPE)
	  REFERENCES BARS.PFU_EPP_KILL_TYPE (ID_TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PFU_EPP_KILLED.sql =========*** E
PROMPT ===================================================================================== 
