    prompt create BARS_INTGR.S_CUR_RATE_COMMERCIAL

begin
    execute immediate q'[
CREATE SEQUENCE s_cur_rate_commercial
  INCREMENT BY 1
  START WITH 1 nocache
    ]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

  grant select on BARS_INTGR.S_CUR_RATE_COMMERCIAL  to bars;

/