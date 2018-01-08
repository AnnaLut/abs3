

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MBM_NBS_ACC_TYPES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MBM_NBSACCTYPES_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_NBS_ACC_TYPES ADD CONSTRAINT FK_MBM_NBSACCTYPES_TYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.MBM_ACC_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MBM_NBS_ACC_TYPES.sql =========**
PROMPT ===================================================================================== 
