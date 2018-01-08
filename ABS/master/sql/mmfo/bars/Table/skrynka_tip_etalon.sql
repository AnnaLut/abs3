

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TIP_ETALON.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TIP_ETALON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TIP_ETALON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TIP_ETALON'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TIP_ETALON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TIP_ETALON ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TIP_ETALON 
   (	ID NUMBER(5,0), 
	NAME VARCHAR2(150 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_TIP_ETALON ***
 exec bpa.alter_policies('SKRYNKA_TIP_ETALON');


COMMENT ON TABLE BARS.SKRYNKA_TIP_ETALON IS 'Еталонні типи депозитних сейфів';
COMMENT ON COLUMN BARS.SKRYNKA_TIP_ETALON.ID IS 'Ідентифікатор еталонної групи сейфів';
COMMENT ON COLUMN BARS.SKRYNKA_TIP_ETALON.NAME IS 'Назва еталонної групи';




PROMPT *** Create  constraint PK_SKRYNKA_TIP_ETALON ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_ETALON ADD CONSTRAINT PK_SKRYNKA_TIP_ETALON PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIPETALIN_O_SK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_ETALON MODIFY (ID CONSTRAINT CC_SKRYNKATIPETALIN_O_SK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIPETALIN_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_ETALON MODIFY (NAME CONSTRAINT CC_SKRYNKATIPETALIN_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA_TIP_ETALON ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA_TIP_ETALON ON BARS.SKRYNKA_TIP_ETALON (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TIP_ETALON ***
grant SELECT                                                                 on SKRYNKA_TIP_ETALON to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TIP_ETALON to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_TIP_ETALON to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TIP_ETALON.sql =========*** En
PROMPT ===================================================================================== 
