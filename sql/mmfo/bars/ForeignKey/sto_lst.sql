

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_LST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STOLST_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST ADD CONSTRAINT FK_STOLST_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOLST_STOGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST ADD CONSTRAINT FK_STOLST_STOGRP FOREIGN KEY (IDG)
	  REFERENCES BARS.STO_GRP (IDG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOLST_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST ADD CONSTRAINT FK_STOLST_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOLST_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST ADD CONSTRAINT FK_STOLST_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_LST.sql =========*** End *** 
PROMPT ===================================================================================== 
