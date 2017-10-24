-- ===================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ===================================================================================
-- Запити на вивантаження даних у файли для DWH
-- ===================================================================================

delete from BARSUPL.UPL_SQL 
 where mod(SQL_ID,1000) IN (566)	;	

--
-- ETL-18563 UPL - Во время выгрузки файла 1248 Донецкого РУ ошибка ORA-01722: invalid number
--
prompt  Обновление запросов 248, 1248

Insert into BARSUPL.UPL_SQL
   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, 
    VERS)
 Values
   (566, 

' SELECT v.BRANCH TOBO,
       v.ACC_NUM AS NLS,
       v.KV AS KV,
       v.REPORT_DATE DATF,
       v.ACC_ID ACC,
       v.SEG_01 DK,
       v.SEG_02 NBS,
       v.SEG_08 KV1,
       v.SEG_04 S181,
       v.SEG_03 R013,
       v.SEG_05 S240,
       v.SEG_06 K030,
       v.SEG_07 R012,
       v.FIELD_VALUE ZNAP,
       v.CUST_ID RNK,
       v.CUST_CODE OKPO,
       v.CUST_NAME NMK,
       v.MATURITY_DATE MDATE,
       acc.isp ISP,
       v.ND ND,
       v.AGRM_NUM CC_ID,
       v.BEG_DT SDATE,
       v.END_DT WDATE,
       v.REF AS REF,
       v.DESCRIPTION COMM
  FROM bars.V_NBUR_#A7_DTL v
       LEFT JOIN bars.accounts acc ON (acc.acc = v.acc_id)
 where report_date = to_date(:param1, 'dd/mm/yyyy')

',

 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'

, NULL,
 'Дані про структуру активів та пасивів за строками', 
    '1.0');

commit;


