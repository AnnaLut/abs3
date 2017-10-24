prompt ####################################################################################
prompt ... �������� ������� � ��������� � ��� ($RM_)OWAY -������������ ��� ���� � ��.  D:\K\MMFO\kwt_2924\Sql\Data\ATM_adm.sql 
prompt ..........................................


declare -- ��� ��������� � OpenWay
 Arm_MMFO varchar2(8) := '$RM_OWAY'; ---- 'OWAY'; -----------'$RM_OWAY' ; --applist.codeapp%type
 Arm_RU   varchar2(8) := 'OWAY'    ; ---- 'OWAY'; -----------'$RM_OWAY' ; 
 -------------------------------------
 fro_ operlist.FRONTEND%type  := 1     ;  
 id_  operlist.CODEOPER%type  ;  
 nam_ operlist.NAME%type      ;
 fun_ operlist.FUNCNAME%type  ;
 lik_ operlist.FUNCNAME%type  ;
 procedure ADD_fun ( p_lik varchar2) is
 begin   ------------ �������.�������� �������
   begin select codeoper into id_ from operlist           where funcname  like p_lik  AND FRONTEND = fro_ ;
         update operlist set  name= nam_, funcname = fun_ where codeoper = id_;
   exception when no_data_found then  id_ := OPERLISTNEXTID ;
         Insert into OPERLIST (CODEOPER,NAME,DLGNAME,FUNCNAME,RUNABLE,ROLENAME,FRONTEND) Values (id_,nam_,'N/A', fun_,1,'BARS_ACCESS_DEFROLE', fro_ );
   end ;
/*
   begin     EXECUTE IMMEDIATE  
     ' begin resource_utl.set_resource_access_mode ( p_grantee_type_id  => resource_utl.get_resource_type_id(''ARM_WEB'') ,  
                                                     p_grantee_type_id  => user_menu_utl.get_arm_id( :p_arm_code ), 
                                                     p_resource_type_id => resource_utl.get_resource_type_id(''FUNCTION_WEB''), 
                                                     p_resource_id      => :p_resource_id  ,               
                                                     p_access_mode_id   => 1 ,                     
                                                     p_approve => true ) ; 
       end ; ' using Arm_MMFO, id_;

   end;
*/



   begin     EXECUTE IMMEDIATE  
     ' begin resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id(''ARM_WEB'') ,  
                                                     user_menu_utl.get_arm_id( :p_arm_code ), 
                                                     resource_utl.get_resource_type_id(''FUNCTION_WEB''), 
                                                     :p_resource_id ,               
                                                     1 ,                     
                                                     true ) ; 
       end ; ' using Arm_MMFO, id_;

   exception when others then   
       if SQLCODE = -06550 then null;   --   ��� ��
           begin Insert into BARS.OPERAPP   (CODEAPP, CODEOPER, APPROVE, GRANTOR) Values   (Arm_RU, id_, 1, 1);
           exception when dup_val_on_index then  null; 
           end;
       else raise; 
       end if;  
   end;

/*
ORA-06550: line 1, column 48:
PLS-00201: identifier 'RESOURCE_UTL.GET_RESOURCE_TYPE_ID' must be declared
ORA-06550: line 1, column 8:
PL/SQL: Statement ignored
ORA-06512: at line 32
ORA-06512: at line 55
*/
 end add_fun ;
 -------------
BEGIN 
  nam_ := '2924*07*08* �������� �� ������� � ���'; 
  fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_ATMREF0[NSIFUNCTION][showDialogWindow=>false]';
  lik_ := '%sPar=V_ATMREF0[NSIFUNCTION]%' ;
  ADD_fun  (lik_) ;
  ------------
end;
/
commit;

