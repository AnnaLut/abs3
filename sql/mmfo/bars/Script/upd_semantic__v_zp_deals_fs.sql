PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/script/upd_semantic__v_zp_deals_fs.sql =========*** Run *** ===
PROMPT ===================================================================================== 

PROMPT *** upd_semantic__v_zp_deals_fs ***

begin
  execute immediate 'update meta_tables set semantic = replace(semantic, ''6110'', ''6510'') where tabname in (''V_ZP_DEALS_FS'') and instr(semantic, ''6110'')>0';
end;
/
commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/script/upd_semantic__v_zp_deals_fs.sql =========*** End *** ===
PROMPT ===================================================================================== 
