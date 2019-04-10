prompt ------------------------6. Добваити в  $RM_XOZD
declare 
  Arm_MMFO varchar2(10)        := '$RM_XOZD'; -- для РУ с редактированием
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

   resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id('ARM_WEB') ,      user_menu_utl.get_arm_id( Arm_MMFO ), 
                                           resource_utl.get_resource_type_id('FUNCTION_WEB'), id_,  1,  true ) ; 
 end add_fun ;
 -------------
BEGIN 
  nam_  := 'XOZ_MSFZ_16.Госп.Угоди, їх рахунки та операції';  
  lik_ := '%accessCode=2_sPar=XOZ_MSFZ_16[%' ;
  fun_  := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=XOZ_MSFZ_16'||
           '[showDialogWindow=>false]'||
           '[NSIFUNCTION]'||
           '[EDIT_MODE=>MULTI_EDIT]'||
           '[PROC=>PUl.PUT(''R020'',4600)]'||
           '[EXEC=>BEFORE]';
  ADD_fun  (lik_) ;
 --------------
end;
/
commit;

