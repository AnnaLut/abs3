

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TAG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TAG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TAG 
   (	TAG VARCHAR2(5), 
	CUSTTYPE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_TAG ***
 exec bpa.alter_policies('SKRYNKA_TAG');


COMMENT ON TABLE BARS.SKRYNKA_TAG IS 'доп реквизиты договоров аренды сейфов';
COMMENT ON COLUMN BARS.SKRYNKA_TAG.TAG IS 'доп. параметр договора';
COMMENT ON COLUMN BARS.SKRYNKA_TAG.CUSTTYPE IS 'тип клиента';




PROMPT *** Create  constraint CC_SKRYNKATAG_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TAG MODIFY (TAG CONSTRAINT CC_SKRYNKATAG_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKATAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TAG ADD CONSTRAINT PK_SKRYNKATAG PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKATAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKATAG ON BARS.SKRYNKA_TAG (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TAG ***
grant SELECT                                                                 on SKRYNKA_TAG     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TAG     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_TAG     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_TAG     to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_TAG     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TAG     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_TAG     to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_TAG ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_TAG FOR BARS.SKRYNKA_TAG;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TAG.sql =========*** End *** =
PROMPT ===================================================================================== 
