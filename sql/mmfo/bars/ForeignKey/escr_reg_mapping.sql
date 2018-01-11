

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ESCR_REG_MAPPING.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REG_MAP_REG_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_MAPPING ADD CONSTRAINT FK_REG_MAP_REG_ID FOREIGN KEY (IN_DOC_ID)
	  REFERENCES BARS.ESCR_REGISTER (ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REG_MAP_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_MAPPING ADD CONSTRAINT FK_REG_MAP_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ESCR_REG_MAPPING.sql =========***
PROMPT ===================================================================================== 
