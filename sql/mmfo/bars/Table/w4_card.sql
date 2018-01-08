

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_CARD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_CARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_CARD'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_CARD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_CARD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_CARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_CARD 
   (	CODE VARCHAR2(32), 
	PRODUCT_CODE VARCHAR2(32), 
	SUB_CODE VARCHAR2(32), 
	DATE_OPEN DATE, 
	DATE_CLOSE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	HAVEINS NUMBER, 
	INS_UKR_ID NUMBER, 
	INS_WRD_ID NUMBER, 
	TMP_ID_UKR NUMBER, 
	TMP_ID_WRD NUMBER, 
	MINTERM NUMBER, 
	MAXTERM NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_CARD ***
 exec bpa.alter_policies('W4_CARD');


COMMENT ON TABLE BARS.W4_CARD IS 'W4. Справочник типов карт';
COMMENT ON COLUMN BARS.W4_CARD.KF IS '';
COMMENT ON COLUMN BARS.W4_CARD.HAVEINS IS 'Признак карти зі договором страхування(1-наявний/0-відсутній)';
COMMENT ON COLUMN BARS.W4_CARD.INS_UKR_ID IS 'Зовнішній ідентифікатор типу договора страхування в системі Ева для подорожі по Ураїні';
COMMENT ON COLUMN BARS.W4_CARD.INS_WRD_ID IS 'Зовнішній ідентифікатор типу договора страхування в системі Ева для подорожі за кордон(якщо порожній то карта тільки с одним типом)';
COMMENT ON COLUMN BARS.W4_CARD.TMP_ID_UKR IS 'Ідентифікатор шаблону договорав системі Ева для подорожі по Ураїні';
COMMENT ON COLUMN BARS.W4_CARD.TMP_ID_WRD IS 'Ідентифікатор шаблону договорав системі Ева для подорожі за кордон';
COMMENT ON COLUMN BARS.W4_CARD.MINTERM IS '';
COMMENT ON COLUMN BARS.W4_CARD.MAXTERM IS '';
COMMENT ON COLUMN BARS.W4_CARD.CODE IS 'Тип карты';
COMMENT ON COLUMN BARS.W4_CARD.PRODUCT_CODE IS 'Код продукта';
COMMENT ON COLUMN BARS.W4_CARD.SUB_CODE IS 'Код субпродукта';
COMMENT ON COLUMN BARS.W4_CARD.DATE_OPEN IS '';
COMMENT ON COLUMN BARS.W4_CARD.DATE_CLOSE IS '';




PROMPT *** Create  constraint PK_W4CARD ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD ADD CONSTRAINT PK_W4CARD PRIMARY KEY (CODE, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4CARD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD MODIFY (KF CONSTRAINT CC_W4CARD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4CARD_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD MODIFY (CODE CONSTRAINT CC_W4CARD_CODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4CARD_PRODUCTCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD MODIFY (PRODUCT_CODE CONSTRAINT CC_W4CARD_PRODUCTCODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4CARD_SUBCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD MODIFY (SUB_CODE CONSTRAINT CC_W4CARD_SUBCODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4CARD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4CARD ON BARS.W4_CARD (CODE, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_CARD ***
grant SELECT                                                                 on W4_CARD         to BARSREADER_ROLE;
grant SELECT                                                                 on W4_CARD         to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_CARD         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_CARD         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_CARD         to OW;
grant SELECT                                                                 on W4_CARD         to UPLD;
grant FLASHBACK,SELECT                                                       on W4_CARD         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_CARD.sql =========*** End *** =====
PROMPT ===================================================================================== 
