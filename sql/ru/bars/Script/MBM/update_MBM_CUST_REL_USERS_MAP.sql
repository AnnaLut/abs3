begin
    declare 
        l_version varchar2(100) := null;
    begin
        select parameter_value into l_version 
        from mbm_parameters
        where parameter_name = 'Version';
        exception when no_data_found then null;
        if l_version is null then
            update MBM_CUST_REL_USERS_MAP set 
                IS_APPROVED = 1
            where 
                user_id is not null;
        end if;
    end;    
end;
/ 
