

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SEC_RESOURCES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SECRES_SECRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES ADD CONSTRAINT FK_SECRES_SECRES FOREIGN KEY (RES_PARENTID)
	  REFERENCES BARS.SEC_RESOURCES (RES_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SEC_RESOURCES.sql =========*** En
PROMPT ===================================================================================== 
