

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_PROECT_CARD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_PROECT_CARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PROECT_CARD'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_PROECT_CARD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BPK_PROECT_CARD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PROECT_CARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_PROECT_CARD 
   (	OKPO VARCHAR2(14), 
	OKPO_N NUMBER(22,0), 
	CARD_CODE VARCHAR2(32), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_PROECT_CARD ***
 exec bpa.alter_policies('BPK_PROECT_CARD');


COMMENT ON TABLE BARS.BPK_PROECT_CARD IS 'БПК. Допустимые типы карт в разрезе З/П проектов';
COMMENT ON COLUMN BARS.BPK_PROECT_CARD.OKPO IS 'ОКПО З/П проекта';
COMMENT ON COLUMN BARS.BPK_PROECT_CARD.OKPO_N IS 'Дата создания заявки';
COMMENT ON COLUMN BARS.BPK_PROECT_CARD.CARD_CODE IS 'Номер счета';
COMMENT ON COLUMN BARS.BPK_PROECT_CARD.KF IS '';




PROMPT *** Create  constraint PK_BPKPROECTCARD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT_CARD ADD CONSTRAINT PK_BPKPROECTCARD PRIMARY KEY (OKPO, OKPO_N, CARD_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPROECTCARD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT_CARD MODIFY (KF CONSTRAINT CC_BPKPROECTCARD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKPROECTCARD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKPROECTCARD ON BARS.BPK_PROECT_CARD (OKPO, OKPO_N, CARD_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PROECT_CARD ***
grant SELECT                                                                 on BPK_PROECT_CARD to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT_CARD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_PROECT_CARD to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT_CARD to OW;
grant SELECT                                                                 on BPK_PROECT_CARD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PROECT_CARD.sql =========*** End *
PROMPT ===================================================================================== 
