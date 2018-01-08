

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ETALON_TARIFF_VALUE.sql =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYN_TAR_HIST_REF_ETAL_TAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF_VALUE ADD CONSTRAINT FK_SKRYN_TAR_HIST_REF_ETAL_TAR FOREIGN KEY (TARIFF_ID)
	  REFERENCES BARS.SKRYNKA_ETALON_TARIFF (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ETALON_TARIFF_VALUE.sql =
PROMPT ===================================================================================== 
