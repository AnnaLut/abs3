

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BPK_NBS_OB22.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BPKNBSOB22_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS_OB22 ADD CONSTRAINT FK_BPKNBSOB22_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BPK_NBS_OB22.sql =========*** End
PROMPT ===================================================================================== 
