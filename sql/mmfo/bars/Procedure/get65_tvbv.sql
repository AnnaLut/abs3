

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET65_TVBV.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET65_TVBV ***

  CREATE OR REPLACE PROCEDURE BARS.GET65_TVBV (p_tvbv OUT varchar2) is
begin
  begin
    execute immediate 'SELECT lpad(to_char(depart),3,''0'')
                       FROM   ASVO_65_DEPARTAMENT
                       WHERE  depart in (SELECT min(depart)
                                         FROM   ASVO_65_CARDFILE)'
                       into   p_tvbv;
  exception when others then
    p_tvbv := null;
  end;
end get65_tvbv;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET65_TVBV.sql =========*** End **
PROMPT ===================================================================================== 
