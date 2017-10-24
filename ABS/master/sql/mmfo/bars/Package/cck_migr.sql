
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cck_migr.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCK_MIGR AS
/******************************************************************************
   NAME:       CCK_MIGR
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14.02.2010             1. Created this package.
******************************************************************************/

-- процедура для запуска после основной конвертации данных
procedure after_migration (p_branch in varchar2);


-- Открывает комиссионные счета для договоров в которых счет 3578 не открыт
-- и введена комиссионная ставка
-- p_kv = null - в валюте договора = 980 - в гривне


PROCEDURE SK0_3578( p_branch in varchar2, tip_ number:=0,p_kv in number);

-- Устанавливает по какую дату начислены проценты
  PROCEDURE LAST_DATE_IR (p_branch in varchar2,p_tip in number, new_date date);

-- Устанавливает по какую дату начислена ПЕНЯ
  PROCEDURE LAST_DATE_SN8 (p_branch in varchar2,p_tip in number, new_date date);

  -- установить на всех счетах по договору дату окончания равную дате окончания по договору
 -- 2 ЮЛ    3- ФЛ
  PROCEDURE SET_MDATE (p_branch in varchar2,p_tip in number);


  -- присоединяет не привязанные счета залога и поруки к кредитным договорам
  -- скрипт для непривязанного счета залога находит кредитный договор  этого же клиента
  -- и привязывает залог к этому договору
  PROCEDURE ADD_ZAL (p_branch in varchar2);

-- дозаполняет процентные карточки счетом доходов и проц счетом которые привязаны к КД.
PROCEDURE ir_z(p_branch in varchar2);


-- в проц карточку прописывает приостановление нач процентов дату окрнчания КД.
-- не начислять проценты после окончания КД для счетов SS и SP.
procedure stop_rate (p_branch in varchar2,p_tip in number);


--
procedure cc_close (p_branch in varchar2,p_tip in number);

-- поднимает бранчи с 3-его на второй уровень
PROCEDURE branch_level (p_branch in varchar2);

-- простановка незаполненного параметра R011
procedure r011 (p_branch in varchar2);

-- установка параметра s031 на проц счетах аналогично как на ссудных
procedure s031 (p_branch in varchar2);

-- установка параметров s260
procedure s260 (p_branch in varchar2);


-- установка параметра  s180
procedure s180 (p_branch in varchar2);

-- удаление КП строго по заданному бранчу (подчиненные бранчи не удаляет)
-- ND (0 все договора бранча  больше нуля только данный КД)
PROCEDURE CCK_DEL( p_branch in varchar2, ND_ in int);


FUNCTION CC_DAY_POG (FDAT_ date,DAY_ number) return DATE;

END CCK_MIGR;
/
CREATE OR REPLACE PACKAGE BODY BARS.CCK_MIGR IS
/******************************************************************************
   NAME:       CCK_MIGR
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14.02.2010             1. Created this package.

   17.02.2011 after_migration- Устанавливать дату изм-ния доп. параметры равную дате нач. договора
******************************************************************************/


PROCEDURE after_migration (p_branch in varchar2) is
l_nd int;
min_date_bars date;
i_sdi int:=0;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));
 -- 1 прописывает реф договоров в табл cc_accp

   dbms_output.put_line('Прописываем для всех КД тип авторазбора погашения = 1');
 for k in (select * from cc_deal  where branch like p_branch||'%')
 loop
    begin
     insert into nd_txt (nd,tag,txt) values (k.nd,'CCRNG','1');
    exception when dup_val_on_index then
     null;
    end;
 end loop;

dbms_output.put_line('Удаляем проц карточки на процентных счетах SN ,SPN');

 for i in (select a.acc,a.tip from cc_deal d,nd_acc n, accounts a,int_accn i
            where d.nd=n.nd and n.acc=a.acc and d.sos<15 and a.tip in ('SN ','SPN') and a.dazs is null
                  and a.acc=i.acc and i.id=0 and d.branch like p_branch||'%'
          )
 loop
   delete from int_ratn where acc=i.acc and id=0;
   delete from int_accn where acc=i.acc and id=0;
 end loop;


   dbms_output.put_line('Прописываем  доп код заставы для непроставленных при миграции = 72');
 for k in (select * from cc_deal  where branch like p_branch||'%')
 loop
    begin
     insert into nd_txt (nd,tag,txt) values (k.nd,'ZASTC','72');
    exception when dup_val_on_index then
     null;
    end;
 end loop;



   dbms_output.put_line('Прописываем № КД для счетов залога');
 for k in (select * from cc_accp where nd is null)
 loop
    begin
    select nd into l_nd from nd_acc where acc=k.accs;
    exception when others then
     null;
    end;
  update cc_accp set nd=l_nd where accs=k.accs and acc=k.acc;
 end loop;

