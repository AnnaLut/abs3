

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BPK_NBS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BPKNBS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS ADD CONSTRAINT FK_BPKNBS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKNBS_SBOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS ADD CONSTRAINT FK_BPKNBS_SBOB22 FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKNBS_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS ADD CONSTRAINT FK_BPKNBS_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BPK_NBS.sql =========*** End *** 
PROMPT ===================================================================================== 
