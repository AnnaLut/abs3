

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FX_DEAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FX_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FX_DEAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FX_DEAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FX_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.FX_DEAL 
   (	DEAL_TAG NUMBER(*,0), 
	NTIK VARCHAR2(15), 
	DAT DATE, 
	KVA NUMBER(*,0), 
	DAT_A DATE, 
	SUMA NUMBER(*,0), 
	KVB NUMBER(*,0), 
	DAT_B DATE, 
	SUMB NUMBER(*,0), 
	REF NUMBER(*,0), 
	REFA NUMBER(*,0), 
	REFB NUMBER(*,0), 
	KODB VARCHAR2(12), 
	REFB2 NUMBER(*,0), 
	SWI_BIC CHAR(11), 
	SWI_ACC VARCHAR2(34), 
	SWI_REF NUMBER(38,0), 
	SWO_BIC CHAR(11), 
	SWO_ACC VARCHAR2(34), 
	SWO_REF NUMBER(38,0), 
	SWO_F57A VARCHAR2(250), 
	SWI_F56A VARCHAR2(250), 
	SWO_F56A VARCHAR2(250), 
	AGRMNT_NUM VARCHAR2(10), 
	AGRMNT_DATE DATE, 
	BICB CHAR(11), 
	INTERM_B VARCHAR2(250), 
	CURR_BASE CHAR(1), 
	ALT_PARTYB VARCHAR2(250), 
	TELEXNUM VARCHAR2(35), 
	RNK NUMBER, 
	ACC9A NUMBER, 
	SOS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FX_DEAL ***
 exec bpa.alter_policies('FX_DEAL');


COMMENT ON TABLE BARS.FX_DEAL IS '';
COMMENT ON COLUMN BARS.FX_DEAL.DEAL_TAG IS '';
COMMENT ON COLUMN BARS.FX_DEAL.NTIK IS '';
COMMENT ON COLUMN BARS.FX_DEAL.DAT IS '';
COMMENT ON COLUMN BARS.FX_DEAL.KVA IS '';
COMMENT ON COLUMN BARS.FX_DEAL.DAT_A IS '';
COMMENT ON COLUMN BARS.FX_DEAL.SUMA IS '';
COMMENT ON COLUMN BARS.FX_DEAL.KVB IS '';
COMMENT ON COLUMN BARS.FX_DEAL.DAT_B IS '';
COMMENT ON COLUMN BARS.FX_DEAL.SUMB IS '';
COMMENT ON COLUMN BARS.FX_DEAL.REF IS '';
COMMENT ON COLUMN BARS.FX_DEAL.REFA IS '';
COMMENT ON COLUMN BARS.FX_DEAL.REFB IS '';
COMMENT ON COLUMN BARS.FX_DEAL.KODB IS '';
COMMENT ON COLUMN BARS.FX_DEAL.REFB2 IS '';
COMMENT ON COLUMN BARS.FX_DEAL.SWI_BIC IS 'Входящий платеж. Код банка';
COMMENT ON COLUMN BARS.FX_DEAL.SWI_ACC IS 'Входящий платеж. Номер счета';
COMMENT ON COLUMN BARS.FX_DEAL.SWI_REF IS 'Референс входящего SWIFT-сообщения';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_BIC IS 'Исходящий платеж. Код банка';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_ACC IS 'Исходящий платеж. Номер счета';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_REF IS 'Референс исходящего SWIFT-сообщения';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_F57A IS 'Ђ«мвҐа­ вЁў­®Ґ Ї®«Ґ ¤«п Ёбе®¤пйҐ© ва ббл';
COMMENT ON COLUMN BARS.FX_DEAL.SWI_F56A IS 'ђҐЄўЁ§Ёвл Ї®баҐ¤­ЁЄ  Ї® бв®а®­Ґ Ђ';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_F56A IS 'ђҐЄўЁ§Ёвл Ї®баҐ¤­ЁЄ  Ї® бв®а®­Ґ Ѓ';
COMMENT ON COLUMN BARS.FX_DEAL.AGRMNT_NUM IS 'Номер ген. соглашения';
COMMENT ON COLUMN BARS.FX_DEAL.AGRMNT_DATE IS 'Дата ген. соглашения';
COMMENT ON COLUMN BARS.FX_DEAL.BICB IS 'BIC код партнера';
COMMENT ON COLUMN BARS.FX_DEAL.INTERM_B IS 'Реквизиты посредника по стороне Б (56A)';
COMMENT ON COLUMN BARS.FX_DEAL.CURR_BASE IS 'Базовая валюта сделки A/B';
COMMENT ON COLUMN BARS.FX_DEAL.ALT_PARTYB IS 'Альтернативное поле для исходящей трассы';
COMMENT ON COLUMN BARS.FX_DEAL.TELEXNUM IS 'Номер телекса партнера';
COMMENT ON COLUMN BARS.FX_DEAL.RNK IS '';
COMMENT ON COLUMN BARS.FX_DEAL.ACC9A IS '';
COMMENT ON COLUMN BARS.FX_DEAL.SOS IS '';




PROMPT *** Create  constraint FK_FXDEAL_SWBANKS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWBANKS3 FOREIGN KEY (BICB)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXDEAL_SWJOURNAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWJOURNAL2 FOREIGN KEY (SWO_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXDEAL_SWBANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWBANKS2 FOREIGN KEY (SWO_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXDEAL_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWJOURNAL FOREIGN KEY (SWI_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXDEAL_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWBANKS FOREIGN KEY (SWI_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FX_DEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT XPK_FX_DEAL PRIMARY KEY (DEAL_TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010242 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL MODIFY (DEAL_TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FX_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FX_DEAL ON BARS.FX_DEAL (DEAL_TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FX_DEAL ***
grant SELECT                                                                 on FX_DEAL         to BARSUPL;
grant SELECT                                                                 on FX_DEAL         to BARS_SUP;
grant SELECT                                                                 on FX_DEAL         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FX_DEAL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FX_DEAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
