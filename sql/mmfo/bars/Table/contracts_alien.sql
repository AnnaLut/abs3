

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRACTS_ALIEN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRACTS_ALIEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRACTS_ALIEN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRACTS_ALIEN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CONTRACTS_ALIEN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRACTS_ALIEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRACTS_ALIEN 
   (	RNK NUMBER, 
	BENEFRNK NUMBER, 
	BENEFNAME VARCHAR2(50), 
	BENEFCOUNTRY NUMBER, 
	BENEFADR VARCHAR2(50), 
	BENEFBANK VARCHAR2(50), 
	BENEFACC VARCHAR2(50), 
	BENEFBIC CHAR(11), 
	BANK_CODE VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRACTS_ALIEN ***
 exec bpa.alter_policies('CONTRACTS_ALIEN');


COMMENT ON TABLE BARS.CONTRACTS_ALIEN IS 'Валютный контроль. Справочник контрагентов-нерезидентов';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.RNK IS 'Рег.№ клиента-резидента';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFRNK IS 'Рег.№ клиента-нерезидента';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFNAME IS 'Наименование клиента-нерезидента';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFCOUNTRY IS 'Код страны клиента-нерезидента';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFADR IS 'Адрес нерезидента';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFBANK IS 'Банк нерезидента';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFACC IS 'Счет нерезидента';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFBIC IS 'BIC-код банка нерезидента';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BANK_CODE IS 'Код банка нерезидента';




PROMPT *** Create  constraint FK_CONTRACTSALIEN_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_ALIEN ADD CONSTRAINT FK_CONTRACTSALIEN_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CONTRACTSALIEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_ALIEN ADD CONSTRAINT PK_CONTRACTSALIEN PRIMARY KEY (BENEFRNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CONTRACTSALIEN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CONTRACTSALIEN ON BARS.CONTRACTS_ALIEN (BENEFRNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CONTRACTS_ALIEN ***
grant SELECT                                                                 on CONTRACTS_ALIEN to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTRACTS_ALIEN to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRACTS_ALIEN.sql =========*** End *
PROMPT ===================================================================================== 
