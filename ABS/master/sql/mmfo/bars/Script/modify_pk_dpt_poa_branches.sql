prompt -- ======================================================
prompt --  modify table DPT_POA_BRANCHES
prompt -- ======================================================

begin 
execute immediate('alter table DPT_POA_BRANCHES drop constraint PK_DPTPOABRANCHES cascade');
exception when others then 
   null;
end;
/
begin 
execute immediate('drop index PK_DPTPOABRANCHES');
exception when others then 
   null;
end;
/
begin 
execute immediate('alter table DPT_POA_BRANCHES add constraint PK_DPTPOABRANCHES primary key (BRANCH, ORD, POA_ID)');
exception when others then 
   null;
end;
/
