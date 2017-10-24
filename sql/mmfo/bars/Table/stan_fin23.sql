

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAN_FIN23.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAN_FIN23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAN_FIN23'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAN_FIN23'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAN_FIN23'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAN_FIN23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAN_FIN23 
   (	FIN NUMBER(38,0), 
	NAME VARCHAR2(35), 
	CODE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAN_FIN23 ***
 exec bpa.alter_policies('STAN_FIN23');


COMMENT ON TABLE BARS.STAN_FIN23 IS 'Õ¡”-23/1. ‘iÌ Î‡Ò ';
COMMENT ON COLUMN BARS.STAN_FIN23.FIN IS ' Ó‰';
COMMENT ON COLUMN BARS.STAN_FIN23.NAME IS 'Õ‡Á‚‡ ';
COMMENT ON COLUMN BARS.STAN_FIN23.CODE IS '';




PROMPT *** Create  constraint PK_STANFIN23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_FIN23 ADD CONSTRAINT PK_STANFIN23 PRIMARY KEY (FIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANFIN23_FIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_FIN23 MODIFY (FIN CONSTRAINT CC_STANFIN23_FIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANFIN23_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_FIN23 MODIFY (NAME CONSTRAINT CC_STANFIN23_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STANFIN23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STANFIN23 ON BARS.STAN_FIN23 (FIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAN_FIN23 ***
grant SELECT                                                                 on STAN_FIN23      to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_FIN23      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAN_FIN23      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_FIN23      to START1;
grant SELECT                                                                 on STAN_FIN23      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAN_FIN23.sql =========*** End *** ==
PROMPT ===================================================================================== 
