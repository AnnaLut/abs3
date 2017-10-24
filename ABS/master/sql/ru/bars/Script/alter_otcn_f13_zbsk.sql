begin
    tuda;
    execute immediate 'ALTER TABLE bars.otcn_f13_zbsk ADD stmt number';
exception
    when others then null;
end;
/    

