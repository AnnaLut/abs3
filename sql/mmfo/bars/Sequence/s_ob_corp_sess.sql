declare
l_max_sess number;
BEGIN
select nvl(max(id),0)+1 into l_max_sess from ob_corp_sess;
execute immediate 'create sequence S_OB_CORP_SESS start with '||l_max_sess||' nocache';
exception when others then
  if sqlcode = -00955 then null; else raise; end if;
end;
/