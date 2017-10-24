

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DEL_FROM_ROLE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DEL_FROM_ROLE ***

  CREATE OR REPLACE PROCEDURE BARS.DEL_FROM_ROLE ---DROP_ROLE
     ( p_grantee_type_id  in integer,
       p_grantee_id       in integer,
       p_resource_type_id in integer,
       p_resource_id      in integer  
    ) is
-- Временный заменитель процедуры пакеджа - УДАЛЕНИЕ связей
-- resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id('STAFF_ROLE'), :RI, resource_utl.get_resource_type_id('ARM_WEB'), :ID, 0, TRUE ) 
-- 16.01.2017 Юрченко Артем - добавлен вызов процедуры
    l_rt0 int ;     l_rt1 int ;
begin

 If p_grantee_type_id is null and p_grantee_id is null and p_resource_type_id is null and  p_resource_id is null then

    ------------------------------------------------------------------------------------------------------------------------------
    -- Разорвать связь : ................ -------> НЕСУЩ.Роль     
    l_rt1 := resource_utl.get_resource_type_id('STAFF_ROLE');
    delete from ADM_RESOURCE B where B.RESOURCE_TYPE_ID = l_rt1 and not exists (select 1 from STAFF_ROLE where b.RESOURCE_ID = id );

    -- Разорвать связь : НЕСУЩ.Роль       -------> ..................
    delete from ADM_RESOURCE b where b.GRANTEE_TYPE_ID  = l_rt1 and not exists (select 1 from STAFF_ROLE where b.GRANTEE_ID  = id );
    ------------------------------------------------------------------------------------------------------------------------------
    l_rt1 := resource_utl.get_resource_type_id('ARM_WEB'     );   
    l_rt0 := resource_utl.get_resource_type_id('ARM_CENTURA' );

    -- Разорвать связь : ................ -------> НЕСУЩ.АРМ_Сен/Веб
    delete from ADM_RESOURCE b where b.RESOURCE_TYPE_ID in (l_rt1,l_rt0) and not exists (select 1 from applist where b.RESOURCE_ID = id );

    -- Разорвать связь : НЕСУЩ.АРМ_Сен/Веб -------> ..................
    delete from ADM_RESOURCE b where b.GRANTEE_TYPE_ID  in (l_rt1,l_rt0) and not exists (select 1 from applist where b.GRANTEE_ID = id );
    ----------------------------------------------------------------------------------------------------------------------------------
    l_rt1 := resource_utl.get_resource_type_id('FUNCTION_WEB');   l_rt0 := resource_utl.get_resource_type_id('FUNCTION_CENTURA' );

    -- Разорвать связь : ................ -------> НЕСУЩ.Функц_Сен/Веб
    delete from ADM_RESOURCE B where B.RESOURCE_TYPE_ID in (l_rt1,l_rt0) and not exists (select 1 from operlist where b.RESOURCE_ID = codeoper);

    -- Разорвать связь : НЕСУЩ.Фун_Сен/Веб -------> ..................
    delete from ADM_RESOURCE b where b.GRANTEE_TYPE_ID  in (l_rt1,l_rt0) and not exists (select 1 from operlist where b.GRANTEE_ID = codeoper );
    ----------------------------------------------------------------------------------------------------------------------------------
    -- Разорвать связь : ................ -------> НЕСУЩ.Справочник   
    l_rt1 := resource_utl.get_resource_type_id('DIRECTORIES' );
    delete from ADM_RESOURCE B where B.RESOURCE_TYPE_ID = l_rt1 and not exists (select 1 from references where b.RESOURCE_ID = tabid);
    ----------------------------------------------------------------------------------------------------------------------------------
    -- Разорвать связь : ................ -------> НЕСУЩ.Отчет   
    l_rt1 := resource_utl.get_resource_type_id('REPORTS'     );
    delete from ADM_RESOURCE B where B.RESOURCE_TYPE_ID = l_rt1 and not exists (select 1 from reports where b.RESOURCE_ID = id);
    ----------------------------------------------------------------------------------------------------------------------------------
    -- Разорвать связь : ................ -------> НЕСУЩ.Грп-Контроля 
    l_rt1 := resource_utl.get_resource_type_id('CHKLIST'     );
    delete from ADM_RESOURCE B where B.RESOURCE_TYPE_ID = l_rt1 and not exists (select 1 from CHKLIST where b.RESOURCE_ID = idchk);
    ----------------------------------------------------------------------------------------------------------------------------------
    -- Разорвать связь : ................ -------> НЕСУЩ.Грп-Доступа 
    l_rt1 := resource_utl.get_resource_type_id('ACCOUNT_GROUP');
    delete from ADM_RESOURCE B where B.RESOURCE_TYPE_ID = l_rt1 and not exists (select 1 from GROUPS where b.RESOURCE_ID = id);
    ----------------------------------------------------------------------------------------------------------------------------------
    -- Разорвать связь : ................ -------> НЕСУЩ.Отч.файл 
    l_rt1 := resource_utl.get_resource_type_id('KLF');
    delete from ADM_RESOURCE B where B.RESOURCE_TYPE_ID = l_rt1 and not exists (select 1 from KL_F00$GLOBAL where b.RESOURCE_ID = id);
    ----------------------------------------------------------------------------------------------------------------------------------
    -- Разорвать связь : ................ -------> НЕСУЩ.Операция 
    l_rt1 := resource_utl.get_resource_type_id('TTS');
    delete from ADM_RESOURCE B where B.RESOURCE_TYPE_ID = l_rt1 and not exists (select 1 from TTS where b.RESOURCE_ID = id);
    ----------------------------------------------------------------------------------------------------------------------------------
    -- Разорвать связь : НЕСУЩ.пользоват  -------> ..................
    l_rt1 := resource_utl.get_resource_type_id('STAFF_USER');
    delete from ADM_RESOURCE b where b.GRANTEE_TYPE_ID  = l_rt1 and not exists (select 1 from STAFF$BASE where b.GRANTEE_ID  = id );
 else

    -- добавляем код Артема Юрченко
    resource_utl.revoke_resource_access(p_grantee_type_id => p_grantee_type_id,
                                        p_grantee_id   => p_grantee_id,
                                        p_resource_type_id => p_resource_type_id,
                                        p_resource_id => p_resource_id,
                                        p_approve     => TRUE 
                                       );
    return;

    -- сохраняем код Татьяны Александровны
    delete from ADM_RESOURCE where grantee_type_id  = p_grantee_type_id  and
                                   grantee_id       = p_grantee_id       and 
                                   resource_type_id = p_resource_type_id and 
                                   resource_id      = p_resource_id      ;


 end if ;

 commit;

end DEL_FROM_ROLE;
/
show err;

PROMPT *** Create  grants  DEL_FROM_ROLE ***
grant EXECUTE                                                                on DEL_FROM_ROLE   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DEL_FROM_ROLE.sql =========*** End
PROMPT ===================================================================================== 
