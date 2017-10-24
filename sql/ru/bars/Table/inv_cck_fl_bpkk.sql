

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL_BPKK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INV_CCK_FL_BPKK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INV_CCK_FL_BPKK'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''INV_CCK_FL_BPKK'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INV_CCK_FL_BPKK ***
begin 
  execute immediate '
  CREATE TABLE BARS.INV_CCK_FL_BPKK 
   (	G00 DATE, 
	G01 VARCHAR2(70), 
	G02 VARCHAR2(30), 
	G03 VARCHAR2(30), 
	G04 VARCHAR2(70), 
	G05 VARCHAR2(10), 
	G06 NUMBER, 
	G07 NUMBER(*,0), 
	G08 VARCHAR2(20), 
	G09 CHAR(10), 
	G10 CHAR(10), 
	G11 CHAR(10), 
	G12 CHAR(1), 
	G13 NUMBER, 
	G13A NUMBER, 
	G13B NUMBER, 
	G13V NUMBER, 
	G13G NUMBER, 
	G13D NUMBER, 
	G13E NUMBER, 
	G13J NUMBER, 
	G13Z NUMBER, 
	G13I NUMBER, 
	G14 CHAR(10), 
	G16 CHAR(10), 
	G17 NUMBER, 
	G18 VARCHAR2(250), 
	G19 CHAR(4), 
	G20 VARCHAR2(9), 
	G21 NUMBER, 
	G22 NUMBER, 
	G23 NUMBER, 
	G24 NUMBER(*,0), 
	G25 NUMBER, 
	G26 NUMBER, 
	G28 NUMBER, 
	G29 NUMBER, 
	G30 NUMBER, 
	G31 NUMBER, 
	G32 NUMBER, 
	G33 NUMBER, 
	G34 NUMBER, 
	G35 NUMBER, 
	G36 CHAR(1), 
	G37 CHAR(3), 
	G38 CHAR(10), 
	G39 CHAR(1), 
	G40 CHAR(1), 
	G41 VARCHAR2(30), 
	G42 NUMBER(*,0), 
	G43 NUMBER, 
	G44 NUMBER, 
	G45 NUMBER, 
	G46 NUMBER, 
	G47 NUMBER, 
	G48 NUMBER, 
	G49 NUMBER, 
	G50 NUMBER, 
	G51 CHAR(1), 
	G52 NUMBER, 
	G53 NUMBER, 
	G54 CHAR(1), 
	G55 VARCHAR2(2), 
	G56 CHAR(10), 
	G57 NUMBER, 
	G58 NUMBER, 
	G59 NUMBER, 
	GT NUMBER, 
	GR VARCHAR2(1), 
	ACC NUMBER, 
	RNK NUMBER, 
	G27 NUMBER(22,4), 
	G15 CHAR(10), 
	G27E NUMBER(22,4), 
	G60 VARCHAR2(10), 
	G62 NUMBER(1,0), 
	G61 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INV_CCK_FL_BPKK ***
 exec bpa.alter_policies('INV_CCK_FL_BPKK');


COMMENT ON TABLE BARS.INV_CCK_FL_BPKK IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G27 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G15 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G27E IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G60 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G62 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G61 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G00 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G01 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G02 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G03 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G04 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G05 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G06 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G07 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G08 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G09 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G10 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G11 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G12 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13A IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13B IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13V IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13G IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13D IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13E IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13J IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13Z IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G13I IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G14 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G16 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G17 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G18 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G19 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G20 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G21 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G22 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G23 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G24 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G25 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G26 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G28 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G29 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G30 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G31 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G32 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G33 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G34 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G35 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G36 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G37 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G38 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G39 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G40 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G41 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G42 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G43 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G44 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G45 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G46 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G47 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G48 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G49 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G50 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G51 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G52 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G53 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G54 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G55 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G56 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G57 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G58 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.G59 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.GT IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.GR IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.ACC IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK.RNK IS '';



PROMPT *** Create  grants  INV_CCK_FL_BPKK ***
grant SELECT                                                                 on INV_CCK_FL_BPKK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INV_CCK_FL_BPKK to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL_BPKK.sql =========*** End *
PROMPT ===================================================================================== 
