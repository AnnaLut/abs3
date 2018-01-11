

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LST_BLC_FILES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBURLSTBLCFILES_REFOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_BLC_FILES ADD CONSTRAINT FK_NBURLSTBLCFILES_REFOBJECTS FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBURLSTBLCFILES_LSTVRSN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_BLC_FILES ADD CONSTRAINT FK_NBURLSTBLCFILES_LSTVRSN FOREIGN KEY (REPORT_DATE, KF, VERSION_ID)
	  REFERENCES BARS.NBUR_LST_VERSIONS (REPORT_DATE, KF, VERSION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBURLSTBLCFILES_LSTOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_BLC_FILES ADD CONSTRAINT FK_NBURLSTBLCFILES_LSTOBJECTS FOREIGN KEY (REPORT_DATE, KF, VERSION_ID, FILE_ID)
	  REFERENCES BARS.NBUR_LST_FILES (REPORT_DATE, KF, VERSION_ID, FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LST_BLC_FILES.sql =========*
PROMPT ===================================================================================== 
