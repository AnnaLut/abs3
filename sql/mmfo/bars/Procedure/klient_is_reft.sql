

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KLIENT_IS_REFT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KLIENT_IS_REFT ***

  CREATE OR REPLACE PROCEDURE BARS.KLIENT_IS_REFT (dat_ date)
-- проверка клиентов на вхождение в справочник террористов
/*lypskykh 06.01.2017: Добавлена проверка связанных лиц для юридических лиц*/
is
   l_id number;
   l_bdate date := bankdate_g;
   l_kf varchar2(6) := sys_context('bars_context', 'user_mfo');
begin
   delete from fm_klient;
   for k in (select /*+ parallel(8)*/ rnk, nmk, nmkk, nmkv, fr1.c1 as c1, null as c2, null as c3, null as rel_rnk, null as rel_intext
              from customer c,
                   FINMON_REFT_AKALIST fr1
              where (date_off is null or date_off > l_bdate)
              and fr1.name_hash = f_fm_hash(c.nmk)
              union all
              select /*+ parallel(8)*/ rnk, nmk, nmkk, nmkv, null as c1, fr2.c1 as c2, null as c3, null as rel_rnk, null as rel_intext
              from customer c,
                   FINMON_REFT_AKALIST fr2
              where (date_off is null or date_off > l_bdate)
              and fr2.name_hash = f_fm_hash(c.nmkk)
              union all
              select /*+ parallel(8)*/ rnk, nmk, nmkk, nmkv, null as c1, null as c2, fr3.c1 as c3, null as rel_rnk, null as rel_intext
              from customer c,
                   FINMON_REFT_AKALIST fr3
              where (date_off is null or date_off > l_bdate)
              and fr3.name_hash = f_fm_hash(c.nmkv)

              union all

              /*проверяем юрлица и их связанные лица*/

              select /*+ parallel(8)*/ c.rnk, c.nmk, c.nmkk, c.nmkv, fr1.c1 as c1, null as c2, null as c3, r.rel_rnk as rel_rnk, 1 as rel_intext
              from customer c,
                   customer_rel r,
                   customer cr,
                   FINMON_REFT_AKALIST fr1
              where (c.date_off is null or c.date_off > l_bdate)
              and c.custtype = 2
              and c.rnk = r.rnk
              and r.rel_intext = 1
              and cr.rnk = r.rel_rnk
              and fr1.name_hash = f_fm_hash(cr.nmk)

              union all

              select /*+ parallel(8)*/ c.rnk, c.nmk, c.nmkk, c.nmkv, null as c1, fr2.c1 as c2, null as c3, r.rel_rnk as rel_rnk, 1 as rel_intext
              from customer c,
                   customer_rel r,
                   customer cr,
                   FINMON_REFT_AKALIST fr2
              where (c.date_off is null or c.date_off > l_bdate)
              and c.custtype = 2
              and c.rnk = r.rnk
              and r.rel_intext = 1
              and cr.rnk = r.rel_rnk
              and fr2.name_hash = f_fm_hash(cr.nmkk)

              union all

              select /*+ parallel(8)*/ c.rnk, c.nmk, c.nmkk, c.nmkv, null as c1, null as c2, fr3.c1 as c3, r.rel_rnk as rel_rnk, 1 as rel_intext
              from customer c,
                   customer_rel r,
                   customer cr,
                   FINMON_REFT_AKALIST fr3
              where (c.date_off is null or c.date_off > l_bdate)
              and c.custtype = 2
              and c.rnk = r.rnk
              and r.rel_intext = 1
              and cr.rnk = r.rel_rnk
              and fr3.name_hash = f_fm_hash(cr.nmkv)

              union all

              /*не-клиенты - проверяем по единственному полю*/
              select /*+ parallel(8)*/ c.rnk, c.nmk, c.nmkk, c.nmkv, null as c1, null as c2, fr3.c1 as c3, r.rel_rnk as rel_rnk, 0 as rel_intext
              from customer c,
                   customer_rel r,
                   customer_extern cre,
                   FINMON_REFT_AKALIST fr3
              where (c.date_off is null or c.date_off > l_bdate)
              and c.custtype = 2
              and c.rnk = r.rnk
              and r.rel_intext = 0
              and r.rel_rnk = cre.id
              and fr3.name_hash = f_fm_hash(cre.name)

)
   loop
      begin
        if k.c1 is not null then
           insert into fm_klient (rnk, kod, dat, rel_rnk, rel_intext, kf) values (k.rnk, k.c1, trunc(sysdate), k.rel_rnk, k.rel_intext, l_kf);
        elsif k.c2 is not null then
           insert into fm_klient (rnk, kod, dat, rel_rnk, rel_intext, kf) values (k.rnk, k.c2, trunc(sysdate), k.rel_rnk, k.rel_intext, l_kf);
        elsif k.c3 is not null then
           insert into fm_klient (rnk, kod, dat, rel_rnk, rel_intext, kf) values (k.rnk, k.c3, trunc(sysdate), k.rel_rnk, k.rel_intext, l_kf);
        end if;
      exception when dup_val_on_index then null;
      end;
   end loop;
end;
/
show err;

PROMPT *** Create  grants  KLIENT_IS_REFT ***
grant EXECUTE                                                                on KLIENT_IS_REFT  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KLIENT_IS_REFT  to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KLIENT_IS_REFT.sql =========*** En
PROMPT ===================================================================================== 
