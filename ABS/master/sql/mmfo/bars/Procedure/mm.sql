

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MM ***

  CREATE OR REPLACE PROCEDURE BARS.MM is
 Arm_ applist.codeapp%type    := '$RM_PRVN';
 fro_ operlist.FRONTEND%type  := 1     ;  
 id_  operlist.CODEOPER%type  ; nam_ operlist.NAME%type      ; fun_ operlist.FUNCNAME%type  ; lik_ operlist.FUNCNAME%type  ;
 procedure ADD_fun ( p_lik varchar2) is
 begin
  begin select codeoper into id_ from operlist           where funcname  like p_lik  AND FRONTEND = fro_ ;
         update operlist set  name= nam_, funcname = fun_ where codeoper = id_;
   exception when no_data_found then  id_ := OPERLISTNEXTID ;
         Insert into OPERLIST (CODEOPER,NAME,DLGNAME,FUNCNAME,RUNABLE,ROLENAME,FRONTEND) Values (id_,nam_,'N/A', fun_,1,'BARS_ACCESS_DEFROLE', fro_ );
   end ;
  resource_utl.set_resource_access_mode ( 
  resource_utl.get_resource_type_id('ARM_WEB')     ,  user_menu_utl.get_arm_id( Arm_ ), --- Что вяжем ? Веб-Арм ,  Его имя    = Arm_
  resource_utl.get_resource_type_id('FUNCTION_WEB'),  Id_ ,                   ----------- с чем вяжем ? Веб-Функц, ее имя(код)= Id_ 
  p_access_mode_id => 1                            ,  p_approve => true );    --------- режим доступа , с авто подтверж 
 end add_fun ;
 -------------
begin  bc.go('/') ;
 nam_  := 'MSFZ9. КП ЮО. Розподіл складних КД на прості.';  lik_ := '%V_MSFZ9[NSIFUNCTION]%' ;
 fun_  := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_MSFZ9[NSIFUNCTION][showDialogWindow=>false]'  ;
 ADD_fun  (lik_) ;
 end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MM.sql =========*** End *** ======
PROMPT ===================================================================================== 
