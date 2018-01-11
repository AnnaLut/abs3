

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_OICREVFILES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWOICREVFILES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OICREVFILES ADD CONSTRAINT FK_OWOICREVFILES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_OICREVFILES.sql =========*** E
PROMPT ===================================================================================== 
