

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_FLD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWFLD_SWTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_FLD ADD CONSTRAINT FK_SWFLD_SWTAG FOREIGN KEY (TAG)
	  REFERENCES BARS.SW_TAG (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_FLD.sql =========*** End *** =
PROMPT ===================================================================================== 
