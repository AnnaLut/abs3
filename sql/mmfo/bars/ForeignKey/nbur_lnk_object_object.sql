

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LNK_OBJECT_OBJECT.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBJDEPENDENCIES_OBJECTPID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_OBJECT_OBJECT ADD CONSTRAINT FK_OBJDEPENDENCIES_OBJECTPID FOREIGN KEY (OBJECT_PID)
	  REFERENCES BARS.NBUR_REF_OBJECTS (ID) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBJDEPENDENCIES_OBJECTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_OBJECT_OBJECT ADD CONSTRAINT FK_OBJDEPENDENCIES_OBJECTID FOREIGN KEY (OBJECT_ID)
	  REFERENCES BARS.NBUR_REF_OBJECTS (ID) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LNK_OBJECT_OBJECT.sql ======
PROMPT ===================================================================================== 
