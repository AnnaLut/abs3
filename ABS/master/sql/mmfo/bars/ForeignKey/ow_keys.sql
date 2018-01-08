

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_KEYS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KEYSTOKEYTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS ADD CONSTRAINT FK_KEYSTOKEYTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.KEYTYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_KEYS.sql =========*** End *** 
PROMPT ===================================================================================== 
