

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FINREZ.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FINREZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FINREZ ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FINREZ 
   (	FONDID NUMBER, 
	S_OLDF1 NUMBER, 
	SQ_OLDF1 NUMBER, 
	S_OLDF2 NUMBER, 
	SQ_OLDF2 NUMBER, 
	SQ_OLDF3 NUMBER, 
	S_NEWF NUMBER, 
	SQ_NEWF NUMBER, 
	S_DEL NUMBER, 
	SQ_DEL NUMBER, 
	S_ISP NUMBER, 
	SQ_ISP NUMBER, 
	SQ_CURS NUMBER, 
	KV NUMBER, 
	ACC NUMBER, 
	TXT VARCHAR2(200), 
	BRANCH VARCHAR2(30), 
	OB22 CHAR(2), 
	NLS_R VARCHAR2(15), 
	NBSL VARCHAR2(4), 
	S080 NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FINREZ ***
 exec bpa.alter_policies('TMP_FINREZ');


COMMENT ON TABLE BARS.TMP_FINREZ IS 'Состояние резервного фонда в целом по банку';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_OLDF3 IS 'Остаток на счетах фонда на текущую дату эквивалент по курсу предыдущей даты (для определения изменений связанных с курсовой разницей)';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_NEWF IS 'новый фонд по таблице TMP_REZ_RISK номинал';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_NEWF IS 'новый фонд по таблице TMP_REZ_RISK эквивалент по курсу текущей отчетной даты';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_DEL IS 'доформировать фонда номинал';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_DEL IS 'доформировать фонд эквивалент';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_ISP IS 'использовано фонда на погашение задолженности номинал';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_ISP IS 'использовано фонда на погашение задолженности эквивалент';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_CURS IS 'величина изменения эквивалента фонда связанная с курсовой разницей';
COMMENT ON COLUMN BARS.TMP_FINREZ.KV IS 'код валюты';
COMMENT ON COLUMN BARS.TMP_FINREZ.ACC IS '';
COMMENT ON COLUMN BARS.TMP_FINREZ.TXT IS '';
COMMENT ON COLUMN BARS.TMP_FINREZ.BRANCH IS 'код безбалансового отделения';
COMMENT ON COLUMN BARS.TMP_FINREZ.OB22 IS 'OB22 счета резерва';
COMMENT ON COLUMN BARS.TMP_FINREZ.NLS_R IS 'Номер счета резерва';
COMMENT ON COLUMN BARS.TMP_FINREZ.NBSL IS 'Бал.рахунок';
COMMENT ON COLUMN BARS.TMP_FINREZ.S080 IS 'Кат.якості';
COMMENT ON COLUMN BARS.TMP_FINREZ.FONDID IS 'код показателя (из REZ_FONDNBS)';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_OLDF1 IS 'Остаток на счетах фонда на предыдущую дату номинал';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_OLDF1 IS 'Остаток на счетах фонда на предыдущую дату эквивалент по курсу предыдущей даты';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_OLDF2 IS 'Остаток на счетах фонда на текущую дату номинал';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_OLDF2 IS 'Остаток на счетах фонда на текущую дату эквивалент по курсу текущей даты';



PROMPT *** Create  grants  TMP_FINREZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FINREZ      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FINREZ      to RCC_DEAL;



PROMPT *** Create SYNONYM  to TMP_FINREZ ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_FINREZ FOR BARS.TMP_FINREZ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FINREZ.sql =========*** End *** ==
PROMPT ===================================================================================== 
