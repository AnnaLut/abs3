

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE_INT_ARCH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_TRACE_INT_ARCH ***


BEGIN 
        execute immediate  
          'begin  
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
   (	KODF VARCHAR2(2), 
	DATF DATE, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(30), 
	ISP NUMBER, 
	RNK NUMBER, 
	ACC NUMBER, 
	REF NUMBER, 
	COMM VARCHAR2(200), 
	ND NUMBER, 
	MDATE DATE, 
	TOBO VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_TRACE_INT_ARCH ***
 exec bpa.alter_policies('RNBU_TRACE_INT_ARCH');


COMMENT ON TABLE BARS.RNBU_TRACE_INT_ARCH IS 'Архів протоколів формування показників файлів звітності';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.KODF IS 'Код файлу';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.DATF IS 'Дата формування файлу';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.NLS IS 'Счет';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.KV IS 'Валюта';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ODATE IS 'Дата формирования';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.KODP IS 'Код показателя';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ZNAP IS 'Значение показателя';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.NBUC IS 'Код области (МФО)';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ISP IS 'Код исполнителя';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.RNK IS 'Рег. номер контрагента';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ACC IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.REF IS 'Номер документа';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.ND IS 'Номер договора';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.MDATE IS 'Дата гашения';
COMMENT ON COLUMN BARS.RNBU_TRACE_INT_ARCH.TOBO IS '';




PROMPT *** Create  index RNBU_TRACE_INT_ARCH_I1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.RNBU_TRACE_INT_ARCH_I1 ON BARS.RNBU_TRACE_INT_ARCH (KODF, DATF, TOBO, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index RNBU_TRACE_INT_ARCH_I2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.RNBU_TRACE_INT_ARCH_I2 ON BARS.RNBU_TRACE_INT_ARCH (KODF, DATF, KODP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_TRACE_INT_ARCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_INT_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_INT_ARCH to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_INT_ARCH to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_TRACE_INT_ARCH to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE_INT_ARCH.sql =========*** E
PROMPT ===================================================================================== 
