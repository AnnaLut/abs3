

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KLP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_KLPMT_KLP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT R_KLPMT_KLP FOREIGN KEY (DOP)
	  REFERENCES BARS.KLP_MT (DOP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT FK_KLP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLP_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT FK_KLP_STAFF FOREIGN KEY (EOM)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLP_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT FK_KLP_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLP_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT FK_KLP_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLP_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT FK_KLP_STAFF2 FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLP_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT FK_KLP_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KLP.sql =========*** End *** ====
PROMPT ===================================================================================== 
