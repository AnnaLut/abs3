

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CCK_NBS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCK_NBS_IDP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NBS ADD CONSTRAINT FK_CCK_NBS_IDP FOREIGN KEY (IDP)
	  REFERENCES BARS.CCK_TIP (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCK_NBS_IDT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NBS ADD CONSTRAINT FK_CCK_NBS_IDT FOREIGN KEY (IDT)
	  REFERENCES BARS.CCK_TERM (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCK_NBS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NBS ADD CONSTRAINT FK_CCK_NBS_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CCK_NBS.sql =========*** End *** 
PROMPT ===================================================================================== 
