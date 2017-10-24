
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/parameter_utl.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PARAMETER_UTL is

    function get_value_for_branch(
        p_param_code in varchar2,
        p_branch_code in varchar2 default sys_context('bars_context', 'user_branch'),
        p_exact_search in char default 'N',
        p_raise_ndf in char default 'N')
    return varchar2;

    function get_value_for_mfo(
        p_param_code in varchar2,
        p_mfo_code in varchar2 default sys_context('bars_context', 'user_mfo'),
        p_raise_ndf in char default 'N')
    return varchar2;

    function get_value_for_bank(
        p_param_code in varchar2,
        p_raise_ndf in char default 'N')
    return varchar2;

    function get_value_from_config(
        p_param_code in varchar2,
        p_raise_ndf in char default 'N')
    return varchar2;

    function get_value(
        p_param_code in varchar2,
        p_branch_code in varchar2 default sys_context('bars_context', 'user_branch'),
        p_raise_ndf in char default 'N')
    return varchar2;

    function get_mfo_list_by_value(
        p_param_code in varchar2,
        p_value in varchar2,
        p_case_sensitive in char default 'Y')
    return string_list;

    function get_branch_list_by_value(
        p_param_code in varchar2,
        p_value in varchar2,
        p_case_sensitive in char default 'Y')
    return string_list;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.PARAMETER_UTL as

    function get_value_for_branch(
        p_param_code in varchar2,
        p_branch_code in varchar2 default sys_context('bars_context', 'user_branch'),
        p_exact_search in char default 'N',
        p_raise_ndf in char default 'N')
    return varchar2
    is
        l_value varchar2(32767 byte);
    begin
        if (p_exact_search = 'N') then
            select min(p.val) keep (dense_rank last order by length(p.branch))
            into   l_value
            from   branch_parameters p
            where  p.tag = p_param_code and
                   p_branch_code like p.branch || '%';
        else
            begin
                select p.val
                into   l_value
                from   branch_parameters p
                where  p.tag = p_param_code and
                       p.branch = p_branch_code;
            exception
                when no_data_found then null;
            end;
        end if;

        if (l_value is null) then
            if (p_raise_ndf = 'N') then
                return l_value;
            else
                raise_application_error(-20000, 'Значення параметра {' || p_param_code || '} для відділення {' || p_branch_code || '} не знайдено');
            end if;
        end if;

        return l_value;
    end;

    function get_value_for_mfo(
        p_param_code in varchar2,
        p_mfo_code in varchar2 default sys_context('bars_context', 'user_mfo'),
        p_raise_ndf in char default 'N')
    return varchar2
    is
        l_value varchar2(32767 byte);
    begin
        select p.val
        into   l_value
        from   params$base p
        where  p.par = p_param_code and
               p.kf = p_mfo_code;

        return l_value;
    exception
        when no_data_found then
             if (p_raise_ndf = 'N') then
                 return null;
             else
                 raise_application_error(-20000, 'Значення параметра {' || p_param_code || '} для МФО {' || p_mfo_code || '} не знайдено');
             end if;
    end;

    function get_value_for_bank(
        p_param_code in varchar2,
        p_raise_ndf in char default 'N')
    return varchar2
    is
        l_value varchar2(32767 byte);
    begin
        select p.val
        into   l_value
        from   params$global p
        where  p.par = p_param_code;

        return l_value;
    exception
        when no_data_found then
             if (p_raise_ndf = 'N') then
                 return null;
             else
                 raise_application_error(-20000, 'Значення глобального параметра {' || p_param_code || '} не знайдено');
             end if;
    end;

    function get_value_from_config(
        p_param_code in varchar2,
        p_raise_ndf in char default 'N')
    return varchar2
    is
        l_value varchar2(32767 byte);
    begin
        select p.val
        into   l_value
        from   web_barsconfig p
        where  p.key = p_param_code;

        return l_value;
    exception
        when no_data_found then
             if (p_raise_ndf = 'N') then
                 return null;
             else
                 raise_application_error(-20000, 'Значення конфігураційного параметра {' || p_param_code || '} не знайдено');
             end if;
    end;

    function get_value(
        p_param_code in varchar2,
        p_branch_code in varchar2 default sys_context('bars_context', 'user_branch'),
        p_raise_ndf in char default 'N')
    return varchar2
    is
        l_value varchar2(32767 byte);
        l_mfo varchar2(6 char);
    begin
        l_value := get_value_for_branch(p_param_code, p_branch_code, p_exact_search => 'N', p_raise_ndf => 'N');

        if (l_value is null) then
            l_mfo := bars_context.extract_mfo(p_branch_code);
            if (l_mfo is not null) then
                l_value := get_value_for_mfo(p_param_code, l_mfo, p_raise_ndf => 'N');
            end if;

            if (l_value is null) then
                l_value := get_value_for_bank(p_param_code, p_raise_ndf => 'N');

                if (l_value is null) then
                    l_value := get_value_from_config(p_param_code, p_raise_ndf => 'N');
                    if (l_value is null) then
                        if (p_raise_ndf = 'N') then
                            return l_value;
                        else
                            raise_application_error(-20000, 'Значення параметра {' || p_param_code || '} для відділення {' || p_branch_code || '} не знайдено');
                        end if;
                    end if;
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_mfo_list_by_value(
        p_param_code in varchar2,
        p_value in varchar2,
        p_case_sensitive in char default 'Y')
    return string_list
    is
        l_mfo_list string_list;
    begin
        select p.kf
        bulk collect into l_mfo_list
        from   params$base p
        where  p.par = p_param_code and
               ((p_case_sensitive = 'Y' and p.val = p_value) or (upper(p.val) = upper(p_value)));

        return l_mfo_list;
    end;

    function get_branch_list_by_value(
        p_param_code in varchar2,
        p_value in varchar2,
        p_case_sensitive in char default 'Y')
    return string_list
    is
        l_branch_list string_list;
    begin
        select p.branch
        bulk collect into l_branch_list
        from   branch_parameters p
        where  p.tag = p_param_code and
               ((p_case_sensitive = 'Y' and p.val = p_value) or (upper(p.val) = upper(p_value)));

        return l_branch_list;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/parameter_utl.sql =========*** End *
 PROMPT ===================================================================================== 
 