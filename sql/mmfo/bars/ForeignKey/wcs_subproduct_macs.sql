

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_MACS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SBPMACS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT FK_SBPMACS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPMACS_MID_MACS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT FK_SBPMACS_MID_MACS_ID FOREIGN KEY (MAC_ID)
	  REFERENCES BARS.WCS_MACS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPMACS_B_BRANCH_B ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT FK_SBPMACS_B_BRANCH_B FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_MACS.sql =========
PROMPT ===================================================================================== 
