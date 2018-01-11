

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_ARSENAL_TARIF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_ARSENAL_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_ARSENAL_TARIF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_ARSENAL_TARIF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_ARSENAL_TARIF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_ARSENAL_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_ARSENAL_TARIF 
   (	ID NUMBER(38,0), 
	DAT DATE, 
	TARIF NUMBER(16,2), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_ARSENAL_TARIF ***
 exec bpa.alter_policies('BPK_ARSENAL_TARIF');


COMMENT ON TABLE BARS.BPK_ARSENAL_TARIF IS 'БПК. Довідник тарифів страхових компаній';
COMMENT ON COLUMN BARS.BPK_ARSENAL_TARIF.KF IS '';
COMMENT ON COLUMN BARS.BPK_ARSENAL_TARIF.ID IS 'Код страхової компанії';
COMMENT ON COLUMN BARS.BPK_ARSENAL_TARIF.DAT IS 'Дата встановлення тарифу';
COMMENT ON COLUMN BARS.BPK_ARSENAL_TARIF.TARIF IS 'Річний тариф';




PROMPT *** Create  constraint PK_BPKARSENALTARIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_TARIF ADD CONSTRAINT PK_BPKARSENALTARIF PRIMARY KEY (ID, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKARSENALTARIF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_TARIF MODIFY (KF CONSTRAINT CC_BPKARSENALTARIF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKARSENALTARIF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_TARIF MODIFY (ID CONSTRAINT CC_BPKARSENALTARIF_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKARSENALTARIF_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_TARIF MODIFY (DAT CONSTRAINT CC_BPKARSENALTARIF_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKARSENALTARIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKARSENALTARIF ON BARS.BPK_ARSENAL_TARIF (ID, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_ARSENAL_TARIF ***
grant SELECT                                                                 on BPK_ARSENAL_TARIF to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BPK_ARSENAL_TARIF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_ARSENAL_TARIF to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_ARSENAL_TARIF to OBPC;
grant SELECT                                                                 on BPK_ARSENAL_TARIF to UPLD;
grant FLASHBACK,SELECT                                                       on BPK_ARSENAL_TARIF to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_ARSENAL_TARIF.sql =========*** End
PROMPT ===================================================================================== 
