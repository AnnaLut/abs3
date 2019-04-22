PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARSUPL/Table/TMP_UPL_DM_STATUS.sql =======*** Run 
PROMPT ===================================================================================== 

PROMPT *** Drop temporary table TMP_UPL_DM_STATUS ***
begin 

  execute immediate 'DROP TABLE BARSUPL.TMP_UPL_DM_STATUS CASCADE CONSTRAINTS';

exception when others then       
  if sqlcode=-942 then null; else raise; end if;
  -- ORA-00942: table or view does not exist
end; 
/

PROMPT *** Create  table TMP_UPL_DM_STATUS ***
begin 
  execute immediate '
CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_UPL_DM_STATUS
(
  DM_CODE           VARCHAR2(30)                     NOT NULL,
  KF                VARCHAR2(6),
  ROWS_CNT          NUMBER,
  BANK_DATE         DATE,
  FILL_DATE         DATE,
  SID               VARCHAR2(30)
)
ON COMMIT PRESERVE ROWS';
--exception when others then       
--  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON TABLE  BARSUPL.TMP_UPL_DM_STATUS           IS 'Временная таблица статусов витрин.';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_STATUS.DM_CODE   IS 'Текстовый код витрины';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_STATUS.KF        IS 'Регион';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_STATUS.ROWS_CNT  IS 'Количество строк';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_STATUS.BANK_DATE IS 'Банковская дата выгрузки';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_STATUS.FILL_DATE IS 'Дата формирования (sysdate)';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_STATUS.SID       IS 'SID сесии';


CREATE OR REPLACE TRIGGER BARSUPL.LOG2UPL_DM_STATUS
AFTER INSERT ON BARSUPL.TMP_UPL_DM_STATUS FOR EACH ROW
/**********************************************************************************
   NAME:       LOG2UPL_DM_STATUS
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ----------------------------------------
   1.0        30/01/2019      kharinva       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     LOG2UPL_DM_STATUS
      Sysdate:         30/01/2019
      Date and Time:   30/01/2019, 14:38:56, and 30/01/2019 14:38:56
      Table Name:      TMP_UPL_DM_STATUS
      Trigger Options: Сохраняет историю наполнения временных витрин при выгрузке
**********************************************************************************/
DECLARE
   l_rec    BARSUPL.UPL_DM_STATUS%rowtype;
BEGIN
   l_rec.DM_CODE   := :new.DM_CODE;
   l_rec.KF        := :new.KF;
   l_rec.ROWS_CNT  := :new.ROWS_CNT;
   l_rec.BANK_DATE := :new.BANK_DATE;
   l_rec.FILL_DATE := :new.FILL_DATE;
   l_rec.SID       := :new.SID;

   insert into BARSUPL.UPL_DM_STATUS values l_rec;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END LOG2UPL_DM_STATUS;
/

PROMPT *** Create  grants  TMP_UPL_DM_STATUS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_UPL_DM_STATUS   to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/TMP_UPL_DM_STATUS.sql =========*** End 
PROMPT ===================================================================================== 
