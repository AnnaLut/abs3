begin

  execute immediate 'create sequence s_w4_instant_batches';

exception
  when others then
    if sqlcode = -955 then
      null;
    else
      raise;
    end if;
end;
/