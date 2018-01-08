

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_RI.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_RI ***

  CREATE OR REPLACE PROCEDURE BARS.GET_RI 
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :    GET_RI.sql
% DESCRIPTION :    Заповнення інформації про інсайдерів з XML
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     :    08/08/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
is
begin
    -- для физ.лиц с кодом (по коду и документу) з урахуванням випадку, коли не вказано документу в АБС
    for m in (select c.rnk,
                     c.branch,
                     c.custtype,
                     c.okpo,
                     p.passp,
                     p.ser,
                     p.numdoc,
                     r.k060 as prinsider,
                     r.insform as insfo,
                     c.prinsider as prinsider_before,
                     to_number(w.value) as insfo_before
              from   customer c
              left join person p on c.rnk = p.rnk
              left join customerw w on c.rnk = w.rnk and w.tag = 'INSFO'
              left join customer_ri r on c.okpo = r.idcode and nvl(p.passp, r.doct) = r.doct and nvl(p.ser, r.docs) = r.docs and nvl(p.numdoc, r.docn) = r.docn
              where c.date_off is null and
                    c.custtype = 3 and
                    c.codcagent in (3, 5) and
                    r.idcode <> '0000000000' and
                    length(r.idcode) = 10 and
                    r.doct is not null and r.docs is not null and r.docn is not null

              union all
              -- для физ.лиц с кодом (по коду и документу) для випадку, коли документ має номер, але немає серії (наприклад, паспорт-ID картка)
              select c.rnk, c.branch, c.custtype, c.okpo, p.passp, p.ser, p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
              from customer c
              left join person p on c.rnk = p.rnk
              left join customerw w on c.rnk = w.rnk and w.tag = 'INSFO'
              left join customer_ri r on c.okpo = r.idcode and nvl(p.passp, r.doct) = r.doct and nvl(p.numdoc, r.docn) = r.docn
              where c.date_off is null and
                    c.custtype = 3 and
                    c.codcagent in (3,5) and
                    r.idcode <> '0000000000' and
                    length(r.idcode) = 10 and
                    r.doct is not null and r.docs is null and r.docn is not null
              union all
              -- для физ.лиц с кодом (по коду и документу) для випадку, якщо код в АБС дорівнює '0000000000' або '000000000'
              select c.rnk, c.branch, c.custtype, c.okpo, p.passp, p.ser, p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
              from   customer c
              left join person p on c.rnk = p.rnk
              left join customerw w on c.rnk = w.rnk and w.tag = 'INSFO'
              left join customer_ri r on p.passp = r.doct and p.ser = r.docs and p.numdoc = r.docn
              where c.date_off is null and
                    c.custtype = 3 and
                    c.codcagent in (3,5) and
                    c.OKPO in ('0000000000', '000000000') and
                    r.idcode <> '0000000000' and
                    length(r.idcode) = 10 and
                    r.doct is not null and r.docs is not null and r.docn is not null

              union all
              -- для физ.лиц без кода (по документу)
              select c.rnk, c.branch, c.custtype, c.okpo, p.passp, p.ser, p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
              from   customer c
              left join person p on c.rnk = p.rnk
              left join customerw w on c.rnk = w.rnk and w.tag = 'INSFO'
              left join customer_ri r on p.passp = r.doct and p.ser = r.docs and p.numdoc = r.docn
              where c.date_off is null and
                    c.custtype = 3 and
                    c.codcagent in (3, 5) and
                    r.idcode = '0000000000' and
                    r.doct is not null and r.docs is not null and r.docn is not null

              union all
              -- для физ.лиц з кодом (только по коду)
              select c.rnk, c.branch,c.custtype,c.okpo,p.passp,p.ser,p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
              from customer c
              left join person p on c.rnk = p.rnk
              left join customerw w on c.rnk=w.rnk and w.tag = 'INSFO'
              left join customer_ri r on c.okpo = r.idcode
              where c.date_off is null and
                    c.custtype = 3 and
                    c.codcagent in (3, 5) and
                    r.idcode <> '0000000000' and length(r.idcode) = 10 and
                    r.doct is null and r.docs is null and r.docn is null

              union all
              -- для юр.лиц
              select c.rnk, c.branch, c.custtype, c.okpo, p.passp, p.ser, p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
              from customer c
              left join person p on c.rnk = p.rnk
              left join customerw w on c.rnk = w.rnk and w.tag = 'INSFO'
              left join customer_ri r on c.okpo = r.idcode
              where c.date_off is null and
                    c.custtype = 2 and
                    c.codcagent in (3, 5) and
                    length(r.idcode) = 8)
    loop
        insert into tmp_ri_cust(rnk, branch, custtype, okpo, passp, ser, numdoc, prinsider, insfo, prinsider_before, insfo_before)
        values (m.rnk, m.branch, m.custtype, m.okpo, m.passp, m.ser, m.numdoc, m.prinsider, m.insfo, m.prinsider_before, m.insfo_before);
    end loop;

    --додаємо клієнтів, що втратили ознаку пов"язаності(не є інсайдерами)
    for m in (select c.rnk, c.branch,c.custtype,c.okpo,p.passp,p.ser,p.numdoc,99 as prinsider, null as insfo,c.prinsider as prinsider_before,w.value as insfo_before
              from customer c
              left join person p on c.rnk=p.rnk
              left join customerw w on c.rnk=w.rnk and w.tag='INSFO'
              where c.rnk not in (select rnk from tmp_ri_cust) and
                    c.date_off is null and
                    c.custtype in (2, 3) and
                    c.codcagent in (3, 5) and
                    c.prinsider <> 99)
    loop
        insert into tmp_ri_cust(rnk, branch, custtype, okpo, passp, ser, numdoc, prinsider, insfo, prinsider_before, insfo_before)
        values (m.rnk, m.branch, m.custtype, m.okpo, m.passp, m.ser, m.numdoc, m.prinsider, m.insfo, m.prinsider_before, m.insfo_before);
    end loop;

    --видаляємо ті записи в тимчасовій таблиці, що не змінилися
    delete from tmp_ri_cust
    where prinsider = prinsider_before and nvl(insfo, -1) = nvl(insfo_before, -1);

    --вносимо зміни в таблицю customer
    for m in (select rnk, prinsider from tmp_ri_cust where prinsider <> prinsider_before)
    loop
        update customer set prinsider = m.prinsider where rnk = m.rnk;
    end loop;

    --вносимо зміни в таблицю customerw
    update customerw cw
    set value = (select to_char(tc.insfo) from tmp_ri_cust tc where cw.rnk=tc.rnk)
    where  cw.rnk in (select tc.rnk from tmp_ri_cust tc where tc.insfo is not null and tc.insfo_before is not null and tc.insfo<>tc.insfo_before) and cw.tag='INSFO';

    merge into customerw c
    using (select distinct tc.rnk, 'INSFO' tag, tc.insfo val, user_id isp
           from   tmp_ri_cust tc
           where  tc.insfo_before is null and
                  tc.insfo is not null) p
    on (c.rnk = p.rnk and
        c.tag = p.tag)
    when matched then
         update set c.value = p.val, c.isp = p.isp
    when not matched then
         insert (c.rnk, c.tag, c.value, c.isp)
         values (p.rnk, p.tag, p.val  , p.isp);

    delete from customerw cw
    where cw.rnk in (select tc.rnk from tmp_ri_cust tc where tc.insfo_before is not null and tc.insfo is null) and cw.tag='INSFO';
end get_ri;
/
show err;

PROMPT *** Create  grants  GET_RI ***
grant EXECUTE                                                                on GET_RI          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_RI          to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_RI.sql =========*** End *** ==
PROMPT ===================================================================================== 
