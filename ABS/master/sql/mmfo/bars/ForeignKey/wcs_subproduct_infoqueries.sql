

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_INFOQUERIES.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SBPIQS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES ADD CONSTRAINT FK_SBPIQS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPIQS_IQID_IQS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES ADD CONSTRAINT FK_SBPIQS_IQID_IQS_ID FOREIGN KEY (IQUERY_ID)
	  REFERENCES BARS.WCS_INFOQUERIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPIQS_SID_SERV_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES ADD CONSTRAINT FK_SBPIQS_SID_SERV_ID FOREIGN KEY (SERVICE_ID)
	  REFERENCES BARS.WCS_SERVICES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCT_INFOQUERIES.sql ==
PROMPT ===================================================================================== 
