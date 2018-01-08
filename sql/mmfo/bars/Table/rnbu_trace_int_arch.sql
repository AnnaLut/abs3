

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE_INT_ARCH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_TRACE_INT_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_TRACE_INT_ARCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_TRACE_INT_ARCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_TRACE_INT_ARCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_TRACE_INT_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_TRACE_INT_ARCH 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DATF DATE, 
	KODF VARCHAR2(2), 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(30), 
	ISP NUMBER, 
	RNK NUMBER, 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	REF NUMBER, 
	COMM VARCHAR2(200), 
	ND NUMBER, 
	MDATE DATE, 
	TOBO VARCHAR2(30)
   ) PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC 
  TABLESPACE BRSBIGD 
  PARTITION BY RANGE (DATF) INTERVAL (NUMTOYMINTERVAL(3,''MONTH'')) 
 (PARTITION P_MINVALUE  VALUES LESS THAN (TO_DATE('' 2015-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD ) 
  PARALLEL 4 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_TRACE_INT_ARCH ***
 exec bpa.alter_policies('RNBU_TRACE_INT_ARCH');


COMMENT ON TABLE BARS.RNBU_TRACE_INT_ARCH IS 'Архів протоколів формування показників файлів звітності';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.KF IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.DATF IS 'Дата формування файлу';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.KODF IS 'Код файлу';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.KODP IS 'Код показника';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ZNAP IS 'Значення показника';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.NBUC IS 'Код області (МФО)';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ISP IS 'Код виконавця';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.RNK IS 'РНК';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ACC IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.NLS IS '№ рахунку';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.KV IS 'Валюта';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ODATE IS 'Дата формування';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.REF IS 'Номер документу';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.COMM IS 'Коментр';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.MDATE IS 'Дата погашення';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.TOBO IS '';




PROMPT *** Create  constraint CC_RNBUTRACEINTARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_TRACE_INT_ARCH MODIFY (KF CONSTRAINT CC_RNBUTRACEINTARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNBUTRACEINTARCH_DATF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_TRACE_INT_ARCH MODIFY (DATF CONSTRAINT CC_RNBUTRACEINTARCH_DATF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNBUTRACEINTARCH_KODF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_TRACE_INT_ARCH MODIFY (KODF CONSTRAINT CC_RNBUTRACEINTARCH_KODF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNBUTRACEINTARCH_KODP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_TRACE_INT_ARCH MODIFY (KODP CONSTRAINT CC_RNBUTRACEINTARCH_KODP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index RNBU_TRACE_INT_ARCH_I2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.RNBU_TRACE_INT_ARCH_I2 ON BARS.RNBU_TRACE_INT_ARCH (DATF, KODF, KODP) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P_MINVALUE 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) COMPRESS 2 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index RNBU_TRACE_INT_ARCH_I1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.RNBU_TRACE_INT_ARCH_I1 ON BARS.RNBU_TRACE_INT_ARCH (DATF, KODF, TOBO, ACC) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P_MINVALUE 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) COMPRESS 2 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_TRACE_INT_ARCH ***
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_INT_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH to BARS_DM;
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_INT_ARCH to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_INT_ARCH to START1;
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_INT_ARCH to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE_INT_ARCH.sql =========*** E
PROMPT ===================================================================================== 
