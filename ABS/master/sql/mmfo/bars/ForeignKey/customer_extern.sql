

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_EXTERN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMEREXTERN_PASSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_PASSP FOREIGN KEY (DOC_TYPE)
	  REFERENCES BARS.PASSP (PASSP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_SEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_SEX FOREIGN KEY (SEX)
	  REFERENCES BARS.SEX (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_FS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_FS FOREIGN KEY (FS)
	  REFERENCES BARS.FS (FS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_VED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_VED FOREIGN KEY (VED)
	  REFERENCES BARS.VED (VED) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_SED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_SED FOREIGN KEY (SED)
	  REFERENCES BARS.SED (SED) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_ISE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_ISE FOREIGN KEY (ISE)
	  REFERENCES BARS.ISE (ISE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_EXTERN.sql =========*** 
PROMPT ===================================================================================== 
