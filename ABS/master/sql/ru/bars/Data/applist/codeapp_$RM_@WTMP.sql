declare -- 	АРМ Виконання автоматичних операцій 
 Arm_ applist.codeapp%type    := 'WTMP' ; 
 fro_ operlist.FRONTEND%type  := 1      ;  
 id_  operlist.CODEOPER%type  ;  
 nam_ operlist.NAME%type      ;
 fun_ operlist.FUNCNAME%type  ;
 lik_ operlist.FUNCNAME%type  ;

 procedure ADD_fun ( p_lik varchar2) is
 begin
   ------------ создать.обновить функцию
   begin select codeoper into id_ from operlist           where funcname  like p_lik  AND FRONTEND = fro_ ;
         update operlist set  name= nam_, funcname = fun_ where codeoper = id_;
   exception when no_data_found then  id_ := OPERLISTNEXTID ;
         Insert into OPERLIST (CODEOPER,NAME,DLGNAME,FUNCNAME,RUNABLE,ROLENAME,FRONTEND) Values (id_,nam_,'N/A', fun_,1,'BARS_ACCESS_DEFROLE', fro_ );
   end ;

/*
   ------------ Включить функцию в Арм (роль)
   resource_utl.set_resource_access_mode ( 
     resource_utl.get_resource_type_id('ARM_WEB')     ,  user_menu_utl.get_arm_id( Arm_ ), --- Что вяжем ? Веб-Арм ,  Его имя    = Arm_
     resource_utl.get_resource_type_id('FUNCTION_WEB'),  Id_ ,                   ----------- с чем вяжем ? Веб-Функц, ее имя(код)= Id_ 
     p_access_mode_id => 1                            ,  p_approve => true );    --------- режим доступа , с авто подтверж 
*/
   delete from OPERAPP where CODEAPP = Arm_ and CODEOPER = id_;
   Insert into OPERAPP (CODEAPP, CODEOPER, APPROVE ) Values   (Arm_, id_, 1 );

 end add_fun ;
 -------------
begin  bc.go('/') ;

   begin Insert into BARS.APPLIST   (CODEAPP, NAME, FRONTEND) Values   (Arm_, 'WEB-АРМ Для разових процедур', 1 );
   exception when dup_val_on_index then null;  
   end;

   ---1-------------------
   nam_ := 'x.Виконання разових процедур';
   fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=SB_OB22[NSIFUNCTION]';
   lik_ := fun_; --- %XOZ_OB22_CL[NSIFUNCTION]%' ;
   ADD_fun  (lik_) ;

end;
/
commit;
-----------
