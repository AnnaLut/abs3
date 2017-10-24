

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_SMS_PHONES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_SMS_PHONES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_SMS_PHONES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_SMS_PHONES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_SMS_PHONES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_SMS_PHONES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_SMS_PHONES 
   (	ACC NUMBER(*,0), 
	PHONE VARCHAR2(30), 
	PHONE1 VARCHAR2(30), 
	PHONE2 VARCHAR2(30), 
	ENCODE VARCHAR2(3), 
	ENCODE1 VARCHAR2(3), 
	ENCODE2 VARCHAR2(3), 
	DAILYREPORT VARCHAR2(1) DEFAULT null, 
	PAYFORSMS VARCHAR2(1) DEFAULT null, 
	SMSCLEARANCE VARCHAR2(1) DEFAULT null
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_SMS_PHONES ***
 exec bpa.alter_policies('ACC_SMS_PHONES');


COMMENT ON TABLE BARS.ACC_SMS_PHONES IS 'Дополнительные мобильные телефоны для рассылки SMS по счетам';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.ACC IS 'ACC счета';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.PHONE IS 'Номер моб. телефона, н-р, +380673334455';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.PHONE1 IS 'Доп. номер моб. телефона(1-ый)';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.PHONE2 IS 'Доп. номер моб. телефона(2-ой)';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.ENCODE IS '';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.ENCODE1 IS '';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.ENCODE2 IS '';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.DAILYREPORT IS 'Ознака відправки щоденної виписки по рахунку (Y - так)';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.PAYFORSMS IS '';
COMMENT ON COLUMN BARS.ACC_SMS_PHONES.SMSCLEARANCE IS '';




PROMPT *** Create  constraint PK_ACCSMSPHONES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SMS_PHONES ADD CONSTRAINT PK_ACCSMSPHONES PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCSMSPHONES_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SMS_PHONES MODIFY (ACC CONSTRAINT CC_ACCSMSPHONES_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCSMSPHONES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCSMSPHONES ON BARS.ACC_SMS_PHONES (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ACC_SMS_PHONE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ACC_SMS_PHONE ON BARS.ACC_SMS_PHONES (PHONE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_SMS_PHONES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_SMS_PHONES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_SMS_PHONES  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_SMS_PHONES  to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_SMS_PHONES  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_SMS_PHONES.sql =========*** End **
PROMPT ===================================================================================== 
