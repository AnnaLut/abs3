

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_Credit_Percent.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_Credit_Percent ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_Credit_Percent ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_Credit_Percent 
   (	BIC NUMBER(10,0), 
	IdContract VARCHAR2(40), 
	D_Begin DATE, 
	Prc_Osn NUMBER(10,0), 
	Prc_Prs NUMBER(10,0), 
	Prc_Pin NUMBER(10,0), 
	Prc_Pnp NUMBER(10,0), 
	D_End DATE, 
	Flag NUMBER(10,0), 
	Percent_N NUMBER(16,0), 
	Prc_Obs NUMBER(10,0), 
	Prc_Dst NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_Credit_Percent ***
 exec bpa.alter_policies('S6_Credit_Percent');


COMMENT ON TABLE BARS.S6_Credit_Percent IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.BIC IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.IdContract IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.D_Begin IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.Prc_Osn IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.Prc_Prs IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.Prc_Pin IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.Prc_Pnp IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.D_End IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.Flag IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.Percent_N IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.Prc_Obs IS '';
COMMENT ON COLUMN BARS.S6_Credit_Percent.Prc_Dst IS '';




PROMPT *** Create  constraint SYS_C008712 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Credit_Percent MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008713 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Credit_Percent MODIFY (IdContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008714 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Credit_Percent MODIFY (Percent_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_Credit_Percent ***
grant SELECT                                                                 on S6_Credit_Percent to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_Credit_Percent.sql =========*** End
PROMPT ===================================================================================== 
