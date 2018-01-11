

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_METALS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_METALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_METALS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_METALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_METALS 
   (	KOD NUMBER, 
	KV NUMBER, 
	VES NUMBER, 
	VES_UN NUMBER, 
	TYPE_ NUMBER, 
	PROBA NUMBER, 
	NAME VARCHAR2(70), 
	NAME_COMMENT VARCHAR2(160), 
	CENA_PROD NUMBER, 
	CENA_KUPI NUMBER, 
	PDV NUMBER(1,0), 
	CENA_NOMI NUMBER, 
	SUM_KOM NUMBER DEFAULT 0, 
	OB_22 VARCHAR2(2) DEFAULT null
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_METALS ***
 exec bpa.alter_policies('BANK_METALS');


COMMENT ON TABLE BARS.BANK_METALS IS 'Види банківських металів в зливках';
COMMENT ON COLUMN BARS.BANK_METALS.KOD IS 'Код зливку';
COMMENT ON COLUMN BARS.BANK_METALS.KV IS '';
COMMENT ON COLUMN BARS.BANK_METALS.VES IS 'Вага зливку в гр.';
COMMENT ON COLUMN BARS.BANK_METALS.VES_UN IS 'Вага зливка в унціях';
COMMENT ON COLUMN BARS.BANK_METALS.TYPE_ IS 'Тип виробу 1 - зливок , 2 - монета.';
COMMENT ON COLUMN BARS.BANK_METALS.PROBA IS 'Проба злитка';
COMMENT ON COLUMN BARS.BANK_METALS.NAME IS 'Назва зливку';
COMMENT ON COLUMN BARS.BANK_METALS.NAME_COMMENT IS 'Назва зливку (детальне)';
COMMENT ON COLUMN BARS.BANK_METALS.CENA_PROD IS '';
COMMENT ON COLUMN BARS.BANK_METALS.CENA_KUPI IS '';
COMMENT ON COLUMN BARS.BANK_METALS.PDV IS '';
COMMENT ON COLUMN BARS.BANK_METALS.CENA_NOMI IS '';
COMMENT ON COLUMN BARS.BANK_METALS.SUM_KOM IS '';
COMMENT ON COLUMN BARS.BANK_METALS.OB_22 IS '';




PROMPT *** Create  constraint PK_BANKMETALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS ADD CONSTRAINT PK_BANKMETALS PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALS_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS MODIFY (KOD CONSTRAINT CC_BANKMETALS_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALS_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS MODIFY (KV CONSTRAINT CC_BANKMETALS_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALS_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS MODIFY (TYPE_ CONSTRAINT CC_BANKMETALS_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS MODIFY (NAME CONSTRAINT CC_BANKMETALS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKMETALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKMETALS ON BARS.BANK_METALS (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_METALS ***
grant SELECT                                                                 on BANK_METALS     to BARSREADER_ROLE;
grant SELECT                                                                 on BANK_METALS     to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_METALS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_METALS     to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_METALS     to START1;
grant SELECT                                                                 on BANK_METALS     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BANK_METALS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_METALS.sql =========*** End *** =
PROMPT ===================================================================================== 
