

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/pfu_file_arc.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table pfu_file_arc ***
begin 
  execute immediate '
CREATE TABLE pfu.pfu_file_arc
    (id                            NUMBER(10,0) constraint pk_pfu_file_arc primary key,
    envelope_request_id            NUMBER(10,0),
    check_sum                      NUMBER(38,2),
    check_lines_count              NUMBER(38,0),
    payment_date                   DATE,
    file_number                    NUMBER(5,0),
    file_name                      VARCHAR2(256 CHAR),
    file_data                      BLOB,
    state                          VARCHAR2(20 BYTE),
    crt_date                       DATE,
    data_sign                      CLOB,
    userid                         NUMBER(38,0),
    pay_date                       DATE,
    match_date                     DATE,
    arcdate                        date ,
    arcdateuser                    varchar2(60), 
    FILE_TYPE                      VARCHAR2(2 CHAR), 
    constraint fk_pfu_file_arc_envelope foreign key (envelope_request_id) references pfu.pfu_envelope_request (id) )' ;
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Create  table pfu_file_arc : newcolumns ( arcdateuser, FILE_TYPE) ***   


begin 
  execute immediate 'alter table pfu.pfu_file_arc add arcdateuser varchar2(60)' ;
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/

begin 
  execute immediate 'alter table pfu.pfu_file_arc add FILE_TYPE VARCHAR2(2 CHAR)' ;
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 

/



PROMPT *** Create  table pfu_file_arc : constraints ***   

BEGIN
    EXECUTE IMMEDIATE
        q'{ alter table pfu_file_arc add constraint ch_pfu_file_arc_state check (state in ('MATCH_SEND',  'CHECKED', 'ERROR') )}';
EXCEPTION
    WHEN OTHERS
    THEN
        IF SQLCODE = -2264
        THEN
            NULL;
        END IF;
END;

/

comment on table pfu.pfu_file_arc is 'Архивная таблица для pfu_file';

comment on column pfu.pfu_file_arc.ID is 'ID файлу';
comment on column pfu.pfu_file_arc.ENVELOPE_REQUEST_ID is 'Номер конверту' ; 
comment on column pfu.pfu_file_arc.CHECK_SUM is 'Сума';
comment on column pfu.pfu_file_arc.CHECK_LINES_COUNT is 'Кількість рядків реєстру' ;  
comment on column pfu.pfu_file_arc.PAYMENT_DATE is 'Планова дата оплати реєстру' ; 
comment on column pfu.pfu_file_arc.FILE_NUMBER is 'Порядковий номер файлу в конверті';
comment on column pfu.pfu_file_arc.FILE_NAME is 'Назва файлу';
comment on column pfu.pfu_file_arc.FILE_DATA is 'Дата файлу';
comment on column pfu.pfu_file_arc.STATE is 'Стан файлу';
comment on column pfu.pfu_file_arc.CRT_DATE is 'Дата «прийому» реєстру'  ;
comment on column pfu.pfu_file_arc.DATA_SIGN is 'Підпис'  ;
comment on column pfu.pfu_file_arc.USERID is 'ID користувача';
comment on column pfu.pfu_file_arc.PAY_DATE is 'Дата оплати реєстру'   ;
comment on column pfu.pfu_file_arc.MATCH_DATE is 'Дата відправки 2-ї квитанції' ;
comment on column pfu.pfu_file_arc.arcdate is 'Дата архивування файлу';
comment on column pfu.pfu_file_arc.arcdateuser is 'Імя користувача що виконав архивування';
comment on column pfu.pfu_file_arc.FILE_TYPE is 'Тип реєстру(1-пенсія, 2-монетизація)';

-- Grants for Table
GRANT SELECT ON pfu.pfu_file_arc TO bars
/
GRANT SELECT ON pfu.pfu_file_arc TO bars_access_defrole
/
GRANT SELECT ON pfu.pfu_file_arc TO upld
/
GRANT SELECT ON pfu.pfu_file_arc TO barsreader_role
/


 



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/pfu_file_arc.sql =========*** End *** =
PROMPT ===================================================================================== 

