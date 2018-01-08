

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REFERENCES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REFERS_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFERENCES ADD CONSTRAINT FK_REFERS_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFERS_TYPEREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFERENCES ADD CONSTRAINT FK_REFERS_TYPEREF FOREIGN KEY (TYPE)
	  REFERENCES BARS.TYPEREF (TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFERS_ROLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFERENCES ADD CONSTRAINT FK_REFERS_ROLES FOREIGN KEY (ROLE2EDIT)
	  REFERENCES BARS.ROLES$BASE (ROLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REFERENCES.sql =========*** End *
PROMPT ===================================================================================== 
