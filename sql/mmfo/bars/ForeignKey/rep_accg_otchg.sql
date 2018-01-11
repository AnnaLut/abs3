

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REP_ACCG_OTCHG.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REPACCOTCH_ACCG ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACCG_OTCHG ADD CONSTRAINT FK_REPACCOTCH_ACCG FOREIGN KEY (ACCGRP)
	  REFERENCES BARS.REP_ACCGRP (ACCGRP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REPACCOTCH_OTCHG ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACCG_OTCHG ADD CONSTRAINT FK_REPACCOTCH_OTCHG FOREIGN KEY (OTCHGRP)
	  REFERENCES BARS.REP_OTCHGRP (OTCHGRP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REPACCGOTCHG_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACCG_OTCHG ADD CONSTRAINT FK_REPACCGOTCHG_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REP_ACCG_OTCHG.sql =========*** E
PROMPT ===================================================================================== 
