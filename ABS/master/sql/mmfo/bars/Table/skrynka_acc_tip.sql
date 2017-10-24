

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ACC_TIP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ACC_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ACC_TIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ACC_TIP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ACC_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ACC_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ACC_TIP 
   (	TIP VARCHAR2(1), 
	NAME VARCHAR2(100), 
	OB22 CHAR(2), 
	OB22_U CHAR(2), 
	NBS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ACC_TIP ***
 exec bpa.alter_policies('SKRYNKA_ACC_TIP');


COMMENT ON TABLE BARS.SKRYNKA_ACC_TIP IS 'типы индивидуального счета сейфа';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_TIP.TIP IS 'типа счета (код)';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_TIP.NAME IS 'название типа счета';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_TIP.OB22 IS 'OB22 рахунка ФО';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_TIP.OB22_U IS 'OB22 рахунка ЮО';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_TIP.NBS IS '';




PROMPT *** Create  constraint XUK_SKRYNKA_ACC_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_TIP ADD CONSTRAINT XUK_SKRYNKA_ACC_NAME UNIQUE (NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKA_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_TIP ADD CONSTRAINT PK_SKRYNKA_ACC PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SKRYNKA_ACC_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_ACC_NAME ON BARS.SKRYNKA_ACC_TIP (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA_ACC ON BARS.SKRYNKA_ACC_TIP (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ACC_TIP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_ACC_TIP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_ACC_TIP to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_ACC_TIP to DEP_SKRN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ACC_TIP to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_ACC_TIP ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_ACC_TIP FOR BARS.SKRYNKA_ACC_TIP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ACC_TIP.sql =========*** End *
PROMPT ===================================================================================== 
