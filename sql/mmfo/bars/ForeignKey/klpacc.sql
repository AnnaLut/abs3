

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KLPACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLPACC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPACC ADD CONSTRAINT FK_KLPACC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_STAFF_KLPACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPACC ADD CONSTRAINT R_STAFF_KLPACC FOREIGN KEY (NEOM)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPACC ADD CONSTRAINT FK_KLPACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KLPACC.sql =========*** End *** =
PROMPT ===================================================================================== 
