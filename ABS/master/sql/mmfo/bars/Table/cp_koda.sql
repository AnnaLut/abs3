

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KODA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KODA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KODA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KODA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KODA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KODA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KODA 
   (	ID NUMBER(*,0), 
	R NUMBER, 
	D NUMBER, 
	EC NUMBER(24,4), 
	NP1 NUMBER(24,4), 
	NP2 NUMBER(24,4), 
	NP3 NUMBER(24,4), 
	PV NUMBER(24,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KODA ***
 exec bpa.alter_policies('CP_KODA');


COMMENT ON TABLE BARS.CP_KODA IS 'Додатков рекв ЦП типу Акц';
COMMENT ON COLUMN BARS.CP_KODA.ID IS 'вн код ЦП';
COMMENT ON COLUMN BARS.CP_KODA.R IS 'поточна ринкова ставка доходності (ставка KIАСR) найтривалішого строку (що не перевищує одного року), коееф';
COMMENT ON COLUMN BARS.CP_KODA.D IS 'частка участі Банку в статутному капіталі емітента цінних паперів з нефіксованим прибутком станом на кінець останнього звітного періоду (останній звітний квартал для юридичних осіб (крім банків) та останній звітний місяць для банків); коееф';
COMMENT ON COLUMN BARS.CP_KODA.EC IS 'розмір власного капіталу емітента за даними фінансової звітності станом на кінець останнього звітного періоду (останній звітний квартал для юридичних осіб (крім банків) та останній звітний місяць для банків). Сума капіталу емітента визначається за даними балансу емітента як загальний обсяг його власного капіталу.  Сумма грн';
COMMENT ON COLUMN BARS.CP_KODA.NP1 IS 'розмір чистого прибутку (після оподаткування) емітента відповідного цінного паперу за даними річної фінансової звітності за  1-й фінансовий рік;';
COMMENT ON COLUMN BARS.CP_KODA.NP2 IS 'розмір чистого прибутку (після оподаткування) емітента відповідного цінного паперу за даними річної фінансової звітності за  2-й фінансовий рік;';
COMMENT ON COLUMN BARS.CP_KODA.NP3 IS 'розмір чистого прибутку (після оподаткування) емітента відповідного цінного паперу за даними річної фінансової звітності за  3-й фінансовий рік;';
COMMENT ON COLUMN BARS.CP_KODA.PV IS '';




PROMPT *** Create  constraint FK_CP_KODA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KODA ADD CONSTRAINT FK_CP_KODA_ID FOREIGN KEY (ID)
	  REFERENCES BARS.CP_KOD (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CP_KODA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KODA ADD CONSTRAINT PK_CP_KODA_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_KODA_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_KODA_ID ON BARS.CP_KODA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_KODA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_KODA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_KODA         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_KODA         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KODA.sql =========*** End *** =====
PROMPT ===================================================================================== 
