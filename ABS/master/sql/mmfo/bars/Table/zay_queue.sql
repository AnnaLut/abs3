

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_QUEUE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_QUEUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_QUEUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAY_QUEUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
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
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
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
COMMENT ON COLUMN BARS.ZAY_QUEUE.KF IS '';




PROMPT *** Create  constraint CC_ZAYQUEUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_QUEUE MODIFY (KF CONSTRAINT CC_ZAYQUEUE_KF_NN NOT NULL ENABLE)';
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
grant SELECT                                                                 on ZAY_QUEUE       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_QUEUE       to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_QUEUE       to WR_ALL_RIGHTS;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_QUEUE       to ZAY;



PROMPT *** Create SYNONYM  to ZAY_QUEUE ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_QUEUE FOR BARS.ZAY_QUEUE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_QUEUE.sql =========*** End *** ===
PROMPT ===================================================================================== 
