insert into customer_field
  (tag, name, b, u, f, tabname, byisp, type, opt, tabcolumn_check, sqlval,
   code, not_to_edit, hist, parid, u_nrez, f_nrez, f_spd)
  select 'W4KKC', 'W4. Документи клієнта передано до служби соц.захисту(2-ні, 1-так)', 0, 0, 0, null, null, 'N', null,
         null, null, 'BPK', 0, null,
         (select max(parid) + 1 from customer_field), 0, 0, 0
    from dual
   where not exists (select 1 from customer_field where tag = 'W4KKC');
commit;
