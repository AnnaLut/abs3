

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_TRACE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_TRACE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.RNBU_TRACE 
   (	RECID NUMBER, 
	USERID NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(254), 
	NBUC VARCHAR2(30), 
	ISP NUMBER, 
	RNK NUMBER, 
	ACC NUMBER, 
	REF NUMBER, 
	COMM VARCHAR2(200), 
	ND NUMBER, 
	MDATE DATE, 
	TOBO VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_TRACE ***
 exec bpa.alter_policies('RNBU_TRACE');


COMMENT ON TABLE BARS.RNBU_TRACE IS 'Протокол формирования показателей файлов отчетности';
COMMENT ON COLUMN BARS.RNBU_TRACE.RECID IS 'ID';
COMMENT ON COLUMN BARS.RNBU_TRACE.USERID IS 'Код пользователя';
COMMENT ON COLUMN BARS.RNBU_TRACE.NLS IS 'Счет';
COMMENT ON COLUMN BARS.RNBU_TRACE.KV IS 'Валюта';
COMMENT ON COLUMN BARS.RNBU_TRACE.ODATE IS 'Дата формирования';
COMMENT ON COLUMN BARS.RNBU_TRACE.KODP IS 'Код показателя';
COMMENT ON COLUMN BARS.RNBU_TRACE.ZNAP IS 'Значение показателя';
COMMENT ON COLUMN BARS.RNBU_TRACE.NBUC IS 'Код области (МФО)';
COMMENT ON COLUMN BARS.RNBU_TRACE.ISP IS 'Код исполнителя';
COMMENT ON COLUMN BARS.RNBU_TRACE.RNK IS 'Рег. номер контрагента';
COMMENT ON COLUMN BARS.RNBU_TRACE.ACC IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE.REF IS 'Номер документа';
COMMENT ON COLUMN BARS.RNBU_TRACE.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.RNBU_TRACE.ND IS 'Номер договора';
COMMENT ON COLUMN BARS.RNBU_TRACE.MDATE IS 'Дата гашения';
COMMENT ON COLUMN BARS.RNBU_TRACE.TOBO IS '';




PROMPT *** Create  index IRNBU_TRACE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IRNBU_TRACE ON BARS.RNBU_TRACE (ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_RNBU_TRACE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_RNBU_TRACE ON BARS.RNBU_TRACE (KODP) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_RNBU_TRACE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_RNBU_TRACE ON BARS.RNBU_TRACE (REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_TRACE ***
grant SELECT                                                                 on RNBU_TRACE      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE      to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE      to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE      to START1;
grant SELECT                                                                 on RNBU_TRACE      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_TRACE      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE.sql =========*** End *** ==
PROMPT ===================================================================================== 
