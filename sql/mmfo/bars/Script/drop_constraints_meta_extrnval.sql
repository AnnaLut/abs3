begin
execute immediate 'ALTER TABLE BARS.META_EXTRNVAL drop CONSTRAINT CC_METAEXTRNVAL_SRCCOLID_NN';
exception when others then 
if sqlcode = -02443 then null; else raise; end if;
end;
/
begin
execute immediate 'ALTER TABLE BARS.META_EXTRNVAL drop CONSTRAINT CC_METAEXTRNVAL_SRCTABID_NN';
exception when others then 
if sqlcode = -02443 then null; else raise; end if;
end;
/
