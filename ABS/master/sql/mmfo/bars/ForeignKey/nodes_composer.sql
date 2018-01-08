

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NODES_COMPOSER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NODES_COMPOSER_SQL_STORAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NODES_COMPOSER ADD CONSTRAINT FK_NODES_COMPOSER_SQL_STORAGE FOREIGN KEY (URI_LINK)
	  REFERENCES BARS.SQL_STORAGE (URI) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NODES_COMPOSER.sql =========*** E
PROMPT ===================================================================================== 
