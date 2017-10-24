begin  Insert into BARS.ROLES$BASE ( ROLE_NAME ) Values ( 'BARS_ACCESS_DEFROLE' );
exception  when DUP_VAL_ON_INDEX  then null;
end;
/

COMMIT;

begin Insert into BARS.APPLIST   (CODEAPP, NAME, FRONTEND) Values   ('WXOZ', 'АРМ Деб.заборг. за госп. діяльністю банку', 1);
exception  when DUP_VAL_ON_INDEX  then null;
end;
/

COMMIT;
-------------------------
declare -- АРМ Деб.заборг. за госп. діяльністю банку
 Arm_ applist.codeapp%type    ; ----:= '$RM_XOZD' ; 
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
   ------------ Включить функцию в Арм (роль)
/*
   resource_utl.set_resource_access_mode ( 
     resource_utl.get_resource_type_id('ARM_WEB')     ,  user_menu_utl.get_arm_id( Arm_ ), --- Что вяжем ? Веб-Арм ,  Его имя    = Arm_
     resource_utl.get_resource_type_id('FUNCTION_WEB'),  Id_ ,                   ----------- с чем вяжем ? Веб-Функц, ее имя(код)= Id_ 
     p_access_mode_id => 1                            ,  p_approve => true );    --------- режим доступа , с авто подтверж 
*/
   delete from OPERAPP where CODEAPP = Arm_ and CODEOPER = id_;
   Insert into OPERAPP (CODEAPP, CODEOPER, APPROVE ) Values   (Arm_, id_, 1 );

 end add_fun ;
 -------------
begin  suda ;

   Arm_:= 'WXOZ';

   ---1-------------------
   nam_ := 'ДЗ-0) В ЦА:Референтні терміни знаходження ДЗ на балансі';
   fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=XOZ_OB22_CL[NSIFUNCTION][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]';
   lik_ := '%XOZ_OB22_CL[NSIFUNCTION]%' ;
   ADD_fun  (lik_) ;

   ---1-------------------
   nam_ := 'ДЗ-0) В ЦА:Моделi закриття ДЗ';
   fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=XOZ_OB22[NSIFUNCTION][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]';
   lik_ := '%XOZ_OB22[NSIFUNCTION]%' ;
   ADD_fun  (lik_) ;

   Arm_:= 'WXOZ' ;
   --2.0.-- В МФО ----------------------------
   nam_ := 'ДЗ-1) В РУ: Складні оп.перерахування з рахунків ДЗ'; 
   fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=OPER_XOZ[NSIFUNCTION][showDialogWindow=>false]';
   lik_ := '%OPER_XOZ[NSIFUNCTION]%' ;
   ADD_fun  (lik_) ;
   --2.1.--
   nam_ := 'ДЗ-2) В РУ: Портфель ДЗ за госп діяльністю';
   fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_XOZACC[NSIFUNCTION][showDialogWindow=>false]';
   lik_ := '%sPar=V_XOZACC[NSIFUNCTION]%' ;
   ADD_fun  (lik_) ;
   -- 2.2.
   nam_ := 'ДЗ-3) В РУ: ДЗ за госп діяльністю. Архiв.';
   fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=V_XOZREF2[NSIFUNCTION][showDialogWindow=>false]';
   lik_ := '%V_XOZREF2[NSIFUNCTION]%' ;
   ADD_fun  (lik_) ;

   nam_ := '------Не викрист.(рез 23)' ; 
   fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||
           'sPar=NBU23_REZ[NSIFUNCTION][PROC=>XOZ.REZ(:A,1)][PAR=>:A(SEM=Зв_дата_01-мм-pppp)][EXEC=>BEFORE][CONDITIONS=>NBU23_REZ.FDAT=z23.B and id like ''XOZ%'' ]';
   lik_ := '%NBU23_REZ%[PROC=>XOZ.REZ(:A,1)][%' ;
   ADD_fun  (lik_) ;

  -- 3 ----------------------
  nam_ := 'ДЗ-4) В ЦА: Відшкодування госп.ДЗ, що виникла в РУ' ; 
  fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)|| 
          'sPar=V_XOZ_RU_CA[NSIFUNCTION][showDialogWindow=>false]'||
          '[PROC=>BEGIN delete from TZAPROS where STMP<BARS.DAT_NEXT_U(trunc(sysdate),-7);END][EXEC=>BEFORE]';
  lik_ := '%sPar=V_XOZ_RU_CA[NSIFUNCTION]%' ;
  ADD_fun  (lik_) ;

  ----------------------------------------------------
  nam_ := 'Візування "своїх" операцій' ; 
  fun_ := '/barsroot/checkinner/default.aspx?type=0';
  lik_ := fun_; 
  ADD_fun  (lik_) ;
  -------------------------------------------------
end;
/
commit;
-----------