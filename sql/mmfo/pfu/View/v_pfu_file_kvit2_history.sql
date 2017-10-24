CREATE OR REPLACE VIEW PFU.V_PFU_FILE_KVIT2_HISTORY AS
SELECT pf."ID",
          pf."ENVELOPE_REQUEST_ID",
          pf."CHECK_SUM",
          pf."CHECK_LINES_COUNT",
          pf."PAYMENT_DATE",
          pf."FILE_NUMBER",
          pf."FILE_NAME",
          pf."FILE_DATA",
          pf."STATE",
          (select pfs.state_name
             from pfu.pfu_file_state pfs
            where pfs.state = pf.state) "STATE_NAME",
          pf."CRT_DATE",
          pf."DATA_SIGN",
          pf."USERID",
          pf."PAY_DATE",
          pf."MATCH_DATE"
     FROM pfu.pfu_file pf
    WHERE pf.state = 'MATCH_SEND';
comment on table PFU.V_PFU_FILE_KVIT2_HISTORY is 'Представлення для перегляду пачок (файлів реєстрів) з статусом MATCH_SEND (відправлена 2-га квитанція)';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.ID is 'ID файлу (реєстру)';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.ENVELOPE_REQUEST_ID is 'ID конверту';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.CHECK_SUM is 'Сума реєстру в копійках';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.CHECK_LINES_COUNT is 'К-ть записів у реєстрі';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.PAYMENT_DATE is 'Дата оплати реєстру';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.FILE_NUMBER is 'Порядковий номер файлу у конверті';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.FILE_NAME is 'Імя файла реєстру';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.FILE_DATA is 'Дані реєстру';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.STATE is 'Статус файлу (реєстру)';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.DATA_SIGN is 'Підпис';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.USERID is 'ID користувача, який відправив 2-гу квитанцію';
