

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_BANK_KEY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_BANK_KEY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_BANK_KEY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_BANK_KEY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_BANK_KEY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_BANK_KEY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_BANK_KEY 
   (	BIC CHAR(11), 
	CORR_BIC CHAR(11)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_BANK_KEY ***
 exec bpa.alter_policies('SW_BANK_KEY');


COMMENT ON TABLE BARS.SW_BANK_KEY IS 'Таблица ключей';
COMMENT ON COLUMN BARS.SW_BANK_KEY.BIC IS 'BIC-код банка получателя';
COMMENT ON COLUMN BARS.SW_BANK_KEY.CORR_BIC IS 'BIC-код банка корреспондента получателя';




PROMPT *** Create  constraint PK_SWBANKKEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANK_KEY ADD CONSTRAINT PK_SWBANKKEY PRIMARY KEY (BIC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWBANKKEY_BIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANK_KEY MODIFY (BIC CONSTRAINT CC_SWBANKKEY_BIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWBANKKEY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWBANKKEY ON BARS.SW_BANK_KEY (BIC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_BANK_KEY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_BANK_KEY     to BARS013;
grant SELECT                                                                 on SW_BANK_KEY     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_BANK_KEY     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_BANK_KEY     to BARS_DM;
grant SELECT                                                                 on SW_BANK_KEY     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_BANK_KEY     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_BANK_KEY     to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_BANK_KEY ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_BANK_KEY FOR BARS.SW_BANK_KEY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_BANK_KEY.sql =========*** End *** =
PROMPT ===================================================================================== 
