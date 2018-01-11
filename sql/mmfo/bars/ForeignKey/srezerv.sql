

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SREZERV.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SREZ_S080 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT FK_SREZ_S080 FOREIGN KEY (S080)
	  REFERENCES BARS.CRISK (CRISK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZERV_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT FK_SREZERV_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZERV_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT FK_SREZERV_ID FOREIGN KEY (ID)
	  REFERENCES BARS.SREZ_ID (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZ_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT FK_SREZ_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SREZERV.sql =========*** End *** 
PROMPT ===================================================================================== 
