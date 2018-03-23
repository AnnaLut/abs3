 declare
    l_sp_id  w4_sparam.sp_id%type := 2;
    l_value  w4_sparam.value%type := '3';
    l_nbs    w4_sparam.nbs%type   := '3570';
begin
    merge into w4_sparam t
    using (select code, tip from w4_product_groups, w4_tips) s
    on (t.grp_code = s.code and
        t.tip = s.tip and
        t.nbs = l_nbs and
        t.sp_id = l_sp_id)
    when matched then update
         set t.value = l_value
    when not matched then insert
         values (s.code, s.tip, l_nbs, l_sp_id, l_value);
 
    commit;
end;
/
 