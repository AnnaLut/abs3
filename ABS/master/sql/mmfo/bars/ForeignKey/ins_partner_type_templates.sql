

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNER_TYPE_TEMPLATES.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PTNTYPETPLS_AID_ATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES ADD CONSTRAINT FK_PTNTYPETPLS_AID_ATTRS FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPETPLS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES ADD CONSTRAINT FK_PTNTYPETPLS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNER_TYPE_TEMPLATES.sql ==
PROMPT ===================================================================================== 
