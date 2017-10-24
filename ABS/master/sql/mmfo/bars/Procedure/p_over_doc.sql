

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OVER_DOC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OVER_DOC ***

  CREATE OR REPLACE PROCEDURE BARS.P_OVER_DOC (p_ number)
is

TYPE t_rid_type is  table of rowid INDEX BY BINARY_INTEGER;
TYPE t_err_type is  table of varchar2(3) INDEX BY BINARY_INTEGER;
TYPE t_dt_type is  table of date INDEX BY BINARY_INTEGER;

t_rid t_rid_type;
t_err t_err_type;
t_dt t_dt_type;
t_rid_null t_rid_type;
t_err_null t_err_type;
t_dt_null t_dt_type;

err varchar2(1000);



begin
    --вставка новых договоров у которых поменялась и дата начала и дата окончания
  /*  select d.rowid rid
    bulk collect into t_rid
    from acc_over o,
         accounts a1,
         accounts a2,
         acc_over_deal d
    where o.acc = a1.acc and o.acco = a2.acc  and a2.nbs = '8025'  and a1.mdate is not null and o.datd is not null
          and o.acc = d.acc and o.acco = d.acco and (o.datd <> d.DAT and a1.mdate <> d.dat2) and d.STATUS is null
          and not (o.datd < d.dat2) and not(o.datd >= a1.mdate)
    ;*/
    --если новая дата начала меньше-равна старой даты окончания - ставим старому договору признак - ПЕРЕОФОРМЛЕН (PER)
    --и по старому договору заменяем дату окончания на дату начала нового договора
    select d.rowid r, (case when o.datd <= d.dat2 then 'PER' else 'OLD' end) c,
            (case when o.datd <= d.dat2 then o.datd else d.dat2 end) d
    bulk collect into t_rid,t_err,t_dt
    from acc_over o,
         accounts a1,
         accounts a2,
         acc_over_deal d
    where o.acc = a1.acc and o.acco = a2.acc  and a2.nbs = '8025'  and a1.mdate is not null and o.datd is not null
          and o.acc = d.acc and o.acco = d.acco and (o.datd <> d.DAT and a1.mdate <> d.dat2) and d.STATUS is null
          and /*not (o.datd < d.dat2) --and */ not(o.datd >= a1.mdate)
    ;

    insert into  acc_over_deal
    select o.acc,a1.nls, o.acco,a2.nls, o.datd, a1.mdate, o.nd --null err, d.*
           ,(case --when o.datd < d.dat2 then 'ER1'
                  when o.datd >= a1.mdate then 'ER2'
                else null
           end)  st , gl.bd
           --, d.rowid rid
    from acc_over o,
         accounts a1,
         accounts a2,
         acc_over_deal d
    where o.acc = a1.acc and o.acco = a2.acc  and a2.nbs = '8025'  and a1.mdate is not null and o.datd is not null
          and o.acc = d.acc and o.acco = d.acco and (o.datd <> d.DAT and a1.mdate <> d.dat2) and d.STATUS is null
          --не существует такой же записи за другую дату.
          --для ошибочных договоров(STATUS is not null), чтобы не появлялись за каждую дату одинаковые записи
          and not exists (select 1 from acc_over_deal d1
                          where d1.acc = o.acc and d1.acco = o.acco and d1.dat = o.datd
                                and d1.dat2 = a1.mdate and d1.nd = o.nd
                                and d1.status = (case when o.datd >= a1.mdate then 'ER2'
                                                      else null
                                                 end)
                         )
    ;
    err := '1. НОВЫЕ = '||sql%rowcount;
    dbms_output.put_line(err);

    --предыдущим договорам ставим признак "старый""/"переоформленный"
     IF t_rid.COUNT () <> 0
         THEN
            FORALL i IN  t_rid.first .. t_rid.last
            UPDATE acc_over_deal d
            SET d.status = t_err(i),
                d.dat2 = t_dt(i)
            WHERE d.ROWID = t_rid(i);

            err := err||' 2. СТАРЫЕ = '||sql%rowcount;
            dbms_output.put_line(err);
     END IF;
    --returning o.acc into t_acc;

    t_rid := t_rid_null;

    --вставка новых договоров у которых поменялась только одна дата
    select d.rowid rid
           bulk collect into t_rid
    from acc_over o,
         accounts a1,
         accounts a2,
         acc_over_deal d
    where o.acc = a1.acc and o.acco = a2.acc  and a2.nbs = '8025'  and a1.mdate is not null and o.datd is not null
          and o.acc = d.acc and o.acco = d.acco and ((o.datd <> d.DAT and a1.mdate = d.dat2) or (o.datd = d.DAT and a1.mdate <> d.dat2))
          and d.STATUS is null
          and not (o.datd < d.dat2 and o.datd <> d.dat and a1.mdate <> d.dat2)
          and not (o.datd >= a1.mdate)
    ;

    insert into  acc_over_deal
    select o.acc,a1.nls, o.acco,a2.nls, o.datd, a1.mdate, o.nd --null err, d.*
           ,(case when o.datd < d.dat2 and o.datd <> d.dat and a1.mdate <> d.dat2 then 'ER1'
                  when o.datd >= a1.mdate  then 'ER2'
                else null
           end)  st  , gl.bd
           --, d.rowid rid
    from acc_over o,
         accounts a1,
         accounts a2,
         acc_over_deal d
    where o.acc = a1.acc and o.acco = a2.acc  and a2.nbs = '8025'  and a1.mdate is not null and o.datd is not null
          and o.acc = d.acc and o.acco = d.acco and ((o.datd <> d.DAT and a1.mdate = d.dat2) or (o.datd = d.DAT and a1.mdate <> d.dat2))
          and d.STATUS is null
          --не существует такой же записи за другую дату.
          --для ошибочных договоров(STATUS is not null), чтобы не появлялись за каждую дату одинаковые записи
          and not exists (select 1 from acc_over_deal d1
                          where d1.acc = o.acc and d1.acco = o.acco and d1.dat = o.datd
                                and d1.dat2 = a1.mdate and d1.nd = o.nd
                                and d1.status = (case when o.datd >= a1.mdate then 'ER2'
                                                      else null
                                                 end)
                         )
    ;
    err := err||' 3. ЧАСТИЧНО НОВЫЕ = '||sql%rowcount;
    dbms_output.put_line(err);

    --предыдущим договорам ставим признак "ошибочный""
    IF t_rid.COUNT () <> 0
         THEN
            FORALL i IN  t_rid.first .. t_rid.last
            UPDATE acc_over_deal d
            SET d.status = 'ER3'
            WHERE d.ROWID = t_rid(i);
            err := err||' 4. ОШИБОЧНЫЕ = '||sql%rowcount;
            dbms_output.put_line(err);
    END IF;

    t_rid := t_rid_null;
    t_err := t_err_null;
    t_dt := t_dt_null;

    update acc_over_deal_hist
    set result = err
    where dt = gl.bd
    ;
    if sql%rowcount = 0 then
      insert into acc_over_deal_hist (dt, result) values (gl.bd, err);
    end if;

exception when others then
   err := substr(sqlerrm,1,1000);

   update acc_over_deal_hist
    set result = err
    where dt = gl.bd
    ;
    if sql%rowcount = 0 then
      insert into acc_over_deal_hist (dt, result) values (gl.bd, err);
    end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OVER_DOC.sql =========*** End **
PROMPT ===================================================================================== 
