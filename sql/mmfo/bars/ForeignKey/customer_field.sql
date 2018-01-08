

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_FIELD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERFIELD_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT FK_CUSTOMERFIELD_METACOLTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.META_COLTYPES (COLTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERFIELD_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT FK_CUSTOMERFIELD_CODES FOREIGN KEY (CODE)
	  REFERENCES BARS.CUSTOMER_FIELD_CODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_FIELD.sql =========*** E
PROMPT ===================================================================================== 
