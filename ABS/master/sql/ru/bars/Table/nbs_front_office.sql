-- довідник балансових рахунків
begin
  bpa.alter_policy_info('NBS_FRONT_OFFICE', 'FILIAL', null, null, null, null);
  bpa.alter_policy_info('NBS_FRONT_OFFICE', 'WHOLE', null, null, null, null);
end;
/

begin
  execute immediate
    ' create table bars.nbs_front_office ('||
    ' nbs char(4),'||
    ' constraint pk_nbs primary key (nbs))';
exception when others then
  if sqlcode=-955 then null; else raise; end if;
end;
/

begin
  bpa.alter_policies('NBS_FRONT_OFFICE');
end;
/

grant select on bars.nbs_front_office to bars_access_defrole;
