set define off
declare 
    l_ref_type number;
    l_arm_code varchar2(100);
	l_codeoper number;
	
begin   
   select type    into l_ref_type from typeref where name = 'Налаштування ОПЕРАЦІЙ';
   select codeapp into l_arm_code from applist where name = 'АРМ Бек-офісу';   
   for c in (select tabname, tabid from meta_tables m where tabname like 'SDO%') loop 
       begin 
          insert into references (TABID, TYPE) 
          values(c.tabid, l_ref_type);      
       exception when dup_val_on_index then 
           update references set type = l_ref_type where tabid = c.tabid ;   
       end;
       umu.add_reference2arm_bytabname( p_reference_tabname => c.tabname, 
                                        p_arm_code => l_arm_code,
                                        p_access_mode_id => 2);
   end loop;
   commit;
   
   
   
   -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'СДО: Редагування правил для автооплати',      
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=SDO_AUTOPAY_RULES_DESC[NSIFUNCTION][showDialogWindow=>false]', 
                    p_frontend  =>      1 );                    

   -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_arm_code, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    
	commit; 					
	
end;
/          

