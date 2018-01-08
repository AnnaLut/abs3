

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAT_PARAM_RULE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAT_PARAM_RULE_TABNAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAT_PARAM_RULE ADD CONSTRAINT FK_STAT_PARAM_RULE_TABNAME FOREIGN KEY (TABLE_NAME)
	  REFERENCES BARS.META_TABLES (TABNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAT_PARAM_RULE.sql =========*** 
PROMPT ===================================================================================== 
