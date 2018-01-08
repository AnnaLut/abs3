

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BARS_SUPP_BANKS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BARS_SUPP_BANKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BARS_SUPP_BANKS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BARS_SUPP_BANKS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BARS_SUPP_BANKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BARS_SUPP_BANKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BARS_SUPP_BANKS 
   (	BANK_CODE VARCHAR2(10), 
	BANK_NAME VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BARS_SUPP_BANKS ***
 exec bpa.alter_policies('BARS_SUPP_BANKS');


COMMENT ON TABLE BARS.BARS_SUPP_BANKS IS 'Банки сопровождаемые БАРС-ом';
COMMENT ON COLUMN BARS.BARS_SUPP_BANKS.BANK_CODE IS 'Код банка';
COMMENT ON COLUMN BARS.BARS_SUPP_BANKS.BANK_NAME IS 'Наименование';




PROMPT *** Create  constraint XPK_BARS_SUPP_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARS_SUPP_BANKS ADD CONSTRAINT XPK_BARS_SUPP_BANKS PRIMARY KEY (BANK_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BARS_SUPP_BANKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BARS_SUPP_BANKS ON BARS.BARS_SUPP_BANKS (BANK_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_SUPP_BANKS ***
grant SELECT                                                                 on BARS_SUPP_BANKS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_SUPP_BANKS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BARS_SUPP_BANKS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_SUPP_BANKS to START1;
grant SELECT                                                                 on BARS_SUPP_BANKS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BARS_SUPP_BANKS to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to BARS_SUPP_BANKS ***

  CREATE OR REPLACE PUBLIC SYNONYM BARS_SUPP_BANKS FOR BARS.BARS_SUPP_BANKS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BARS_SUPP_BANKS.sql =========*** End *
PROMPT ===================================================================================== 
