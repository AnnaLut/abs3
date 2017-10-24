

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MFK_ACCP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MFK_ACCP ***

  CREATE OR REPLACE PROCEDURE BARS.P_MFK_ACCP (p_dat date, p_basey number)
is
/*  ќткрытие счетов начисленных процентов дл€ межфилилаьных
    кредитов-депозитов, корректировка проц. карточки.
    ѕостановка:
       —чета уже подт€нуты в рабочие таблицы портфел€
       ќткрываем счета %% по маске и доступу как основной,
       мен€ем в процентной карточке только счет начисленных %%
       (счет доходов оставл€ем)
       ≈сли наступили на счет, который по маске  подходит, но закрыт -
       не переоткрываем, но подставл€ем в процентную карточку.
       ƒату погашени€ остатка ставим как у основного счета.
       ƒата открыти€ счета будет равна текущей банковской.
       ѕары счетов "осн счет"-"счет начисл %%" пишем в таблицу test_mfkaccp.
       “аблицу int_accn скопировали в  test_int_accn_mfkd .

       ѕеред установкой процедуры - см. 1mfkd_table.sql

*/
l_nmsb  accounts.nms%type;  -- название счета (нач %%)
l_nlsb  oper.nlsb%type;     -- счет нач %%
l_accb  accounts.acc%type;  /* acc счета  нач %%           */
l_nbs   accounts.nbs%type;  /* nbs счета  нач %%           */
l_tip   accounts.tip%type;  /* tip счета  нач %%           */
l_tmp   varchar2(30);         /* нужна дл€ открыти€          */
l_id    number;             /* ID проц карточки */
l_basey integer;
BEGIN

/*  счета  3902,3903 незакрытые, с ненулевыми остатками, есть в cc_deal, cc_add - вариант ќЅ */

for k in (
   select  a.acc,a.nls, a.nbs,a.kv,a.isp,a.sec,a.grp, a.nms, c.rnk, p.mfoperc
   from  accounts a,customer c, cc_deal d,  cc_add p    --, int_accn i,accounts b  -- нет проц карточки вообще
   where a.nbs in ('3902','3903')
     and a.dazs is null
     and a.rnk=c.rnk
     and a.acc=p.accs
     and p.nd=d.nd
     and d.vidd in ('3902','3903')
     --and i.acc=a.acc    -- нет %% карточки вообще
     --and i.acra=b.acc
     --and ltrim(rtrim(substr(a.nls,6,9)))<>ltrim(rtrim(substr(b.nls,6,9)))
     order by a.rnk,a.nls
     )
/*
  если к селекту добавить уточнение конкретного счета (группы счетов)
  3902, 3903 - отработает только по ним
  например :
  and nls like'390__003')
*/
loop
   /* дл€ каждого счета 3902 , 3903 найдем открытый 3904,3905
     если счет не найден - откроем c доступом как у основного 3902*/
   if   k.nbs='3902'
   then l_nbs:='3904';   l_id:=0;
   else l_nbs:='3905';   l_id:=1;
   end if;

   begin
        l_nlsb := sb_acc(l_nbs||'??????????',k.nls);
       -- bars_audit.info('mfk1 = l_nlsb'||l_nlsb);

      exception when others then
         raise_application_error(-20000, 'my error: nls='||k.nls||', nbs+='||l_nbs||'?????????'||', msg='
          ||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
   end;

  l_nmsb := TRIM(SUBSTR(k.nms,1,70));

  begin
      SELECT acc, nms INTO l_accb, l_nmsb
      FROM accounts
      WHERE nls=l_nlsb AND kv=k.kv AND dazs IS NULL;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
       if k.nbs='3902'
         then l_tip:='SN';
         else l_tip:='DEN';
       end if;
       OP_REG(6,k.acc,0,0,l_tmp,k.rnk,l_nlsb,k.kv, l_nmsb,l_tip,k.isp,l_accb);
  end;

--   корректировка %% карточки
--bars_audit.info('mfk2 = l_accb'||l_accb);

--select nvl(basey,0) into l_basey from tabval where kv=k.kv;
-- дл€ ќЅ берем дл€ всех basey=0

  l_basey:=p_basey;

  begin
   Insert into BARS.INT_ACCN
     (ACC, ID, METR, BASEM, BASEY,
     FREQ, ACR_DAT,  TT,
     ACRA, S, IO, KF)
    Values
     (k.acc, l_id, 0, 0, l_basey,
      1, p_dat, '%MB',
      l_accb, 0, 0, sys_context('bars_context','user_mfo'));
      exception when dup_val_on_index then
      update int_accn set tt='%MB',acra=l_accb where acc=k.acc;
  end;  -- первоначальное заполнение

   update accounts set daos=p_dat where acc=l_accb;

--  фиксаци€ в рабочей таблице
   insert into test_mfkaccp (acc,accp) values (k.acc,l_accb);
   commit;
end loop;
end p_mfk_accp;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MFK_ACCP.sql =========*** End **
PROMPT ===================================================================================== 
