

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BANK_METALS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BANKMETALS_BANKMETALSTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS ADD CONSTRAINT FK_BANKMETALS_BANKMETALSTYPE FOREIGN KEY (TYPE_)
	  REFERENCES BARS.BANK_METALS_TYPE (KOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETALS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS ADD CONSTRAINT FK_BANKMETALS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BANK_METALS.sql =========*** End 
PROMPT ===================================================================================== 
