

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ADD_TO_ROLE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ADD_TO_ROLE ***

  CREATE OR REPLACE PROCEDURE BARS.ADD_TO_ROLE 
     ( p_grantee_type_id  in integer,
       p_grantee_id       in integer,
       p_resource_type_id in integer,
       p_resource_id      in integer
    ) is

   l_default_access_mode_id integer := 1;


---- 28.12.2016 Сухова Т.А.  Временный заменитель процедуры вставки связей с параллельной поддержкой старых связей

 
 t_rol int := resource_utl.get_resource_type_id('STAFF_ROLE')       ;
 t_sta int := resource_utl.get_resource_type_id('STAFF_USER')       ;
 t_arw int := resource_utl.get_resource_type_id('ARM_WEB')          ;
 t_arc int := resource_utl.get_resource_type_id('ARM_CENTURA')      ;
 t_Rep int := resource_utl.get_resource_type_id('REPORTS')          ;
 t_Ref int := resource_utl.get_resource_type_id('DIRECTORIES')      ;
 t_FUw int := resource_utl.get_resource_type_id('FUNCTION_WEB')     ;
 t_FUc int := resource_utl.get_resource_type_id('FUNCTION_CENTURA') ;
 t_acc int := resource_utl.get_resource_type_id('ACCOUNT_GROUP')    ;
 t_chk int := resource_utl.get_resource_type_id('CHKLIST')          ;
 t_otc int := resource_utl.get_resource_type_id('KLF')              ;    
 t_tts int := resource_utl.get_resource_type_id('TTS')              ;
 --
procedure add_sta ( p_staff int, p_RESOURCE_TYPE_ID int, p_RESOURCE_ID  int ) is 
begin
   begin
      If p_RESOURCE_TYPE_ID  in (t_arw, t_arc) then  -- пользователь --> АРМ
         Insert into APPLIST_STAFF (ID,CODEAPP,APPROVE,GRANTOR) select p_staff, CODEAPP, 1, gl.aUid from applist where id = p_RESOURCE_ID ;
      elsIf p_RESOURCE_TYPE_ID = t_acc         then  -- пользователь --> группа дост 
         Insert into GROUPS_STAFF  (IDU,IDG,SECG,APPROVE,SEC_SEL,SEC_CRE,SEC_DEB,GRANTOR)  Values (p_staff, p_grantee_id, 7, 1, 1, 1, 1, gl.aUid );
      elsIf p_RESOURCE_TYPE_ID = t_chk         then  -- пользователь --> группа визиров
         Insert into STAFF_CHK     (ID,CHKID,APPROVE,GRANTOR) Values   (p_staff, p_grantee_id, 1, gl.aUid  );
      elsIf p_RESOURCE_TYPE_ID = t_otc         then  -- пользователь --> стат отчет
         Insert into STAFF_KLF00   (id,kodf,a017,approve,GRANTOR) select p_staff, kodf, a017, 1, gl.aUid  from KL_F00$GLOBAL where id = p_RESOURCE_ID  ;
      elsIf p_RESOURCE_TYPE_ID = t_tts         then  -- пользователь --> операцмия
         Insert into STAFF_tts     (id,tt,approve,GRANTOR) select p_staff, tt, 1, gl.aUid  from tts where id = p_RESOURCE_ID  ;
      end if;
   exception when dup_val_on_index then null; 
   end;
end add_sta ;
-----------------------------
begin

   -- добавляем код Артема Юрченко
   resource_utl.set_resource_access_mode(p_grantee_type_id => p_grantee_type_id,
                                         p_grantee_id => p_grantee_id,
                                         p_resource_type_id => p_resource_type_id,
                                         p_resource_id => p_resource_id,
                                         p_access_mode_id => l_default_access_mode_id,
                                         p_approve => true
                                        );

   return;

   -- сохраняем код Татьяны Александровны
   -- Для рол модели
   begin insert into ADM_RESOURCE (GRANTEE_TYPE_ID,   GRANTEE_ID,   RESOURCE_TYPE_ID,   RESOURCE_ID , ACCESS_MODE_ID )
                        values ( p_grantee_type_id, p_grantee_id, p_resource_type_id, p_resource_id , 1 ) ;
   exception when dup_val_on_index then null; 
   end;
--logger.info('ROL-1*'|| p_grantee_type_id ||' , '|| p_grantee_id ||' , '|| p_resource_type_id ||' , '|| p_resource_id);

   gl.aUid := NVL( gl.auId, 1);
 
   -- для админитст по-старому
   If p_grantee_type_id in (t_arw, t_arc )   then
      begin
        If p_resource_type_id = t_rep             then Insert into APP_rep (CODEAPP,CODEREP,APPROVE,GRANTOR)     select codeapp,p_resource_id,1,gl.aUid      from applist where id=p_grantee_id; 
        elsIf p_resource_type_id=t_Ref            then Insert into refAPP  (CODEAPP,TABID,ACODE,APPROVE,GRANTOR) select CODEAPP,p_resource_id,'RO',1,gl.aUid from applist where id=p_grantee_id;
        elsIf p_resource_type_id in (t_Fuw,t_fuc) then Insert into operAPP (CODEAPP,CODEOPER,APPROVE,GRANTOR)    select CODEAPP,p_resource_id,1,gl.aUid      from applist where id=p_grantee_id;
        end if;
      exception when dup_val_on_index then null; 
      end;
      --------------------------
   ElsIf p_grantee_type_id  =  t_rol then -- что-то добавили в роль. надо размножить для всех рольвователей. кот имеют эту роль
      for k in ( select * from ADM_RESOURCE where grantee_type_id = t_sta and resource_type_id = t_rol and resource_id = p_grantee_id)
      loop  add_sta ( k.grantee_id , p_RESOURCE_TYPE_ID, p_RESOURCE_ID );    end loop;

   ElsIf p_grantee_type_id  =  t_sta then -- кому-то дали роль. надо размножить єтому польв все ресурсі роли

      for k in ( select * from ADM_RESOURCE where grantee_type_id = t_rol and grantee_id = p_resource_id )
      loop  add_sta ( p_grantee_id, k.RESOURCE_TYPE_ID, k.RESOURCE_ID );    end loop;

   end if;

end ADD_TO_ROLE;
/
show err;

PROMPT *** Create  grants  ADD_TO_ROLE ***
grant EXECUTE                                                                on ADD_TO_ROLE     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ADD_TO_ROLE.sql =========*** End *
PROMPT ===================================================================================== 
