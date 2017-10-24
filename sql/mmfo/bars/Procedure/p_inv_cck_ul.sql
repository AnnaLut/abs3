

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INV_CCK_UL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INV_CCK_UL ***

  CREATE OR REPLACE PROCEDURE BARS.P_INV_CCK_UL (p_dat date, frm_ int ) is
-- Даные про классификацию кредитных операций и расчет сумы резерва по юр.лицам
-- frm_   -- с(1)/без(0) переформирования

  U_REZ_ int ; -- \ юзер и дата по реальному расчету резервов
  D_REZ_ date; -- /
  U_REZ1_ int ; -- \ юзер и дата по фактическому расчету резервов
  D_REZ1_ date; -- /
  acc_SS  int;
  acc_ZAL int;
  acc_pot int;
  dat_   date :=p_dat ;

  dTmp1_ date;
  dTmp_  date;
  nTmp_  int;
--==================
  G01_ INV_CCK_UL.G01%type;
  G02_ INV_CCK_UL.G02%type;
  G03_ INV_CCK_UL.G03%type;
  G04_ INV_CCK_UL.G04%type;
  G05_ INV_CCK_UL.G05%type;
  G06_ INV_CCK_UL.G06%type;
  G07_ INV_CCK_UL.G07%type;
  G08_ INV_CCK_UL.G08%type;
  G09_ INV_CCK_UL.G09%type;
  G10_ INV_CCK_UL.G10%type;
  G11_ INV_CCK_UL.G11%type;
  G12_ INV_CCK_UL.G12%type;
  G13_ INV_CCK_UL.G13%type;
  G14_ INV_CCK_UL.G14%type;
  G15_ INV_CCK_UL.G15%type;
  G16_ INV_CCK_UL.G16%type;
  G17_ INV_CCK_UL.G17%type;
  G18_ INV_CCK_UL.G18%type;
  G19_ INV_CCK_UL.G19%type;
  G20_ INV_CCK_UL.G20%type;
  G21_ INV_CCK_UL.G21%type;
  G22_ INV_CCK_UL.G22%type;
  G23_ INV_CCK_UL.G23%type;
  G24_ INV_CCK_UL.G24%type;
  G25_ INV_CCK_UL.G25%type;
  G26_ INV_CCK_UL.G26%type;
  G27_ INV_CCK_UL.G27%type;
  G28_ INV_CCK_UL.G28%type;
  G29_ INV_CCK_UL.G29%type;
  G30_ INV_CCK_UL.G30%type;
  G31_ INV_CCK_UL.G31%type;
  G32_ INV_CCK_UL.G32%type;
  G33_ INV_CCK_UL.G33%type;
  G34_ INV_CCK_UL.G34%type;
  G35_ INV_CCK_UL.G35%type;
  G36_ INV_CCK_UL.G36%type;
  G37_ INV_CCK_UL.G37%type;
  G38_ INV_CCK_UL.G38%type;
  G39_ INV_CCK_UL.G39%type;
  G40_ INV_CCK_UL.G40%type;
  G41_ INV_CCK_UL.G41%type;
  G42_ INV_CCK_UL.G42%type;
  G43_ INV_CCK_UL.G43%type;
  G44_ INV_CCK_UL.G44%type;
  G45_ INV_CCK_UL.G45%type;
  G46_ INV_CCK_UL.G46%type;
  G47_ INV_CCK_UL.G47%type;
  G48_ INV_CCK_UL.G48%type;
  G49_ INV_CCK_UL.G49%type;
  G50_ INV_CCK_UL.G50%type;
  G51_ INV_CCK_UL.G51%type;
  G52_ INV_CCK_UL.G52%type;
  G53_ INV_CCK_UL.G53%type;
  G54_ INV_CCK_UL.G54%type;
  G55_ INV_CCK_UL.G55%type;
  G56_ INV_CCK_UL.G56%type;
  G57_ INV_CCK_UL.G57%type;
  G58_ INV_CCK_UL.G58%type;
  G59_ INV_CCK_UL.G59%type;
  G60_ INV_CCK_UL.G60%type;
  G61_ INV_CCK_UL.G61%type;
  G62_ INV_CCK_UL.G62%type;
  G63_ INV_CCK_UL.G63%type;
  G64_ INV_CCK_UL.G64%type;


  l_nd cc_deal.nd%type;
  l_title varchar2(20) := 'CCK P_INV_CCK_UL:';
  fd_  varchar2(10) := 'DD.MM.YYYY';  -- формат дат

  l_s031 cc_pawn.s031%type;
  l_dogs insu_acc.dogs%type;
  l_dats insu_acc.dats%type;
  l_nree pawn_acc.nree%type;

