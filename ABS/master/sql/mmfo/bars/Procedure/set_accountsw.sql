

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_ACCOUNTSW.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_ACCOUNTSW ***

  CREATE OR REPLACE PROCEDURE BARS.SET_ACCOUNTSW (p_acc number ,p_TAG varchar2 ,p_VALUE varchar2)
IS
   l_col number:=-1;
   l_proc_name varchar2(40) := 'Set_accountsw ';
   g_pack_name varchar2(20) := 'REZ_KORR.';
 begin

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: ACC=%s, tag=%s, VALUE=%s',
                                  to_char(p_ACC), p_tag, p_VALUE
                    );


  if p_ACC is null then
    raise_application_error(-20203,'\    Set Accountsw:Не вказан ACC рах.! TAG='||p_TAG||' Значення='||p_VALUE,TRUE);
  end if;
  if p_TAG is null then
    raise_application_error(-20203,'\    Set Accountsw:Для ACC='||p_ACC||' Значення='||p_VALUE||' Не вказан TAG' ,TRUE);
  end if;

  if p_VALUE is null then
    delete from accountsw where acc=p_acc and tag=p_tag;
  else
    update accountsw set value=p_value where acc=p_acc and tag=p_tag ;
--returning count(nd) into l_col;
    IF SQL%ROWCOUNT = 0 then
       insert into accountsw (acc, tag, value) values (p_acc, p_tag, p_value);
    end if;
  end if;


    bars_audit.trace(g_pack_name || l_proc_name || ' TYPE_change='||to_char(l_col)||'Finish.');
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_ACCOUNTSW.sql =========*** End
PROMPT ===================================================================================== 
