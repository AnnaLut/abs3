

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_AUTHORIZATIONS.sql
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SBPAUTHS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_AUTHORIZATIONS ADD CONSTRAINT FK_SBPAUTHS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPAUTHS_AID_AUTHS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_AUTHORIZATIONS ADD CONSTRAINT FK_SBPAUTHS_AID_AUTHS_ID FOREIGN KEY (AUTH_ID)
	  REFERENCES BARS.WCS_AUTHORIZATIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_AUTHORIZATIONS.sql
PROMPT ===================================================================================== 
