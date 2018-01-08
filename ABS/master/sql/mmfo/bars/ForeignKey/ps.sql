

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PS_PAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT FK_PS_PAP FOREIGN KEY (PAP)
	  REFERENCES BARS.PAP (PAP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PS_CHKNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT FK_PS_CHKNBS FOREIGN KEY (CHKNBS)
	  REFERENCES BARS.CHKNBS (CHKNBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PS_XAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT FK_PS_XAR FOREIGN KEY (XAR)
	  REFERENCES BARS.XAR (XAR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_PSSB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT XFK_PSSB FOREIGN KEY (SB)
	  REFERENCES BARS.PS_SBFLAGS (SBFLAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PS.sql =========*** End *** =====
PROMPT ===================================================================================== 
