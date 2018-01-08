

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_ADDRESS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERADR_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_CUSTOMERADRTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_CUSTOMERADRTYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.CUSTOMER_ADDRESS_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_ADDRESS.sql =========***
PROMPT ===================================================================================== 
