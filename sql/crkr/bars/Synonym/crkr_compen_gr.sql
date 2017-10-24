begin
  execute immediate 'CREATE PUBLIC SYNONYM crkr_compen FOR crkr_compen';
exception when others then
  if sqlcode=-955 then
    null;
  else
    raise;
  end if;
end;
/

grant execute on crkr_compen to BARS_ACCESS_DEFROLE;