

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_CPROD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_CPROD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_CPROD'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_CPROD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_CPROD'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_CPROD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_CPROD 
   (	CPROD_ID NUMBER, 
	CPROD_NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_CPROD ***
 exec bpa.alter_policies('CCK_CPROD');


COMMENT ON TABLE BARS.CCK_CPROD IS 'Перелік кредитних продуктів';
COMMENT ON COLUMN BARS.CCK_CPROD.CPROD_ID IS 'Код продукта';
COMMENT ON COLUMN BARS.CCK_CPROD.CPROD_NAME IS 'Наименование продукта';




PROMPT *** Create  constraint PK_CCKCPROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_CPROD ADD CONSTRAINT PK_CCKCPROD PRIMARY KEY (CPROD_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCCPRODID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_CPROD MODIFY (CPROD_ID CONSTRAINT CC_CCCPRODID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKCPROD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKCPROD ON BARS.CCK_CPROD (CPROD_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_CPROD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_CPROD       to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CCK_CPROD       to BARSREADER_ROLE;
grant SELECT                                                                 on CCK_CPROD       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_CPROD       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_CPROD       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_CPROD       to RCC_DEAL;
grant SELECT                                                                 on CCK_CPROD       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_CPROD.sql =========*** End *** ===
PROMPT ===================================================================================== 
