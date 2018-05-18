begin
    execute immediate 'alter table bars.CC_DEAL DROP constraint CC_CCDEAL_PROD_NN';
exception
    when others then null;
end;
/
