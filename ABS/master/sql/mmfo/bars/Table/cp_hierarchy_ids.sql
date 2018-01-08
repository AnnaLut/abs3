

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_IDS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_HIERARCHY_IDS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_HIERARCHY_IDS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_HIERARCHY_IDS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_HIERARCHY_IDS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_HIERARCHY_IDS 
   (	ID NUMBER(*,0), 
	DATE_START DATE, 
	DATE_FINISH DATE, 
	HIERARCHY_REP NUMBER(*,0), 
	H1 NUMBER(*,0), 
	H2 NUMBER(*,0), 
	COUNT_START NUMBER, 
	COUNT_END NUMBER, 
	N NUMBER, 
	DP NUMBER, 
	R NUMBER, 
	R2 NUMBER, 
	S NUMBER, 
	BV NUMBER, 
	N_END NUMBER, 
	DP_END NUMBER, 
	R_END NUMBER, 
	R2_END NUMBER, 
	S_END NUMBER, 
	BV_END NUMBER, 
	R_PAY NUMBER, 
	R_INT NUMBER, 
	TR NUMBER, 
	RESERVED NUMBER, 
	OVERPRICED NUMBER, 
	BOUGHT NUMBER, 
	SOLD NUMBER, 
	SETTLED NUMBER, 
	RECLASS_FROM NUMBER, 
	RECLASS_INTO NUMBER, 
	RANSOM NUMBER, 
	PAYEDINT NUMBER, 
	RNK NUMBER, 
	NBS VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_HIERARCHY_IDS ***
 exec bpa.alter_policies('CP_HIERARCHY_IDS');


COMMENT ON TABLE BARS.CP_HIERARCHY_IDS IS 'Отчет по уровням иерархии в разрезе кодов ЦП';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.NBS IS '';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RANSOM IS 'Викуп';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.PAYEDINT IS 'Сплачено купон';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RNK IS '';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.ID IS 'ID ЦП';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.DATE_START IS 'Дата начала отчета';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.DATE_FINISH IS 'Дата окончания отчета';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.HIERARCHY_REP IS 'Уровень иерархии для группировки';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.H1 IS 'Уровень иерархии на начало';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.H2 IS 'Уровень иерархии на конец';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.COUNT_START IS 'Количество бумаг на начало';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.COUNT_END IS 'Количество бумаг на конец';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.N IS 'Номинал на начало';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.DP IS 'Дисконт/премия на начало';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R IS 'Купон на начало';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R2 IS 'Купон2 на начало';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.S IS 'Переоценка на начало';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.BV IS 'Балансовая стоимость на начало';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.N_END IS 'Номинал на конец';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.DP_END IS 'Дисконт/премия на конец';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R_END IS 'Купон на конец';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R2_END IS 'Купон2 на конец';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.S_END IS 'Переоценка на конец';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.BV_END IS 'Балансовая стоимость на конец';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R_PAY IS 'Полученный купон в периоде';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R_INT IS 'Процентные доходы в периоде';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.TR IS 'Торговый результат в периоде';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RESERVED IS 'Резервы в периоде';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.OVERPRICED IS 'Переоценка в периоде';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.BOUGHT IS 'Куплено в периоде';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.SOLD IS 'Продано в периоде';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.SETTLED IS 'Погашено в периоде';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RECLASS_FROM IS 'Реклассификация из уровня (бал.стоимость)';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RECLASS_INTO IS 'Реклассификация в уровень (бал.стоимость)';



PROMPT *** Create  grants  CP_HIERARCHY_IDS ***
grant SELECT                                                                 on CP_HIERARCHY_IDS to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_HIERARCHY_IDS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_HIERARCHY_IDS to BARS_DM;
grant SELECT                                                                 on CP_HIERARCHY_IDS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_IDS.sql =========*** End 
PROMPT ===================================================================================== 
