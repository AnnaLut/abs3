

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/pfu_file_arc_log.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table pfu_file_arc_log ***
begin 
  execute immediate 
'CREATE TABLE pfu_file_arc_log
    (file_id                        NUMBER,
    arcdate                        DATE DEFAULT sysdate,
    state                          VARCHAR2(20 BYTE),
    direction                      VARCHAR2(20 BYTE),
    username                       VARCHAR2(120 BYTE) DEFAULT user)

' ;
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table pfu_file_arc_log is 'Таблица логирования для переноса файлов между pfu_file и pfu_file_arc'; 


comment on column pfu_file_arc_log.FILE_ID is  'ID файла из PFU_FILE';
comment on column pfu_file_arc_log.ARCDATE is  'Дата выполнения операции';
comment on column pfu_file_arc_log.STATE is  'Статус файла';
comment on column pfu_file_arc_log.DIRECTION is  'Направление архивирования - в архив или возврат из архива';
comment on column pfu_file_arc_log.USERNAME is  'Имя пользователя выполнившего операцию';




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/pfu_file_arc_log.sql =========*** End *** =
PROMPT ===================================================================================== 

