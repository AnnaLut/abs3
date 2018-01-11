

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_PTRTYPES.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SBPPTRTYPES_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_PTRTYPES ADD CONSTRAINT FK_SBPPTRTYPES_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPPTRTYPES_PID_PARTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_PTRTYPES ADD CONSTRAINT FK_SBPPTRTYPES_PID_PARTS_ID FOREIGN KEY (PTR_TYPE_ID)
	  REFERENCES BARS.WCS_PARTNER_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_PTRTYPES.sql =====
PROMPT ===================================================================================== 