--------------------------------------- остатки на 8999
dbms_output.put_line('Устанавливаем остатки на счетах 8999');
 for i in (select nd from cc_deal where branch like p_branch||'%' and sos<15)
 loop
  cck.cc_start(i.nd);
 end loop;


dbms_output.put_line('Актуализируем текушие лимиты');
 ---------------
-- cck.cc_day_lim(gl.bd,0);
 ---------------

dbms_output.put_line('Актуализируем потоки');
 select min(fdat) into min_date_bars from saldoa sa, accounts a
  where sa.acc=a.acc and a.tip='SS ' and a.branch = p_branch;
 min_date_bars:=nvl(min_date_bars,gl.bd);
 for k in i_sdi..trunc(gl.bdate-(min_date_bars+1))
  loop
   cc_rmany(0,min_date_bars+k,0);
  end loop;



dbms_output.put_line('Актуализируем лимиты по КД');

    for k in (select   -abs(lim2) lim2,l.acc, l.nd from cc_lim l,cc_deal d
                 where  l.nd=d.nd and
                  l.fdat=(select max(fdat) from cc_lim where fdat<=gl.bd and nd=l.nd )
                 and d.branch like p_branch||'%'
             )
     loop

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! фигня какаято  в стр cc_deal BARS.FK_CCDEAL_CUSTOMER
       begin
      update accounts set  ostx=nvl(k.lim2,0) where acc=k.acc;
      update cc_deal set  limit=abs(nvl(k.lim2,0))/100 where nd=k.nd;
      exception when others then null; end;
     end loop;

dbms_output.put_line('Прописываем группы доступв по счетам');
  for k in (select a.acc,decode (d.vidd,1,3,2,3,3,3,11,5,12,5,13,5) grp
                   from cc_deal d,nd_acc n, accounts a
                  where d.nd=n.nd and n.acc=a.acc  and a.dazs is null and
                  sos<15 and d.vidd in (1,2,3,11,12,13) and
                  d.branch like p_branch||'%'
           )
    loop
            sec.addAgrp(k.acc,k.grp );
    end loop;

---------------------------------------------
dbms_output.put_line('удаляем ошибочные записи по R013');
  update specparam s set s.r013=null where
         s.acc in (select acc from accounts where branch like p_branch||'%' and
         nbs in('2909','2651','2652','2658','2203','3522','4400','2608','3739'));

---------------------------------------------

--
dbms_output.put_line('Устанавливаем дату изм-ния доп. параметры равную дате начала договора');

 for k in (select t.idupd,d.sdate from cc_deal d,nd_txt_update t
            where d.nd=t.nd and chgaction=1
                  and d.branch like p_branch||'%'
          )
 loop
  update nd_txt_update set chgdate=k.sdate where idupd=k.idupd;
 end loop;

  bc.SET_CONTEXT();
end;





PROCEDURE SK0_3578( p_branch in varchar2, tip_ number:=0,p_kv in number)
IS
--  Авто-открытие комиссионных счетов

--  KF_ - код МФО
--  tip - 0 - Все 2- ЮЛ 3- ФЛ


  ACC_    accounts.ACC%type;
  l_NLS    accounts%rowtype;
  l_s080   specparam.s080%type;
  l_count int:=0;

begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

  for k in ( select d.branch, d.nd, d.wdate, a.acc,a.rnk,a.kv
          from cc_deal d , nd_acc n, accounts a
          where d.sos<15 and d.vidd in (1,2,3,11,12,13) and d.branch like p_branch||'%'
                and d.nd=n.nd and n.acc=a.acc and a.tip='LIM' and a.ostc!=0
            and ( (d.vidd in (1,2,3) and tip_ in (0,2))
                  or (d.vidd in (11,12,13) and tip_ in (0,3))
                )
            and not exists (select 1
                              from nd_acc n2,accounts a2
                             where n2.acc=a2.acc and n2.nd=d.nd and a2.dazs is null
                                  and  (a2.tip='SK0' or a2.nbs in ('3578'))
                           )
            and exists (select 1 from int_ratn i3 where i3.acc=a.acc and i3.id=2 and i3.ir>0
                           )
            and exists( select 1
                          from accounts a,nd_acc n,specparam s
                         where n.nd=d.nd and n.acc=a.acc and a.tip in ('SS ','SP ','SN ','SPN')
                               and a.dazs is null and a.acc=s.acc
                      )
           )
  loop
   bc.subst_BRANCH(k.branch);
   select kv, nls, isp, grp, s080
     into l_nls.kv ,l_nls.nls,l_nls.isp, l_nls.grp,l_s080
   from
   (
      select a.kv, a.nls, a.isp, a.grp, s.s080
        from accounts a,nd_acc n,specparam s
       where n.nd=k.nd and n.acc=a.acc and a.tip in ('SS ','SP ','SN ','SPN')
             and a.dazs is null and a.acc=s.acc
       order by a.tip
    ) where rownum=1;

   cck.cc_op_nls( k.ND, nvl(p_kv,k.kv) ,VKRZN(substr(gl.aMFO,1,5),'35780'||substr(l_nls.nls,6,9) ), 'SK0', l_nls.isp, l_nls.grp,l_s080,k.wdate, ACC_);
   update int_accn set acrb=nvl(acrb,cc_o_nls('3578',k.rnk,4,k.nd,nvl(p_kv,k.kv),'SD ')) where id=2 and acc=k.acc;
   l_count:=l_count+1;

  end loop;

  commit;

  bc.set_context;
  dbms_output.put_line('Открыто счетов с типом SK0 - '||l_count);
  logger.info('CCK2  migr открыто комиссионных счетов = '||l_count);

end SK0_3578;




-- по какую дату начислены проценты
PROCEDURE LAST_DATE_IR (p_branch in varchar2,p_tip in number, new_date date) is
 l_count int:=0;
 col int:=0;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

 for k in (select a.acc from cc_deal d,nd_acc n,accounts a
            where d.nd=n.nd and n.acc=a.acc and a.tip in ('SS ','SP ','SL ')
                  and ((p_tip=2 and d.vidd in (1,2,3)) or  (p_tip=3 and d.vidd in (11,12,13)) )
                  and  a.branch like p_branch||'%' and  d.branch like p_branch||'%'
          )
 loop
                                                    -- and acr_dat<new_date
   update int_accn set acr_dat=new_date where  id=0
    and acc=k.acc returning count(acc) into col;
    l_count:=l_count+nvl(col,0);
 end loop;
 dbms_output.put_line('Всего='||l_count);


  bc.SET_CONTEXT();
end;




-- по какую дату начислена ПЕНЯ
PROCEDURE LAST_DATE_SN8 (p_branch in varchar2,p_tip in number, new_date date) is
 l_count int:=0;
 col int:=0;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

 for k in (select a.acc from cc_deal d,nd_acc n,accounts a
            where d.nd=n.nd and n.acc=a.acc and a.tip in ('SP ','SL ','SPN','SK9')
                  and ((p_tip=2 and d.vidd in (1,2,3)) or  (p_tip=3 and d.vidd in (11,12,13)) )
                  and  a.branch like p_branch||'%' and  d.branch like p_branch||'%'
          )
 loop
                                                  --  and acr_dat<new_date
   update int_accn set acr_dat=new_date where  id=2
    and acc=k.acc returning count(acc) into col;
    l_count:=l_count+nvl(col,0);
 end loop;
 dbms_output.put_line('Всего='||l_count);


  bc.SET_CONTEXT();
end;



-- установить на всех счетах по договору дату окончания равную дате окончания по договору
 -- 2 ЮЛ    3- ФЛ
