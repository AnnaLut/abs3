

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_PRIORITY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_PRIORITY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_PRIORITY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_PRIORITY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_PRIORITY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_PRIORITY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_PRIORITY 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(50), 
	VERIFY NUMBER(1,0) DEFAULT 0, 
	ACTIVE NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_PRIORITY ***
 exec bpa.alter_policies('ZAY_PRIORITY');


COMMENT ON TABLE BARS.ZAY_PRIORITY IS 'Приоритеты заявок клиентов на покупку-продажу валюты';
COMMENT ON COLUMN BARS.ZAY_PRIORITY.ID IS 'Код приоритета';
COMMENT ON COLUMN BARS.ZAY_PRIORITY.NAME IS 'Название приоритета';
COMMENT ON COLUMN BARS.ZAY_PRIORITY.VERIFY IS 'Признак подтверждения';
COMMENT ON COLUMN BARS.ZAY_PRIORITY.ACTIVE IS 'Признак активности';




PROMPT *** Create  constraint PK_ZAYPRIORITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PRIORITY ADD CONSTRAINT PK_ZAYPRIORITY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYPRIORITY_VERIFY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PRIORITY ADD CONSTRAINT CC_ZAYPRIORITY_VERIFY CHECK (verify in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYPRIORITY_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PRIORITY ADD CONSTRAINT CC_ZAYPRIORITY_ACTIVE CHECK (active in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYPRIORITY_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PRIORITY MODIFY (ID CONSTRAINT CC_ZAYPRIORITY_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYPRIORITY_ID_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PRIORITY MODIFY (NAME CONSTRAINT CC_ZAYPRIORITY_ID_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYPRIORITY_VERIFY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PRIORITY MODIFY (VERIFY CONSTRAINT CC_ZAYPRIORITY_VERIFY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYPRIORITY_ACTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PRIORITY MODIFY (ACTIVE CONSTRAINT CC_ZAYPRIORITY_ACTIVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYPRIORITY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYPRIORITY ON BARS.ZAY_PRIORITY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_PRIORITY ***
grant SELECT                                                                 on ZAY_PRIORITY    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_PRIORITY    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_PRIORITY    to BARS_DM;
grant SELECT                                                                 on ZAY_PRIORITY    to UPLD;
grant FLASHBACK,SELECT                                                       on ZAY_PRIORITY    to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_PRIORITY    to ZAY;



PROMPT *** Create SYNONYM  to ZAY_PRIORITY ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_PRIORITY FOR BARS.ZAY_PRIORITY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_PRIORITY.sql =========*** End *** 
PROMPT ===================================================================================== 
