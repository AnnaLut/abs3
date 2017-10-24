

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BOPBANK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BOPBANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BOPBANK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BOPBANK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BOPBANK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BOPBANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.BOPBANK 
   (	REGNUM CHAR(4), 
	NAME VARCHAR2(35), 
	ADDRESS VARCHAR2(35), 
	FIO CHAR(3), 
	ELADR VARCHAR2(20), 
	BIC CHAR(11), 
	REGNUM_N VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BOPBANK ***
 exec bpa.alter_policies('BOPBANK');


COMMENT ON TABLE BARS.BOPBANK IS '';
COMMENT ON COLUMN BARS.BOPBANK.REGNUM IS '';
COMMENT ON COLUMN BARS.BOPBANK.NAME IS '';
COMMENT ON COLUMN BARS.BOPBANK.ADDRESS IS '';
COMMENT ON COLUMN BARS.BOPBANK.FIO IS '';
COMMENT ON COLUMN BARS.BOPBANK.ELADR IS '';
COMMENT ON COLUMN BARS.BOPBANK.BIC IS 'Код BIC для определения банка в 1-ПБ';
COMMENT ON COLUMN BARS.BOPBANK.REGNUM_N IS '';




PROMPT *** Create  constraint FK_BOPBANK_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BOPBANK ADD CONSTRAINT FK_BOPBANK_SWBANKS FOREIGN KEY (BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BOPBANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BOPBANK ADD CONSTRAINT XPK_BOPBANK PRIMARY KEY (REGNUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BOPBANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BOPBANK ON BARS.BOPBANK (REGNUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BOPBANK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BOPBANK         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BOPBANK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BOPBANK         to BARS_DM;
grant SELECT                                                                 on BOPBANK         to OPERKKK;
grant DELETE,INSERT,SELECT,UPDATE                                            on BOPBANK         to PB1;
grant SELECT                                                                 on BOPBANK         to PYOD001;
grant SELECT                                                                 on BOPBANK         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BOPBANK         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BOPBANK         to WR_REFREAD;



PROMPT *** Create SYNONYM  to BOPBANK ***

  CREATE OR REPLACE PUBLIC SYNONYM BOPBANK FOR BARS.BOPBANK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BOPBANK.sql =========*** End *** =====
PROMPT ===================================================================================== 