PROCEDURE SET_MDATE (p_branch in varchar2,p_tip in number) is
col int:=0;
col_all int:=0;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

  for k in (select * from cc_deal d
             where sos>0 and sos<15 and d.branch like p_branch||'%' and
             ((p_tip=2 and d.vidd in (1,2,3)) or  (p_tip=3 and d.vidd in (11,12,13)))
           )
   loop
      for i in (select a.acc from nd_acc n,accounts a
                 where n.nd=k.nd and n.acc=a.acc and a.tip in ('SS ','SP ','SN ','SPN','SL ','SLN''SDI','SPI','SG ','SK0','SK9','CR9')
                 union
                select a.acc from nd_acc n,cc_accp p,accounts a
                 where n.nd=k.nd and n.acc=p.accs and p.acc=a.acc
                       and a.tip='ZAL'
                group by a.acc
               )


     loop
       update accounts set mdate=k.wdate
        where mdate is null and acc=i.acc returning count(mdate) into col;

             col_all:=col_all+nvl(col,0);

     end loop;
   end loop;

  dbms_output.put_line('Изменено счетов = '||col_all);
  bc.SET_CONTEXT();
end;

PROCEDURE ADD_ZAL (p_branch in varchar2) is
  l_nd int;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

for i in (select * from accounts where nbs in ('9031','9500','9501','9502','9520','9521', '9523') and dazs is null and tip='ODB' and branch like p_branch||'%')
 loop
   begin
   select nd into l_nd from nd_acc n,accounts a where n.acc=a.acc and a.rnk=i.rnk group by n.nd;
   exception when others then
   dbms_output.put_line(i.nls||' '||i.kv||' '||i.nms||' '||i.ostc/100||' '||SQLERRM);
   l_nd:=null;
   end;
   if l_nd is not null then




         update accounts set tip='ZAL' where acc=i.ACC;
       begin
         insert into PAWN_ACC (ACC,PAWN,MPAWN)
         values (i.acc, decode(i.nbs,'9031',34,'9500','30',9030,'11',9521,'25',9010,'14',9523,'29',9520,'31',null), 1 );
       exception when DUP_VAL_ON_INDEX then null;
       end;

      --UPDATE pawn_acc SET nree='"|| NREE ||"', idz=" ||Str(IDZ)||
      --              ", SV="||Str(SV*100)||",deposit_id='"|| colDep ||"' WHERE acc=" || Str(nAcc) || ";
      FOR PWN in
         (SELECT n.acc ACCS FROM nd_acc n,accounts a
          WHERE n.acc=a.acc AND
               n.ND=l_ND AND a.tip in ('SS ','SL ','SP ','CR9')
         )
       LOOP
         update cc_accp set pr_12=1,nd=l_ND where ACCS=PWN.ACCS and ACC=i.ACC;
        IF SQL%rowcount = 0 then
           INSERT INTO cc_accp (ACC,ND,ACCS,pr_12) VALUES (i.acc,l_ND,PWN.ACCS,1);
        END if;
       END LOOP;


   end if;

 end loop;

  bc.SET_CONTEXT();

end;

-- дозаполняет процентные карточки счетом доходов и проц счетом которые привязаны к КД.
PROCEDURE ir_z(p_branch in varchar2) is
l_SD int;
l_sn int;
l_count int:=0;
l_count_all int:=0;
l2_count int:=0;
l2_count_all int:=0;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(f_ourmfo_g);

