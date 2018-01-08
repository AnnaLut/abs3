

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_KLF00.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFTIPKLF00_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_KLF00 ADD CONSTRAINT FK_STAFFTIPKLF00_STAFFTIPS FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPKLF00_KLF00 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_KLF00 ADD CONSTRAINT FK_STAFFTIPKLF00_KLF00 FOREIGN KEY (KODF, A017)
	  REFERENCES BARS.KL_F00$GLOBAL (KODF, A017) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_KLF00.sql =========*** E
PROMPT ===================================================================================== 
