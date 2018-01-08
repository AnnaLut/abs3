

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STMT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STMT_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.STMT ADD CONSTRAINT FK_STMT_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STMT.sql =========*** End *** ===
PROMPT ===================================================================================== 
