

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BPK_ARSENAL_TARIF.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BPKARSENALTARIF_STR ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_TARIF ADD CONSTRAINT FK_BPKARSENALTARIF_STR FOREIGN KEY (ID)
	  REFERENCES BARS.BPK_ARSENAL_STR (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKARSENALTARIF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_TARIF ADD CONSTRAINT FK_BPKARSENALTARIF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BPK_ARSENAL_TARIF.sql =========**
PROMPT ===================================================================================== 
