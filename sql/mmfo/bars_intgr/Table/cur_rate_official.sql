
prompt create table bars_intgr.cur_rate_official

begin
    execute immediate q'{
    CREATE TABLE bars_intgr.cur_rate_official
 (arcdate                        DATE,
    kv                             NUMBER(3,0),
    kvcode                         VARCHAR2(3 BYTE),
    kvname                         VARCHAR2(150 BYTE),
    kvnominal                      NUMBER(4,0),
    rate                           NUMBER(9,4),
    kvfixingdate                   DATE DEFAULT systimestamp,
    state                          NUMBER(1,0) DEFAULT 0,
    msgid                          number)
    }' ;
    
    
exception
    when others then
        if sqlcode = -955 then null;
         else raise; end if;
end;


/
-- Grants for Table
GRANT INSERT ON cur_rate_official TO bars
/
GRANT SELECT ON cur_rate_official TO bars
/
GRANT UPDATE ON cur_rate_official TO bars
/
GRANT delete ON cur_rate_official TO bars
/

-- Comments for CUR_RATE_OFFICIAL

COMMENT ON TABLE cur_rate_official IS 'Витрина курсов валют НБУ для ИШД'
/
COMMENT ON COLUMN cur_rate_official.arcdate IS 'Дата курсов'
/
COMMENT ON COLUMN cur_rate_official.kv IS 'Код валюты'
/
COMMENT ON COLUMN cur_rate_official.kvcode IS 'Символьный код валюты'
/
COMMENT ON COLUMN cur_rate_official.kvfixingdate IS 'Дата установки курса'
/
COMMENT ON COLUMN cur_rate_official.kvname IS 'Название валюты'
/
COMMENT ON COLUMN cur_rate_official.kvnominal IS 'Номинал валюты'
/
COMMENT ON COLUMN cur_rate_official.msgid IS 'Уникльный идентификатор для ШД'
/
COMMENT ON COLUMN cur_rate_official.rate IS 'Курс'
/
COMMENT ON COLUMN cur_rate_official.state IS 'Состояние синхронизации'
/

