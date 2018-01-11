

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BL_BLOCK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BL_BLOCK_BLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK ADD CONSTRAINT FK_BL_BLOCK_BLK FOREIGN KEY (BLK)
	  REFERENCES BARS.BL_BLOCK_DICT (BLK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BL_BLOCK.sql =========*** End ***
PROMPT ===================================================================================== 
