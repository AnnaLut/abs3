

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL_BPKK_23.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INV_CCK_FL_BPKK_23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INV_CCK_FL_BPKK_23'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INV_CCK_FL_BPKK_23'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INV_CCK_FL_BPKK_23'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INV_CCK_FL_BPKK_23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.INV_CCK_FL_BPKK_23 
   (	G00 DATE, 
	G01 VARCHAR2(70), 
	G02 VARCHAR2(30), 
	G03 VARCHAR2(30), 
	G04 VARCHAR2(70), 
	G05 VARCHAR2(9), 
	G05I VARCHAR2(14), 
	G06 NUMBER, 
	G07 NUMBER(38,0), 
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
	G15 CHAR(10), 
	G16 CHAR(10), 
	G17 NUMBER, 
	G18 VARCHAR2(250), 
	G19 CHAR(4), 
	G20 VARCHAR2(9), 
	G21 NUMBER, 
	G22 NUMBER, 
	G23 NUMBER, 
	G24 NUMBER(38,0), 
	G25 NUMBER, 
	G26 NUMBER, 
	G27 NUMBER(22,4), 
	G28 NUMBER(22,4), 
	G29 NUMBER, 
	G30 NUMBER, 
	G31 NUMBER, 
	G32 CHAR(1), 
	G33 CHAR(3), 
	G34 CHAR(10), 
	G35 CHAR(1), 
	G36 CHAR(1), 
	G37 VARCHAR2(30), 
	G38 CHAR(10), 
	G39 NUMBER, 
	G40 NUMBER, 
	G41 NUMBER(22,3), 
	G42 NUMBER, 
	G43 NUMBER, 
	G44 NUMBER, 
	G45 NUMBER, 
	G46 CHAR(1), 
	G47 CHAR(1), 
	G48 VARCHAR2(2), 
	G49 CHAR(10), 
	G50 NUMBER, 
	G51 NUMBER, 
	G52 NUMBER, 
	G53 VARCHAR2(10), 
	G54 NUMBER, 
	G55 NUMBER(1,0), 
	G56 NUMBER, 
	G57 NUMBER, 
	G58 VARCHAR2(30), 
	G59 NUMBER, 
	G60 VARCHAR2(30), 
	G61 NUMBER, 
	G62 VARCHAR2(30), 
	G63 NUMBER, 
	G64 VARCHAR2(300), 
	G65 NUMBER, 
	GT NUMBER, 
	GR VARCHAR2(1), 
	ACC NUMBER, 
	RNK NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INV_CCK_FL_BPKK_23 ***
 exec bpa.alter_policies('INV_CCK_FL_BPKK_23');


COMMENT ON TABLE BARS.INV_CCK_FL_BPKK_23 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G00 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G01 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G02 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G03 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G04 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G05 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G05I IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G06 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G07 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G08 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G09 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G10 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G11 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G12 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13A IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13B IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13V IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13G IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13D IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13E IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13J IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13Z IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G13I IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G14 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G15 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G16 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G17 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G18 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G19 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G20 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G21 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G22 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G23 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G24 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G25 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G26 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G27 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G28 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G29 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G30 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G31 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G32 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G33 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G34 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G35 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G36 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G37 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G38 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G39 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G40 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G41 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G42 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G43 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G44 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G45 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G46 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G47 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G48 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G49 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G50 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G51 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G52 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G53 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G54 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G55 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G56 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G57 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G58 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G59 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G60 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G61 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G62 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G63 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G64 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.G65 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.GT IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.GR IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.ACC IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.RNK IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_BPKK_23.KF IS '';




PROMPT *** Create  constraint CC_INVCCKFLBPKK23_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_BPKK_23 MODIFY (KF CONSTRAINT CC_INVCCKFLBPKK23_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INVCCKFLBPKK23_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_BPKK_23 ADD CONSTRAINT FK_INVCCKFLBPKK23_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INV_CCK_FL_BPKK_23 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INV_CCK_FL_BPKK_23 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INV_CCK_FL_BPKK_23 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INV_CCK_FL_BPKK_23 to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL_BPKK_23.sql =========*** En
PROMPT ===================================================================================== 
