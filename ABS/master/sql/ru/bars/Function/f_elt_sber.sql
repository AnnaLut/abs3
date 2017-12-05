create or replace function 
F_Elt_sber  (p_acc int, p_dat date,
              p_id int default null,
              p_ost number default 0, p_otl number default 0)
              return NUMBER IS

-- *** ver 1.4  12/05-16   ***  1.3  19(20)/01-16     ***

l_acc int; l_kv int; l_acc8 int; l_otl number;
kol_ int; l_day_ int; trcn_ int;
l_nls   varchar2(15); l_nbs char(4); l_rnk int;
l_nls26 varchar2(15);  l_dat1 date;  l_dat2 date;
l_dos number; l_kos number;  l_ost number;  l_ob number;
l_blkd int;   l_dos1 number; l_kos1 number;
fl int; fl1 int; fl2 int; fl3 int;  fl_o int;
l_id int; l_ob22 varchar2(2);  l_tip varchar2(3);
s_nadx number; s_tar number;
s_por number; s_tar_p1 number; s_tar_p2 number;

BEGIN

--kol_:=1;  -- контрольное кол-во проводок для начисления абонплаты
--l_day_:=0; -- флаг последнего рабочего дня месяца
-- if p_dat=dat_last(p_dat) then l_day_:=1; end if;

  l_dat1 :=  ADD_MONTHS (last_day(p_dat),-1)+1;
  l_dat2:=p_dat;   fl:=0;   l_dos1:=0; l_kos1:=0;  l_otl:=p_otl;
  s_nadx:=0;

if l_otl=1 then
logger.info('F_ELT acc='||p_acc||' '||p_dat||' id='||p_id||' p_ost='||p_ost/100);
end if;
l_id:=p_id;
--logger.info('F_ELT dat1='||l_dat1||' dat2='||l_dat2);
if l_id in (204) then null;
else
fl:=1; goto KON;
end if;

  begin
  -- залишок по р-ку 26__  + ?нш? рекв?зити
  select nls, kv, ostc, substr(nls,1,4), rnk, blkd, ob22, a.tip -- i.acra,
  into l_nls, l_kv, l_ost, l_nbs, l_rnk, l_blkd, l_ob22, l_tip  --l_acc8,
  from accounts a        --, int_accn i
  where a.acc=p_acc and a.dazs is null;
        -- and i.id=1   -- and acrdat=... and acrb=...    -- %-карточка
        -- and a.acc=i.acc(+);   -- and ostc=ostb;

  fl_o:=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN NULL; l_ost:=0; fl_o:=0;
  fl:=0;  goto KON;   -- закритий рах-к
  end;

-- D/С - обороти по SALDOA
  begin
  select nvl(sum(dos),0), nvl(sum(kos),0)    into l_dos, l_kos
  from saldoa
  where  acc=p_acc      --  and dos!=0
         and fdat between l_dat1  and l_dat2;   fl1:=1;
      if l_otl=1 then
      logger.info('F_ELT saldo osn l_dos='||l_dos/100||' l_kos='||l_kos/100);
      end if;

        -- analises for p_acc only
  if l_id = 204 and l_dos=0 and l_kos=0 then fl:=0; goto KON; end if;

  l_kos1:=l_kos; l_dos1:=l_dos;

   if 1=1 then   -- for all add acc
    -- пошук та аналіз оборотів по дод-му рах-ку
     -- !! уточнити умови
  for l in (select acc,nls from accounts where rnk=l_rnk
                   and (nbs=l_nbs and nls!=l_nls or nbs in (2560,2604,2620,2650))
                   and dazs is null and kv=l_kv    --980
          and (nbs=2560 and ob22 in ('01')
               or nbs=2600 and ob22 in ('04','05','11','12')
               or nbs=2604 and ob22 in ('01','02')
               or nbs=2620 and ob22 in ('01','02','03')
               or nbs=2650 and ob22 in ('01'))
                   order by nls)
  loop
  select nvl(sum(dos),0), nvl(sum(kos),0)    into l_dos, l_kos
  from saldoa
  where  acc=l.acc      --and dos!=0
         and fdat between l_dat1  and l_dat2;
  l_dos1:=l_dos1+l_dos; l_kos1:=l_kos1+l_kos;
  end loop;


  if l_otl=1 then
     logger.info('F_ELT saldo dop l_dos='||l_dos1/100);
  end if;
  if l_dos1=0 and l_kos1=0 then fl:=0; goto KON; end if;   -- 19/01-16
  fl1:=1;
  end if;

  EXCEPTION WHEN OTHERS   THEN fl1:=0;
  l_dos:=0; l_kos:=0; l_dos1:=0; l_kos1:=0;
  logger.info('F_ELT saldo exc nls='||l_nls||' l_dos='||l_dos/100);
  fl:=0; goto KON;   --
  end;


-- D/С - обороти по OPLDOK
  begin
     l_dos1:=0; l_kos1:=0;

       -- ! 12/05-16    19/01-16

