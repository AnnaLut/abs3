

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OPERW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OPERW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW ADD CONSTRAINT FK_OPERW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERW_OPFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW ADD CONSTRAINT FK_OPERW_OPFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERW_OPER2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW ADD CONSTRAINT FK_OPERW_OPER2 FOREIGN KEY (KF, REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_OPERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW ADD CONSTRAINT R_OPER_OPERW FOREIGN KEY (REF)
	  REFERENCES BARS.OPER (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OPERW.sql =========*** End *** ==
PROMPT ===================================================================================== 
