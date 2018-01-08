

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_TYPES_OB22.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUTYPESOB22_SBOB22_INT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT FK_DPUTYPESOB22_SBOB22_INT FOREIGN KEY (NBS_DEP, OB22_DEP)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUTYPESOB22_SBOB22_EXP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT FK_DPUTYPESOB22_SBOB22_EXP FOREIGN KEY (NBS_EXP, OB22_EXP)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUTYPESOB22_SBOB22_RED ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT FK_DPUTYPESOB22_SBOB22_RED FOREIGN KEY (NBS_RED, OB22_RED)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_TYPES_OB22.sql =========*** E
PROMPT ===================================================================================== 
