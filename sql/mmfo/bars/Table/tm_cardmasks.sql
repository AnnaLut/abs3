

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TM_CARDMASKS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TM_CARDMASKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TM_CARDMASKS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TM_CARDMASKS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TM_CARDMASKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TM_CARDMASKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TM_CARDMASKS 
   (	MASK_ID NUMBER, 
	MASK_NAME VARCHAR2(70), 
	MASK_LEN NUMBER(3,0), 
	MASK_REGEXP VARCHAR2(140), 
	MASK_BLK NUMBER(1,0) DEFAULT 0, 
	DELETED DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TM_CARDMASKS ***
 exec bpa.alter_policies('TM_CARDMASKS');


COMMENT ON TABLE BARS.TM_CARDMASKS IS 'Шаблони карткових рахунків системи Transmaster';
COMMENT ON COLUMN BARS.TM_CARDMASKS.MASK_ID IS 'Код шаблону карт.рахунку';
COMMENT ON COLUMN BARS.TM_CARDMASKS.MASK_NAME IS 'Опис шаблону карт.рахунку';
COMMENT ON COLUMN BARS.TM_CARDMASKS.MASK_LEN IS 'Довжина карт.рахунку';
COMMENT ON COLUMN BARS.TM_CARDMASKS.MASK_REGEXP IS 'Регулярний вираз';
COMMENT ON COLUMN BARS.TM_CARDMASKS.MASK_BLK IS 'Ознака вилучення з обігу';
COMMENT ON COLUMN BARS.TM_CARDMASKS.DELETED IS '';




PROMPT *** Create  constraint PK_TMCARDMASKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDMASKS ADD CONSTRAINT PK_TMCARDMASKS PRIMARY KEY (MASK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMCARDMASKS_MASKBLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDMASKS ADD CONSTRAINT CC_TMCARDMASKS_MASKBLK CHECK (mask_blk in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMCARDMASKS_MASKLEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDMASKS ADD CONSTRAINT CC_TMCARDMASKS_MASKLEN CHECK (mask_len > 0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMCARDMASKS_MASKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDMASKS MODIFY (MASK_ID CONSTRAINT CC_TMCARDMASKS_MASKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMCARDMASKS_MASKBLK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDMASKS MODIFY (MASK_BLK CONSTRAINT CC_TMCARDMASKS_MASKBLK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMCARDMASKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMCARDMASKS ON BARS.TM_CARDMASKS (MASK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TM_CARDMASKS ***
grant SELECT                                                                 on TM_CARDMASKS    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TM_CARDMASKS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TM_CARDMASKS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TM_CARDMASKS    to DPT_ADMIN;
grant SELECT                                                                 on TM_CARDMASKS    to DPT_ROLE;
grant SELECT                                                                 on TM_CARDMASKS    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TM_CARDMASKS    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on TM_CARDMASKS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TM_CARDMASKS.sql =========*** End *** 
PROMPT ===================================================================================== 
