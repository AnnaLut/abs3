

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_CUST_PRINS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_CUST_PRINS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_CUST_PRINS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_CUST_PRINS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_CUST_PRINS 
   (	DATF DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RNK NUMBER(38,0), 
	PRINS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_CUST_PRINS ***
 exec bpa.alter_policies('OTCN_CUST_PRINS');


COMMENT ON TABLE BARS.OTCN_CUST_PRINS IS '«р≥з пол€ PRINSIDER з таблиц≥ CUSTOMER на к≥нець м≥с€ц€ дл€ D8 файлу';
COMMENT ON COLUMN BARS.OTCN_CUST_PRINS.DATF IS '«в≥тна дата';
COMMENT ON COLUMN BARS.OTCN_CUST_PRINS.KF IS ' од фiлiалу (ћ‘ќ)';
COMMENT ON COLUMN BARS.OTCN_CUST_PRINS.RNK IS '≤д. контрагента';
COMMENT ON COLUMN BARS.OTCN_CUST_PRINS.PRINS IS 'ќзнака ≥нсайдера';




PROMPT *** Create  constraint SYS_C00135449 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_CUST_PRINS MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135450 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_CUST_PRINS MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNCUSTPRINS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_CUST_PRINS MODIFY (KF CONSTRAINT CC_OTCNCUSTPRINS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OTCNCUSTPRINS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_CUST_PRINS ADD CONSTRAINT UK_OTCNCUSTPRINS UNIQUE (DATF, KF, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OTCNCUSTPRINS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OTCNCUSTPRINS ON BARS.OTCN_CUST_PRINS (DATF, KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_CUST_PRINS ***
grant SELECT                                                                 on OTCN_CUST_PRINS to BARSUPL;
grant SELECT                                                                 on OTCN_CUST_PRINS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_CUST_PRINS to BARS_DM;
grant SELECT                                                                 on OTCN_CUST_PRINS to UPLD;



PROMPT *** Create SYNONYM  to OTCN_CUST_PRINS ***

  CREATE OR REPLACE SYNONYM BARS.DM_VERSIONS_LIST FOR BARS.OTCN_CUST_PRINS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_CUST_PRINS.sql =========*** End *
PROMPT ===================================================================================== 
