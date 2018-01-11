

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PERSON.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PERSON_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT FK_PERSON_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PERSON_SEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT FK_PERSON_SEX FOREIGN KEY (SEX)
	  REFERENCES BARS.SEX (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PERSON_PASSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT FK_PERSON_PASSP FOREIGN KEY (PASSP)
	  REFERENCES BARS.PASSP (PASSP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PERSON.sql =========*** End *** =
PROMPT ===================================================================================== 
