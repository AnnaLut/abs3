

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_EXCLUSIVE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_EXCLUSIVE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_EXCLUSIVE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_EXCLUSIVE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_EXCLUSIVE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_EXCLUSIVE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_EXCLUSIVE 
   (	TYPE_ID NUMBER(38,0), 
	TT VARCHAR2(3), 
	OSTC_MIN NUMBER(38,0), 
	OSTC_MAX NUMBER(38,0), 
	MONTH_TERM NUMBER(3,0), 
	KV NUMBER(3,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_EXCLUSIVE ***
 exec bpa.alter_policies('DPT_VIDD_EXCLUSIVE');


COMMENT ON TABLE BARS.DPT_VIDD_EXCLUSIVE IS 'Перелік умов пакету Ексклюзивний';
COMMENT ON COLUMN BARS.DPT_VIDD_EXCLUSIVE.TYPE_ID IS 'тип депозитного договору';
COMMENT ON COLUMN BARS.DPT_VIDD_EXCLUSIVE.TT IS 'ТТ операції по договору';
COMMENT ON COLUMN BARS.DPT_VIDD_EXCLUSIVE.OSTC_MIN IS 'Нижній поріг суми залишку';
COMMENT ON COLUMN BARS.DPT_VIDD_EXCLUSIVE.OSTC_MAX IS 'Верхній поріг суми залишку';
COMMENT ON COLUMN BARS.DPT_VIDD_EXCLUSIVE.MONTH_TERM IS 'Поріг строковості';
COMMENT ON COLUMN BARS.DPT_VIDD_EXCLUSIVE.KV IS 'валюта договору';




PROMPT *** Create  index CC_DPTVIDDEXCLUSIVE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_DPTVIDDEXCLUSIVE ON BARS.DPT_VIDD_EXCLUSIVE (TYPE_ID, OSTC_MIN, OSTC_MAX, MONTH_TERM, KV, TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_EXCLUSIVE ***
grant SELECT                                                                 on DPT_VIDD_EXCLUSIVE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_EXCLUSIVE.sql =========*** En
PROMPT ===================================================================================== 
