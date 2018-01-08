

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_SALDO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_SALDO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_SALDO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_SALDO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_SALDO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_SALDO ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_SALDO 
   (	ODATE DATE, 
	FDAT DATE, 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(38,0), 
	NBS VARCHAR2(4), 
	RNK NUMBER, 
	OST NUMBER, 
	OSTQ NUMBER, 
	DOS NUMBER, 
	DOSQ NUMBER, 
	KOS NUMBER, 
	KOSQ NUMBER, 
	DOS96P NUMBER, 
	DOSQ96P NUMBER, 
	KOS96P NUMBER, 
	KOSQ96P NUMBER, 
	DOS96 NUMBER, 
	DOSQ96 NUMBER, 
	KOS96 NUMBER, 
	KOSQ96 NUMBER, 
	DOS99 NUMBER, 
	DOSQ99 NUMBER, 
	KOS99 NUMBER, 
	KOSQ99 NUMBER, 
	DOSZG NUMBER, 
	KOSZG NUMBER, 
	DOS96ZG NUMBER, 
	KOS96ZG NUMBER, 
	DOS99ZG NUMBER, 
	KOS99ZG NUMBER, 
	VOST NUMBER, 
	VOSTQ NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_SALDO ***
 exec bpa.alter_policies('OTCN_SALDO');


COMMENT ON TABLE BARS.OTCN_SALDO IS '¬ременна¤ таблица оборотов и остатков по счетам дл¤ формировани¤ файлов отчетности';
COMMENT ON COLUMN BARS.OTCN_SALDO.ODATE IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KV IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.OST IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.OSTQ IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOS IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOSQ IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOS IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOSQ IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOS96P IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOSQ96P IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOS96P IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOSQ96P IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOS96 IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOSQ96 IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOS96 IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOSQ96 IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOS99 IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOSQ99 IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOS99 IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOSQ99 IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOSZG IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOSZG IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOS96ZG IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOS96ZG IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.DOS99ZG IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.KOS99ZG IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.VOST IS '';
COMMENT ON COLUMN BARS.OTCN_SALDO.VOSTQ IS '';




PROMPT *** Create  constraint SYS_C0010404 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_SALDO MODIFY (ODATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010405 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_SALDO MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010406 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_SALDO MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_OTCN_SALDO ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_OTCN_SALDO ON BARS.OTCN_SALDO (RNK, ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_OTCN_SALDO ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_OTCN_SALDO ON BARS.OTCN_SALDO (NLS, KV) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_SALDO ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_SALDO ON BARS.OTCN_SALDO (ACC, FDAT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_SALDO ***
grant SELECT                                                                 on OTCN_SALDO      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_SALDO      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_SALDO      to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_SALDO      to RPBN002;
grant SELECT                                                                 on OTCN_SALDO      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_SALDO      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_SALDO.sql =========*** End *** ==
PROMPT ===================================================================================== 
