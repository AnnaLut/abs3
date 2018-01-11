

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_DAT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STO_DAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT ADD CONSTRAINT FK_STO_DAT FOREIGN KEY (IDD)
	  REFERENCES BARS.STO_DET (IDD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODAT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT ADD CONSTRAINT FK_STODAT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODAT_STODET2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT ADD CONSTRAINT FK_STODAT_STODET2 FOREIGN KEY (KF, IDD)
	  REFERENCES BARS.STO_DET (KF, IDD) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_DAT.sql =========*** End *** 
PROMPT ===================================================================================== 
