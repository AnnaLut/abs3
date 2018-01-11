

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FX_SWAP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FX_SWAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FX_SWAP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FX_SWAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FX_SWAP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FX_SWAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.FX_SWAP 
   (	DEAL_TAG NUMBER(*,0), 
	NPP NUMBER(*,0), 
	DAT1 DATE, 
	DAT2 DATE, 
	VDAT DATE, 
	KVA NUMBER(3,0), 
	SUMA NUMBER(22,0), 
	KVB NUMBER(3,0), 
	SUMB NUMBER(22,0), 
	BASEY_A NUMBER(*,0), 
	RATE_A NUMBER(20,4), 
	BASEY_B NUMBER(*,0), 
	RATE_B NUMBER(20,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FX_SWAP ***
 exec bpa.alter_policies('FX_SWAP');


COMMENT ON TABLE BARS.FX_SWAP IS 'Календарь по депо-свопам';
COMMENT ON COLUMN BARS.FX_SWAP.DEAL_TAG IS 'Ид. договора';
COMMENT ON COLUMN BARS.FX_SWAP.NPP IS 'НПП';
COMMENT ON COLUMN BARS.FX_SWAP.DAT1 IS 'Дата нач.% С';
COMMENT ON COLUMN BARS.FX_SWAP.DAT2 IS 'Дата нач.% По';
COMMENT ON COLUMN BARS.FX_SWAP.VDAT IS 'Дата договора';
COMMENT ON COLUMN BARS.FX_SWAP.KVA IS 'Вал-А';
COMMENT ON COLUMN BARS.FX_SWAP.SUMA IS 'Сумма-А';
COMMENT ON COLUMN BARS.FX_SWAP.KVB IS 'Вал-Б';
COMMENT ON COLUMN BARS.FX_SWAP.SUMB IS 'Сумма-Б';
COMMENT ON COLUMN BARS.FX_SWAP.BASEY_A IS '% база-Б';
COMMENT ON COLUMN BARS.FX_SWAP.RATE_A IS '% ставка-Б';
COMMENT ON COLUMN BARS.FX_SWAP.BASEY_B IS '';
COMMENT ON COLUMN BARS.FX_SWAP.RATE_B IS '';




PROMPT *** Create  constraint PK_FXSWAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP ADD CONSTRAINT PK_FXSWAP PRIMARY KEY (DEAL_TAG, NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_DEALTAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (DEAL_TAG CONSTRAINT CC_FXSWAP_DEALTAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_NPP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (NPP CONSTRAINT CC_FXSWAP_NPP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_DAT1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (DAT1 CONSTRAINT CC_FXSWAP_DAT1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_DAT2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (DAT2 CONSTRAINT CC_FXSWAP_DAT2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_VDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (VDAT CONSTRAINT CC_FXSWAP_VDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_KVA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (KVA CONSTRAINT CC_FXSWAP_KVA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_SUMA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (SUMA CONSTRAINT CC_FXSWAP_SUMA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_KVB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (KVB CONSTRAINT CC_FXSWAP_KVB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSWAP_SUMB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SWAP MODIFY (SUMB CONSTRAINT CC_FXSWAP_SUMB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FXSWAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FXSWAP ON BARS.FX_SWAP (DEAL_TAG, NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FX_SWAP ***
grant SELECT                                                                 on FX_SWAP         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_SWAP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FX_SWAP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_SWAP         to FOREX;
grant SELECT                                                                 on FX_SWAP         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FX_SWAP.sql =========*** End *** =====
PROMPT ===================================================================================== 
