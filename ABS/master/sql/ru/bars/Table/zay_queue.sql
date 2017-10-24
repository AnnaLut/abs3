

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_QUEUE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_QUEUE'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''ZAY_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_QUEUE 
   (	ID NUMBER, 
	 CONSTRAINT XPK_ZAY_QUEUE PRIMARY KEY (ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 2 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_QUEUE ***
 exec bpa.alter_policies('ZAY_QUEUE');


COMMENT ON TABLE BARS.ZAY_QUEUE IS 'Очередь заявок на покупку-продажу валюты';
COMMENT ON COLUMN BARS.ZAY_QUEUE.ID IS 'Идентификатор заявки';




PROMPT *** Create  constraint FK_ZAYQUEUE_ZAYAVKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_QUEUE ADD CONSTRAINT FK_ZAYQUEUE_ZAYAVKA FOREIGN KEY (ID)
	  REFERENCES BARS.ZAYAVKA (ID) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_ZAY_QUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_QUEUE ADD CONSTRAINT XPK_ZAY_QUEUE PRIMARY KEY (ID)
  USING INDEX PCTFREE 2 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAY_QUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAY_QUEUE ON BARS.ZAY_QUEUE (ID) 
  PCTFREE 2 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_QUEUE ***
grant FLASHBACK,REFERENCES,SELECT                                            on ZAY_QUEUE       to BARSAQ with grant option;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_QUEUE       to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_QUEUE       to WR_ALL_RIGHTS;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_QUEUE       to ZAY;



PROMPT *** Create SYNONYM  to ZAY_QUEUE ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_QUEUE FOR BARS.ZAY_QUEUE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_QUEUE.sql =========*** End *** ===
PROMPT ===================================================================================== 
