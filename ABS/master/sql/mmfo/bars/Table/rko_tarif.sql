

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_TARIF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_TARIF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_TARIF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_TARIF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_TARIF 
   (	ACC NUMBER(22,0), 
	INDPAR NUMBER(10,0), 
	ORGAN NUMBER(10,0), 
	DATE_OPEN DATE, 
	DATE_CLOSE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_TARIF ***
 exec bpa.alter_policies('RKO_TARIF');


COMMENT ON TABLE BARS.RKO_TARIF IS 'РКО. Індивідуальні тарифи та процентні ставки';
COMMENT ON COLUMN BARS.RKO_TARIF.ACC IS 'ACC';
COMMENT ON COLUMN BARS.RKO_TARIF.INDPAR IS 'Тип індивідуального параметру';
COMMENT ON COLUMN BARS.RKO_TARIF.ORGAN IS 'Орган управління';
COMMENT ON COLUMN BARS.RKO_TARIF.DATE_OPEN IS 'Дата рішення про встановлення індивідуальних тарифів/процентної ставки';
COMMENT ON COLUMN BARS.RKO_TARIF.DATE_CLOSE IS 'Дата закінчення дії індивідуальних тарифів/процентної ставки';




PROMPT *** Create  constraint PK_RKOTARIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_TARIF ADD CONSTRAINT PK_RKOTARIF PRIMARY KEY (ACC, INDPAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOTARIF_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_TARIF MODIFY (ACC CONSTRAINT CC_RKOTARIF_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOTARIF_INDPAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_TARIF MODIFY (INDPAR CONSTRAINT CC_RKOTARIF_INDPAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOTARIF_ORGAN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_TARIF MODIFY (ORGAN CONSTRAINT CC_RKOTARIF_ORGAN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKOTARIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKOTARIF ON BARS.RKO_TARIF (ACC, INDPAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_TARIF ***
grant SELECT                                                                 on RKO_TARIF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RKO_TARIF       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_TARIF.sql =========*** End *** ===
PROMPT ===================================================================================== 
