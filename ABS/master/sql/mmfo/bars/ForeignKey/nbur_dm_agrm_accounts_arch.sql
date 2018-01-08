

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_DM_AGRM_ACCOUNTS_ARCH.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DMAGRMACCARC_REFAGRMPRTFLTP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH ADD CONSTRAINT FK_DMAGRMACCARC_REFAGRMPRTFLTP FOREIGN KEY (PRTFL_TP)
	  REFERENCES BARS.NBUR_REF_AGRM_PRTFL_TP (PRTFL_TP_ID) RELY ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_DM_AGRM_ACCOUNTS_ARCH.sql ==
PROMPT ===================================================================================== 
