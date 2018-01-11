

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BS1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BS1_BSZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.BS1 ADD CONSTRAINT FK_BS1_BSZ FOREIGN KEY (IDZ)
	  REFERENCES BARS.BSZ (IDZ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BS1.sql =========*** End *** ====
PROMPT ===================================================================================== 
