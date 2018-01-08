

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_NBS_OB22.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_W4NBSOB22_W4TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 ADD CONSTRAINT FK_W4NBSOB22_W4TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.W4_TIPS (TIP) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4NBSOB22_SBOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 ADD CONSTRAINT FK_W4NBSOB22_SBOB22 FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.SB_OB22 (R020, OB22) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_NBS_OB22.sql =========*** End 
PROMPT ===================================================================================== 
