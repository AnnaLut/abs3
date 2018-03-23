SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KWT .sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KWT ***
declare -- АРМ Розшифровка 2924
 Arm_MMFO varchar2(8) := '$RM_KWT '; ---- 'KWT '; -----------'$RM_KWT '; --applist.codeapp%type
 Arm_RU   varchar2(8) := 'KWT '    ; ---- 'KWT '; -----------'KWT '; 
 l_application_name varchar2(300 char) := 'АРМ Розшифровка 2924';
 -------------------------------------
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
     ' begin resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id(''ARM_WEB''),  
                                                     user_menu_utl.get_arm_id( :p_arm_code ), 
                                                     resource_utl.get_resource_type_id(''FUNCTION_WEB''), 
                                                     :p_resource_id,               
                                                     1,                     
                                                     true ); 
       end ; ' using Arm_MMFO, id_;

   exception when others then   
       if SQLCODE = -06550 then null;   --   для РУ
           begin Insert into BARS.OPERAPP   (CODEAPP, CODEOPER, APPROVE, GRANTOR) Values   (Arm_RU, id_, 1, 1);
           exception when dup_val_on_index then  null; 
           end;
       else raise; 
       end if;  
   end;

 end add_fun ;
-------------
BEGIN 

   -- Скрипт загрузки ресурсов АРМа KWT 

   begin
      insert into applist (codeapp, name, frontend)
      values (Arm_RU, l_application_name, fro_);
   exception when dup_val_on_index then
      update applist
      set name = l_application_name,
          frontend = fro_
      where codeapp = Arm_RU;
   end;


  nam_ := '2924 з залишком. Квитовка по сумі'; 
  fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=V_KWT_2924[NSIFUNCTION][showDialogWindow=>false]';
  lik_ := '%sPar=V_KWT_2924%' ;
  ADD_fun  (lik_) ;
  ------------
  nam_ := '2924.Календар квитовки'; 
  fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=V_KWT_D_2924[NSIFUNCTION][PROC=>KWT_2924.MAX_DAT][EXEC=>BEFORE][showDialogWindow=>false]';
  lik_ := '%sPar=V_KWT_D_2924%' ;
  ADD_fun  (lik_) ;
  --------------
  nam_ := '2924.Ручна розшифровка'; 
  fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_KWT_RA_2924[NSIFUNCTION][showDialogWindow=>false]'||
          '[PROC=>PUL_DAT(:B,null)][PAR=>:B(SEM=Звітна_дата,TYPE=S)][EXEC=>BEFORE]';
  lik_ := '%sPar=V_KWT_RA_2924[%' ;
  ADD_fun  (lik_) ;
  ------------------------------------
  nam_ := '2924*07*Надлишки в АТМ'; 
  fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_ATMREF07[NSIFUNCTION][showDialogWindow=>false]';
  lik_ := '%sPar=V_ATMREF07[NSIFUNCTION]%' ;
  update operlist set  name= nam_, funcname = fun_ where funcname  LIKE LIK_;
  lik_ := '%sPar=V_ATMREF07[NSIFUNCTION]%' ;
  ADD_fun  (lik_) ;
  ------------
  nam_ := '2924*08*Нестачі в АТМ'; 
  fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_ATMREF08[NSIFUNCTION][showDialogWindow=>false]';
  lik_ := '%sPar=V_ATMREF08[NSIFUNCTION]%' ;
  ADD_fun  (lik_) ;
  ------------
  nam_ := 'Друк звітів NEW';
  fun_ := '/barsroot/cbirep/rep_list.aspx?codeapp=\S*';
  lik_ := fun_;
  ADD_fun  (lik_) ;
end;
/
commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_KWT .sql ========*** En
PROMPT ===================================================================================== 
