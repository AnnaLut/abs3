

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PS_SPARAM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PSSPARAM_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_SPARAM ADD CONSTRAINT FK_PSSPARAM_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PSSPARAM_SPARAMLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_SPARAM ADD CONSTRAINT FK_PSSPARAM_SPARAMLIST FOREIGN KEY (SPID)
	  REFERENCES BARS.SPARAM_LIST (SPID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PS_SPARAM.sql =========*** End **
PROMPT ===================================================================================== 