begin
 -- bars_context.subst_branch('/333368/');
  bars_audit.trace('%s 0.Старт инвентаризации КП ЮЛ. Вх.пар-ры:DAT_=%s, frm_=%s',l_title, to_char(DAT_),to_char(frm_));

----------------------------------
  begin /*  юзер и дата по расчетному расчету резервов */
    select min(p.USERID), max(p.DAT)  into U_REZ_, D_REZ_
    from REZ_PROTOCOL p  where p.dat <= DAT_
     and to_char(p.dat,'yyyymm')=to_char(DAT_,'yyyymm')
     and exists (select 1 from TMP_REZ_RISK where DAT= p.DAT and id=p.USERID);
  EXCEPTION WHEN NO_DATA_FOUND THEN
        begin
          select id, dat  into U_REZ_, D_REZ_ from TMP_REZ_RISK where id=user_id and dat=p_dat and rownum=1;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
	end;
  end;
  If U_REZ_ is null then
     RAISE_APPLICATION_ERROR (-20001,
     'Не выполнен расчет резервов на дату '||to_char(DAT_,'dd/mm/yyyy') );
     return;
  end if;

  begin /*  юзер и дата по фактическому расчету резервов */
    select min(p.USERID), max(p.DAT)  into U_REZ1_, D_REZ1_
    from REZ_PROTOCOL p  where p.dat <= D_REZ_
     and to_char(p.dat,'yyyymm')=to_char(D_REZ_,'yyyymm')
     and exists (select 1 from TMP_REZ_RISK where DAT= p.DAT and id=p.USERID);
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  dat_:=D_REZ_;
  bars_audit.trace('%s 0.Дата отчета DAT_=%s',l_title, to_char(DAT_));

  /*frm_ = 0 - без переформирования */
  if FRM_ = 0  then
     begin
       select 1 into nTmp_ from INV_CCK_UL where G00=dat_ and rownum=1;
       return;
     exception when no_data_found then null;
     end;
  end if;

  delete from INV_CCK_UL where G00=dat_;

for k in
   (select d.nd, c.OKPO, d.sdate, d.wdate, d.obs, c.crisk, d.cc_id, a.kv, c.NMK,
           a.acc,d.SDOG, c.PRINSIDER , d.branch, a.tip, c.bc, c.codcagent, c.rnk
      from cc_deal d, customer c, accounts a, nd_acc n
     where d.vidd in (1,2,3) and d.sos>=10 and d.sos<=15
       and d.rnk=c.rnk
       and d.nd =n.nd
       and n.acc=a.acc
       and a.tip in ('SS ','SP ','SL ')
       and (a.dazs is null or a.dazs>DAT_)
       and d.nd in ( 60084, 60088)  -- отладка!
    )