if newnbs.g_state= 1 then  --переход на новый план счетов
     for r in (select acc,nls,ob22 from accounts where rnk=l_rnk
                   and acc=p_acc      --  ! уточнити список рах-в 19/01-16
                   and dazs is null
                   order by nls)
  loop
  SELECT
  nvl(sum(o.S*DECODE(o.DK,0,1,0)),0), nvl(sum(o.S*DECODE(o.DK,0,0,1)),0)
  INTO l_dos, l_kos
  FROM opldok o, opldok ok, accounts d, accounts k
  WHERE o.sos=5
        and o.acc=p_acc  and o.acc=d.acc and ok.acc=k.acc
        and o.ref=ok.ref and o.stmt=ok.stmt and o.dk!=ok.dk
        and (o.dk=1 or o.dk=0 and k.nbs not in ('3570','3578'))
        and (o.dk=0 or o.dk=1 and k.nbs not in ('2608','2618','2568','2658','2528','2548','2628','2638'))
        and o.fdat>=l_dat1 AND o.fdat<=l_dat2;

  l_dos1:=l_dos1+l_dos; l_kos1:=l_kos1+l_kos;
  end loop;  
else     
     for r in (select acc,nls,ob22 from accounts where rnk=l_rnk
                   and acc=p_acc      --  ! уточнити список рах-в 19/01-16
                   and dazs is null
                   order by nls)
  loop
  SELECT
  nvl(sum(o.S*DECODE(o.DK,0,1,0)),0), nvl(sum(o.S*DECODE(o.DK,0,0,1)),0)
  INTO l_dos, l_kos
  FROM opldok o, opldok ok, accounts d, accounts k
  WHERE o.sos=5
        and o.acc=p_acc  and o.acc=d.acc and ok.acc=k.acc
        and o.ref=ok.ref and o.stmt=ok.stmt and o.dk!=ok.dk
        and (o.dk=1 or o.dk=0 and k.nbs not in ('3570','3578','3579'))
        and (o.dk=0 or o.dk=1 and k.nbs not in ('2608','2618','2568','2658','2528','2548','2628','2638'))
        and o.fdat>=l_dat1 AND o.fdat<=l_dat2;

  l_dos1:=l_dos1+l_dos; l_kos1:=l_kos1+l_kos;
  end loop;
end if;  


    if l_otl=1 then
    logger.info('F_ELT opl nls='||l_nls||' dos='||l_dos1/100||' kos='||l_kos1/100);
    end if;

  if l_dos1=0 and l_kos1=0 then fl2:=0; fl:=0;  goto KON;
  else                   -- 20/01-16
    fl:=1; goto KON;  -- 26/06-14
  -- ===============================>>>>>
  ---------------------------------

  end if;   -- корп. чи МСБ
  end;

goto KON;   ---  26/06-14

----- дальше до KON  - НЕ актуальний фрагмент (НАДРА)

  /**
  if l_id in (8,11,12) then     -- чисто абонплата
     if l_dos1<= p_ost then fl2:=0; fl:=0; goto KON;
     else fl2:=1; fl:=1;
     end if;
  goto KON;
  end if;  **/

-- для 4 та 7 потрібно мати суму нар-х %-в на залишок за минулий місяць
-- передавати або вираховувати в даній ф-ії
  l_ob:=l_kos1-l_dos1;
  if l_otl=1 then NULL;
  logger.info('F_ELT ob='||l_ob/100||' p_ost='||p_ost/100);
  end if;
if p_ost is not NULL then
   NULL;
   --if l_ost = p_ost and l_id in (8,11,12) then fl_o:=0; else fl_o:=1; end if;
else fl_o:=1;
end if;

--if p_ost is not NULL and p_ost>0 then
----if p_ost!=0 then
---if l_ob=p_ost and l_ost=p_ost then fl2:=0; else fl2:=1; end if;
fl2:=1;  -- !! без контролю нар-х %-в на залишки
 ------  if l_ob=p_ost and l_dos1=0 then fl2:=0; else fl2:=1; end if;
----else fl2:=1;  --- ????
----end if;
--logger.info('F_ELT fl2='||fl2);

if l_otl=1 then
logger.info('F_ELT флаги fl_o='||fl_o||' fl1='||fl1||' fl2='||fl2);
end if;
if fl_o=1 and fl1=1 and fl2=1 then fl:=1;
else fl:=0;
end if;
         --  НАДРА


<<KON>> NULL;
  if l_otl=1 then NULL;
  logger.info('F_ELT acc='||p_acc||' id='||p_id||' fl='||fl);
  end if;

  --if l_id in (13,14) and l_dos1 = 0 then return -1; end if;

  -- if l_id in (13,14) and l_dos1 != 0 then
  -- аналіз суми надходжень
  --  return l_kos1/100;
  --end if;

return fl;
END;
/
 show err;
 
PROMPT *** Create  grants  F_ELT_SBER ***
grant EXECUTE                                                                on F_ELT_SBER      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ELT_SBER      to ELT;
