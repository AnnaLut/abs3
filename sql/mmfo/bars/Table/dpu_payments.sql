

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_PAYMENTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_PAYMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_PAYMENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_PAYMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_PAYMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_PAYMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_PAYMENTS 
   (	DPU_ID NUMBER(38,0), 
	REF NUMBER(38,0), 
	 CONSTRAINT PK_DPUPAYMENTS PRIMARY KEY (DPU_ID, REF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_PAYMENTS ***
 exec bpa.alter_policies('DPU_PAYMENTS');


COMMENT ON TABLE BARS.DPU_PAYMENTS IS 'Історія платежів по депозитним договорам ЮО';
COMMENT ON COLUMN BARS.DPU_PAYMENTS.DPU_ID IS 'Ідентифікатор договору';
COMMENT ON COLUMN BARS.DPU_PAYMENTS.REF IS 'Референс платежу';




PROMPT *** Create  constraint CC_DPUPAYMENTS_DPUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_PAYMENTS MODIFY (DPU_ID CONSTRAINT CC_DPUPAYMENTS_DPUID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUPAYMENTS_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_PAYMENTS MODIFY (REF CONSTRAINT CC_DPUPAYMENTS_REF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUPAYMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_PAYMENTS ADD CONSTRAINT PK_DPUPAYMENTS PRIMARY KEY (DPU_ID, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUPAYMENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUPAYMENTS ON BARS.DPU_PAYMENTS (DPU_ID, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_PAYMENTS ***
grant SELECT                                                                 on DPU_PAYMENTS    to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_PAYMENTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_PAYMENTS    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_PAYMENTS    to DPT_ADMIN;
grant SELECT                                                                 on DPU_PAYMENTS    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_PAYMENTS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_PAYMENTS.sql =========*** End *** 
PROMPT ===================================================================================== 
