

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/COUNTRY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_COUNTRY_RISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.COUNTRY ADD CONSTRAINT FK_COUNTRY_RISK FOREIGN KEY (GRP)
	  REFERENCES BARS.REZ_GRP_COUNTRY (GRP) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/COUNTRY.sql =========*** End *** 
PROMPT ===================================================================================== 
