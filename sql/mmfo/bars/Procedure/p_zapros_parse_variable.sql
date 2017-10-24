

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAPROS_PARSE_VARIABLE.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAPROS_PARSE_VARIABLE ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAPROS_PARSE_VARIABLE (p_kodz number)
is
    l_bindvars ZAPROS.BINDVARS%type;
    l_length number;
    l_tag varchar2(32767);
    l_name varchar2(32767);
    l_tmp varchar2(32767);
    l_str varchar2(32767);
      procedure parse_str(p_str varchar2, p_tag out varchar2, p_name out varchar2)
        is
        begin
          p_tag := substr(p_str,0,instr(p_str,'=')-1);
          p_name := substr(p_str,instr(p_str,'=')+1);
        end;

begin
delete from tmp_zapros_variable where kodz=p_kodz and userid=user_id();

    select Z.BINDVARS into l_bindvars
    from zapros z
    where z.kodz=p_kodz;
 if l_bindvars is not null then
                  l_length := length(l_bindvars) - length(replace(l_bindvars,','))+1;
                  l_str :=l_bindvars;
                  for i in 0..l_length - 1 loop
                   if i!=l_length - 1 then
                    l_tmp := substr(l_str, 0, instr(l_str,',')-1);
                    l_str := substr(l_str, instr(l_str,',')+1);
                   else
                    l_tmp := substr(l_str, 0);
                   end if;
                    parse_str(l_tmp,l_tag,l_name);
                    insert into tmp_zapros_variable(tag, name, userid, kodz)
                        values(l_tag, l_name, user_id, p_kodz);
                  end loop;
         end if;
end;
/
show err;

PROMPT *** Create  grants  P_ZAPROS_PARSE_VARIABLE ***
grant EXECUTE                                                                on P_ZAPROS_PARSE_VARIABLE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAPROS_PARSE_VARIABLE.sql ======
PROMPT ===================================================================================== 
