

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARIF_ACC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARIF_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TARIF_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARIF_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARIF_ACC 
   (	ND VARCHAR2(40), 
	TAR NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARIF_ACC ***
 exec bpa.alter_policies('TARIF_ACC');


COMMENT ON TABLE BARS.TARIF_ACC IS 'Довідник рахунок-тариф Нафтогазу для нарахування комісії за прийнятий платіж';
COMMENT ON COLUMN BARS.TARIF_ACC.ND IS '№ дог. на РКО';
COMMENT ON COLUMN BARS.TARIF_ACC.TAR IS 'Тариф за 1 прийнятий платіж в копійках';




PROMPT *** Create  constraint CC_TARIF_ACC_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_ACC MODIFY (ND CONSTRAINT CC_TARIF_ACC_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_ACC_TAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_ACC MODIFY (TAR CONSTRAINT CC_TARIF_ACC_TAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TARIF_ACC ***
grant SELECT                                                                 on TARIF_ACC       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF_ACC       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,UPDATE                                                   on TARIF_ACC       to START1;
grant SELECT                                                                 on TARIF_ACC       to UPLD;
grant FLASHBACK,SELECT                                                       on TARIF_ACC       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARIF_ACC.sql =========*** End *** ===
PROMPT ===================================================================================== 
