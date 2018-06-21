PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_ku_by_nbuc.sql =========*** Run *** ======
PROMPT ===================================================================================== 
 
create or replace function f_get_ku_by_nbuc(p_nbuc varchar2) return varchar2 deterministic parallel_enable
is
  l_result varchar2(10 char);
begin
  begin
    select to_char(to_number(trim(obl)))
      into
     l_result
    from   branch
    where  branch = '/' || p_nbuc || '/';
  exception
    when no_data_found then
      begin
        l_result := to_char(to_number(p_nbuc));
      exception
        when others then
          l_result := p_nbuc;
      end;
    when others then
      logger.error('P_GET_KU_BY_NBUC error get ku for nbuc=' || p_nbuc);
  end;

 return l_result;
end f_get_ku_by_nbuc;
/
show err;
 
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_ku_by_nbuc.sql =========*** End *** ======
PROMPT ===================================================================================== 
 