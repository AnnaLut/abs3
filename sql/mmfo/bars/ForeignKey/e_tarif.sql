

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/E_TARIF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ETARIF_KF_IDGLOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF ADD CONSTRAINT FK_ETARIF_KF_IDGLOB FOREIGN KEY (KF, ID_GLOB)
	  REFERENCES BARS.TARIF (KF, KOD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/E_TARIF.sql =========*** End *** 
PROMPT ===================================================================================== 
