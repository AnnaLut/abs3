

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MONEY2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MONEY2_OB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEY2 ADD CONSTRAINT FK_MONEY2_OB22 FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MONEY2.sql =========*** End *** =
PROMPT ===================================================================================== 
