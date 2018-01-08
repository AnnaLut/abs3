

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_STAFF_TIP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_STAFF_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_STAFF_TIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_STAFF_TIP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_STAFF_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_STAFF_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_STAFF_TIP 
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




PROMPT *** ALTER_POLICIES to SKRYNKA_STAFF_TIP ***
 exec bpa.alter_policies('SKRYNKA_STAFF_TIP');


COMMENT ON TABLE BARS.SKRYNKA_STAFF_TIP IS 'тип исполнителя связанного с деп. сейфами';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF_TIP.TIP IS 'тп исполнителя';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF_TIP.NAME IS 'наименование типа исполнителя';




PROMPT *** Create  constraint PK_SKRYNKASTAFFTIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF_TIP ADD CONSTRAINT PK_SKRYNKASTAFFTIP PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKASTAFFTIP_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF_TIP MODIFY (TIP CONSTRAINT CC_SKRYNKASTAFFTIP_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKASTAFFTIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKASTAFFTIP ON BARS.SKRYNKA_STAFF_TIP (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_STAFF_TIP ***
grant SELECT                                                                 on SKRYNKA_STAFF_TIP to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_STAFF_TIP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_STAFF_TIP to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_STAFF_TIP to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_STAFF_TIP to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_STAFF_TIP to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_STAFF_TIP ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_STAFF_TIP FOR BARS.SKRYNKA_STAFF_TIP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_STAFF_TIP.sql =========*** End
PROMPT ===================================================================================== 
