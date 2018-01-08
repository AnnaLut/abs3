

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_IFC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_IFC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_IFC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_IFC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_IFC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_IFC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_IFC 
   (	IFC NUMBER(*,0), 
	RNK NUMBER, 
	KV NUMBER(*,0), 
	FLI NUMBER(*,0), 
	NAME VARCHAR2(35), 
	ACCOUNT VARCHAR2(15), 
	NOSTRO_BANK CHAR(11), 
	NOSTRO_ACC VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_IFC ***
 exec bpa.alter_policies('CUSTOMER_IFC');


COMMENT ON TABLE BARS.CUSTOMER_IFC IS '';
COMMENT ON COLUMN BARS.CUSTOMER_IFC.IFC IS '';
COMMENT ON COLUMN BARS.CUSTOMER_IFC.RNK IS '';
COMMENT ON COLUMN BARS.CUSTOMER_IFC.KV IS '';
COMMENT ON COLUMN BARS.CUSTOMER_IFC.FLI IS '';
COMMENT ON COLUMN BARS.CUSTOMER_IFC.NAME IS '';
COMMENT ON COLUMN BARS.CUSTOMER_IFC.ACCOUNT IS '';
COMMENT ON COLUMN BARS.CUSTOMER_IFC.NOSTRO_BANK IS '';
COMMENT ON COLUMN BARS.CUSTOMER_IFC.NOSTRO_ACC IS '';




PROMPT *** Create  constraint XPK_CUSTOMER_IFC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IFC ADD CONSTRAINT XPK_CUSTOMER_IFC PRIMARY KEY (IFC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_INTERBANK_CUSTOMERIFC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IFC ADD CONSTRAINT R_INTERBANK_CUSTOMERIFC FOREIGN KEY (FLI)
	  REFERENCES BARS.INTERBANK (FLI) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_SWBANKS_CUSTOMER_IFC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IFC ADD CONSTRAINT R_SWBANKS_CUSTOMER_IFC FOREIGN KEY (NOSTRO_BANK)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CUSTOMER_IFC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CUSTOMER_IFC ON BARS.CUSTOMER_IFC (IFC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_IFC ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_IFC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_IFC    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_IFC    to SWIFT001;
grant FLASHBACK,SELECT                                                       on CUSTOMER_IFC    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_IFC.sql =========*** End *** 
PROMPT ===================================================================================== 
