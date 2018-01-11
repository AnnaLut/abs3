

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FX_IN_MT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FX_IN_MT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FX_IN_MT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FX_IN_MT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FX_IN_MT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FX_IN_MT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FX_IN_MT 
   (	ACC NUMBER(*,0), 
	NBS NUMBER(*,0), 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	IN10 CHAR(2), 
	OST10 NUMBER, 
	OST10Q NUMBER, 
	IN11 CHAR(2), 
	OST11 NUMBER, 
	OST11Q NUMBER, 
	IN12 CHAR(2), 
	OST12 NUMBER, 
	OST12Q NUMBER, 
	IN13 CHAR(2), 
	OST13 NUMBER, 
	OST13Q NUMBER, 
	IN14 CHAR(2), 
	OST14 NUMBER, 
	OST14Q NUMBER, 
	IN15 CHAR(2), 
	OST15 NUMBER, 
	OST15Q NUMBER, 
	FDAT DATE, 
	I_OST NUMBER, 
	I_OSTQ NUMBER, 
	DAY_O NUMBER(*,0), 
	DAY NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FX_IN_MT ***
 exec bpa.alter_policies('FX_IN_MT');


COMMENT ON TABLE BARS.FX_IN_MT IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.ACC IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.NBS IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.NLS IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.KV IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.IN10 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST10 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST10Q IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.IN11 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST11 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST11Q IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.IN12 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST12 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST12Q IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.IN13 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST13 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST13Q IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.IN14 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST14 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST14Q IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.IN15 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST15 IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.OST15Q IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.FDAT IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.I_OST IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.I_OSTQ IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.DAY_O IS '';
COMMENT ON COLUMN BARS.FX_IN_MT.DAY IS '';




PROMPT *** Create  constraint PK_FXIN_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_IN_MT ADD CONSTRAINT PK_FXIN_ACC PRIMARY KEY (ACC, NLS, KV, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FXIN_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FXIN_ACC ON BARS.FX_IN_MT (ACC, NLS, KV, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FX_IN_MT ***
grant SELECT                                                                 on FX_IN_MT        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_IN_MT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FX_IN_MT        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_IN_MT        to START1;
grant SELECT                                                                 on FX_IN_MT        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FX_IN_MT.sql =========*** End *** ====
PROMPT ===================================================================================== 
