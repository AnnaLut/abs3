

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPA_NBS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPANBS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_NBS ADD CONSTRAINT FK_DPANBS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPANBS_DPATYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_NBS ADD CONSTRAINT FK_DPANBS_DPATYPE FOREIGN KEY (TYPE)
	  REFERENCES BARS.DPA_TYPE (TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPA_NBS.sql =========*** End *** 
PROMPT ===================================================================================== 
