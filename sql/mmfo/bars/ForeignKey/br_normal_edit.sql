

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BR_NORMAL_EDIT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BRNORMALEDIT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT ADD CONSTRAINT FK_BRNORMALEDIT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRNORMALEDIT_BRATES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT ADD CONSTRAINT FK_BRNORMALEDIT_BRATES2 FOREIGN KEY (BR_ID, BR_TP)
	  REFERENCES BARS.BRATES (BR_ID, BR_TP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BR_NORMAL_EDIT.sql =========*** E
PROMPT ===================================================================================== 
