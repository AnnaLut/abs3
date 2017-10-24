

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_CARD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_CARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_CARD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''W4_CARD'', ''WHOLE'' , null, null, null, null);
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
	DATE_CLOSE DATE
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
COMMENT ON COLUMN BARS.W4_CARD.CODE IS 'Тип карты';
COMMENT ON COLUMN BARS.W4_CARD.PRODUCT_CODE IS 'Код продукта';
COMMENT ON COLUMN BARS.W4_CARD.SUB_CODE IS 'Код субпродукта';
COMMENT ON COLUMN BARS.W4_CARD.DATE_OPEN IS '';
COMMENT ON COLUMN BARS.W4_CARD.DATE_CLOSE IS '';




PROMPT *** Create  constraint FK_W4CARD_W4SUBPRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD ADD CONSTRAINT FK_W4CARD_W4SUBPRODUCT FOREIGN KEY (SUB_CODE)
	  REFERENCES BARS.W4_SUBPRODUCT (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4CARD_W4PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD ADD CONSTRAINT FK_W4CARD_W4PRODUCT FOREIGN KEY (PRODUCT_CODE)
	  REFERENCES BARS.W4_PRODUCT (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4CARD_SUBCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD MODIFY (SUB_CODE CONSTRAINT CC_W4CARD_SUBCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4CARD_PRODUCTCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD MODIFY (PRODUCT_CODE CONSTRAINT CC_W4CARD_PRODUCTCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4CARD_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD MODIFY (CODE CONSTRAINT CC_W4CARD_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4CARD ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD ADD CONSTRAINT PK_W4CARD PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4CARD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4CARD ON BARS.W4_CARD (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
begin 
  execute immediate 'alter table w4_card add (minterm number,maxterm number)';
exception when others then 
  if sqlcode = -1430 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table w4_card add haveins number';
exception
  when others then
    if sqlcode = -1430 then
      null;
    else
      raise;
    end if;
end;
/
begin
  execute immediate 'alter table w4_card add ins_ukr_id number';
exception
  when others then
    if sqlcode = -1430 then
      null;
    else
      raise;
    end if;
end;
/
begin
  execute immediate 'alter table w4_card add ins_wrd_id number';
exception
  when others then
    if sqlcode = -1430 then
      null;
    else
      raise;
    end if;
end;
/

begin
  execute immediate 'alter table w4_card add tmp_id_ukr number';
exception
  when others then
    if sqlcode = -1430 then
      null;
    else
      raise;
    end if;
end;
/
begin
  execute immediate 'alter table w4_card add tmp_id_wrd number';
exception
  when others then
    if sqlcode = -1430 then
      null;
    else
      raise;
    end if;
end;
/
begin 
  execute immediate 'alter table w4_card add (minterm number,maxterm number)';
exception when others then 
  if sqlcode = -1430 then null; else raise; end if;
end;
/

comment on column W4_CARD.Haveins is 'Признак карти зі договором страхування(1-наявний/0-відсутній)';
comment on column W4_CARD.INS_UKR_ID is 'Зовнішній ідентифікатор типу договора страхування в системі Ева для подорожі по Ураїні';
comment on column W4_CARD.INS_WRD_ID is 'Зовнішній ідентифікатор типу договора страхування в системі Ева для подорожі за кордон(якщо порожній то карта тільки с одним типом)';
comment on column W4_CARD.TMP_ID_UKR is 'Ідентифікатор шаблону договорав системі Ева для подорожі по Ураїні';
comment on column W4_CARD.TMP_ID_WRD is 'Ідентифікатор шаблону договорав системі Ева для подорожі за кордон';


PROMPT *** Create  grants  W4_CARD ***
grant SELECT                                                                 on W4_CARD         to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_CARD         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_CARD         to BARS_DM;
grant SELECT                                                                 on W4_CARD         to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_CARD         to OW;
grant SELECT                                                                 on W4_CARD         to UPLD;
grant FLASHBACK,SELECT                                                       on W4_CARD         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_CARD.sql =========*** End *** =====
PROMPT ===================================================================================== 