----------------------
loop

   --01 Наименование отделения
   select name into G01_ from branch where branch=k.branch;

   --02 Отделение
   G02_:=k.branch;

   bars_audit.trace('%s 1.Дог.реф=%s:G01_=%s,G02_=%s',l_title,to_char(k.nd),to_char(G01_),to_char(G02_));

   --03 ОКПО
   G03_:=k.OKPO;

   --04 Наименование заемщика
   G04_:=k.NMK;

   select min(a.acc)
     into acc_pot
     from accounts a, nd_acc na where a.tip in ('SS ','SP ','SL ') and (a.dazs is null or a.dazs>DAT_)
      ---and fostq(a.acc,DAT_)<>0
      and a.acc=na.acc and na.nd=k.nd;

   --05 Клиент/неклиент банка
   select decode(k.bc,1,'нк','к') into G05_ from dual;

   --06 Инсайдер
   select prinsiderlv1 into G06_ from prinsider where prinsider=k.prinsider;

   --07 Резидент
   select rezid into G07_ from codcagent where codcagent=k.codcagent;

   bars_audit.trace('%s 2.Дог.реф=%s:G03_=%s,G04_=%s,G05_=%s,G06_=%s,G07_=%s',
                      l_title,to_char(k.nd),to_char(G03_),to_char(G04_),to_char(G05_),to_char(G06_),to_char(G07_));

   --08 Сумма по договору в валюте договора
   select decode(k.acc,acc_pot,k.SDOG,null) into G08_ from dual;

   --09 Валюта договора
   G09_:=k.KV;

   --10 № договора
   G10_:=k.CC_ID;

   bars_audit.trace('%s 3.Дог.реф=%s:G08_=%s,G09_=%s,G10_=%s',
                      l_title,to_char(k.nd),to_char(G08_),to_char(G09_),to_char(G10_));

   --11 Дата договора
   G11_:=to_char(k.sdate,fd_);

   --12 Дата фактической выдачи
   select to_char(wdate,fd_) into G12_ from cc_add where nd=k.nd;

   begin
    select mdate into dTmp_ from cc_prol where nd=k.ND and npp=0;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;

   --13 Планируемая дата погашения (первоначальная)';
   select to_char(LEAST(k.wdate,decode(dTmp_,null,k.wdate,dTmp_)),fd_) into G13_ from dual;

   --14 Планируемая дата погашения с учетом последней пролонгации' - если пролонгации не было - пусто;
   select decode(GREATEST(k.Wdate,dTmp_),LEAST(k.wdate,dTmp_),'',to_char(GREATEST(k.Wdate,dTmp_),fd_))  INTO G14_ from dual;

   bars_audit.trace('%s 4.Дог.реф=%s:G11_=%s,G12_=%s,G13_=%s,G14_=%s',
                      l_title,to_char(k.nd),to_char(G11_),to_char(G12_),to_char(G13_),to_char(G14_));

   --15 Дата вiднесення на рахунок прострочених
   select  decode(k.tip,'SP ',to_char(max(fdat),fd_),null)
   into G15_
   from saldoa
   where ostf=0 and fdat<=DAT_ and dos>0
     and acc in (select n.acc from nd_acc n, accounts a
                 where a.acc=n.acc and n.nd=k.ND and a.tip='SP ');

   --16 - не заполняется по разъяснениям
   G16_:=null;

   --17 Отрасль экономики
   select oe into G17_ from customer_update where rnk=k.rnk  and idupd=(select max(idupd) from customer_update where rnk=k.rnk and chgdate<=DAT_);

   --18 Принадлежность к малому бизнесу
   select decode(mb,1,'10',9,'90','') into G18_ from customer_update where rnk=k.rnk
          and idupd=(select max(idupd) from customer_update where rnk=k.rnk and chgdate<=DAT_);

   --19 Форма собственности
   select fs into G19_ from customer_update where rnk=k.rnk  and idupd=(select max(idupd) from customer_update where rnk=k.rnk and chgdate<=DAT_);

   bars_audit.trace('%s 5.Дог.реф=%s:rnk=%s,G15_=%s,G17_=%s,G18_=%s,G19_=%s',
                      l_title,to_char(k.nd),to_char(k.rnk),to_char(G15_),to_char(G17_),to_char(G18_),to_char(G19_));

   --20 Номер бал.счета
   select accs into ACC_SS from cc_add   where nd=k.ND and adds=0;
   select nbs  into G20_ from accounts where acc=k.acc;

   --21 Фактический остаток задолженности в валюте договора';
   G21_:=-(fost(k.ACC,DAT_)/100);
   --22 Фактический остаток задолженности в национальной валюте';
   G22_:=-(fostQ(k.ACC,DAT_)/100);

   bars_audit.trace('%s 6.Дог.реф=%s:G20_=%s,G21_=%s,G22_=%s',
                      l_title,to_char(k.nd),to_char(G20_),to_char(G21_),to_char(G22_));

   --23 9129 в нац вал за якими банк ризику не несе (9129 с ob22=01,10);
   select decode(k.acc,acc_pot,-(nvl(sum(fostQ(a.acc,DAT_))/100,0)),0) into G23_
   from accounts a, nd_acc n, specparam_int s
   where n.nd=k.ND and a.acc=n.acc and a.tip='CR9' and (a.dazs is null or a.dazs>DAT_) and a.acc=s.acc and s.ob22 in ('02') ;

   --24 9129 в нац вал ризиков (9129 с ob22=03,5,7,11)
   select decode(k.acc,acc_pot,-(nvl(sum(fostQ(a.acc,DAT_))/100,0)),0) into G24_
   from accounts a, nd_acc n, specparam_int s
   where n.nd=k.ND and a.acc=n.acc and a.tip='CR9' and (a.dazs is null or a.dazs>DAT_) and a.acc=s.acc and s.ob22 in ('04','06','08','09') ;

   --25 Действующая cтавка (% годовых)
   /*select nvl(max(acrn.fprocn(a.acc,0,DAT_) ),0) into G25_
   from accounts a, nd_acc n
   where n.nd=k.ND and a.acc=n.acc and a.tip in ('SS ','SP ')
    and (dazs is null or dazs>DAT_);  */
   select nvl(acrn.fprocn(k.acc,0,DAT_),0)  into G25_  from dual;


   bars_audit.trace('%s 7.Дог.реф=%s:G23_=%s,G24_=%s,G25_=%s',
                      l_title,to_char(k.nd),to_char(G23_),to_char(G24_),to_char(G25_));

   --26 Начисл.неуплач.(непросроч) доходы
   select decode(k.acc,acc_pot,-(nvl(sum(fostQ(a.acc,DAT_) )/100,0)),0)  into G26_
   from accounts a, nd_acc n
   where n.nd=k.ND and a.acc=n.acc and a.tip in ('SN ','SK0') and (a.dazs is null or a.dazs>DAT_);

   --27 Начисл.проср. доходы до 31 дня
   --28 Начисл.проср. доходы более 31 дня
   select decode(k.acc,acc_pot,-(nvl(sum(fostQ(a.acc,DAT_))/100,0)),0),
          decode(k.tip,'SP ',-(nvl(sum(FOSTQ_SP(31,a.kv,a.acc,DAT_))/100,0)),0)
   into G27_, G28_
   from accounts a, nd_acc n
   where n.nd=k.ND and a.acc=n.acc and a.tip in ('SPN','SK9') and (a.dazs is null or a.dazs>DAT_);
   G27_ := G27_ - G28_;

   --29 - не заполняется по разъяснениям
   G29_:=null;

   bars_audit.trace('%s 8.Дог.реф=%s:G26_=%s,G27_=%s,G28_=%s',
                      l_title,to_char(k.nd),to_char(G26_),to_char(G27_),to_char(G28_));

   --30 Начисл.доходы на 9603
   select decode(k.acc,acc_pot,-(nvl(sum(fostQ(a.acc,DAT_) )/100,0)),0)  into G30_
   from accounts a, nd_acc n
   where n.nd=k.ND and a.acc=n.acc and a.tip in ('S9N','S9K') and (a.dazs is null or a.dazs>DAT_);

   --31 Меры по проср.кредитам
   begin
     select substr(txt,1,110) into G31_ from nd_txt
      where tag='Z_SP' and nd=k.ND;
     EXCEPTION WHEN NO_DATA_FOUND THEN G31_:= null;
   end;

   --32 Меры по сомнит.кредитам
   begin
     select substr(txt,1,110) into G32_ from nd_txt
      where tag='Z_SL' and nd=k.ND;
     EXCEPTION WHEN NO_DATA_FOUND THEN G32_:= null;
   end;

   bars_audit.trace('%s 9.Дог.реф=%s:G30_=%s,G31_=%s,G32_=%s',
                      l_title,to_char(k.nd),to_char(G30_),to_char(G31_),to_char(G32_));

   --33 Фин.рез-т в пред.году
   G33_:=null;

   --34 Фин.рез-т в пред.квартале
   G34_:=null;

   --35 Класс фин.состояния заемщика
   --36 Категория риска
   --37 Обслуживание долга
   begin
     select decode(fin,1,'А',2,'Б',3,'В',4,'Г','Д') , s080 , OBS
     into G35_, G36_ , G37_
     from TMP_REZ_RISK
     where acc =ACC_SS  and id=U_REZ_ and dat=D_REZ_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
     if nvl(k.crisk,1)=1 then G35_:='А';
     elsIf k.crisk    =2 then G35_:='Б';
     elsIf k.crisk    =3 then G35_:='В';
     elsIf k.crisk    =4 then G35_:='Г';
     else                     G35_:='Д';
     end if;
     begin
       select s080 into G36_ from specparam_update
        where acc=ACC_SS and idupd=(select max(idupd) from specparam_update where acc=ACC_SS and fdat<=DAT_);
     EXCEPTION WHEN NO_DATA_FOUND THEN G36_:= '1';
     end;
     G37_:= k.obs;
   end;

   bars_audit.trace('%s 10.Дог.реф=%s:G35_=%s,G37_=%s,G37_=%s',l_title,to_char(k.nd),to_char(G35_),to_char(G36_),to_char(G37_));

   --!! Согласовано с Харлан - п.38-39, 45 - непонятно, писать разными строками, разынми колонками или через запятую, если залогов несколько.
   -- Информации по п.40-44, 47-49 в АБС нет. Вопрос - необходимо дать возможность ее заполнения.

   --38 Вид залога
   G38_:=null; --!! Сделать справочник и новый доп.реквизит - они должны пересмотреть справочник

   --39 Местонахождение залога
   G39_:=null; --!! Могу вытащить mpawn, но если хотят указывать несколько и не те, которые у нас - могу сделать доп.реквизит

   --40-44 все по залогу - информации нет, могу сделать доп.реквизит
   G40_:=null;
   G41_:=null;
   G42_:=null;
   G43_:=null;
   G44_:=null;

   begin
    G45_:=null;
    G50_:=null;
    G51_:=null;
    G52_:=null;
      for m in (  select a.acc from accounts a, cc_accp z
                   where z.accs=ACC_SS and a.acc=z.acc and a.nbs like '9%' and (a.dazs is null or a.dazs>DAT_) )
         loop
           -- 52 Виды залогов
           begin
            select c.s031 into l_s031 from cc_pawn c, pawn_acc a
             where a.acc=m.acc and a.pawn=c.pawn;
            G52_:=l_s031||' '||G52_;
            EXCEPTION WHEN NO_DATA_FOUND THEN G52_:=null;
           end;
           -- 50,51 - Номер и дата страховки
           begin
            select dogs, dats into l_dogs, l_dats from insu_acc
             where acc=m.acc;
            G51_:=l_dogs||' '||G51_;
            G50_:=l_dats||' '||G50_;
            EXCEPTION WHEN NO_DATA_FOUND THEN G51_:=null; G50_:=null;
           end;
           --45 Номер в гос.реестре
           begin
            select nree into l_nree from pawn_acc
             where acc=m.acc;
            G45_:=l_nree||' '||G45_;
            EXCEPTION WHEN NO_DATA_FOUND THEN G45_:=null;
           end;
         end loop;
   end;

   --46 Общая сумма обеспечения, грн.
   --53 Сумма обеспечения, кот.берется для расчета
   --54 Сумма задолженности, кот.берется для расчета
   --55 Коэф-т резервирования по ступени риска (%)
   --56 Расчетная сумма резерва, грн.
   select nvl(sum(t.obesp),0), nvl(sum(soq)/100,0), nvl(sum(t.skq2)/100,0), max(t.pr_rez),
          sum(decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_)))/100
   into G46_, G53_, G54_, G55_, G56_
   from TMP_REZ_RISK t
   where t.acc=k.acc and t.id=U_REZ_ and t.dat=D_REZ_ and t.s080<'9';

   bars_audit.trace('%s 11.Дог.реф=%s:G45_=%s,G46_=%s,G52_=%s,G53_=%s,G54_=%s,G55_=%s,G56_=%s',
            l_title,to_char(k.nd),to_char(G45_),to_char(G46_),to_char(G52_),to_char(G53_),to_char(G54_),to_char(G55_),to_char(G56_));

   --57 Фактически сформированный резерв за счет прибыли
   --58 Фактически сформированный резерв за счет вал.затрат
   --59 Отклонение

   --57
   select sum(decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_)))/100
   into G57_
   from TMP_REZ_RISK t
   where t.acc=k.acc and t.id=U_REZ1_ and t.dat=D_REZ1_ and s080='1';
   --58
   select sum(decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_)))/100
   into G58_
   from TMP_REZ_RISK t
   where t.acc=k.acc and t.id=U_REZ1_ and t.dat=D_REZ1_ and t.s080<>'1' and t.s080<'9';
   --59
   G59_:= G56_ - (G57_ + G58_);

   bars_audit.trace('%s 12.Дог.реф=%s:G57_=%s,G58_=%s,G59_=%s',
           l_title,to_char(k.nd),to_char(G57_),to_char(G58_),to_char(G59_));

   --60 Пеня и штрафы
   select -(nvl(sum(fostQ(a.acc,DAT_) )/100,0))  into G60_
   from accounts a, nd_acc n
   where n.nd=k.ND and a.acc=n.acc and a.tip in ('SN8') ;

   --61 Отношение кредита к проблемному (код типу)
   begin
     select substr(txt,1,110) into G61_ from nd_txt
      where tag='PROBL' and nd=k.ND;
     EXCEPTION WHEN NO_DATA_FOUND THEN G61_:= null;
   end;

   --62 Расчетный резерв проср.и сомнит.проценты
   --63 Фактический резерв проср.и сомнит.проценты

   select sum(decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_)))/100
   into G62_
   from TMP_REZ_RISK t, nd_acc n
   where n.nd=k.ND and  n.acc=t.acc and t.id=U_REZ_ and t.dat=D_REZ_ and t.s080='9'
         and
         ( (k.tip ='SS ' and substr(t.nls,4,1) ='8') or
           (k.tip ='SP ' and substr(t.nls,4,1) <> '8' and instr(s080_name,'Сомнит') = 0) or
           (k.tip ='SL ' and substr(t.nls,4,1) <> '8' and instr(s080_name,'Сомнит') <> 0)
         )
         ;

   select sum(decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_)))/100
   into G63_
   from TMP_REZ_RISK t, nd_acc n
   where n.nd=k.ND and  n.acc=t.acc and t.id=U_REZ1_ and t.dat=D_REZ1_ and t.s080='9'
         and
         ( (k.tip ='SS ' and substr(t.nls,4,1) ='8') or
           (k.tip ='SP ' and substr(t.nls,4,1) <> '8' and instr(s080_name,'Сомнит') = 0) or
           (k.tip ='SL ' and substr(t.nls,4,1) <> '8' and instr(s080_name,'Сомнит') <> 0)
         )
   ;

  --64 Сумма неамортизированного дисконта
  begin
  select nvl(fost(a.acc, dat_),0) into G64_
    from accounts a, nd_acc na
   where a.tip='SDI' and a.acc=na.acc and na.nd=k.nd and (a.dazs is null or a.dazs>DAT_);
  exception when no_data_found then G64_ := 0;
  end;

   bars_audit.trace('%s 13.Дог.реф=%s:G60_=%s,G61_=%s,G62_=%s,G63_=%s,G64_=%s',
           l_title,to_char(k.nd),to_char(G60_),to_char(G61_),to_char(G62_),to_char(G63_),to_char(G64_));
