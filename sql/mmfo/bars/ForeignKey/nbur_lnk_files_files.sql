

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LNK_FILES_FILES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REFLNKFILFILS_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_FILES ADD CONSTRAINT FK_REFLNKFILFILS_FILES FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFLNKFILFILS_FILEDEPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_FILES ADD CONSTRAINT FK_REFLNKFILFILS_FILEDEPS FOREIGN KEY (FILE_DEP_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LNK_FILES_FILES.sql ========
PROMPT ===================================================================================== 
