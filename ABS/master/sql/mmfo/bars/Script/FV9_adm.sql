declare 
  Arm_MMFO varchar2(10)        := '$RM_PRVN'; 
--  Arm_RU   varchar2(10)        := 'PRVN'    ; -----------'$RM_OWAY' ; 
  fro_ operlist.FRONTEND%type  := 1     ;  
 id_  operlist.CODEOPER%type  ;  
 nam_ operlist.NAME%type      ;
 fun_ operlist.FUNCNAME%type  ;
 lik_ operlist.FUNCNAME%type  ;

 procedure ADD_fun ( p_lik varchar2) is
 begin   ------------ создать.обновить функцию
   begin select codeoper into id_ from operlist           where funcname  like p_lik  AND FRONTEND = fro_ ;
         update operlist set  name= nam_, funcname = fun_ where codeoper = id_;
   exception when no_data_found then  id_ := OPERLISTNEXTID ;
         Insert into OPERLIST (CODEOPER,NAME,DLGNAME,FUNCNAME,RUNABLE,ROLENAME,FRONTEND) Values (id_,nam_,'N/A', fun_,1,'BARS_ACCESS_DEFROLE', fro_ );
   end ;

   begin     EXECUTE IMMEDIATE  
     ' begin resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id(''ARM_WEB'') ,  
                                                     user_menu_utl.get_arm_id( :p_arm_code ), 
                                                     resource_utl.get_resource_type_id(''FUNCTION_WEB''), 
                                                     :p_resource_id ,               
                                                     1 ,                     
                                                     true ) ; 
       end ; ' using Arm_MMFO, id_;

   exception when others then   null;
--     if SQLCODE = -06550 then null;   --   для РУ
--        begin Insert into BARS.OPERAPP   (CODEAPP, CODEOPER, APPROVE, GRANTOR) Values   (Arm_RU, id_, 1, 1);   exception when dup_val_on_index then  null;   end;
--     else raise; 
--     end if;  
   end;

 end add_fun ;
 -------------
BEGIN 
  nam_  := 'Диспетчер по обробці вітрин FV9';  
  lik_ := '%PRVN_FV9[NSIFUNCTION]%' ;
  fun_  := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=3'||chr(38)||'sPar=PRVN_FV9[NSIFUNCTION][showDialogWindow=>false]'  ;
  ADD_fun  (lik_) ;

 --------------
  nam_  := 'Диспетчер по обробці вітрин FV9 (Тільки Перегляд)';  
  lik_ := '%PRVN_FV9_RO[NSIFUNCTION]%' ;
  fun_  := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=PRVN_FV9_RO[NSIFUNCTION][showDialogWindow=>false]'  ;
  ADD_fun  (lik_) ;

end;



/
commit;
