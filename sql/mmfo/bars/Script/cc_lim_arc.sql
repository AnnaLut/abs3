exec bc.go('/');
exec bars_policy_adm.alter_policy_info(p_table_name => 'cc_lim_arc', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null); 
exec bars_policy_adm.alter_policy_info(p_table_name => 'cc_lim_arc', p_policy_group => 'FILIAL', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');   
exec bars_policy_adm.alter_policies(p_table_name => 'cc_lim_arc');
begin 
   execute immediate ' begin  bars_policy_adm.add_column_kf(p_table_name => ''CC_LIM_ARC'');  end; ';
   exception when others then
   -- ORA-02296: name is already used by an existing object
   if SQLCODE = -02296 then null;   else raise; end if; 
end;
/

begin
   execute immediate 'begin update cc_lim_arc a set kf = (select distinct kf from cc_lim where nd = a.nd ); commit; end;';
   exception when others then
   -- ORA-02296: name is already used by an existing object
   if SQLCODE = -20097 then null;   else raise; end if; 
end;
/ 

exec bars_policy_adm.alter_policy_info(p_table_name => 'CC_LIM_ARC', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'CC_LIM_ARC', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'CC_LIM_ARC');

exec bc.go('/');
exec bars_policy_adm.alter_policy_info(p_table_name => 'cc_trans_arc', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null); 
exec bars_policy_adm.alter_policy_info(p_table_name => 'cc_trans_arc', p_policy_group => 'FILIAL', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');   
exec bars_policy_adm.alter_policies(p_table_name => 'cc_trans_arc');
begin 
   execute immediate ' begin  bars_policy_adm.add_column_kf(p_table_name => ''CC_TRANS_ARC'');  end; ';
   exception when others then
   -- ORA-02296: name is already used by an existing object
   if SQLCODE = -02296 then null;   else raise; end if; 
end;
/

update cc_trans_arc a set kf = (select distinct kf from cc_trans where acc = a.acc );
commit;
begin
   for k in (select * from cc_trans_arc where  kf is null)
   loop
      update cc_trans_arc a set kf = (select distinct kf from cc_trans where acc = to_number(to_char(a.acc)||'01') ) where acc=k.acc;
   end loop;
   commit;
end;
/ 
begin
   for k in (select * from cc_trans_arc where  kf is null)
   loop
      update cc_trans_arc a set kf = (select distinct kf from accounts where acc =a.acc ) where acc=k.acc;
   end loop;
   commit;
end;
/ 

begin
   for k in (select * from cc_trans_arc where  kf is null)
   loop
      update cc_trans_arc a set kf = (select distinct kf from accounts where acc =to_number(to_char(a.acc)||'01') ) where acc=k.acc;
   end loop;
   commit;
end;
/ 

exec bars_policy_adm.alter_policy_info(p_table_name => 'CC_TRANS_ARC', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'CC_TRANS_ARC', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'CC_TRANS_ARC');

exec bc.go('/');
exec bars_policy_adm.alter_policy_info(p_table_name => 'nd_acc_arc', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null); 
exec bars_policy_adm.alter_policy_info(p_table_name => 'nd_acc_arc', p_policy_group => 'FILIAL', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');   
exec bars_policy_adm.alter_policies(p_table_name => 'nd_acc_arc');
begin 
   execute immediate ' begin  bars_policy_adm.add_column_kf(p_table_name => ''ND_ACC_ARC'');  end; ';
   exception when others then
   -- ORA-02296: name is already used by an existing object
   if SQLCODE = -02296 then null;   else raise; end if; 
end;
/

update nd_acc_arc a set kf = (select distinct kf from nd_acc where acc = a.acc );
commit;
begin
   for k in (select * from nd_acc_arc where  kf is null)
   loop
      update nd_acc_arc a set kf = (select kf from accounts where acc = a.acc ) where acc=k.acc;
   end loop;
   commit;
end;
/ 

exec bars_policy_adm.alter_policy_info(p_table_name => 'ND_ACC_ARC', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'ND_ACC_ARC', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'ND_ACC_ARC');