for k in
 (
    select acc,ref,nmk,cc_id,nls,kv,sdate,wdate,proc,dox,ir,acc8 from
    (
    select a.acc,d.nd ref,c.nmk,d.cc_id,a.nls,a.kv,d.sdate,d.wdate,d.vidd,
          (select (case when acra is null
                             then 'Проц счет незаполнен'
                        when substr(nls,1,3)||'8'!=(select substr(nls,1,4) from accounts where acc=acra)
                             then (select nls from accounts where acc=acra) else null end) from int_accn where id=0 and acc=a.acc) Proc,
          (select (case when acrb is null then 'Счет доходов незаполн'
                        when (select substr(nls,1,1) from accounts where acc=acrb and id=0)!=6
                              then (select nls from accounts where acc=acrb) else null end) from int_accn where id=0 and acc=a.acc) Dox,
          (select i.ir from int_ratn i where i.acc=a.acc and i.id=0 and rownum=1) ir,
          (select a8.acc from accounts a8,nd_acc n8 where a8.acc=n8.acc and n8.nd=d.nd and a8.tip='LIM') acc8
          from cc_deal d,nd_acc n,accounts a,customer c where d.nd=n.nd and n.acc=a.acc and d.rnk=c.rnk and d.vidd in (11,12,13)
               and a.tip in ('SS ','SP') and sos<15 and d.branch like p_branch||'%'
    ) where dox is not null or proc is not null
    order by vidd,nmk,ref
 )
 loop

   delete from int_ratn where ir is null and br is null;

   if k.proc is not null then
     begin
       select a.acc into l_SN from nd_acc n, accounts a where n.acc=a.acc and n.nd=k.ref and a.tip='SN ' and rownum=1;
     exception when no_data_found then
       l_SN:=null;
     end;
       update int_accn set acra=l_sn where id=0 and acc=k.acc returning  count(acc) into l_count;
       l_count_all:=l_count_all+nvl(l_count,0);
   end if;



   if k.dox is not null then
     begin
       select a.acc into l_SD from nd_acc n, accounts a where n.acc=a.acc and n.nd=k.ref and a.tip='SD ' and rownum=1;
     exception when no_data_found then
       l_SD:=null;
      -- dbms_output.put_line ('NOT SD ='||k.ref);
     end;
       update int_accn set acrb=l_SD where id=0 and acc=k.acc returning  count(acc) into l2_count;
       l2_count_all:=l2_count_all+nvl(l2_count,0);
   end if;

   if k.ir is not null then
    begin
     insert into int_ratn (acc,id,bdat,ir) values (k.acc8,0,k.sdate,k.ir);
    exception when others  then
     null;
    end;
  end if;

 end loop;

 dbms_output.put_line ('Процентных счетов изменено ='||l_count_all);
 dbms_output.put_line ('СЧетов доходов изменено    ='||l2_count_all);

   bc.SET_CONTEXT();

end;





procedure stop_rate (p_branch in varchar2,p_tip in number) is
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

 for k in (select a.acc,d.wdate from cc_deal d,nd_acc n, accounts a
            where d.nd=n.nd and n.acc=a.acc and a.tip in ('SS ','SP ') and a.dazs is null
             and (  (d.vidd in (11,12,13) and p_tip=3) or  (d.vidd in (1,2,3) and p_tip=2)  )
             and d.branch like p_branch||'%'
          )
 loop
   update int_accn i set stp_dat= k.wdate where i.acc=k.acc and i.id=0;
 end loop;

  bc.SET_CONTEXT();

end;

-- закрывает кредитные договора без остатков
procedure cc_close (p_branch in varchar2,p_tip in number) is
errM varchar2 (500);
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

 for i in
     (
      select * from
           (
            select d.nd,
                   (select sum(a.ostc ) from nd_acc n, accounts a
                     where n.acc=a.acc and a.tip!='SD ' and n.nd=d.nd) ostc
              from cc_deal d
              where branch like p_branch||'%' and sos<15 and
                    ((p_tip=2 and d.vidd in (1,2,3)) or  (p_tip=3 and d.vidd in (11,12,13)) )
           ) where ostc=0
     )
 loop
  errm:=null;
  cck.cc_close(i.nd,errm);
  if errm is not null then dbms_output.put_line(errm); end if;
 end loop;

  bc.SET_CONTEXT();

end;



PROCEDURE branch_level (p_branch in varchar2) is

begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));


for i in (select d.nd, length(d.branch)lng ,d.branch from cc_deal d where  d.sos<15 and
                (d.branch like p_branch||'%' or p_branch is null)
         )
loop
 if  i.lng=9 then
  update nd_txt set txt=i.branch||'/000000/' where tag='INIC' and nd=i.nd;
 end if;

 if  i.lng=22 then
  update nd_txt set txt=substr(i.branch,1,15) where tag='INIC' and nd=i.nd;
 end if;

 if  i.lng=15 then
  update nd_txt set txt=i.branch where tag='INIC' and nd=i.nd;
 end if;


 if i.lng not in (9,15,22) then
    raise_application_error (-20025,'Error length Contract nd = '||i.nd ||' branch='||i.branch);
 end if;


end loop;

end;



