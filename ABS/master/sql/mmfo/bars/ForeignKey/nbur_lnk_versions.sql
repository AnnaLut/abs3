

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LNK_VERSIONS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBURLNKVERSIONS_REFOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_VERSIONS ADD CONSTRAINT FK_NBURLNKVERSIONS_REFOBJECTS FOREIGN KEY (OBJECT_ID)
	  REFERENCES BARS.NBUR_REF_OBJECTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBURLNKVERSIONS_LSTVRSN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_VERSIONS ADD CONSTRAINT FK_NBURLNKVERSIONS_LSTVRSN FOREIGN KEY (REPORT_DATE, KF, VERSION_ID)
	  REFERENCES BARS.NBUR_LST_VERSIONS (REPORT_DATE, KF, VERSION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBURLNKVERSIONS_LSTVRSN_GL ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_VERSIONS ADD CONSTRAINT FK_NBURLNKVERSIONS_LSTVRSN_GL FOREIGN KEY (GLBL_VRSN_ID)
	  REFERENCES BARS.NBUR_LST_VERSIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBURLNKVERSIONS_LSTOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_VERSIONS ADD CONSTRAINT FK_NBURLNKVERSIONS_LSTOBJECTS FOREIGN KEY (REPORT_DATE, KF, VERSION_ID, OBJECT_ID)
	  REFERENCES BARS.NBUR_LST_OBJECTS (REPORT_DATE, KF, VERSION_ID, OBJECT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBURLNKVERSIONS_LSTBLCOBJS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_VERSIONS ADD CONSTRAINT FK_NBURLNKVERSIONS_LSTBLCOBJS FOREIGN KEY (KF, REPORT_DATE, OBJECT_ID)
	  REFERENCES BARS.NBUR_LST_BLC_OBJECTS (KF, REPORT_DATE, OBJECT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LNK_VERSIONS.sql =========**
PROMPT ===================================================================================== 
