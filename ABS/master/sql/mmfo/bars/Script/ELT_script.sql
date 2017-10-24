begin 
execute immediate('ALTER TABLE BARS.E_TAR_ND DROP CONSTRAINT FK_E_TAR_ND_ID');
exception when others then 
   null;
end;
/
begin 
execute immediate('ALTER TABLE BARS.E_TARIF DROP CONSTRAINT  XPK_E_TARIF DROP INDEX');
exception when others then 
   null;
end;
/


begin 
   execute immediate('alter table E_TARIF add "KF" VARCHAR2(6 BYTE  ) ');
   execute immediate 'alter table E_TARIF MODIFY KF default sys_context(''bars_context'',''user_mfo'')';
exception when others then 
   null;
end;
/

begin
update E_TARIF set KF='300465' where kf is null;
end;
/