----------==========================
insert into INV_CCK_UL
(G01 , G02 , G03 , G04 , G05 , G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
 G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
 G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
 G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
 G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 ,
 G61 , G62 , G63 , G64 , G00 )
values
(G01_, G02_, G03_, G04_, G05_, G06_, G07_, G08_, G09_, G10_, G11_, G12_,
 G13_, G14_, G15_, G16_, G17_, G18_, G19_, G20_, G21_, G22_, G23_, G24_,
 G25_, G26_, G27_, G28_, G29_, G30_, G31_, G32_, G33_, G34_, G35_, G36_,
 G37_, G38_, G39_, G40_, G41_, G42_, G43_, G44_, G45_, G46_, G47_, G48_,
 G49_, G50_, G51_, G52_, G53_, G54_, G55_, G56_, G57_, G58_, G59_, G60_,
 G61_, G62_, G63_, G64_, DAT_);

 <<HET>> null;

END LOOP;

--------------------------!!!!!!!!!!!!!!!!! БПК !!!!!!!!!!!!!!!!!--------------------------
/* bars_audit.trace('%s 14.Вставляем данные по БПК ЮЛ.',l_title);

for m in (
  select b.name G01, a.branch G02, 'БПК' G04, decode(c.bc,1,'нк','к') G05,  p.prinsiderlv1 G06,  ca.rezid G07,
       a.kv G09, cu.oe G17, cu.mb G18, cu.fs G19,
       a.nbs G20,
       -sum((fost(a.acc,dat_)/100))  G21,
       -sum((fostq(a.acc,dat_)/100)) G22,
       sum(decode(s.ob22,'01',-(nvl(fostQ(ba.acc_9129,dat_)/100,0)),'10',-(nvl(fostQ(ba.acc_9129,dat_)/100,0)), 0)) G23,
       sum(decode(s.ob22,'03',-(nvl(fostQ(ba.acc_9129,dat_)/100,0)),'05',-(nvl(fostQ(ba.acc_9129,dat_)/100,0)),
                         '07',-(nvl(fostQ(ba.acc_9129,dat_)/100,0)), '11',-(nvl(fostQ(ba.acc_9129,dat_)/100,0)), 0)) G24,
       -sum((fostq(ba.acc_2208,dat_)/100)) G26,
       0 G27,  0 G28,  0 G29,  0 G30,
       decode(t.fin,1,'А',2,'Б',3,'В',4,'Г','Д') G35,
       nvl(t.s080,'1') G36, t.OBS G37,
       sum(decode(t.s080,'9',0,nvl(t.obesp,0)))    G46,
       sum(decode(t.s080,'9',0,nvl(soq/100,0)))    G53,
       sum(decode(t.s080,'9',0,nvl(t.skq2/100,0))) G54,
       sum(decode(t.s080,'9',0,decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_))))/100              G56,
       sum(decode(t.s080,'1',decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_)), 0))/100             G57,
       sum(decode(t.s080,'1',0,'9',0, decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_))))/100       G58,
       sum(decode(t.s080,'9',0,decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_))))/100 -
            (   sum(decode(t.s080,'1',decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_)), 0))/100
              + sum(decode(t.s080,'1',0,'9',0, decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,dat_))))/100 ) G59
   from bpk_acc ba, customer c, accounts a, branch b, specparam_int s, tmp_rez_risk t,
        prinsider p, codcagent ca,
	(select rnk, oe, decode(mb,1,'10',9,'90','') mb, fs
	   from customer_update
	  where (rnk,idupd) in (select rnk, max(idupd) from customer_update where chgdate<=DAT_ group by rnk) ) cu
  where ba.acc_ovr is not null
    and ba.acc_ovr   = a.acc
    and (a.dazs is null or a.dazs>DAT_)
    and a.branch     = b.branch
    and a.rnk        = c.rnk
    and c.custtype   = 2
    and p.prinsider  = c.prinsider
    and ca.codcagent = c.codcagent
    and c.rnk        = cu.rnk (+)
    and ba.acc_9129  = s.acc(+)
    and a.acc        = t.acc
    and t.id         = U_REZ_
    and t.dat        = D_REZ_
   -- and a.acc in ()    -- отладка!
  group by b.name, a.branch, c.bc, p.prinsiderlv1, ca.rezid, a.kv, cu.oe, cu.mb, cu.fs, a.nbs, t.fin, t.s080, t.OBS, t.obesp    )

loop

  insert into INV_CCK_UL
  (G01 , G02 , G03 , G04 , G05 , G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 ,
   G61 , G62 , G63 , G64 , G00 )
  values
  (m.G01, m.G02,  null, m.G04, m.G05, m.G06, m.G07,  null, m.G09,  null,  null,  null,
    null,  null,  null,  null, m.G17, m.G18, m.G19, m.G20, m.G21, m.G22, m.G23, m.G24,
    null, m.G26, m.G27, m.G28, m.G29, m.G30,  null,  null,  null,  null, m.G35, m.G36,
   m.G37,  null,  null,  null,  null,  null,  null,  null,  null, m.G46,  null,  null,
    null,  null,  null,  null, m.G53, m.G54,  null, m.G56, m.G57, m.G58, m.G59,  null,
    null,  null,  null,  null, DAT_);

end loop;     */

commit;
  bars_audit.trace('%s 15.Финиш инвентаризации КП ЮЛ.',l_title);
end P_INV_CCK_UL ;
/
show err;

PROMPT *** Create  grants  P_INV_CCK_UL ***
grant EXECUTE                                                                on P_INV_CCK_UL    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_INV_CCK_UL    to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INV_CCK_UL.sql =========*** End 
PROMPT ===================================================================================== 
