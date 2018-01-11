

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_BONUS_COMPLEX.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTBONUSCMPLX_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_COMPLEX ADD CONSTRAINT FK_DPTBONUSCMPLX_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_BONUS_COMPLEX.sql =========**
PROMPT ===================================================================================== 
