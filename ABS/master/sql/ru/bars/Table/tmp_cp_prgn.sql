

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CP_PRGN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CP_PRGN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CP_PRGN ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CP_PRGN 
   (	RNK NUMBER(*,0), 
	REF NUMBER(*,0), 
	ND VARCHAR2(10), 
	CP_ID VARCHAR2(30), 
	ACC NUMBER(*,0), 
	V_KUP CHAR(2), 
	DAT01 DATE, 
	S_N01 NUMBER, 
	DAT02 DATE, 
	S_N02 NUMBER, 
	DAT03 DATE, 
	S_N03 NUMBER, 
	DAT04 DATE, 
	S_N04 NUMBER, 
	DAT05 DATE, 
	S_N05 NUMBER, 
	DAT06 DATE, 
	S_N06 NUMBER, 
	DAT07 DATE, 
	S_N07 NUMBER, 
	DAT08 DATE, 
	S_N08 NUMBER, 
	DAT09 DATE, 
	S_N09 NUMBER, 
	DAT10 DATE, 
	S_N10 NUMBER, 
	DAT11 DATE, 
	S_N11 NUMBER, 
	DAT12 DATE, 
	S_N12 NUMBER, 
	DAT13 DATE, 
	S_N13 NUMBER, 
	DAT14 DATE, 
	S_N14 NUMBER, 
	DAT15 DATE, 
	S_N15 NUMBER, 
	DAT16 DATE, 
	S_N16 NUMBER, 
	DAT17 DATE, 
	S_N17 NUMBER, 
	DAT18 DATE, 
	S_N18 NUMBER, 
	DAT19 DATE, 
	S_N19 NUMBER, 
	DAT20 DATE, 
	S_N20 NUMBER, 
	DAT21 DATE, 
	S_N21 NUMBER, 
	DAT22 DATE, 
	S_N22 NUMBER, 
	DAT23 DATE, 
	S_N23 NUMBER, 
	DAT24 DATE, 
	S_N24 NUMBER, 
	DAT25 DATE, 
	S_N25 NUMBER, 
	DAT26 DATE, 
	S_N26 NUMBER, 
	DAT27 DATE, 
	S_N27 NUMBER, 
	DAT28 DATE, 
	S_N28 NUMBER, 
	DAT29 DATE, 
	S_N29 NUMBER, 
	DAT30 DATE, 
	S_N30 NUMBER, 
	DAT31 DATE, 
	S_N31 NUMBER, 
	U_ID NUMBER(*,0), 
	D_KUP DATE, 
	S_KUP NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CP_PRGN ***
 exec bpa.alter_policies('TMP_CP_PRGN');


COMMENT ON TABLE BARS.TMP_CP_PRGN IS '������� ��������� �����_� �� ��';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N21 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT22 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N22 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT23 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N23 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT24 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N24 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT25 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N25 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT26 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N26 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT27 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N27 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT28 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N28 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT29 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N29 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT30 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N30 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.U_ID IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.D_KUP IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_KUP IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.REF IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.ND IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.CP_ID IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.ACC IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.V_KUP IS '��� ������ ���������/�����������';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT01 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N01 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT02 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N02 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT03 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N03 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT04 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N04 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT05 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N05 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT06 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N06 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT07 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N07 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT08 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N08 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT09 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N09 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT10 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N10 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT11 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N11 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT12 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N12 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT13 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N13 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT14 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N14 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT15 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N15 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT16 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N16 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT17 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N17 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT18 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N18 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT19 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N19 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT20 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.S_N20 IS '';
COMMENT ON COLUMN BARS.TMP_CP_PRGN.DAT21 IS '';




PROMPT *** Create  constraint SYS_C002685979 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_PRGN MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685978 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_PRGN MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685977 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_PRGN MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_VSTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_VSTR ON BARS.TMP_CP_PRGN (RNK, REF, ACC, U_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CP_PRGN ***
grant SELECT                                                                 on TMP_CP_PRGN     to START1;



PROMPT *** Create SYNONYM  to TMP_CP_PRGN ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_CP_PRGN FOR BARS.TMP_CP_PRGN;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CP_PRGN.sql =========*** End *** =
PROMPT ===================================================================================== 
