

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_R020_B5.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_R020_B5 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_R020_B5'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_R020_B5'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_R020_B5'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_R020_B5 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_R020_B5 
   (	R020 VARCHAR2(4), 
	T020 VARCHAR2(1), 
	R050 VARCHAR2(2), 
	TXT VARCHAR2(192), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	R114 CHAR(1), 
	DDD CHAR(3), 
	PR_A NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_R020_B5 ***
 exec bpa.alter_policies('KOD_R020_B5');


COMMENT ON TABLE BARS.KOD_R020_B5 IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.R020 IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.T020 IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.R050 IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.TXT IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.D_MODE IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.R114 IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.DDD IS '';
COMMENT ON COLUMN BARS.KOD_R020_B5.PR_A IS '';




PROMPT *** Create  constraint KOD_R020_B5_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOD_R020_B5 ADD CONSTRAINT KOD_R020_B5_PK PRIMARY KEY (R020, T020, R114, DDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KOD_R020_B5_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KOD_R020_B5_PK ON BARS.KOD_R020_B5 (R020, T020, R114, DDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KOD_R020_B5 ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KOD_R020_B5     to ABS_ADMIN;
grant SELECT                                                                 on KOD_R020_B5     to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on KOD_R020_B5     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_R020_B5     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_R020_B5     to RPBN002;
grant SELECT                                                                 on KOD_R020_B5     to START1;
grant SELECT                                                                 on KOD_R020_B5     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_R020_B5     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KOD_R020_B5     to WR_REFREAD;



PROMPT *** Create SYNONYM  to KOD_R020_B5 ***

  CREATE OR REPLACE PUBLIC SYNONYM KOD_R020_B5 FOR BARS.KOD_R020_B5;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_R020_B5.sql =========*** End *** =
PROMPT ===================================================================================== 
