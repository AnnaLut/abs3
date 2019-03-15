
prompt create table bars_intgr.CUR_RATE_COMMERCIAL

begin
    execute immediate q'{
    CREATE TABLE bars_intgr.cur_rate_commercial
    (arcdate                        DATE,
    branch                         VARCHAR2(30 BYTE),
    kv                             NUMBER(3,0),
    kvcode                         VARCHAR2(3 BYTE),
    kvname                         VARCHAR2(150 BYTE),
    kvnominal                      NUMBER(4,0),
    rate_b                         NUMBER(9,4),
    rate_s                         NUMBER(9,4),
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
GRANT INSERT ON cur_rate_commercial TO bars
/
GRANT SELECT ON cur_rate_commercial TO bars
/
GRANT UPDATE ON cur_rate_commercial TO bars
/
GRANT delete ON cur_rate_commercial TO bars
/

-- Comments for CUR_RATE_COMMERCIAL
COMMENT ON TABLE cur_rate_commercial IS '������� ������������ ������ ����� ��� ���'
/
COMMENT ON COLUMN cur_rate_commercial.arcdate IS '���� ������'
/
COMMENT ON COLUMN cur_rate_commercial.branch IS '������'
/
COMMENT ON COLUMN cur_rate_commercial.kv IS '��� ������'
/
COMMENT ON COLUMN cur_rate_commercial.kvcode IS '���������� ��� ������'
/
COMMENT ON COLUMN cur_rate_commercial.kvfixingdate IS '���� ��������� �����'
/
COMMENT ON COLUMN cur_rate_commercial.kvname IS '�������� ������'
/
COMMENT ON COLUMN cur_rate_commercial.kvnominal IS '������� ������'
/
COMMENT ON COLUMN cur_rate_commercial.msgid IS '��������� ������������� ��� ��'
/
COMMENT ON COLUMN cur_rate_commercial.rate_b IS '���� �������'
/
COMMENT ON COLUMN cur_rate_commercial.rate_s IS '���� �������'
/
COMMENT ON COLUMN cur_rate_commercial.state IS '��������� �������������'
/

