

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_TAG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCTAG_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TAG ADD CONSTRAINT FK_CCTAG_CODES FOREIGN KEY (CODE)
	  REFERENCES BARS.CC_TAG_CODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_TAG_META_TABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TAG ADD CONSTRAINT FK_CC_TAG_META_TABLE FOREIGN KEY (TABLE_NAME)
	  REFERENCES BARS.META_TABLES (TABNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_TAG.sql =========*** End *** =
PROMPT ===================================================================================== 
