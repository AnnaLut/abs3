
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/visa_kd9819_nd.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VISA_KD9819_ND (
    l_ref   in oper.ref%type
    ) return integer is
    l_num   integer;
begin
    select 1
    into l_num
    from operw
    where ref=l_ref and TAG ='ND';
    return 1;
exception when no_data_found then
    return 0;
end VISA_KD9819_ND;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/visa_kd9819_nd.sql =========*** End
 PROMPT ===================================================================================== 
 