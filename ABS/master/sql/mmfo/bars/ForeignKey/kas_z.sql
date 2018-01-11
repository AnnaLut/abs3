

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KAS_Z.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KASZ_IDM ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z ADD CONSTRAINT FK_KASZ_IDM FOREIGN KEY (IDM)
	  REFERENCES BARS.KAS_M (IDM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASZ_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z ADD CONSTRAINT FK_KASZ_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASZ_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z ADD CONSTRAINT FK_KASZ_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASZ_IDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z ADD CONSTRAINT FK_KASZ_IDS FOREIGN KEY (IDS)
	  REFERENCES BARS.KAS_U (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASZ_IDI ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z ADD CONSTRAINT FK_KASZ_IDI FOREIGN KEY (IDI)
	  REFERENCES BARS.KAS_F (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASZ_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z ADD CONSTRAINT FK_KASZ_SOS FOREIGN KEY (SOS)
	  REFERENCES BARS.KAS_SOS (SOS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASZ_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z ADD CONSTRAINT FK_KASZ_VID FOREIGN KEY (VID)
	  REFERENCES BARS.KAS_VID (VID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KAS_Z.sql =========*** End *** ==
PROMPT ===================================================================================== 
