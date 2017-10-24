create or replace force view v_w4_batches_mmsb as
select t.id, t.name, t.card_code, p.name prodname, t.numbercards, tg.lcv,
       p.ob22, p.tip, t.regdate, st.logname
  from w4_instant_batches t
  join w4_card tt
    on t.card_code = tt.code
  join w4_product p
    on tt.product_code = p.code and p.grp_code = 'INSTANT_MMSB'
  join tabval$global tg
    on p.kv = tg.kv
  join w4_subproduct ws
    on tt.sub_code = ws.code
  join staff$base st
    on t.user_id = st.id;
grant select on V_W4_BATCHES_MMSB to BARS_ACCESS_DEFROLE;