
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dpt_trusty_options.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DPT_TRUSTY_OPTIONS (p_options varchar2) return varchar2
is
 p_result varchar2(1500);
 l_len number;
 l_tmp_str varchar2(500);
begin
  p_result := '';

  l_len := length(p_options);

  for i in 1..l_len loop

          begin
              select  name_option||', '
              into l_tmp_str
              from dpt_dict_trustyoptions
              where id_option = i
              and substr(p_options, i ,1) = 1;
          exception
            when no_data_found
            then     l_tmp_str := '';
          end;

          p_result := p_result ||  l_tmp_str;
  end loop;

  p_result := lower(substr(p_result, 1,length(p_result)-1));
  return p_result;
end;
/
 show err;
 
PROMPT *** Create  grants  DPT_TRUSTY_OPTIONS ***
grant EXECUTE                                                                on DPT_TRUSTY_OPTIONS to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dpt_trusty_options.sql =========***
 PROMPT ===================================================================================== 
 