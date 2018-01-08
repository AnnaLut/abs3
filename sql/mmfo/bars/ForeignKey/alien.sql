

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ALIEN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ALIEN_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT FK_ALIEN_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ALIEN_STANFIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT FK_ALIEN_STANFIN FOREIGN KEY (CRISK)
	  REFERENCES BARS.STAN_FIN (FIN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ALIEN_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT FK_ALIEN_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ALIEN_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT FK_ALIEN_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ALIEN.sql =========*** End *** ==
PROMPT ===================================================================================== 
