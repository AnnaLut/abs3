

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BR_TIER_EDIT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BRTIEREDIT_BRATES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT ADD CONSTRAINT FK_BRTIEREDIT_BRATES2 FOREIGN KEY (BR_ID, BR_TP)
	  REFERENCES BARS.BRATES (BR_ID, BR_TP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRTIEREDIT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT ADD CONSTRAINT FK_BRTIEREDIT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BR_TIER_EDIT.sql =========*** End
PROMPT ===================================================================================== 
