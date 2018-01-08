

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KAS_MF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KASMF_IDM ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_MF ADD CONSTRAINT FK_KASMF_IDM FOREIGN KEY (IDM)
	  REFERENCES BARS.KAS_M (IDM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASMF_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_MF ADD CONSTRAINT FK_KASMF_ID FOREIGN KEY (ID)
	  REFERENCES BARS.KAS_F (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KAS_MF.sql =========*** End *** =
PROMPT ===================================================================================== 
