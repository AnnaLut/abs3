declare -- 	��� ��������� ������������ �������� 
 Arm_ applist.codeapp%type    := 'WTMP' ; 
 fro_ operlist.FRONTEND%type  := 1      ;  
 id_  operlist.CODEOPER%type  ;  
 nam_ operlist.NAME%type      ;
 fun_ operlist.FUNCNAME%type  ;
 lik_ operlist.FUNCNAME%type  ;

 procedure ADD_fun ( p_lik varchar2) is
 begin
   ------------ �������.�������� �������
   begin select codeoper into id_ from operlist           where funcname  like p_lik  AND FRONTEND = fro_ ;
         update operlist set  name= nam_, funcname = fun_ where codeoper = id_;
   exception when no_data_found then  id_ := OPERLISTNEXTID ;
         Insert into OPERLIST (CODEOPER,NAME,DLGNAME,FUNCNAME,RUNABLE,ROLENAME,FRONTEND) Values (id_,nam_,'N/A', fun_,1,'BARS_ACCESS_DEFROLE', fro_ );
   end ;

/*
   ------------ �������� ������� � ��� (����)
   resource_utl.set_resource_access_mode ( 
     resource_utl.get_resource_type_id('ARM_WEB')     ,  user_menu_utl.get_arm_id( Arm_ ), --- ��� ����� ? ���-��� ,  ��� ���    = Arm_
     resource_utl.get_resource_type_id('FUNCTION_WEB'),  Id_ ,                   ----------- � ��� ����� ? ���-�����, �� ���(���)= Id_ 
     p_access_mode_id => 1                            ,  p_approve => true );    --------- ����� ������� , � ���� �������� 
*/
   delete from OPERAPP where CODEAPP = Arm_ and CODEOPER = id_;
   Insert into OPERAPP (CODEAPP, CODEOPER, APPROVE ) Values   (Arm_, id_, 1 );

 end add_fun ;
 -------------
begin  bc.go('/') ;

   begin Insert into BARS.APPLIST   (CODEAPP, NAME, FRONTEND) Values   (Arm_, 'WEB-��� ��� ������� ��������', 1 );
   exception when dup_val_on_index then null;  
   end;

   ---1-------------------
   nam_ := 'x.��������� ������� ��������';
   fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=SB_OB22[NSIFUNCTION]';
   lik_ := fun_; --- %XOZ_OB22_CL[NSIFUNCTION]%' ;
   ADD_fun  (lik_) ;

end;
/
commit;
-----------
