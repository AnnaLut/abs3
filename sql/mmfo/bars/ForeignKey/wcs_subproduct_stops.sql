

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_STOPS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SBPSTOPS_SBPID_SBPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_STOPS ADD CONSTRAINT FK_SBPSTOPS_SBPID_SBPS FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPSTOPS_STPID_STOPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_STOPS ADD CONSTRAINT FK_SBPSTOPS_STPID_STOPS FOREIGN KEY (STOP_ID)
	  REFERENCES BARS.WCS_STOPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_STOPS.sql ========
PROMPT ===================================================================================== 
