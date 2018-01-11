

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_KOD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CP_FAIR_METHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_FAIR_METHOD FOREIGN KEY (FAIR_METHOD_ID)
	  REFERENCES BARS.CP_FAIR_METHOD (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FX_CP_KOD_IDT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FX_CP_KOD_IDT FOREIGN KEY (IDT)
	  REFERENCES BARS.CP_TYPE (IDT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_HIERARCHY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_HIERARCHY FOREIGN KEY (HIERARCHY_ID)
	  REFERENCES BARS.CP_HIERARCHY (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CP_KOD_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CP_KOD_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CP_KOD_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CP_KOD_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CP_KOD_VR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CP_KOD_VR FOREIGN KEY (AMORT)
	  REFERENCES BARS.CP_VR (VR) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_DOX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_DOX FOREIGN KEY (DOX)
	  REFERENCES BARS.CP_DOX (DOX) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_EMI ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_EMI FOREIGN KEY (EMI)
	  REFERENCES BARS.CP_EMI (EMI) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_VNCRR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_VNCRR FOREIGN KEY (VNCRR)
	  REFERENCES BARS.CCK_RATING (CODE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_KOD.sql =========*** End *** =
PROMPT ===================================================================================== 
