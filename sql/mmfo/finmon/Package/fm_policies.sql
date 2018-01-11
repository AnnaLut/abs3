
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/FINMON/package/fm_policies.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE FINMON.FM_POLICIES IS

procedure set_params(p_MFO varchar2);

function get_fm_policies(obj_schema VARCHAR2, obj_name VARCHAR2) RETURN VARCHAR2;

function get_mfo RETURN VARCHAR2;

function get_branch_id RETURN VARCHAR2;

end;
/
CREATE OR REPLACE PACKAGE BODY FINMON.FM_POLICIES IS

    l_mfo finmon.bank.ust_mfo%type := null;
    l_branch_id finmon.bank.id%type := null;

procedure set_params(p_MFO varchar2)
is 
begin
    select id, ust_mfo
    into l_branch_id, l_mfo
    from finmon.bank
    where ust_mfo = p_MFO;
exception when no_data_found then
    raise_application_error(-20000, 'Не знайдено МФО '||p_MFO);
end;

function get_fm_policies(obj_schema VARCHAR2, obj_name VARCHAR2) RETURN VARCHAR2
is 
begin
  /*if l_mfo is null and sys_context('BARS_CONTEXT', 'USER_MFO') is not null then l_mfo := sys_context('BARS_CONTEXT', 'USER_MFO');
  select id into l_branch_id from finmon.bank where ust_mfo = l_MFO;
  end if;*/
    return case when l_mfo is null then '1=1' else
        case 
            when obj_schema = 'FINMON' THEN case when obj_name = 'BANK' then ' UST_MFO = '''||l_mfo||'''' else ' branch_id = '||l_branch_id end 
            ELSE ' KF = '''||l_mfo||'''' end
    end;
end;

function get_mfo RETURN VARCHAR2
is 
begin
    return l_mfo;
end;


function get_branch_id RETURN VARCHAR2
is 
begin
    return l_branch_id;
end;

--begin
  --if sys_context('BARS_CONTEXT', 'USER_MFO') is not null then set_params(sys_context('BARS_CONTEXT', 'USER_MFO')); end if;
end;
/
 show err;
 
PROMPT *** Create  grants  FM_POLICIES ***
grant EXECUTE                                                                on FM_POLICIES     to BARSREADER_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/FINMON/package/fm_policies.sql =========*** End *
 PROMPT ===================================================================================== 
 