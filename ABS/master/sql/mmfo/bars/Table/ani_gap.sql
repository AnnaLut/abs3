

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_GAP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_GAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_GAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_GAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_GAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_GAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_GAP 
   (	FDAT DATE, 
	PAP NUMBER(*,0), 
	KV NUMBER(*,0), 
	BRANCH VARCHAR2(30), 
	KOL NUMBER(*,0), 
	G00 NUMBER, 
	R00 NUMBER, 
	G01 NUMBER, 
	R01 NUMBER, 
	G02 NUMBER, 
	R02 NUMBER, 
	G03 NUMBER, 
	R03 NUMBER, 
	G04 NUMBER, 
	R04 NUMBER, 
	G05 NUMBER, 
	R05 NUMBER, 
	G06 NUMBER, 
	R06 NUMBER, 
	G07 NUMBER, 
	R07 NUMBER, 
	G0A NUMBER, 
	R0A NUMBER, 
	G0B NUMBER, 
	R0B NUMBER, 
	G0C NUMBER, 
	R0C NUMBER, 
	G0D NUMBER, 
	R0D NUMBER, 
	G0E NUMBER, 
	R0E NUMBER, 
	G0F NUMBER, 
	R0F NUMBER, 
	G0G NUMBER, 
	R0G NUMBER, 
	G0H NUMBER, 
	R0H NUMBER, 
	G0X NUMBER, 
	R0X NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_GAP ***
 exec bpa.alter_policies('ANI_GAP');


COMMENT ON TABLE BARS.ANI_GAP IS '';
COMMENT ON COLUMN BARS.ANI_GAP.FDAT IS '';
COMMENT ON COLUMN BARS.ANI_GAP.PAP IS '';
COMMENT ON COLUMN BARS.ANI_GAP.KV IS '';
COMMENT ON COLUMN BARS.ANI_GAP.BRANCH IS '';
COMMENT ON COLUMN BARS.ANI_GAP.KOL IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G00 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R00 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G01 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R01 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G02 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R02 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G03 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R03 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G04 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R04 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G05 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R05 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G06 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R06 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G07 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R07 IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0A IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0A IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0B IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0B IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0C IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0C IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0D IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0D IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0E IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0E IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0F IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0F IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0G IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0G IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0H IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0H IS '';
COMMENT ON COLUMN BARS.ANI_GAP.G0X IS '';
COMMENT ON COLUMN BARS.ANI_GAP.R0X IS '';




PROMPT *** Create  constraint PK_ANIGAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI_GAP ADD CONSTRAINT PK_ANIGAP PRIMARY KEY (FDAT, PAP, KV, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ANIGAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ANIGAP ON BARS.ANI_GAP (FDAT, PAP, KV, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANI_GAP ***
grant SELECT                                                                 on ANI_GAP         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI_GAP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI_GAP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI_GAP         to SALGL;
grant SELECT                                                                 on ANI_GAP         to UPLD;



PROMPT *** Create SYNONYM  to ANI_GAP ***

  CREATE OR REPLACE PUBLIC SYNONYM ANI_GAP FOR BARS.ANI_GAP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_GAP.sql =========*** End *** =====
PROMPT ===================================================================================== 
