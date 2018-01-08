

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_P__SALDO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_P__SALDO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_P__SALDO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S6_P__SALDO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S6_P__SALDO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_P__SALDO ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_P__SALDO 
   (	NLS VARCHAR2(25), 
	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	MFO NUMBER(10,0), 
	R020_FA VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	OB88 VARCHAR2(4), 
	P080 VARCHAR2(4), 
	R013 CHAR(1), 
	KORG NUMBER(5,0), 
	R011 CHAR(1), 
	F_30 CHAR(4), 
	S085 CHAR(1), 
	TRKK VARCHAR2(2), 
	S240 CHAR(1), 
	Syntax NUMBER(10,0), 
	S260 CHAR(2), 
	S270 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_P__SALDO ***
 exec bpa.alter_policies('S6_P__SALDO');


COMMENT ON TABLE BARS.S6_P__SALDO IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.NLS IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.I_VA IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.MFO IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.R020_FA IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.OB22 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.OB88 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.P080 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.R013 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.KORG IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.R011 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.F_30 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.S085 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.TRKK IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.S240 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.Syntax IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.S260 IS '';
COMMENT ON COLUMN BARS.S6_P__SALDO.S270 IS '';




PROMPT *** Create  constraint SYS_C007740 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_P__SALDO MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007741 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_P__SALDO MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007742 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_P__SALDO MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007743 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_P__SALDO MODIFY (Syntax NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_P__SALDO ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_P__SALDO ON BARS.S6_P__SALDO (NLS, I_VA, GROUP_U) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_P__SALDO ***
grant SELECT                                                                 on S6_P__SALDO     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_P__SALDO     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_P__SALDO     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_P__SALDO     to START1;
grant SELECT                                                                 on S6_P__SALDO     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_P__SALDO.sql =========*** End *** =
PROMPT ===================================================================================== 
