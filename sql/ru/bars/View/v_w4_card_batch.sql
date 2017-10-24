create or replace force view v_w4_card_batch
(code, product_code, sub_code, sub_name)
as
select c.code,  c.product_code,   c.sub_code,   s.name
    from w4_card c, w4_subproduct s
where     c.sub_code = s.code
      and nvl (c.date_open, bankdate) <= bankdate
      and nvl (c.date_close, bankdate + 1) > bankdate;
grant select on V_W4_CARD_BATCH to BARS_ACCESS_DEFROLE;


