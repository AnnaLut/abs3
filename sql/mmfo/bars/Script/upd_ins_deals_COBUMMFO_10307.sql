PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Script/upd_ins_deals_COBUMMFO_10307.sql =========*** Run *** ===
PROMPT ===================================================================================== 

-- в рамках оптимізації добавлено поле ext_deal_id - id договору зовнішньої системи
begin
  update bars.ins_deals d set ext_deal_id = (select val from bars.ins_deal_attrs a where a.deal_id = d.id and a.attr_id = 'EXT_SYSTEM' and a.kf = d.kf) where ext_deal_id is null;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Script/upd_ins_deals_COBUMMFO_10307.sql =========*** End *** ===
PROMPT =====================================================================================
