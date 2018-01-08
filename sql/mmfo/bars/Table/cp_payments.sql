

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_PAYMENTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_PAYMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_PAYMENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PAYMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PAYMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_PAYMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_PAYMENTS 
   (	CP_REF NUMBER, 
	OP_REF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_PAYMENTS ***
 exec bpa.alter_policies('CP_PAYMENTS');


COMMENT ON TABLE BARS.CP_PAYMENTS IS 'Документи угоди';
COMMENT ON COLUMN BARS.CP_PAYMENTS.CP_REF IS 'Ідентифікатор угоди ЦП';
COMMENT ON COLUMN BARS.CP_PAYMENTS.OP_REF IS 'Референс операції';




PROMPT *** Create  constraint SYS_C005481 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PAYMENTS MODIFY (CP_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005482 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PAYMENTS MODIFY (OP_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CP_PAYMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PAYMENTS ADD CONSTRAINT XPK_CP_PAYMENTS PRIMARY KEY (CP_REF, OP_REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_PAYMENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_PAYMENTS ON BARS.CP_PAYMENTS (CP_REF, OP_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_PAYMENTS ***
grant SELECT                                                                 on CP_PAYMENTS     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PAYMENTS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_PAYMENTS     to BARS_DM;
grant SELECT                                                                 on CP_PAYMENTS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_PAYMENTS.sql =========*** End *** =
PROMPT ===================================================================================== 
