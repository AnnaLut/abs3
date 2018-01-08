

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD_EXTDESC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTVIDDEXTDESC_DPTVIDEXTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT FK_DPTVIDDEXTDESC_DPTVIDEXTYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.DPT_VIDD_EXTYPES (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDEXTDESC_DPTEXTMETHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT FK_DPTVIDDEXTDESC_DPTEXTMETHOD FOREIGN KEY (METHOD_ID)
	  REFERENCES BARS.DPT_EXTENSION_METHOD (METHOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDEXTDESC_INTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT FK_DPTVIDDEXTDESC_INTOP FOREIGN KEY (OPER_ID)
	  REFERENCES BARS.INT_OP (OP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD_EXTDESC.sql =========***
PROMPT ===================================================================================== 
