

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_SPARAM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_W4SPARAM_W4PRODUCTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT FK_W4SPARAM_W4PRODUCTGROUPS FOREIGN KEY (GRP_CODE)
	  REFERENCES BARS.W4_PRODUCT_GROUPS (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4SPARAM_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT FK_W4SPARAM_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4SPARAM_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT FK_W4SPARAM_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4SPARAM_SPARAMLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT FK_W4SPARAM_SPARAMLIST FOREIGN KEY (SP_ID)
	  REFERENCES BARS.SPARAM_LIST (SPID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_SPARAM.sql =========*** End **
PROMPT ===================================================================================== 
