

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SPECPARAM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SPECPARAM_SPS240 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM ADD CONSTRAINT FK_SPECPARAM_SPS240 FOREIGN KEY (S240)
	  REFERENCES BARS.SP_S240 (S240) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECPARAM_CRISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM ADD CONSTRAINT FK_SPECPARAM_CRISK FOREIGN KEY (S080)
	  REFERENCES BARS.CRISK (CRISK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECPARAM_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM ADD CONSTRAINT FK_SPECPARAM_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECPARAM_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM ADD CONSTRAINT FK_SPECPARAM_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECPARAM_SPS180 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM ADD CONSTRAINT FK_SPECPARAM_SPS180 FOREIGN KEY (S180)
	  REFERENCES BARS.SP_S180 (S180) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SPECPARAM.sql =========*** End **
PROMPT ===================================================================================== 
