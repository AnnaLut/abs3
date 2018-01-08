

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_TEMPLATES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSTMPS_TID_DOCSCHM_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_TEMPLATES ADD CONSTRAINT FK_WCSTMPS_TID_DOCSCHM_ID FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSTMPS_DETID_DOCEXPTPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_TEMPLATES ADD CONSTRAINT FK_WCSTMPS_DETID_DOCEXPTPS_ID FOREIGN KEY (DOCEXP_TYPE_ID)
	  REFERENCES BARS.WCS_DOCEXPORT_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_TEMPLATES.sql =========*** En
PROMPT ===================================================================================== 
