

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_INSTANT_BATCHES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_INSTANT_BATCHES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_INSTANT_BATCHES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_INSTANT_BATCHES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_INSTANT_BATCHES ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_INSTANT_BATCHES 
   (	ID NUMBER, 
	NAME VARCHAR2(100), 
	CARD_CODE VARCHAR2(32), 
	NUMBERCARDS NUMBER, 
	REGDATE DATE DEFAULT sysdate, 
	USER_ID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_INSTANT_BATCHES ***
 exec bpa.alter_policies('W4_INSTANT_BATCHES');


COMMENT ON TABLE BARS.W4_INSTANT_BATCHES IS 'Пачки карт інстант';
COMMENT ON COLUMN BARS.W4_INSTANT_BATCHES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.W4_INSTANT_BATCHES.NAME IS 'Імя пакету';
COMMENT ON COLUMN BARS.W4_INSTANT_BATCHES.CARD_CODE IS 'Код карткового продукту';
COMMENT ON COLUMN BARS.W4_INSTANT_BATCHES.NUMBERCARDS IS 'Количество карт';
COMMENT ON COLUMN BARS.W4_INSTANT_BATCHES.REGDATE IS 'Дата реєстрації';
COMMENT ON COLUMN BARS.W4_INSTANT_BATCHES.USER_ID IS 'Ідентифікатор коритсувача';
COMMENT ON COLUMN BARS.W4_INSTANT_BATCHES.KF IS '';




PROMPT *** Create  constraint SYS_C00109348 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_INSTANT_BATCHES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109349 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_INSTANT_BATCHES MODIFY (CARD_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109350 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_INSTANT_BATCHES MODIFY (NUMBERCARDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109351 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_INSTANT_BATCHES MODIFY (REGDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109352 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_INSTANT_BATCHES MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109353 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_INSTANT_BATCHES MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4_ACC_INSTANT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_INSTANT_BATCHES ADD CONSTRAINT PK_W4_ACC_INSTANT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4_ACC_INSTANT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4_ACC_INSTANT ON BARS.W4_INSTANT_BATCHES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_INSTANT_BATCHES ***
grant SELECT                                                                 on W4_INSTANT_BATCHES to BARSREADER_ROLE;
grant SELECT                                                                 on W4_INSTANT_BATCHES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_INSTANT_BATCHES.sql =========*** En
PROMPT ===================================================================================== 
