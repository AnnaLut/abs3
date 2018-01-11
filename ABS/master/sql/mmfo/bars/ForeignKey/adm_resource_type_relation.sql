

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ADM_RESOURCE_TYPE_RELATION.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GRANTEE_REF_RES_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE_RELATION ADD CONSTRAINT FK_GRANTEE_REF_RES_TYPE FOREIGN KEY (GRANTEE_TYPE_ID)
	  REFERENCES BARS.ADM_RESOURCE_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RESOURCE_REF_RES_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE_RELATION ADD CONSTRAINT FK_RESOURCE_REF_RES_TYPE FOREIGN KEY (RESOURCE_TYPE_ID)
	  REFERENCES BARS.ADM_RESOURCE_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ADM_RESOURCE_TYPE_RELATION.sql ==
PROMPT ===================================================================================== 
