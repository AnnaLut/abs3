declare 
 Arm_MMFO varchar2(10)        := '$RM_BVBB' ;  --- '$RM_@IN '; 
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

   exception when others then null; -- на лок РУ НЕТ
   end;

 end add_fun ;
 -------------
BEGIN  suda ;

--  nam_  := 'F5 Генерація проводок по ПРОСТРОЧЕНІЙ комісії';                 lik_ := '%[PROC=>CIN.SP(0)]%' ;
--  fun_  := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>CIN.SP(0)][QST=>Виконати - ПРОСТРОЧЕНУ комісію ?][MSG=>Готово!]'  ;
--  ADD_fun  (lik_) ;

  nam_  := 'Винесення на ПРОСТРОЧЕНІ залишків ФІН.ДЕБ.';                   lik_  := '%[PROC=>FIN_DEB.SP(:M,:B,:R)]%' ;
  fun_  := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>FIN_DEB.SP(:M,:B,:R)][PAR=>:M(SEM=Модуль,TYPE=N,REF=FIN_DEBM),:B(SEM=Продукт,TYPE=C),:R(SEM=РНК_кл)]'||
           '[QST=>Виконати винесення на прострочені ?][MSG=>OK]';
  ADD_fun  (lik_) ;


end;
/
commit;


begin

 Insert into TMS_TASK
   (ID, TASK_CODE, TASK_TYPE_ID, TASK_GROUP_ID, SEQUENCE_NUMBER, 
    TASK_NAME, TASK_DESCRIPTION, BRANCH_PROCESSING_MODE, ACTION_ON_FAILURE, TASK_STATEMENT, 
    STATE_ID)
 Values
   (244, 'FIN_DEB.SP', 1, 2, 50, 
    'Винесення на ПРОСТРОЧЕНІ залишків ФІН.ДЕБ.',
     'Згідно платіжного дня', 3, 1, 'begin FIN_DEB.SP( NULL,''%'',null); end ;', 
    1);
    
COMMIT;
exception when dup_val_on_index then null;  
end;
/

