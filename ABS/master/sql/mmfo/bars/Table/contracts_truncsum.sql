

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRACTS_TRUNCSUM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRACTS_TRUNCSUM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRACTS_TRUNCSUM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRACTS_TRUNCSUM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRACTS_TRUNCSUM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRACTS_TRUNCSUM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRACTS_TRUNCSUM 
   (	CURCODE NUMBER(38,0), 
	TRUNCSUM NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRACTS_TRUNCSUM ***
 exec bpa.alter_policies('CONTRACTS_TRUNCSUM');


COMMENT ON TABLE BARS.CONTRACTS_TRUNCSUM IS '';
COMMENT ON COLUMN BARS.CONTRACTS_TRUNCSUM.CURCODE IS '';
COMMENT ON COLUMN BARS.CONTRACTS_TRUNCSUM.TRUNCSUM IS '';




PROMPT *** Create  constraint PK_CONTRACTSTRUNCSUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_TRUNCSUM ADD CONSTRAINT PK_CONTRACTSTRUNCSUM PRIMARY KEY (CURCODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CNTRCTTRUNCSUM_CURCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_TRUNCSUM MODIFY (CURCODE CONSTRAINT CC_CNTRCTTRUNCSUM_CURCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CNTRCTTRUNCSUM_TRUNCSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_TRUNCSUM MODIFY (TRUNCSUM CONSTRAINT CC_CNTRCTTRUNCSUM_TRUNCSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CONTRACTSTRUNCSUM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CONTRACTSTRUNCSUM ON BARS.CONTRACTS_TRUNCSUM (CURCODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CONTRACTS_TRUNCSUM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTRACTS_TRUNCSUM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CONTRACTS_TRUNCSUM to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CONTRACTS_TRUNCSUM to F_500;
grant FLASHBACK,SELECT                                                       on CONTRACTS_TRUNCSUM to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRACTS_TRUNCSUM.sql =========*** En
PROMPT ===================================================================================== 