procedure r011 (p_branch in varchar2) is
col int;
i int;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

 col:=0;

  for k in (            select  substr(prod,1,4) SS,a.acc,a.nls,
                             decode(a.tip,'SP ', nvl(R011_SP ,' ') ,
                                          'SN ', nvl(R011_SN ,' ') ,
                                          'SK0', nvl(R011_SN ,' ') ,
                                          'SPN', nvl(R011_SPN,' ') ,
                                          'SK9', nvl(R011_SPN,' ') ,
                                          'SL ', nvl(R011_SL ,' ') ,
                                          'SLN', nvl(R011_SLN,' ') ,
                                          '  ') r011
             FROM CCK_R011_R181 sp,cc_deal d, nd_acc n,accounts a
                      WHERE d.nd=n.nd and n.acc=a.acc and a.tip in ('SP ','SN ','SPN') and
                      aim=1 and sp.SS=substr(prod,1,4)  and  d.vidd in (11,12,13)
                      and d.branch like p_branch||'%'
           )
  loop

  update specparam s set s.r011=k.r011 where s.acc=k.acc and (s.r011 is null or s.r011='0' )
  returning count(k.r011) into i;
  col:=col+nvl(i,0);

  end loop;
 dbms_output.put_line ('---');
 dbms_output.put_line ('Додано R011='||to_char(col) );
 dbms_output.put_line ('---');


  bc.SET_CONTEXT();

end;


procedure s031 (p_branch in varchar2) is
col int:=0;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

 for i in (  select d.nd,n.accs,cp.s031 from cc_deal d, cc_add n, cc_accp p,pawn_acc pa, cc_pawn cp,specparam s
            where d.nd=n.nd and n.adds=0 and n.accs=p.accs and p.acc=pa.acc and pa.pawn!=33 and pa.pawn=cp.pawn and n.accs=s.acc
             and d.branch like p_branch||'%'
          )
 loop
    for k in (select a.acc from nd_acc n ,accounts a where n.acc=a.acc and n.nd=i.nd and a.tip in ('SN ','SPN'))
     loop
      update specparam set s031=i.s031 where acc=k.acc;
      col:=col+1;
     end loop;

 end loop;

 dbms_output.put_line('Проставено S031='||col);

 bc.SET_CONTEXT();

end;


procedure s180 (p_branch in varchar2) is
l_srok char(1);
l_col int:=0;
col_all int:=0;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

  for i in (select d.nd,d.sdate,d.wdate,d.prod
              from cc_deal d
             where d.vidd in (1,2,3,11,12,13) and d.sos<15
                   and d.branch like p_branch||'%'
           )
  loop

  l_srok:=null;

   for k in (SELECT n.acc,nvl(a.mdate,i.wdate) wdate,s.s180,a.nbs
               FROM accounts a,nd_acc n,specparam s
              WHERE n.acc=a.acc and n.nd=i.nd and a.acc=s.acc and a.dazs is null
                    and a.tip in ('SS ') --order by s.s180 nulls first
            )
    loop
     if (k.s180 is null)
         or (substr(k.nbs,4,1)='2' and k.s180 not in ('1','2','3','4','5','6','7','8','A','B','9'))
         or (substr(k.nbs,4,1)='3' and k.s180 not in ('C','D','E','F','G','H'))
     then


         if  substr(k.nbs,4,1)='2' then
             if k.wdate-i.sdate>365 then
                l_srok:=f_srok(i.sdate,i.sdate+360,2);
             else
                l_srok:=f_srok(i.sdate,k.wdate,2);
             end if;
         else
            if  k.wdate-i.sdate<=365 then
                l_srok:=f_srok(i.sdate,i.sdate+367,2);
            else
               l_srok:=f_srok(i.sdate,k.wdate,2);
            end if;
         end if;


        UPDATE specparam SET
          s180=l_srok
        WHERE acc=k.ACC and (s180 is null or s180!=l_srok) returning count(s180) into l_col;
        col_all:=col_all+nvl(l_col,0);
     else
       l_srok:=k.s180;
     end if;

    end loop;


    if l_srok is null then
     l_srok:=f_srok(i.sdate,i.wdate,2);
    end if;

  update specparam s set s.s180=l_srok where (s.s180 is null or s.s180!=l_srok) and
         acc in (select a.acc from accounts a,nd_acc n where n.nd=i.nd and a.acc=n.acc
                 and a.tip in ('SN ','SP ','SPN','SL ','SLN','SDI','SPI','SG ','SK0','SK9','CR9')
                )returning count(s180) into l_col;

  col_all:=col_all+nvl(l_col,0);

  end loop;

 dbms_output.put_line ('---S180---');
 dbms_output.put_line ('Проставлено и изменено ='||col_all);
 dbms_output.put_line ('---');

end;

