

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_BLOCK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_BLOCK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_BLOCK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_BLOCK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_BLOCK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_BLOCK ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_BLOCK 
   (	ID NUMBER, 
	INN NUMBER(10,0), 
	INN_DATE DATE, 
	LNAME VARCHAR2(50), 
	FNAME VARCHAR2(50), 
	MNAME VARCHAR2(50), 
	BDATE DATE, 
	PASS_SER VARCHAR2(10), 
	PASS_NUM VARCHAR2(6), 
	PASS_DATE DATE, 
	PASS_OFFICE VARCHAR2(300), 
	SVZ_ID NUMBER, 
	TYPE_ID NUMBER DEFAULT 0, 
	BLK_COMMENT VARCHAR2(2000), 
	BLK NUMBER, 
	BLK_DATE DATE, 
	USER_ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_BLOCK ***
 exec bpa.alter_policies('BL_BLOCK');


COMMENT ON TABLE BARS.BL_BLOCK IS 'Таблиця тимчасово заблокованих осіб';
COMMENT ON COLUMN BARS.BL_BLOCK.ID IS 'Код';
COMMENT ON COLUMN BARS.BL_BLOCK.INN IS 'Ідентифікаційний податковий номер';
COMMENT ON COLUMN BARS.BL_BLOCK.INN_DATE IS 'Дата видачі ідентифікаційного податкового номера';
COMMENT ON COLUMN BARS.BL_BLOCK.LNAME IS 'Прізвище';
COMMENT ON COLUMN BARS.BL_BLOCK.FNAME IS 'Ім'я';
COMMENT ON COLUMN BARS.BL_BLOCK.MNAME IS 'По батькові';
COMMENT ON COLUMN BARS.BL_BLOCK.BDATE IS 'Дата народження';
COMMENT ON COLUMN BARS.BL_BLOCK.PASS_SER IS 'Серія паспорта. Кирилиця у верхньому регістрі';
COMMENT ON COLUMN BARS.BL_BLOCK.PASS_NUM IS 'Номер паспорта, із провідними нулями';
COMMENT ON COLUMN BARS.BL_BLOCK.PASS_DATE IS 'Дата видачі паспорта';
COMMENT ON COLUMN BARS.BL_BLOCK.PASS_OFFICE IS 'Ким виданий паспорт';
COMMENT ON COLUMN BARS.BL_BLOCK.SVZ_ID IS 'Тип SVZ_ID коду 0 - анкета(bid_id) 1 -№ договору (ND)';
COMMENT ON COLUMN BARS.BL_BLOCK.TYPE_ID IS '';
COMMENT ON COLUMN BARS.BL_BLOCK.BLK_COMMENT IS '';
COMMENT ON COLUMN BARS.BL_BLOCK.BLK IS 'код блокування';
COMMENT ON COLUMN BARS.BL_BLOCK.BLK_DATE IS 'дата блокування';
COMMENT ON COLUMN BARS.BL_BLOCK.USER_ID IS 'код користувача';




PROMPT *** Create  constraint CC_BL_BLOCK_TYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK ADD CONSTRAINT CC_BL_BLOCK_TYPE_ID CHECK (type_id IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK MODIFY (ID CONSTRAINT NN_BL_BLOCK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_INN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK MODIFY (INN CONSTRAINT NN_BL_BLOCK_INN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_SVZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK MODIFY (SVZ_ID CONSTRAINT NN_BL_BLOCK_SVZ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_TYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK MODIFY (TYPE_ID CONSTRAINT NN_BL_BLOCK_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_BLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK MODIFY (BLK CONSTRAINT NN_BL_BLOCK_BLK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_BLK_DATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK MODIFY (BLK_DATE CONSTRAINT NN_BL_BLOCK_BLK_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_USER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK MODIFY (USER_ID CONSTRAINT NN_BL_BLOCK_USER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_BLOCK ***
grant SELECT                                                                 on BL_BLOCK        to BARSREADER_ROLE;
grant SELECT                                                                 on BL_BLOCK        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_BLOCK        to RBLOCK;
grant SELECT                                                                 on BL_BLOCK        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_BLOCK.sql =========*** End *** ====
PROMPT ===================================================================================== 
