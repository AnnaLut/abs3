

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LNK_TYPE_R020.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBURLNKTYPER020_REFACCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_TYPE_R020 ADD CONSTRAINT FK_NBURLNKTYPER020_REFACCTYPES FOREIGN KEY (ACC_TYPE)
	  REFERENCES BARS.NBUR_REF_ACC_TYPES (ACC_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LNK_TYPE_R020.sql =========*
PROMPT ===================================================================================== 
