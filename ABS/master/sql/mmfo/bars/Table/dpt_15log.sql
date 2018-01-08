

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_15LOG.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_15LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_15LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_15LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_15LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_15LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_15LOG 
   (	DPT_ID NUMBER, 
	ACRA NUMBER, 
	KV NUMBER, 
	INT_DATE_BEGIN DATE, 
	INT_DATE_END DATE, 
	INT_S NUMBER, 
	INT_SQ NUMBER, 
	TAX_NLS VARCHAR2(14), 
	TAX_DATE_BEGIN DATE, 
	TAX_DATE_END DATE, 
	TAX_BASE_S NUMBER, 
	TAX_BASE_SQ NUMBER, 
	TAX_S NUMBER, 
	TAX_SQ NUMBER, 
	REF NUMBER, 
	USERID NUMBER, 
	DWHEN TIMESTAMP (6), 
	BDATE DATE, 
	ROUND_ERR NUMBER, 
	TAX_TYPE NUMBER, 
	TAX_SOCINFO VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_15LOG ***
 exec bpa.alter_policies('DPT_15LOG');


COMMENT ON TABLE BARS.DPT_15LOG IS 'Таблица начислений %15 по методу make_int';
COMMENT ON COLUMN BARS.DPT_15LOG.DPT_ID IS 'Идентификатор деп.договора (0 для текущих счетов)';
COMMENT ON COLUMN BARS.DPT_15LOG.ACRA IS 'Идентификатор процентного счета';
COMMENT ON COLUMN BARS.DPT_15LOG.KV IS 'Валюта договора/счета';
COMMENT ON COLUMN BARS.DPT_15LOG.INT_DATE_BEGIN IS 'Дата начала периода начисления процентов';
COMMENT ON COLUMN BARS.DPT_15LOG.INT_DATE_END IS 'Дата окончания периода начисления процентов';
COMMENT ON COLUMN BARS.DPT_15LOG.INT_S IS 'Сумма начисленных процентов (номинал)';
COMMENT ON COLUMN BARS.DPT_15LOG.INT_SQ IS 'Сумма начисленных процентов (эквивалент)';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_NLS IS 'Счет Дт задолженность налогообложения';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_DATE_BEGIN IS 'Дата начала налогообложения (в периоде начисления)';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_DATE_END IS 'Дата окончания налогообложения (в периоде начисления)';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_BASE_S IS 'База налогообложения - номинал (в периоде начисления)';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_BASE_SQ IS 'База налогообложения - эквивалент (в периоде начисления)';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_S IS 'Сумма налога - номинал (в периоде начисления)';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_SQ IS 'Сумма налога - эквивалент (в периоде начисления)';
COMMENT ON COLUMN BARS.DPT_15LOG.REF IS 'Референс документа начисления';
COMMENT ON COLUMN BARS.DPT_15LOG.USERID IS 'Исполнитель документа начисления';
COMMENT ON COLUMN BARS.DPT_15LOG.DWHEN IS 'Штамп времени порождения документа начисления';
COMMENT ON COLUMN BARS.DPT_15LOG.BDATE IS 'Банковская дата';
COMMENT ON COLUMN BARS.DPT_15LOG.ROUND_ERR IS 'Ошибка округления при снятии налога';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_TYPE IS 'Код налога (TAX_SETTINGS.TAX_TYPE)';
COMMENT ON COLUMN BARS.DPT_15LOG.TAX_SOCINFO IS 'Информация о "социальной составляющей остатка" ';




PROMPT *** Create  constraint SYS_C007485 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_15LOG MODIFY (DPT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007486 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_15LOG MODIFY (ACRA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_15LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_15LOG       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_15LOG       to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_15LOG.sql =========*** End *** ===
PROMPT ===================================================================================== 
