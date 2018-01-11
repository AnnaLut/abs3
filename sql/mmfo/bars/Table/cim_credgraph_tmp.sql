

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_TMP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDGRAPH_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDGRAPH_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDGRAPH_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CIM_CREDGRAPH_TMP 
   (	DAT DATE, 
	PSNT NUMBER, 
	RSNT NUMBER, 
	PSPT NUMBER, 
	RSPT NUMBER, 
	PSK NUMBER, 
	RSK NUMBER, 
	PSPE NUMBER, 
	RSPE NUMBER, 
	PZT NUMBER, 
	ZT NUMBER, 
	DT NUMBER, 
	SMP NUMBER, 
	SMPS NUMBER, 
	SP NUMBER, 
	SVP NUMBER, 
	ZP NUMBER, 
	DP NUMBER, 
	SD NUMBER, 
	ZPNBU NUMBER, 
	BT NUMBER, 
	XSP NUMBER, 
	XPSPT NUMBER, 
	I_RP NUMBER, 
	I_VP NUMBER, 
	KP NUMBER, 
	PERCENT NUMBER, 
	PERCENT_NBU NUMBER, 
	PERCENT_BASE NUMBER, 
	DY NUMBER, 
	Z NUMBER, 
	T_DELAY NUMBER, 
	P_DELAY NUMBER, 
	GET_DAY NUMBER, 
	PAY_DAY NUMBER, 
	ADAPTIVE NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDGRAPH_TMP ***
 exec bpa.alter_policies('CIM_CREDGRAPH_TMP');


COMMENT ON TABLE BARS.CIM_CREDGRAPH_TMP IS 'Графік кредитного контракту';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.DAT IS 'Дата';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PSNT IS 'Планова сума надходжень по тілу';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.RSNT IS 'Реальна сума надходжень по тілу';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PSPT IS 'Планова сума погашення тіла';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.RSPT IS 'Реальна сума погашення тіла';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PSK IS 'Планова сума комісії';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.RSK IS 'Реальна сума комісії';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PSPE IS 'Планова сума Пені';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.RSPE IS 'Реальна сума пені';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PZT IS 'Планова заборгованість по тілу';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.ZT IS 'Заборгованість по тілу';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.DT IS 'Прострочена заборгованість по тілу';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SMP IS 'Нараховані проценти за інтервал графіку';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SMPS IS 'Сума нарахованих процентів';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SP IS 'Сума нарахованих процентів за плановий період по графіку';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SVP IS 'Сума виплачених процентів';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.ZP IS 'Заборгованість по процентах';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.DP IS 'Прострочена заборгованість по %';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SD IS 'Сума додаткових платежів';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.ZPNBU IS 'Сума нарахованих процентів НБУ';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.BT IS 'Cума дострокового погашення тіла';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.XSP IS 'Сума нарахованих процентів за плановий період по графіку без врахування майбутніх надходжень';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.XPSPT IS 'Планова сума погашення тіла без врахування майбутніх надходжень';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.I_RP IS 'Реальний платіж';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.I_VP IS 'Виплата процентів';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.KP IS 'Кількість періодів до кінця інтервалу графіка';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PERCENT IS 'Процентна ставка';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PERCENT_NBU IS 'Процентна ставка НБУ';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PERCENT_BASE IS 'База нарахування процентів';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.DY IS 'Кількість днів у році';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.Z IS 'Залишок на кінець інтервалу';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.T_DELAY IS 'Затримка виплати тіла';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.P_DELAY IS 'Затримка виплати %';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.GET_DAY IS 'Врахування дня видачі кредиту';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PAY_DAY IS 'Врахування дня погашення кредиту';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.ADAPTIVE IS 'Врахування дострокового погашення тіла';



PROMPT *** Create  grants  CIM_CREDGRAPH_TMP ***
grant SELECT                                                                 on CIM_CREDGRAPH_TMP to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_TMP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_TMP to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_TMP to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_TMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_TMP.sql =========*** End
PROMPT ===================================================================================== 
