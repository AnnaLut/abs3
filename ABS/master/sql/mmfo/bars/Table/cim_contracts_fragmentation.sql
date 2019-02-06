

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_FRAGMENTATION.sql ===*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACTS_FRAGMENTATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACTS_FRAGMENTATION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_FRAGMENTATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_FRAGMENTATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACTS_FRAGMENTATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACTS_FRAGMENTATION 
   (	ID_CHECK NUMBER,
        BOUND_CONTR_ID NUMBER,
        BOUND_ID NUMBER, 
	KIND_DOC_ID NUMBER, 
	TYPE_DOC_ID NUMBER, 
        SQ NUMBER,
	DATE_DOC DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACTS_FRAGMENTATION ***
 exec bpa.alter_policies('CIM_CONTRACTS_FRAGMENTATION');


COMMENT ON TABLE BARS.CIM_CONTRACTS_FRAGMENTATION IS 'Документи при розрахунку Ознаки дроблення';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGMENTATION.ID_CHECK IS 'Ідентифікатор перевірки на ознаку';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGMENTATION.BOUND_CONTR_ID IS 'ID контракту до якого привязаний документ';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGMENTATION.BOUND_ID IS 'ID документу у табл. привязок';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGMENTATION.KIND_DOC_ID IS 'Вид документу 0 - Платіж 1 - МД';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGMENTATION.TYPE_DOC_ID IS 'Тип документу 0 - Платіж або МД 1 - Фантом або Акт';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGMENTATION.SQ IS 'Гривневий еквівалент відповідного документу';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGMENTATION.DATE_DOC IS 'Дата валютування/дозволу відповідного документу';

begin   
 execute immediate '
  CREATE INDEX BARS.IDX1_CIMCONTRACTSFRAGM ON BARS.CIM_CONTRACTS_FRAGMENTATION (ID_CHECK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_CIMCONTRFRAGM_BCONTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGMENTATION MODIFY (BOUND_CONTR_ID CONSTRAINT CC_CIMCONTRFRAGM_BCONTRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CIMCONTRFRAGM_BID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGMENTATION MODIFY (BOUND_ID CONSTRAINT CC_CIMCONTRFRAGM_BID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CIMCONTRFRAGM_KINDDOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGMENTATION MODIFY (KIND_DOC_ID CONSTRAINT CC_CIMCONTRFRAGM_KINDDOCID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_CIMCONTRFRAGM_TYPEDOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGMENTATION MODIFY (TYPE_DOC_ID CONSTRAINT CC_CIMCONTRFRAGM_TYPEDOCID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CIMCONTRFRAGM_IDCHECK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGMENTATION MODIFY (ID_CHECK CONSTRAINT CC_CIMCONTRFRAGM_IDCHECK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_CIM_FRAGMENT_B_CONTR_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGMENTATION ADD CONSTRAINT FK_CIM_FRAGMENT_B_CONTR_ID FOREIGN KEY (BOUND_CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint FK_CIM_CONTRFRAG_ID_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGMENTATION ADD CONSTRAINT FK_CIM_CONTRFRAG_ID_CHECK FOREIGN KEY (ID_CHECK)
	  REFERENCES BARS.CIM_CONTRACTS_FRAGCHECK (ID_CHECK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CIM_CONTRACTS_FRAGMENTATION ***
grant SELECT                                                                 on CIM_CONTRACTS_FRAGMENTATION to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_FRAGMENTATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACTS_FRAGMENTATION to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_FRAGMENTATION to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACTS_FRAGMENTATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_FRAGMENTATION.sql =========*** 
PROMPT ===================================================================================== 
