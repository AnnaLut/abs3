

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_MACS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MACS_APLEV_SRVHRCH_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MACS ADD CONSTRAINT FK_MACS_APLEV_SRVHRCH_ID FOREIGN KEY (APPLY_LEVEL)
	  REFERENCES BARS.WCS_SRV_HIERARCHY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MACS_TID_MACTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MACS ADD CONSTRAINT FK_MACS_TID_MACTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_MAC_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_MACS.sql =========*** End ***
PROMPT ===================================================================================== 
