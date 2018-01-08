

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LST_FILES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBURLSTFILES_LSTFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES ADD CONSTRAINT FK_NBURLSTFILES_LSTFILES FOREIGN KEY (REPORT_DATE, KF, VERSION_ID)
	  REFERENCES BARS.NBUR_LST_VERSIONS (REPORT_DATE, KF, VERSION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBURLSTFILES_REFFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES ADD CONSTRAINT FK_NBURLSTFILES_REFFILES FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBURLSTFILES_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES ADD CONSTRAINT FK_NBURLSTFILES_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LST_FILES.sql =========*** E
PROMPT ===================================================================================== 
