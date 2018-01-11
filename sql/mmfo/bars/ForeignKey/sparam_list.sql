

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SPARAM_LIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SPARAMLIST_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPARAMLIST_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_METACOLTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.META_COLTYPES (COLTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPARAMLIST_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_CODES FOREIGN KEY (CODE)
	  REFERENCES BARS.SPARAM_CODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SPARAM_LIST.sql =========*** End 
PROMPT ===================================================================================== 
