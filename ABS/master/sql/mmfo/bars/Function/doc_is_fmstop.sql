
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/doc_is_fmstop.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DOC_IS_FMSTOP (p_ref number, p_nazn varchar2)
return number
is
  l_otm  number;
begin
  -- проверка на блокировку
  begin
    select otm into l_otm from fm_ref_que where ref=p_ref;
    return l_otm;
  exception when no_data_found then null;
  end;

  -- проверка на вхождение в справочник террористов
  l_otm := f_istr(p_nazn);
  if l_otm > 0 then
    fm_blockdoc(p_ref, l_otm);
    return l_otm;
  end if;

  return 0;
end;
/
 show err;
 
PROMPT *** Create  grants  DOC_IS_FMSTOP ***
grant EXECUTE                                                                on DOC_IS_FMSTOP   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/doc_is_fmstop.sql =========*** End 
 PROMPT ===================================================================================== 
 