procedure s260 (p_branch in varchar2) is
S260_   varchar2(2);
col     int:=0;
col_nd  int:=0;
col_upd int:=0;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

 col:=0;
 for k in (select d.nd,d.prod,substr(p.s260,1,2)  s260, cck_app.get_nd_txt(d.nd,'S260')  S260_old
             from cc_deal d,cc_potra p
            where d.sos>0 and d.sos<15 and d.branch like p_branch||'%' and d.prod = p.id and p.s260 is not null)
 loop

         cck_app.set_nd_txt(k.nd, 'S260', k.s260);

        col:=col+1;
        if k.S260_old is null then
           col_nd:=col_nd+1;
        elsif k.S260_old!=k.s260 then
           col_upd:=col_upd+1;
        end if;
 end loop;
 dbms_output.put_line ('---S260---');
 dbms_output.put_line ('Всього договор_в ='||col);
 dbms_output.put_line ('Проставлено по договорам='||col_nd);
 dbms_output.put_line ('Зм_нено параметров по договорам='||col_upd);
 dbms_output.put_line ('---');

  bc.SET_CONTEXT();

end;


PROCEDURE CCK_DEL( p_branch in varchar2, ND_ in int)  IS
 col int;
 col_all int;
begin

  DBMS_OUTPUT.ENABLE;
  bc.SET_CONTEXT();
  bc.subst_mfo(substr(p_branch,2,6));

  for k in (select d.nd,d.rnk,a8.acc from cc_deal d,nd_acc n, accounts a8
             where d.branch like p_branch and (ND_=0 or d.nd=ND_) and d.vidd in (1,2,3,11,12,13)
                   and d.nd=n.nd and n.acc=a8.acc and a8.nls like '8999%'
           )
  loop
    delete from cck_restr where nd=k.ND;
--    delete from insu_rnk  where rnk=k.rnk
    delete from insu_acc  where acc in (select acc from cc_accp  where nd=k.nd);
    delete from cc_lim    where nd=k.ND;
    delete from cc_many   where nd=k.ND;
    delete from cc_sob    where nd=k.ND;
    delete from cc_add    where nd=k.ND;
    delete from nd_acc    where nd=k.ND;
    delete from nd_txt    where nd=k.ND;
    delete from cc_prol   where nd=k.ND;
    delete from cc_deal   where nd=k.ND returning count(nd) into col;
    col_all:=nvl(col_all,0)+nvl(col,0);
     update accounts set ostc=0, ostb=0, ostf=0, DAZS= nvl(gl.bd,trunc(sysdate))  where acc=k.acc;
  end loop;

  delete from TEST_PROT_CCK where branch=p_branch;
  dbms_output.put_line ('У бранча'||p_branch||' договоров удалено  ='||col_all);
--  update "S6_Credit_NLS"  s6
--    set s6.bic=substr(BRANCH_,2,6)
--   where s6."Type"=1 and exists
--     (select 1 from accounts
--      where substr(NLS,1,4)||substr(NLS,6,9)=s6.nls and branch=BRANCH_);

  bc.SET_CONTEXT();

end;



FUNCTION CC_DAY_POG (FDAT_ date,DAY_ number) return DATE is
 DS_ varchar2(4);
begin
 if day_<10 then
           return to_date('0'||to_char(DAY_)||to_char(FDAT_,'MMYYYY'),'ddmmyyyy');

 elsif day_>=28 then
        DS_:=to_char(FDAT_,'mm')||to_char(DAY_);

    If DS_ in ('0229','0230','0231')
       and trunc(to_number(to_char(fdat_,'yyyy'))/4)!=to_number(to_char(fdat_,'yyyy'))/4
       then
            return to_date('0228'||to_char(FDAT_,'yyyy'),'mmddyyyy');
    elsif  DS_ in ('0229','0230','0231')
           and trunc(to_number(to_char(fdat_,'yyyy'))/4)=to_number(to_char(fdat_,'yyyy'))/4
           then
                return to_date('0229'||to_char(FDAT_,'yyyy'),'mmddyyyy');
    elsIf DS_ in ('0431','0631','0931','1131')
          then
               return to_date(substr(DS_,1,3)||'0'||to_char(FDAT_,'yyyy'),'mmddyyyy');
    end if;

 end if;
return to_date(to_char(DAY_)||to_char(FDAT_,'MMYYYY'),'ddmmyyyy');

end;



END CCK_MIGR;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cck_migr.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 