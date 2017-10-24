

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_EMI_LOT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_EMI_LOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_EMI_LOT'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''TMP_EMI_LOT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_EMI_LOT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_EMI_LOT 
   (	EMI CHAR(2), 
	NAME_EMI VARCHAR2(45), 
	SV_2905 NUMBER, 
	SI_2905 NUMBER, 
	SV_2805 NUMBER, 
	SI_2805 NUMBER, 
	LOT CHAR(6), 
	NAME_LOT VARCHAR2(45), 
	KV_9819 NUMBER, 
	KI_9819 NUMBER, 
	KD_9819 NUMBER, 
	KK_9819 NUMBER, 
	SK_2905 NUMBER, 
	KD_9812 NUMBER, 
	SD_2805 NUMBER, 
	BRANCH VARCHAR2(15)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_EMI_LOT ***
 exec bpa.alter_policies('TMP_EMI_LOT');


COMMENT ON TABLE BARS.TMP_EMI_LOT IS 'Раб.раблица для отчета по лотореям';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.EMI IS 'Код эмитента';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.NAME_EMI IS 'Наименование эмитента';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.SV_2905 IS 'Вх. ост по 2905';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.SI_2905 IS 'Исх.ост по 2905';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.SV_2805 IS 'Вх. ост по 2805';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.SI_2805 IS 'Исх.ост по 2805';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.LOT IS 'Код лотореи';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.NAME_LOT IS 'Наименование лотореи';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.KV_9819 IS 'Вх. ост по 9819 кол.';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.KI_9819 IS 'Исх.ост по 9819 кол.';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.KD_9819 IS 'Обрибутковано     - количество';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.KK_9819 IS 'Продано           - количество';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.SK_2905 IS 'Продано           - сумма     ';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.KD_9812 IS 'Погашено виграних - количество';
COMMENT ON COLUMN BARS.TMP_EMI_LOT.SD_2805 IS 'Оплачено виграних - сумма     ';



PROMPT *** Create  grants  TMP_EMI_LOT ***
grant SELECT                                                                 on TMP_EMI_LOT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_EMI_LOT     to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_EMI_LOT     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_EMI_LOT.sql =========*** End *** =
PROMPT ===================================================================================== 
