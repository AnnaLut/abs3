

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAN_KAT23.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAN_KAT23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAN_KAT23'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAN_KAT23'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAN_KAT23'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAN_KAT23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAN_KAT23 
   (	KAT NUMBER(38,0), 
	NAME VARCHAR2(35), 
	K NUMBER, 
	K_MIN NUMBER, 
	K_MAX NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAN_KAT23 ***
 exec bpa.alter_policies('STAN_KAT23');


COMMENT ON TABLE BARS.STAN_KAT23 IS 'НБУ-23/3. Категорiя якостi';
COMMENT ON COLUMN BARS.STAN_KAT23.KAT IS 'Код';
COMMENT ON COLUMN BARS.STAN_KAT23.NAME IS 'Назва ';
COMMENT ON COLUMN BARS.STAN_KAT23.K IS 'пок.ризику кредиту по замовч. НБУ-23';
COMMENT ON COLUMN BARS.STAN_KAT23.K_MIN IS '';
COMMENT ON COLUMN BARS.STAN_KAT23.K_MAX IS '';




PROMPT *** Create  constraint PK_STANKAT23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_KAT23 ADD CONSTRAINT PK_STANKAT23 PRIMARY KEY (KAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANKAT23_KAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_KAT23 MODIFY (KAT CONSTRAINT CC_STANKAT23_KAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANKAT23_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_KAT23 MODIFY (NAME CONSTRAINT CC_STANKAT23_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STANKAT23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STANKAT23 ON BARS.STAN_KAT23 (KAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAN_KAT23 ***
grant SELECT                                                                 on STAN_KAT23      to BARSREADER_ROLE;
grant SELECT                                                                 on STAN_KAT23      to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_KAT23      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_KAT23      to START1;
grant SELECT                                                                 on STAN_KAT23      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAN_KAT23.sql =========*** End *** ==
PROMPT ===================================================================================== 
