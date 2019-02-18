BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_DECLS_POLICY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_DECLS_POLICY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_DECLS_POLICY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** ALTER_POLICIES to EDS_DECLS_POLICY ***
begin
 bpa.alter_policies('EDS_DECLS_POLICY');
end;
/

begin
execute immediate'alter table eds_decls_policy drop constraint pk_eds_decls_policy';
exception when others then
if sqlcode = -02443 then null; else raise; end if;
end;
/
begin
execute immediate'drop index pk_eds_decls_policy';
exception when others then
if sqlcode = -01418 then null; else raise; end if;
end;
/

begin
execute immediate'alter table eds_decls_policy drop column kf';
exception when others then
if sqlcode = -00904 then null; else raise; end if;
end;
/
begin
delete eds_decls_policy where rowid in (select min(rowid) from eds_decls_policy group by id, add_id having count(*)>1);
commit;
end;
/
begin
execute immediate'create unique index pk_eds_decls_policy on eds_decls_policy(id, add_id) tablespace brsmdli';
exception when others then
if sqlcode = -01418 then null; else raise; end if;
end;
/

begin
execute immediate'alter table eds_decls_policy add constraint pk_eds_decls_policy primary key (id, add_id) using index pk_eds_decls_policy';
exception when others then
if sqlcode = -02443 then null; else raise; end if;
end;
/
