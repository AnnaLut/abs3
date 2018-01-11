

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_METALS_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_METALS_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_METALS_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_METALS_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_METALS_TYPE 
   (	KOD NUMBER, 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_METALS_TYPE ***
 exec bpa.alter_policies('BANK_METALS_TYPE');


COMMENT ON TABLE BARS.BANK_METALS_TYPE IS 'Типи банк_вських метал_в в зливках';
COMMENT ON COLUMN BARS.BANK_METALS_TYPE.KOD IS 'Код зливку';
COMMENT ON COLUMN BARS.BANK_METALS_TYPE.NAME IS 'Назва зливку';




PROMPT *** Create  constraint PK_BANKMETALSTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS_TYPE ADD CONSTRAINT PK_BANKMETALSTYPE PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALSTYPE_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS_TYPE MODIFY (KOD CONSTRAINT CC_BANKMETALSTYPE_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALSTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS_TYPE MODIFY (NAME CONSTRAINT CC_BANKMETALSTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKMETALSTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKMETALSTYPE ON BARS.BANK_METALS_TYPE (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_METALS_TYPE ***
grant SELECT                                                                 on BANK_METALS_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on BANK_METALS_TYPE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_METALS_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_METALS_TYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_METALS_TYPE to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_METALS_TYPE to START1;
grant SELECT                                                                 on BANK_METALS_TYPE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS_TYPE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_METALS_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
