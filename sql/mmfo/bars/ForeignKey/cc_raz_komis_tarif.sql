

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_RAZ_KOMIS_TARIF.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_RAZ_KOMIS_TARIF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF ADD CONSTRAINT FK_CC_RAZ_KOMIS_TARIF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_RAZ_KOMIS_TARIF_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF ADD CONSTRAINT FK_CC_RAZ_KOMIS_TARIF_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZ_KOMIS_TARIF_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF ADD CONSTRAINT CC_RAZ_KOMIS_TARIF_TYPE FOREIGN KEY (TIP)
	  REFERENCES BARS.CC_RAZ_KOMIS_TYPE (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_RAZ_KOMIS_TARIF.sql =========*
PROMPT ===================================================================================== 
