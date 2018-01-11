

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF_TIP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TARIFF_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TARIFF_TIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TARIFF_TIP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TARIFF_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TARIFF_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TARIFF_TIP 
   (	TIP NUMBER, 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_TARIFF_TIP ***
 exec bpa.alter_policies('SKRYNKA_TARIFF_TIP');


COMMENT ON TABLE BARS.SKRYNKA_TARIFF_TIP IS 'тип тарифа  -  признак модели тарифной оплаты';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF_TIP.TIP IS 'код типа тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF_TIP.NAME IS 'наименование типа тарифа';




PROMPT *** Create  constraint PK_SKRYNKATARIFFTIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_TIP ADD CONSTRAINT PK_SKRYNKATARIFFTIP PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_SKRYNKA_TARIFF_TIP_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_TIP ADD CONSTRAINT XUK_SKRYNKA_TARIFF_TIP_NAME UNIQUE (NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFFTIP_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_TIP MODIFY (TIP CONSTRAINT CC_SKRYNKATARIFFTIP_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKATARIFFTIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKATARIFFTIP ON BARS.SKRYNKA_TARIFF_TIP (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SKRYNKA_TARIFF_TIP_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_TARIFF_TIP_NAME ON BARS.SKRYNKA_TARIFF_TIP (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TARIFF_TIP ***
grant SELECT                                                                 on SKRYNKA_TARIFF_TIP to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TARIFF_TIP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_TARIFF_TIP to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TARIFF_TIP to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_TARIFF_TIP to START1;
grant SELECT                                                                 on SKRYNKA_TARIFF_TIP to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TARIFF_TIP to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_TARIFF_TIP to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_TARIFF_TIP ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_TARIFF_TIP FOR BARS.SKRYNKA_TARIFF_TIP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF_TIP.sql =========*** En
PROMPT ===================================================================================== 
