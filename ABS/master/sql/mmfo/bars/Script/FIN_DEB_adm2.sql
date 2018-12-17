declare 
  --Редактирование справочника (в виде отдельной функции) дать только в один АРМ = Методолога.
  --В остальных АРМах эту функцию – забрать, но взамен дать на просмотр , в общей функции «Довідники» 
  oo operlist%rowtype    ;
  mm meta_tables%rowtype ; 
begin
  begin 
     --создать справочник 3) Продукт: "ФІНАНСОВА ДЕБІТОРКА"  в ОБ
     select * into mm from meta_tables where  tabname ='FIN_DEBT';
     begin Insert into REFERENCES (TABID, TYPE, ROLE2EDIT) Values  (mm.TABID, 92, 'BARS_ACCESS_DEFROLE');     
     exception when dup_val_on_index then null;     
     end;

     -- Вычитать функцию 3) Продукт: "ФІНАНСОВА ДЕБІТОРКА"  в ОБ
     select * into oo from operlist   where  funcname  like   '%='||mm.tabname||'[%';
     for aa in (select a.id from operapp o, applist a where o.codeoper = oo.codeoper and o.codeapp = a.codeapp and a.codeapp not like '%METO%'  )
     loop 
         -- забрать єту функцию оо всех, кроме МЕТОДОЛОГА
         resource_utl.revoke_resource_access
                                    (p_grantee_type_id   => resource_utl.get_resource_type_id('ARM_WEB') ,  
                                     p_grantee_id        => aa.ID,
                                     p_resource_type_id  => resource_utl.get_resource_type_id('FUNCTION_WEB'), 
                                     p_resource_id       => oo.codeoper ,
                                     p_approve           => TRUE 
                                    );
         -- дать в АРМ общую функцию «Довідники»  - если ее там нет
        resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id('ARM_WEB') ,  
---                                             user_menu_utl.get_arm_id( aa.ID ),   ---           
                                                aa.ID , 
                                                resource_utl.get_resource_type_id('FUNCTION_WEB'), 
                                                4420,  1 , true ) ; 

         -- взамен дать на просмотр , в общей функции «Довідники» 
         resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id('ARM_WEB') ,     aa.ID,
                                                 resource_utl.get_resource_type_id('DIRECTORIES'),  mm.TABID,
                                                 1 ,  true ) ; 
     end loop ; -- oa

     --дополнительно в эти АРМы
     resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id('ARM_WEB') ,     user_menu_utl.get_arm_id( '$RM_TEHA' ), 
                                            resource_utl.get_resource_type_id('DIRECTORIES'),  mm.TABID,
                                            1 ,  true ) ; 
     resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id('ARM_WEB') ,    user_menu_utl.get_arm_id( '$RM_TENA' ), 
                                                 resource_utl.get_resource_type_id('DIRECTORIES'),  mm.TABID,
                                                 1 ,  true ) ; 

  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;
end ;
/

commit;



