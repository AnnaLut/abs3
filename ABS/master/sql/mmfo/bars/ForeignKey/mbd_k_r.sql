

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MBD_K_R.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_MB_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBD_K_R ADD CONSTRAINT R_MB_ND FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MBD_K_R.sql =========*** End *** 
PROMPT ===================================================================================== 
