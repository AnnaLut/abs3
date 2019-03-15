prompt create s_cur_rate_dealer

begin
    execute immediate q'[
CREATE SEQUENCE s_cur_rate_dealer
  INCREMENT BY 1
  START WITH 1 nocache
    ]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

  grant select on s_cur_rate_dealer to bars;

/