

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BM_NLS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BMNLS_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BM_NLS ADD CONSTRAINT FK_BMNLS_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.BANK_METALS_TYPE (KOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BM_NLS.sql =========*** End *** =
PROMPT ===================================================================================== 
