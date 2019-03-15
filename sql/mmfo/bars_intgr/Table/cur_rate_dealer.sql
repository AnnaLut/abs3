
prompt create table bars_intgr.cur_rate_dealer

begin
    execute immediate q'{
    CREATE TABLE bars_intgr.cur_rate_dealer
(arcdate                        DATE,
    kv                             NUMBER(3,0),
    kvcode                         VARCHAR2(3 BYTE),
    kvname                         VARCHAR2(150 BYTE),
    kvnominal                      NUMBER(4,0),
    rate_b                         number (35,8),
    rate_s                         number (35,8),
    kvfixingdate                   DATE DEFAULT sysdate,
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
GRANT INSERT ON cur_rate_dealer TO bars
/
GRANT SELECT ON cur_rate_dealer TO bars
/
GRANT UPDATE ON cur_rate_dealer TO bars
/
GRANT delete ON cur_rate_dealer TO bars
/

-- Comments for CUR_RATE_DEALER

COMMENT ON TABLE cur_rate_dealer IS 'Витрина курсов валют казначейства для ИШД'
/
COMMENT ON COLUMN cur_rate_dealer.arcdate IS 'Дата курсов'
/
COMMENT ON COLUMN cur_rate_dealer.kv IS 'Код валюты'
/
COMMENT ON COLUMN cur_rate_dealer.kvcode IS 'Символьный код валюты'
/
COMMENT ON COLUMN cur_rate_dealer.kvfixingdate IS 'Дата установки курса'
/
COMMENT ON COLUMN cur_rate_dealer.kvname IS 'Название валюты'
/
COMMENT ON COLUMN cur_rate_dealer.kvnominal IS 'Номинал валюты'
/
COMMENT ON COLUMN cur_rate_dealer.msgid IS 'Уникльный идентификатор для ШД'
/
COMMENT ON COLUMN cur_rate_dealer.rate_b IS 'Курс покупки'
/
COMMENT ON COLUMN cur_rate_dealer.rate_s IS 'Курс продажи'
/
COMMENT ON COLUMN cur_rate_dealer.state IS 'Состояние синхронизации'
/


