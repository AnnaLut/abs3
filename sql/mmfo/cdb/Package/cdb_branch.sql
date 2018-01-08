
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_branch.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_BRANCH is

    BRANCH_CODE_CENTRAL_APPARAT    constant varchar(6 char) := '300465';

    function read_branch(p_branch_id in integer, p_raise_ndf in boolean default true) return branch%rowtype;
    function read_branch(p_branch_code in varchar2, p_raise_ndf in boolean default true) return branch%rowtype;

    function create_branch(p_branch_code in varchar2, p_branch_name in varchar2) return integer;

    function get_branch_id(p_branch_code in varchar2) return integer;
    function get_branch_code(p_branch_id in integer) return varchar2;
    function get_branch_name(p_branch_id in integer) return varchar2;

    function get_branch_customer(p_base_branch_id in integer, p_branch_id in integer) return integer;
    function get_branch_transit_account(p_base_branch_id in integer, p_branch_id in integer) return integer;
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_BRANCH as

    function read_branch(p_branch_id in integer, p_raise_ndf in boolean default true)
    return branch%rowtype
    is
        l_branch_row branch%rowtype;

    begin
        select *
        into   l_branch_row
        from   branch b
        where  b.id = p_branch_id;

        return l_branch_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(cdb_exception.NO_DATA_FOUND,
                                         'Філіал з ідентифікатором {' || p_branch_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_branch(p_branch_code in varchar2, p_raise_ndf in boolean default true)
    return branch%rowtype
    is
        l_branch_row branch%rowtype;
    begin
        select *
        into   l_branch_row
        from   branch b
        where  b.branch_code = p_branch_code;

        return l_branch_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(cdb_exception.NO_DATA_FOUND,
                                         'Філіал з кодом {' || p_branch_code || '} не знайдений');
             else return null;
             end if;
    end;

    function create_branch(p_branch_code in varchar2, p_branch_name in varchar2)
    return integer
    is
        l_branch_id integer;
    begin
        insert into branch
        values (branch_seq.nextval, p_branch_code, p_branch_name)
        returning id
        into l_branch_id;

        return l_branch_id;
    end;

    function get_branch_id(p_branch_code in varchar2)
    return integer
    is
    begin
        return read_branch(p_branch_code, false).id;
    end;

    function get_branch_code(p_branch_id in integer)
    return varchar2
    is
    begin
        return read_branch(p_branch_id, false).branch_code;
    end;

    function get_branch_name(p_branch_id in integer)
    return varchar2
    is
    begin
        return read_branch(p_branch_id, false).branch_name;
    end;

    function get_branch_customer(p_base_branch_id in integer, p_branch_id in integer)
    return integer
    is
        l_customer_id integer;
    begin
        select bc.customer_id
        into   l_customer_id
        from   branch_in_branch_settings bc
        where  bc.base_branch_id = p_base_branch_id and
               bc.branch_id = p_branch_id;

        return l_customer_id;
    exception
        when no_data_found then
             return null;
    end;

    function get_branch_transit_account(p_base_branch_id in integer, p_branch_id in integer)
    return integer
    is
        l_transit_account_id integer;
    begin
        select bc.transit_account_id
        into   l_transit_account_id
        from   branch_in_branch_settings bc
        where  bc.base_branch_id = p_base_branch_id and
               bc.branch_id = p_branch_id;

        return l_transit_account_id;
    exception
        when no_data_found then
             return null;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_branch.sql =========*** End *** =
 PROMPT ===================================================================================== 
 