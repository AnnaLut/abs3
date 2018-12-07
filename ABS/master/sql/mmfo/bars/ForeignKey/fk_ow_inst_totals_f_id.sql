

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_INST_TOTALS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OW_INST_TOTALS_F_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_INST_TOTALS ADD CONSTRAINT FK_OW_INST_TOTALS_F_ID FOREIGN KEY (ID)
      REFERENCES BARS.OW_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OW_INST_TOTALS_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_INST_TOTALS ADD CONSTRAINT FK_OW_INST_TOTALS_ND FOREIGN KEY (ND)
      REFERENCES BARS.W4_ACC (ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_INST_TOTALS.sql =========*** E
PROMPT ===================================================================================== 

