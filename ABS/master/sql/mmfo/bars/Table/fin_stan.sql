

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_STAN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_STAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_STAN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_STAN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_STAN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_STAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_STAN 
   (	CUSTTYPE NUMBER(1,0), 
	FIN NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_STAN ***
 exec bpa.alter_policies('FIN_STAN');


COMMENT ON TABLE BARS.FIN_STAN IS 'Фінансовий стан позичальника';
COMMENT ON COLUMN BARS.FIN_STAN.CUSTTYPE IS 'Тип клієнта';
COMMENT ON COLUMN BARS.FIN_STAN.FIN IS 'Фін. стан';
COMMENT ON COLUMN BARS.FIN_STAN.NAME IS 'Назва';




PROMPT *** Create  constraint PK_FINSTAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_STAN ADD CONSTRAINT PK_FINSTAN PRIMARY KEY (CUSTTYPE, FIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINSTAN_CUSTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_STAN MODIFY (CUSTTYPE CONSTRAINT CC_FINSTAN_CUSTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINSTAN_FIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_STAN MODIFY (FIN CONSTRAINT CC_FINSTAN_FIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINSTAN_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_STAN MODIFY (NAME CONSTRAINT CC_FINSTAN_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINSTAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINSTAN ON BARS.FIN_STAN (CUSTTYPE, FIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_STAN ***
grant SELECT                                                                 on FIN_STAN        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_STAN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_STAN        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_STAN        to START1;
grant SELECT                                                                 on FIN_STAN        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_STAN.sql =========*** End *** ====
PROMPT ===================================================================================== 
