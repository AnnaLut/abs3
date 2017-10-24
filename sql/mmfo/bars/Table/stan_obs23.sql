

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAN_OBS23.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAN_OBS23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAN_OBS23'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAN_OBS23'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAN_OBS23'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAN_OBS23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAN_OBS23 
   (	OBS NUMBER(38,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAN_OBS23 ***
 exec bpa.alter_policies('STAN_OBS23');


COMMENT ON TABLE BARS.STAN_OBS23 IS 'НБУ-23/2. Обсл.боргу';
COMMENT ON COLUMN BARS.STAN_OBS23.OBS IS 'Код';
COMMENT ON COLUMN BARS.STAN_OBS23.NAME IS 'Назва ';




PROMPT *** Create  constraint PK_STANOBS23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_OBS23 ADD CONSTRAINT PK_STANOBS23 PRIMARY KEY (OBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANOBS23_OBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_OBS23 MODIFY (OBS CONSTRAINT CC_STANOBS23_OBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANOBS23_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_OBS23 MODIFY (NAME CONSTRAINT CC_STANOBS23_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STANOBS23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STANOBS23 ON BARS.STAN_OBS23 (OBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAN_OBS23 ***
grant SELECT                                                                 on STAN_OBS23      to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAN_OBS23      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAN_OBS23      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_OBS23      to START1;
grant SELECT                                                                 on STAN_OBS23      to UPLD;
grant FLASHBACK,SELECT                                                       on STAN_OBS23      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAN_OBS23.sql =========*** End *** ==
PROMPT ===================================================================================== 
