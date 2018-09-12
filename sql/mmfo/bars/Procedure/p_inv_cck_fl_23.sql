

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INV_CCK_FL_23.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INV_CCK_FL_23 ***

  CREATE OR REPLACE PROCEDURE BARS.P_INV_CCK_FL_23 (p_dat date, p_frm int, p_mode int default 0) is
-- ============================================================================
--                    Инвентаризационная ведомость - 23 постанова
--                          VERSION 7.2 (12/09/2018)
-- ============================================================================
/*
 12-09-2018(7.2) - G05 = Null - COBUMMFO-9420
 Даные про классификацию кредитных операций и расчет сумы резерва по физ.лицам - 23 постанова
 p_dat   -- на дату  (ПОСЛЕДНЯЯ ДАТА МЕСЯЦА!!!!!!)
 p_frm   -- с(1)/без(0) переформирования
 p_mode  -- 1 - JOB, 0 - без JOB
*/

  Di_       number    ;   -- accm_calendar.caldt_id%type
  l_dat     date := p_dat ;

  l_err     varchar2(25);
  l_title   varchar2(20) := 'CCK P_INV_CCK_FL_23:'; -- для трассировки
  fd_       varchar2(10) := 'DD.MM.YYYY';  -- формат дат

  GG   INV_CCK_FL_23%rowtype; l_code  regions.code%type;      l_kf      varchar2(6) ;

  dTmp_     date;
  nTmp_     int;

  acc_SS    int;
  acc_ZAL   int;
  acc_pot   int;
  l_acc_sp   number;
  l_ost_sp   number;
  l_sp       number := 0;
  l_sum8     number := 0;
  l_sum9     number := 0;

  l_acc9129 accounts.acc%type;
  l_nd      cc_deal.nd%type;
  l_count_s031   number;
  l_time_start   varchar2(20);
  l_time_finish  varchar2(20);
  L_MES          varchar2(100) := 'Сообщение';
  L_MES_err      varchar2(100) := 'Ошибка';

  l_usedwh    char(1);        -- использование загрузки в ЦАС
  l_errmsg    varchar2(500);  -- сообщение
  l_errcode   number;         -- код выполнения

begin
   --
   -- проверка на возможность пересчета инв. ведомости
   -- Выполняется только для тех у кого работает загрузка в ЦАС
   --
/*   begin
      select val into l_usedwh from params$global  where par = 'CCKDWH';

      if l_usedwh = '1' then
         bars.bars_dwhcck.check_import_status(
                 p_date        => p_dat,
                 p_daymon_flag => 1,
                 p_errmsg      => l_errmsg,
                 p_retcode     => l_errcode);

         if l_errcode <> 0 then
            raise_application_error(-20079,l_errmsg );
         end if;

      end if;
   exception when no_data_found then l_usedwh := '0';
   end;   */
if p_mode = 0 THEN

  GG.kf := sys_context('bars_context','user_mfo');
  z23.to_log_rez (user_id , 77 , l_dat ,'INV:1. Инвентаризация ФО-23 - початок');
  select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') into l_time_start from dual;
  bars_audit.trace('%s TIME_Start: l_time_start=%s',l_title, l_time_start);
  bars_audit.trace('%s 0.Старт инвентаризации КП ФЛ. Вх.пар-ры:l_dat=%s, p_frm=%s',l_title, to_char(l_dat), to_char(p_frm));

 -- если необходимо перенакопить снапы:
 -- ежемесячные
 -- Begin
 --  bars_accm_sync.sync_agg('MONBAL', to_date('29/04/2011','dd/mm/yyyy'),0);
 -- End;

----------------------------------

 -- Id отч.даты
  if getglobaloption('HAVETOBO') = 2 then
    execute immediate 'select  to_char ( add_months( (last_day(:l_dat)+1), -1), ''J'' ) - 2447892 from dual' into Di_ using l_dat;
  else Di_ := to_number(to_char(l_dat,'DDMMYYYY'));
  end if;

   bars_audit.trace('%s 1.Дата отчета l_dat=%s, Di_=%s',l_title, to_char(l_dat),to_char(Di_));

  -- передаем дату в pul, чтоб потом при населении таблицы данными дата подтянулась в фильтр
  PUL.Set_Mas_Ini( 'sFdat1', to_char(l_dat,'dd/mm/yyyy'), 'Пар.sFdat1' );

  /*p_frm = 0 - без переформирования */
  if nvl(p_frm,0) = 0  then
     begin
       select 1 into nTmp_ from INV_CCK_FL_23 where G00 = l_dat and GT = 1 and rownum = 1;
       z23.to_log_rez (user_id , 77 , l_dat ,'INV:1. Инвентаризация ФО-23 - фініш (без розрахунку)');
       return;
     exception when no_data_found then null;
     end;
  end if;
  dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||': Інвентаризація КП ФО - Підготовка');
  -- почистим все за выбранную дату
  z23.to_log_rez (user_id , 77 , l_dat ,'INV:2. Удаление INV_CCK_FL_23 ');
  delete from INV_CCK_FL_23 where G00 = l_dat and GT = 1;
  z23.to_log_rez (user_id , 77 , l_dat ,'INV:3. Удаление INV_CCK_FL_BPKK_23 ');
  delete from INV_CCK_FL_BPKK_23 where G00 = l_dat and GT = 1;
  z23.to_log_rez (user_id , 77 , l_dat ,'INV:4. Інвентаризація КП ФО - КП ');
  commit;
  dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||':1-4. Інвентаризація КП ФО - КП');
  --курсор по КП
for k in
     ( select d.nd,c.OKPO, d.wdate, d.obs, d.cc_id, a.kv, c.NMK,
           a.acc,d.SDOG, c.PRINSIDER , d.PROD, d.branch, a.tip, c.rnk, d.kf, a.ob22, a.daos, a.ostc, a89.acc accc, c.nompdv
      from cc_deal d, customer c, accounts a, nd_acc n, accounts a89
     where d.vidd in (11,12,13) and d.sos >= 10
       and d.rnk = c.rnk
       and d.nd  = n.nd
       and n.acc = a.acc
       and a.tip in ('SS ','SP ','SL ')
       and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat
       and a.accc = a89.acc
       and a89.tip = 'LIM' and a89.nls like '8999%'
       and (a89.dazs is null or a89.dazs > l_dat) and a89.daos <= l_dat
       --and d.nd in ( 15195, 17930, 58046)  -- отладка!!!!!!!
       UNION  -- добавляем те КД, у которых нет тела, а только %%
       select d.nd,c.OKPO, d.wdate, d.obs, d.cc_id, a.kv, c.NMK,
           a.acc,d.SDOG, c.PRINSIDER , d.PROD, d.branch, a.tip, c.rnk, d.kf, a.ob22, a.daos, a.ostc,
           ( select a8.acc from accounts a8, nd_acc n8 where a8.acc=n8.acc and n8.nd=d.nd and a8.tip='LIM') accc, c.nompdv
      from cc_deal d, customer c, accounts a, nd_acc n
     where d.vidd in (11,12,13) and d.sos >= 10
       and d.rnk = c.rnk
       and d.nd  = n.nd
       and n.acc = a.acc
       and a.tip in ('SPN', 'SLN')
       and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat
       and d.nd not in
                          ( select d.nd
                              from cc_deal d, accounts a, nd_acc n
                             where d.vidd in (11,12,13) and d.sos >= 10
                               and d.nd  = n.nd
                               and n.acc = a.acc
                               and a.tip in ('SS ','SP ','SL ')
                               and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat )
       UNION  -- добавляем те КД, у которых нет тела, а только 9129
       select d.nd,c.OKPO, d.wdate, d.obs,  d.cc_id, a.kv, c.NMK,
           a.acc,d.SDOG, c.PRINSIDER , d.PROD, d.branch, a.tip, c.rnk, d.kf, a.ob22, a.daos, a.ostc,
           ( select a8.acc from accounts a8, nd_acc n8 where a8.acc=n8.acc and n8.nd=d.nd and a8.tip='LIM') accc, c.nompdv
      from cc_deal d, customer c, accounts a, nd_acc n
     where d.vidd in (11,12,13) and d.sos >= 10
       and d.rnk = c.rnk
       and d.nd  = n.nd
       and n.acc = a.acc
       and a.tip in ('CR9')
       and f_get_ost(a.acc,di_,1,8)<>0
       and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat
       and d.nd not in
                          ( select d.nd
                              from cc_deal d, accounts a, nd_acc n
                             where d.vidd in (11,12,13) and d.sos >= 10
                               and d.nd  = n.nd
                               and n.acc = a.acc
                               and a.tip in ('SS ','SP ','SL ')
                               and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat )
      )
----------------------
loop
   -- обнуляем переменные
   GG.G01 := null;    GG.G02 := null;   GG.G03 := null;   GG.G04 := null;   GG.G05 := null;   GG.G05I := null;  GG.G06 := 0;      GG.G07 := 0;         GG.G08 := null;
   GG.G09 := null;    GG.G10 := null;   GG.G11 := null;   GG.G12 := null;   GG.G13 := 0;      GG.G14 := null;   GG.G15 := null;      GG.G16 := null;
   GG.G17 := 0;       GG.G18 := null;   GG.G19 := null;   GG.G20 := null;   GG.G21 := 0;      GG.G22 := 0;      GG.G23 := 0;         GG.G24 := 0;
   GG.G25 := 0;       GG.G26 := 0;      GG.G27 := 0;      GG.G28 := null;   GG.G29 := 0;      GG.G30 := 0;      GG.G31 := 0;         GG.G32 := null;
   GG.G33 := null;    GG.G34 := null;   GG.G35 := null;   GG.G36 := null;   GG.G37 := null;   GG.G38 := null;   GG.G39 := 0;         GG.G40 := 0;
   GG.G41 := 0;       GG.G42 := 0;      GG.G43 := 0;      GG.G44 := 0;      GG.G45 := 0;      GG.G46 := null;   GG.G47 := null;      GG.G48 := null;
   GG.G49 := null;    GG.G50 := 0;      GG.G51 := 0;      GG.G52 := 0;      GG.G53 := null;   GG.G54 := 0;      GG.G55 := 0;         GG.G56 := 0;
   GG.G57 := 0;       GG.G58 := null;   GG.G59 := 0;      GG.G60 := null;   GG.G61 := 0;      GG.G62 := null;   GG.G63 := 0;         GG.G64 := null;    GG.G65 := null;
   l_nd := 0;

----------------
   -- для отслеживания ошибок при ексепшине
   l_err := 'КП: КД № '||k.nd||' ';

   --01 Наименование отделения
   begin
     select name into GG.G01 from branch where branch = '/'||k.kf||'/';
   exception when no_data_found then  GG.G01 := null;
   end;

   --02 Филиал
   GG.G02 := k.kf;

   --03 Отделение
   GG.G03 := k.branch;

   bars_audit.trace('%s 2.Дог.реф=%s:G01=%s,G02=%s,G03=%s',l_title,to_char(k.nd),to_char(GG.G01),to_char(GG.G02),to_char(GG.G03));

   --04 Наименование заемщика
   GG.G04 := k.NMK;

   --05 Номер плательщика налогов --INV_CCK_FL_23  
   --GG.G05 := k.nompdv;     --G05=Null - COBUMMFO-9420

   --05I OKPO
   GG.G05I := k.OKPO;

   -- выберем acc "главное", в строке которого будем писать повторяющиеся значения
   begin
    select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip = 'SS ' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
          and f_get_ost(a.acc,di_,1,8)<>0 and a.acc=na.acc and na.nd=k.nd;
    if acc_pot is null then
       select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip in ('SS ','SP ','SL ') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
          and f_get_ost(a.acc,di_,1,8)<>0 and a.acc=na.acc and na.nd=k.nd;
       if acc_pot is null then
            select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip in ('SS ','SP ','SL ') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                and a.acc=na.acc and na.nd=k.nd and a.daos = (select min(a.daos)
	                                                        from accounts a, nd_acc na
	     		   				       where a.tip in ('SS ','SP ','SL ') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                                                                 and a.acc=na.acc and na.nd=k.nd) ;
            if acc_pot is null then
               select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip in ('SPN','SLN') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                  and f_get_ost(a.acc,di_,1,8)<>0 and a.acc=na.acc and na.nd=k.nd;
              if acc_pot is null then
                 select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip in ('SPN','SLN') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                   and a.acc=na.acc and na.nd=k.nd;
               if acc_pot is null then
                   select a.acc into acc_pot from accounts a, nd_acc na where a.tip in ('CR9') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                      and f_get_ost(a.acc,di_,1,8)<>0 and a.acc=na.acc and na.nd=k.nd;
               end if;
              end if;
            end if;
	end if;
     end if;
   end;

   --06 Сумма по договору в валюте договора
   GG.G06 := k.SDOG;

   --07 Валюта договора
   GG.G07 := k.KV;

   --08  № договора
   GG.G08 := k.CC_ID;

   bars_audit.trace('%s 3.Дог.реф=%s:acc_pot=%s,G04=%s,G05=%s,G06=%s,G07=%s,G08=%s',
                      l_title,to_char(k.nd),to_char(acc_pot),to_char(GG.G04),to_char(GG.G05),to_char(GG.G06),to_char(GG.G07),to_char(GG.G08));

   --09 Дата фактической выдачи средств (в карточке КД - дата выдачи)
   --   !!! Не берем как первое движение по saldoa, так как после импорта - даты такой не будет
   select to_char(wdate,fd_) into GG.G09 from cc_add where nd = k.nd;

   --10 Планируемая дата погашения (первоначальная)';
   begin
    select to_char(mdate,fd_) into GG.G10 from cc_prol where nd = k.ND and npp = 0;
   exception when no_data_found then
      begin
       select to_char(mdate,fd_) into GG.G10 from cc_prol where npp = ( select min(npp)
                                                                          from cc_prol
							                 where fdat <= l_dat
							                   and nd = k.nd
							                   and mdate is not null
							               group by nd) and nd = k.nd and rownum = 1;
      exception when no_data_found then null;
      end;
   end;

   --11 Планируемая дата погашения с учетом последней пролонгации' - если пролонгации не было - пусто;
   begin
     select mdate into dTmp_ from cc_prol where npp = ( select max(npp)
                                                          from cc_prol
							 where fdat <= l_dat and npp>0
							   and nd = k.nd
							   and mdate is not null
							  group by nd) and nd = k.nd and rownum = 1;
   exception when no_data_found then dTmp_ := null;
   end;

   if GG.G10 =  to_char(dTmp_,fd_) or GG.G10 > to_char(dTmp_,fd_) then  GG.G11 := null;
   else GG.G11 := to_char(dTmp_,fd_);
   end if;

   bars_audit.trace('%s 4.Дог.реф=%s:G09=%s,G10=%s,G11=%s',l_title,to_char(k.nd),to_char(GG.G09),to_char(GG.G10),to_char(GG.G11));

   -- 12,13 - данные по реструктуризации
   -- cck_restr - смотрим сколько вообще реструктуризаций независимо от вида
   select count(*) into GG.G13 from cck_restr where nd = k.nd and fdat <= l_dat;

   -- если реструктуризаций не было - признак "нет" (2), иначе - "реструктуризирован" (1)
   select decode(GG.G13,0, '2', '1') into GG.G12 from dual;

   -- cck_restr - смотрим сколько пролонгаций по видам вида
   /*
   13а Зм_на виду платежу по кредиту (з погашення р_вними частками на ану_тетний плат_ж)
   13б Пролонгац_я кредиту
   13в Зм_на граф_ку погашення кредиту
   13г Зм_на валюти зобовязання
   13д Реф_нансування кредиту
   13е Зм_на виду забезпечення з прийняттям в забезпечення поруки платоспроможних ф_зичних ос_б
   13ж Реструктуризац_я простроченої заборгованост_
   13з Зм_на предмету забезпечення без прийняття в  забезпечення поруки платоспроможних ф_зичних ос_б
   13i Рефінансування із залученням нового позичальника
   */

   select  sum(decode(vid_restr, 1, 1, 0)), sum(decode(vid_restr, 7, 1, 0)),  sum(decode(vid_restr, 8, 1, 0)),
           sum(decode(vid_restr, 9, 1, 0)), sum(decode(vid_restr, 10, 1, 0)), sum(decode(vid_restr, 11, 1, 0)),
          sum(decode(vid_restr, 13, 1, 0)), sum(decode(vid_restr, 12, 1, 0)), sum(decode(vid_restr, 14, 1, 0))
     into   GG.G13a, GG.G13b, GG.G13v,
            GG.G13g, GG.G13d, GG.G13e,
            GG.G13j, GG.G13z, GG.G13i
     from cck_restr
    where nd = k.nd and fdat <= l_dat;

     bars_audit.trace('%s 5.Дог.реф=%s:G12=%s,G13=%s', l_title,to_char(k.nd),GG.G12,to_char(GG.G13));

  --14 Дата виникнення першого, із всіх існуючих на звітну дату, непогашених прострочених платежів за основним боргом
  -- беру по доп.реквизиту, если пусто - функцией
   begin
     select decode(k.tip, 'SP ', to_char(to_date(substr(f_get_nd_txt(k.ND, 'DATSP', l_dat),1,10),fd_),fd_),null)
       into GG.G14
       from dual
      where k.tip = 'SP ' and f_get_ost(k.acc,DI_,1,7)<>0;
     if GG.G14 is null then
       l_acc_sp := null;
       begin
         select max(a.acc) into l_acc_sp
           from accounts a, nd_acc n
          where n.nd = k.nd
            and n.acc = a.acc
            and a.tip = 'SP '
            and (a.dazs is null or a.dazs > l_dat)
            and a.daos <= l_dat
            and f_get_ost(a.acc, di_, 1, 7)<>0;
       exception when no_data_found then l_acc_sp := 0;
       end;

       if l_acc_sp > 0 then
          l_ost_sp := -f_get_ost(l_acc_sp, di_, 1, 7);
          l_sp := 0;

         for dsp in (select s.fdat, s.dos
                       from saldoa s
                      where acc = l_acc_sp
                        and s.fdat <= l_dat
                      order by s.fdat desc)
            loop
              l_sp := l_sp + dsp.dos;
              if l_sp >= l_ost_sp then GG.G14 := to_char(dsp.fdat,fd_); exit; end if;
            end loop;

       else GG.G14 := null;
       end if;
     end if;
   exception when no_data_found then
       l_acc_sp := null;
       begin
         select max(a.acc) into l_acc_sp
           from accounts a, nd_acc n
          where n.nd = k.nd
            and n.acc = a.acc
            and a.tip = 'SP '
            and (a.dazs is null or a.dazs > l_dat)
            and a.daos <= l_dat
            and f_get_ost(a.acc, di_, 1, 7)<>0;
       exception when no_data_found then l_acc_sp := 0;
       end;

       if l_acc_sp > 0 then
          l_ost_sp := -f_get_ost(l_acc_sp, di_, 1, 7);
          l_sp := 0;

         for dsp in (select s.fdat, s.dos
                       from saldoa s
                      where acc = l_acc_sp
                        and s.fdat <= l_dat
                      order by s.fdat desc)
            loop
              l_sp := l_sp + dsp.dos;
              if l_sp >= l_ost_sp then GG.G14 := to_char(dsp.fdat,fd_); exit; end if;
            end loop;

       else GG.G14 := null;
       end if;
   end;

   --15 Дата виникнення першого, із всіх існуючих на звітну дату, непогашених прострочених платежів за нарахованими доходами
   l_acc_sp := null;
   begin
     select max(a.acc) into l_acc_sp
       from accounts a, nd_acc n
      where n.nd = k.nd
        and n.acc = a.acc
        and a.tip = 'SPN'
        and (a.dazs is null or a.dazs > l_dat)
        and a.daos <= l_dat
        and f_get_ost(a.acc, di_, 1, 7)<>0;
     exception when no_data_found then l_acc_sp := 0;
     end;

     if l_acc_sp > 0 then
        l_ost_sp := -f_get_ost(l_acc_sp, di_, 1, 7);
        l_sp := 0;

       for dsp in (select s.fdat, s.dos
                     from saldoa s
                    where acc = l_acc_sp
                      and s.fdat <= l_dat
                    order by s.fdat desc)
          loop
            l_sp := l_sp + dsp.dos;
            if l_sp >= l_ost_sp then GG.G15 := to_char(dsp.fdat,fd_); exit; end if;
          end loop;

     else GG.G15 := null;
     end if;

   if to_date(GG.G14,fd_) > nvl(to_date(GG.G11,fd_),to_date(GG.G10,fd_)) then  GG.G14 := nvl(GG.G11,GG.G10); end if;
   if to_date(GG.G15,fd_) > nvl(to_date(GG.G11,fd_),to_date(GG.G10,fd_)) then  GG.G15 := nvl(GG.G11,GG.G10); end if;

   --16 Дата виз-ня кредиту проблемним на КК
   -- беру по доп.реквизиту NOHOP, если ее нет - то как дату вынесения на сомнительные
   begin
     select to_char(to_date(substr(f_get_nd_txt(k.ND, 'NOHOP',l_dat),1,10),fd_),fd_) into GG.G16 from dual;
    if GG.G16 is null then
      begin
        select decode(k.tip,'SL ',to_char(max(fdat),fd_),null)
          into GG.G16
          from saldoa
         where ostf = 0 and fdat <= l_dat and dos > 0
           and acc in (select n.acc from nd_acc n, accounts a
                        where a.acc = n.acc and n.nd = k.ND and a.tip = 'SL ');
      EXCEPTION WHEN NO_DATA_FOUND THEN GG.G16 := null;
      end;
    end if;
   end;

   bars_audit.trace('%s 6.Дог.реф=%s:G14=%s,G15=%s,G16=%s',l_title,to_char(k.nd),to_char(GG.G14),to_char(GG.G15),to_char(GG.G16));

   --17 Ознака _нсайдера зг_дно класиф_катору KL_K061
   select prinsiderlv1 into GG.G17 from prinsider where prinsider = nvl(k.prinsider,2);

   --18 Пiдстава для надання кредиту iнсайдеру банку
   -- они должны вписывать эту текстовку при авторизации
   if GG.G17 = 1 then
        select substr(f_get_nd_txt(k.ND, 'AUTOR',l_dat),1,250) into GG.G18 from dual;
   end if;

   bars_audit.trace('%s 7.Дог.реф=%s:rnk=%s,G17=%s,G18=%s',l_title,to_char(k.nd),to_char(k.rnk),to_char(GG.G17),to_char(GG.G18));

   --19 Номер бал.счета
   begin
     select accs into ACC_SS
       from cc_add ca, accounts a
      where ca.nd = k.nd and ca.adds = 0 and ca.accs = a.acc and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat;
   exception when no_data_found then  ACC_SS := k.acc;
   end;

   select nbs  into GG.G19 from accounts where acc = k.acc;

    --20 Частина № анал?тичного рахунку
   GG.G20 := k.ob22;

   --21 Фактический остаток задолженности в валюте договора';
   if k.tip in ('SS ','SP ','SL ') then
        GG.G21 := -(f_get_ost(k.acc,DI_,1,7)/100);
   else GG.G21 := 0;
   end if;

   --22 Фактический остаток задолженности в национальной валюте';
   if k.tip in ('SS ','SP ','SL ') then
        GG.G22 := -(f_get_ost(k.acc,DI_,1,8)/100);
   else GG.G22 := 0;
   end if;

   --23 Сума неамортизованого дисконту на звiтну дату

   begin
   select -decode(k.acc,acc_pot, SUM(nvl( f_get_ost(a.acc,DI_,1,8) ,0)/100),0) into GG.G23
     from accounts a, nd_acc na
    where a.tip = 'SDI' and a.acc = na.acc and na.nd = k.nd
      and (dazs is null or dazs > l_dat) and a.daos <= l_dat;
   exception when no_data_found then GG.G23 := 0;
   end;

   bars_audit.trace('%s 8.Дог.реф=%s:G19=%s,G20=%s,G21=%s,G22=%s,G23=%s',
                      l_title,to_char(k.nd),to_char(GG.G19),to_char(GG.G20),to_char(GG.G21),to_char(GG.G22),to_char(GG.G23));

   --24 Код обл_ку заборгованост_ на балансових рахунках
   begin
     select nd
       into l_nd
       from nd_acc na, accounts a
      where na.acc = a.acc and na.nd = k.nd
        and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
        and f_get_ost(a.acc,DI_,1,7)<>0
        and a.tip = 'SS ' and rownum = 1;
         begin
           select 3 into GG.G24
             from nd_acc na, accounts a
            where na.acc = a.acc and na.nd = k.nd
              and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
              and f_get_ost(a.acc,DI_,1,7)<>0
              and a.tip = 'SP ' and rownum = 1;
         exception when no_data_found then GG.G24 := 1;
         end;
   exception when no_data_found then GG.G24 := 2;
   end;

   --25 9129 в нац вал за якими банк ризику не несе (9129 с r013=9);
   begin
   select a.acc into l_acc9129
     from accounts a, nd_acc n, nbu23_rez r
    where n.nd = k.ND and a.acc = n.acc and a.nbs = '9129' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
      and a.acc = r.acc and r.nd = k.nd and r.rnk = k.rnk and r.r013 = '9' and r.fdat = trunc(last_day(l_dat)+1,'MM') and r.id like 'CCK%';
      select -decode(k.acc, acc_pot, nvl(f_get_ost (l_acc9129,DI_,1,8),0)/100, 0)
        into GG.G25
        from dual;
   exception when no_data_found then GG.G25 := 0;
             when others then
                 if (sqlcode = -1422) then
		          RAISE_APPLICATION_ERROR (-20078,'К договору реф = '||to_char(k.ND)||' присоединено более одного счета 9129. Отсоедините и выполните переформирование!' );
			  return;
		 else raise;
		 end if;
   end;

   --26 9129 в нац вал ризиков (9129 с r013=1)
   begin
   select a.acc into l_acc9129
     from accounts a, nd_acc n, nbu23_rez r
    where n.nd = k.ND and a.acc = n.acc and a.nbs = '9129' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
      and a.acc = r.acc and r.nd = k.nd and r.rnk = k.rnk and r.r013 = '1' and r.fdat = trunc(last_day(l_dat)+1,'MM') and r.id like 'CCK%';
      select -decode(k.acc, acc_pot, nvl(f_get_ost (l_acc9129,DI_,1,8),0)/100, 0)
        into GG.G26
        from dual;
   exception when no_data_found then GG.G26 := 0;
             when others then
                 if (sqlcode = -1422) then
		          RAISE_APPLICATION_ERROR (-20078,'К договору реф = '||to_char(k.ND)||' присоединено более одного счета 9129. Отсоедините и выполните переформирование!' );
			  return;
		 else raise;
		 end if;
   end;


   bars_audit.trace('%s 9.Дог.реф=%s:G24=%s,G25=%s,G26=%s', l_title,to_char(k.nd),to_char(GG.G24),to_char(GG.G25),to_char(GG.G26));

   --27 Действующая cтавка (% годовых)
    select nvl(acrn.fprocn(k.acc,0,l_dat),0)  into GG.G27  from dual;

   --28 Эффект. cтавка (% годовых)
    select acrn.fprocn(k.accc,-2,l_dat)  into GG.G28  from dual;

   --29 Непрострочені нарах.доходи
   l_sum8 := 0;

   for ss08 in (select a.acc, nvl( -f_get_ost(a.acc,DI_,1,8)/100, 0) ost
                  from accounts a, nd_acc na
                 where a.tip in ('SN ','SNO') and a.acc = na.acc and na.nd = k.nd
                   and (dazs is null or dazs > l_dat) and a.daos <= l_dat)
   loop
     l_sum8 := l_sum8 + ss08.ost;
     -- Вставляем обработанные ACC счетов SN
     INSERT INTO TMP_INV_2208_23 (ACC) VALUES (ss08.acc);
   end loop;

   select decode(k.acc, acc_pot, l_sum8, 0) into GG.G29 from dual;


   --30 Прострочені нарах.доходи
   l_sum9 := 0;

   for ss09 in (select a.acc, nvl( -f_get_ost(a.acc,DI_,1,8)/100, 0) ost
                  from accounts a, nd_acc na
                 where a.tip in ('SPN','SLN') and a.acc = na.acc and na.nd = k.nd
                   and (dazs is null or dazs > l_dat) and a.daos <= l_dat)
   loop
     l_sum9 := l_sum9 + ss09.ost;
     -- Вставляем обработанные ACC счетов SN
     INSERT INTO TMP_INV_2208_23 (ACC) VALUES (ss09.acc);
   end loop;

   select decode(k.acc, acc_pot, l_sum9, 0) into GG.G30 from dual;

   --31 Сума забезпечення на звітну дату у вигляді поруки (34 код згідно класифікатора НБУ KL_S031), грн

   begin
   select decode(k.acc,acc_pot,nvl( sum(f_get_ost (a.acc,DI_,1,8))/100,0),0)
     into GG.G31
     from accounts a, cc_accp z, cc_pawn c, pawn_acc pa
    where z.accs = ACC_SS and z.acc = a.acc and a.nbs = '9031' and a.tip='ZAL' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
      and a.acc = pa.acc and pa.pawn = c.pawn and c.s031 = 34;
   EXCEPTION WHEN NO_DATA_FOUND THEN GG.G31 := 0;
   end;

   bars_audit.trace('%s 10.Дог.реф=%s:G27=%s,G28=%s,G29=%s,G30=%s,G31=%s',
                      l_title,to_char(k.nd),to_char(GG.G27),to_char(GG.G28),to_char(GG.G29),to_char(GG.G30),to_char(GG.G31));

    -- 32 Клас боржника
    -- 36 Стан обслуговування боргу
    -- 35 Класифікація за категоріями якості
    -- 41 Значення показнику ризику
    -- 57 Тепер.вартість попер.оцінених майб.грош.потоків
    --42 Розрахункова сума резерву, грн.
    --43 Фактично сформована сума резерву, грн., за кредитами, які не враховані в ПО
    --44 Фактично сформована сума резерву, грн., за кредитами, які враховані в ПО
    --56 Балансова вартість кредиту, грн.
    --40 Сума прийнятого до розрахунку резерву забезпечення, грн
   begin
   select distinct substr(fin,1,1), substr(obs,1,1), substr(kat,1,1), k, substr(nvl(pawn,f_get_s031(k.acc,l_dat,null,k.nd )),1,30)
     into GG.G32, GG.G36, GG.G35, GG.G41, GG.G37
     from nbu23_rez
    where fdat = trunc(last_day(l_dat)+1,'MM') and id like 'CCK%'
      and rnk = k.rnk and rownum=1
      and nd = k.nd;
   exception when no_data_found then null;
   end;

   begin
   select sum(gl.p_icurval(kv,pv,l_dat)), sum(rezq), sum(reznq), sum(rezq-reznq), sum(bvq), sum(nvl(gl.p_icurval(kv,zal,l_dat),0))
     into GG.G57, GG.G42, GG.G43, GG.G44, GG.G56, GG.G40
     from nbu23_rez
    where fdat = trunc(last_day(l_dat)+1,'MM') and id like 'CCK%'
      and rnk = k.rnk
      and nd = k.nd
    group by nd;
   exception when no_data_found then null;
   end;

   select decode(k.acc,acc_pot,GG.G57,0), decode(k.acc,acc_pot,GG.G42,0), decode(k.acc,acc_pot,GG.G43,0), decode(k.acc,acc_pot,GG.G44,0), decode(k.acc,acc_pot,GG.G56,0), decode(k.acc,acc_pot,GG.G40,0)
     into GG.G57, GG.G42, GG.G43, GG.G44, GG.G56, GG.G40
     from dual;

   --33 - Внутрiшнiй кредитний рейтинг позичальника
   begin
    select substr(f_get_nd_txt(k.ND, 'VNCRR', l_dat),1,3) into GG.G33 from dual;
   EXCEPTION WHEN NO_DATA_FOUND THEN GG.G33:= null;
   end;

   --34 - Дата останньої оц_нки ф_н.стану
   begin
     select distinct nvl(to_char(fact_date,'dd/mm/yyyy'),null) into GG.G34
       from cc_sob
      where nd   = k.nd
        and psys = 7
        and otm  = 6
        and fact_date = (select max(fact_date)
                           from cc_sob
                          where fact_date <= l_dat
                            and psys = 7
                            and otm = 6
                            and nd = k.nd);
   EXCEPTION WHEN NO_DATA_FOUND THEN GG.G34:= null;
   end;

   bars_audit.trace('%s 11.Дог.реф=%s:G32=%s,G33=%s,G34=%s,G35=%s,G36=%s,G37=%s',
                      l_title,to_char(k.nd),to_char(GG.G32),to_char(GG.G33),to_char(GG.G34),to_char(GG.G35),to_char(GG.G36),to_char(GG.G37));

   --38 Дата віднесення до 5 категорії якості
   begin
     select to_char(to_date(substr(f_get_nd_txt(k.ND, 'KAT5',l_dat),1,10),fd_),fd_) into GG.G38 from dual;
   EXCEPTION WHEN NO_DATA_FOUND THEN GG.G38 := null;
   end;


   --39 Переглянута оціночна вартість, грн
   begin
   select sum(gl.p_icurval(t.kv,t.sall,l_dat)/100)
     into GG.G39
     from tmp_rez_obesp23 t
    where dat  = trunc(last_day(l_dat)+1,'MM')
      and t.nd = k.nd
      and t.kv is not null
   group by nd;
   exception when no_data_found then null;
   end;

   select decode(k.acc,acc_pot,greatest(GG.G39-GG.G31,0),0)
     into GG.G39
     from dual;

   bars_audit.trace('%s 12.Дог.реф=%s:G38=%s,G39=%s,G40=%s,G41=%s',l_title,to_char(k.nd),GG.G38,to_char(GG.G39),to_char(GG.G40),to_char(GG.G41));
   -- 45 - ???

   bars_audit.trace('%s 13.Дог.реф=%s:G42=%s,G43=%s,G44=%s',l_title,to_char(k.nd),to_char(GG.G42),to_char(GG.G43),to_char(GG.G44));

   --46 Категор?я громадян, як? постраждали внасл?док Чорнобильської катастрофи
   begin
    select substr(f_get_custw_h (k.rnk, 'CHORN', l_dat),1,1) into GG.G46 from dual;
     EXCEPTION WHEN NO_DATA_FOUND THEN GG.G46:= null;
   end;

   --47 Приналежн?сть до прац?вник?в банку
   begin
         select substr(f_get_custw_h (k.rnk, 'WORKB', l_dat),1,1) into GG.G47 from dual;
      EXCEPTION WHEN NO_DATA_FOUND THEN GG.G47:= 0;
   end;

   --48 Ц?льове призначення кредиту (заповнюється т?льки по кредитах, наданих прац?вникам банку)
   If GG.G47>0 then
        select substr(f_get_nd_txt(k.ND, 'W_AIM',l_dat),1,2) into GG.G48 from dual;
   end if;

  --49 Дата останньої пролонгац?ї кредиту
  select to_char(max(fdat),FD_) into GG.G49 from cc_prol
  where nd = k.ND and npp>0 and mdate is not null
    and fdat <= l_dat;

   bars_audit.trace('%s 14.Дог.реф=%s:G46=%s,G47=%s,G48=%s,G49=%s',
                         l_title,to_char(k.nd),to_char(GG.G46),to_char(GG.G47),to_char(GG.G48),to_char(GG.G49));

   -- 50 БР групи 891, на якому облiковуються сума нарах.та неотрим.доходiв по кредитах, що не будуть отриманi

   begin
   select decode(k.acc,acc_pot,
                 a.nls , null) into GG.G50
     from accounts a, nd_acc na
    where a.tip = 'S9N' and a.acc = na.acc and na.nd = k.nd
      and (dazs is null or dazs > l_dat) and a.daos <= l_dat;
   exception when no_data_found then GG.G50 := 0;
   end;

   --51 Сума нарах.та неотрим.доходiв по кредитах, що не будуть отриманi

   begin
   select -decode(k.acc, acc_pot, nvl( f_get_ost (a.acc,DI_,1,8)/100, 0), 0)
     into GG.G51
     from accounts a, nd_acc na
    where a.tip='S9N' and a.acc=na.acc and na.nd=k.nd
      and (dazs is null or dazs>l_dat) and a.daos <= l_dat;
   exception when no_data_found then GG.G51 := 0;
   end;

   --52 Референс договора
   GG.G52 := k.nd;

   --53 Дата останньої реструктуризації кредита
   begin
      select to_char(max(fdat),fd_) into GG.G53 from cck_restr where nd = k.nd and fdat <= l_dat;
   exception when no_data_found then GG.G53 := null;
   end;

   --54 Фактично сформована сума резерву для відшкодування можливих втрат за позабалансовими зобов'язаннями (рах. 3690), грн
  begin
   select decode(k.acc,acc_pot, sum(rezq),0)
   into GG.G54
   from nbu23_rez
   where fdat = trunc(last_day(l_dat)+1,'MM') and id like 'CCK%'
     and nd = k.ND
     and substr(nls,1,4) in (select nbs from srezerv_ob22 where nbs_rez = '3690')
     and rnk = k.rnk
    group by nd;
  exception when no_data_found then GG.G54 := 0;
  end;

   --55 Порядок розрахунку платежів (1-Ануїтет, 2-Рівними частинами)
   select decode(vid, 4, 1, 2) into GG.G55
     from accounts
    where acc = k.accc;

   bars_audit.trace('%s 15.Дог.реф=%s:G50=%s,G51=%s,G52=%s,G53=%s,G54=%s,G55=%s',
                         l_title,to_char(k.nd),to_char(GG.G50),to_char(GG.G51),to_char(GG.G52),to_char(GG.G53),to_char(GG.G54),to_char(GG.G55));

   bars_audit.trace('%s 16.Дог.реф=%s:G56=%s,G57=%s',
                         l_title,to_char(k.nd),to_char(GG.G56),to_char(GG.G57));

   if GG.G37 >= 40 and GG.G37 <= 45
     then
       begin
        for pz in
        (         select nd, pawn, sum(s)/100 ss, row_number() over (partition by nd order by sum(s) desc ) npp
                    from tmp_rez_obesp23
                   where dat = l_dat
                     and nd  = k.nd
                   group by nd, pawn   )
          loop
            if pz.npp = 1 then GG.G58 := pz.pawn; GG.G59 := pz.ss;  end if;
            if pz.npp = 2 then GG.G60 := pz.pawn; GG.G61 := pz.ss;  end if;
            if pz.npp = 3 then GG.G62 := pz.pawn; GG.G63 := pz.ss;  end if;
          end loop;
       end;
   end if;

   select decode(k.acc,acc_pot,GG.G58, null), decode(k.acc,acc_pot,GG.G59, null), decode(k.acc,acc_pot,GG.G60, null), decode(k.acc,acc_pot,GG.G61, null), decode(k.acc,acc_pot,GG.G62, null), decode(k.acc,acc_pot,GG.G63, null)
     into GG.G58, GG.G59, GG.G60, GG.G61, GG.G62, GG.G63
     from dual;


   GG.G00     := l_dat;
   GG.GT      := 1;
  -- вставляем в INV_CCK_FL_23 данные по КП с признаком GR = 'C'
   GG.GR      := 'C';
   GG.ACC     := k.acc;
   GG.RNK     := k.rnk;
   GG.ACC9129 := l_acc9129;

----------==========================
 insert into INV_CCK_FL_23 values GG;

END LOOP;

--------------------------!!!!!!!!!!!!!!!!! БПК расширенные!!!!!!!!!!!!!!!!!--------------------------
bars_audit.trace('%s 17-1.Вставляем данные по БПК ФЛ расширенные.',l_title);
   dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||': 5.Інвентаризація КП ФО-БПК 2203');
   z23.to_log_rez (user_id , 77 , l_dat ,'INV:5. Інвентаризація КП ФО-БПК 2203');
   -- для отслеживания ошибок при ексепшине
   l_err := 'БПК: ';

  insert into INV_CCK_FL_23
  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 , G63 , G64 , G65 ,
   G00 , GT, GR, ACC, RNK, ACC2208, ACC2209, ACC9129)
  (
-- БПК 2202, 2203, у которых остаток в принципе существует (может 0)
  select (select name from branch where branch = nvl(a.branch,'/')) G01, a.kf G02, a.branch G03, substr('БПК '||c.nmk,1,70) G04, null G05, c.okpo G05I, 0 G06,   --G05=Null - COBUMMFO-9420
       a.kv G07, ba.nd G08, to_char(get_dat_first_turn(ba.acc_ovr),fd_) G09,
       null G10, null G11, null G12, 0 G13, null G14, null G15, null G16, (select prinsiderlv1  from prinsider where prinsider = c.prinsider) G17, null G18, a.nbs G19, a.ob22 G20,
       -f_get_ost(a.acc,DI_,1,7)/100 G21,
       -f_get_ost(a.acc,DI_,1,8)/100 G22, 0 G23, null G24,
       decode(s.r013,'9',-(nvl(f_get_ost(ba.acc_9129,DI_,1,8)/100,0)), 0) G25,
       decode(s.r013,'1',-(nvl(f_get_ost(ba.acc_9129,DI_,1,8)/100,0)), 0) G26,
       nvl(acrn.fprocn(ba.acc_ovr,0,l_dat),0) G27,
       null G28,
       -f_get_ost(ba.acc_2208,DI_,1,8)/100-f_get_ost(ba.acc_2627,DI_,1,8)/100 G29, -f_get_ost(ba.acc_2209,DI_,1,8)/100 G30,
       null G31, n.fin G32, F_GET_CUSTW_H(c.rnk,'VNCRR',l_dat) G33, null G34, n.kat G35, n.obs G36, n.pawn G37, null G38,
       0 G39, 0 G40,
       n.k G41, n1.rezq G42, n1.reznq G43, n1.r_rez G44, 0 G45, null G46, null G47,
       null G48, null G49, null G50, 0 G51, ba.nd G52,
       0 G53,  t36.rezq G54, null G55,
       n1.bvq G56, n1.pvq G57,
       null G58,  null G59,null G60, null G61,  null G62,null G63,  null G64,
       decode (sign(nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0)),-1,-f_get_ost(ba.acc_pk,DI_,1,8)/100,0) G65,
       l_dat G00, 1 GT, 'R' GR, a.acc ACC, a.rnk RNK, ba.acc_2208 ACC2208, ba.acc_2209 ACC2209, ba.acc_9129  ACC9129
   from bpk_all_accounts ba, customer c, accounts a, 
        (select acc, r013 from nbu23_rez where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4')) s,
        (select distinct nd, fin, kat, obs, pawn, k
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') and rownum = 1) n,
        (select nd, sum(rezq) rezq, sum(reznq) reznq, sum(rezq-reznq) r_rez, sum(bvq) bvq, sum(pvq) pvq
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') group by nd) n1,
	(select acc, t.rezq rezq  from nbu23_rez t where t.nbs='9129' and fdat = trunc(last_day(l_dat)+1,'MM')  and substr(id,1,2) in ('BP','W4') ) t36
  where ba.acc_ovr is not null
    and ba.acc_ovr = a.acc
    and a.daos <= l_dat
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.acc_9129= s.acc(+)
    and ba.nd      = n.nd(+)
    and ba.nd      = n1.nd(+)
    and ba.acc_9129= t36.acc(+));

   dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||':6.Інвентаризація КП ФО-БПК,нет 2203,есть 9129');
   z23.to_log_rez (user_id , 77 , l_dat ,'INV:6. Інвентаризація КП ФО - БПК,нет 2203,есть 9129');

  insert into INV_CCK_FL_23
  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 , G63 , G64 , G65 ,
   G00 , GT, GR, ACC, RNK, ACC2208, ACC2209, ACC9129)
  (
  --UNION ALL
  -- БПК, по которым 2202, 2203 еще не открыт, но есть 9129
  select (select name from branch where branch = nvl(a.branch,'/')) G01, a.kf G02, a.branch G03,  substr('БПК '||c.nmk,1,70) G04, null G05, c.okpo G05I, 0,  --G05=Null - COBUMMFO-9420
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, (select prinsiderlv1  from prinsider where prinsider = c.prinsider) G17, null, a.nbs G19, null G20,
       0 G21,
       0 G22, 0 G23, null,
       decode(s.r013,'9',-(nvl(f_get_ost(ba.acc_9129,DI_,1,8)/100,0)), 0) G25,
       decode(s.r013,'1',-(nvl(f_get_ost(ba.acc_9129,DI_,1,8)/100,0)), 0) G26,
       nvl(acrn.fprocn(ba.acc_ovr,0,l_dat),0) G27,
       null G28,
       -f_get_ost(ba.acc_2208,DI_,1,8)/100-f_get_ost(ba.acc_2627,DI_,1,8)/100 G29, -f_get_ost(ba.acc_2209,DI_,1,8)/100 G30,
       null G31, n.fin G32, F_GET_CUSTW_H(c.rnk,'VNCRR',l_dat) G33, null G34, n.kat G35, n.obs G36, n.pawn G37, null G38,
       0 G39, 0 G40,
       n.k G41, n1.rezq G42, n1.reznq G43, n1.r_rez G44, 0 G45, null G46, null G47,
       null G48, null G49, null G50, 0 G51, ba.nd G52,
       0 G53,  t36.rezq G54, null G55,
       n1.bvq G56, n1.pvq G57,
       null G58,  null G59,null G60, null G61,  null G62,null G63,  null G64,
       decode (sign(nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0)),-1,-f_get_ost(ba.acc_pk,DI_,1,8)/100,0) G65,
       l_dat G00, 1 GT, 'R' GR, a.acc ACC, a.rnk RNK, ba.acc_2208 ACC2208, ba.acc_2209 ACC2209, ba.acc_9129  ACC9129
   from bpk_all_accounts ba, customer c, accounts a, 
        (select acc, r013 from nbu23_rez  where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4')) s,
        (select distinct nd, fin, kat, obs, pawn, k from nbu23_rez  where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') and rownum = 1) n,
        (select nd, sum(rezq) rezq, sum(reznq) reznq, sum(rezq-reznq) r_rez, sum(bvq) bvq, sum(pvq) pvq
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') group by nd) n1,
	(select acc, t.rezq rezq
           from nbu23_rez t
          where t.nbs='9129' and fdat = trunc(last_day(l_dat)+1,'MM')  and substr(id,1,2) in ('BP','W4') ) t36
  where ba.acc_ovr is null and ba.acc_2207 is null
    and ba.acc_9129 is not null
    and ba.acc_9129 = a.acc
    and a.daos <= l_dat
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.acc_9129= t36.acc(+)
    and ba.acc_9129= s.acc(+)
    and ba.nd      = n.nd(+)
    and ba.nd      = n1.nd(+));

   dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||': 7.Інвентаризація КП ФО-БПК,есть 9129,2203');
   z23.to_log_rez (user_id , 77 , l_dat ,'INV:7. Інвент.КП ФО-БПК,есть 9129,2203');

  insert into INV_CCK_FL_23
  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 , G63 , G64 , G65 ,
   G00 , GT, GR, ACC, RNK, ACC2208, ACC2209, ACC9129)
  (
  --UNION ALL
  -- БПК, по которым есть 9129, а 2202, 2203 открыт позже даты формирования
  select (select name from branch where branch = nvl(a.branch,'/')) G01, a.kf G02, a.branch G03,  substr('БПК '||c.nmk,1,70) G04, null G05, c.okpo G05I, 0,  --G05=Null - COBUMMFO-9420
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, (select prinsiderlv1  from prinsider where prinsider = c.prinsider) G17, null, a.nbs G19, null G20,
       0 G21,
       0 G22, 0 G23, null,
       decode(s.r013,'9',-(nvl(f_get_ost(ba.acc_9129,DI_,1,8)/100,0)), 0) G25,
       decode(s.r013,'1',-(nvl(f_get_ost(ba.acc_9129,DI_,1,8)/100,0)), 0) G26,
       nvl(acrn.fprocn(ba.acc_ovr,0,l_dat),0) G27,
       null G28,
       -f_get_ost(ba.acc_2208,DI_,1,8)/100-f_get_ost(ba.acc_2627,DI_,1,8)/100 G29, -f_get_ost(ba.acc_2209,DI_,1,8)/100 G30,
       null G31, n.fin G32, F_GET_CUSTW_H(c.rnk,'VNCRR',l_dat) G33, null G34, n.kat G35, n.obs G36, n.pawn G37, null G38,
       0 G39, 0 G40,
       n.k G41, n1.rezq G42, n1.reznq G43, n1.r_rez G44, 0 G45, null G46, null G47,
       null G48, null G49, null G50, 0 G51, ba.nd G52,
       0 G53,  t36.rezq G54, null G55,
       n1.bvq G56, n1.pvq G57,
       null G58,  null G59,null G60, null G61,  null G62,null G63,  null G64,
       decode (sign(nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0)),-1,-f_get_ost(ba.acc_pk,DI_,1,8)/100,0) G65,
       l_dat G00, 1 GT, 'R' GR, a.acc ACC, a.rnk RNK, ba.acc_2208 ACC2208,  ba.acc_2209 ACC2209, ba.acc_9129  ACC9129
   from bpk_all_accounts ba, customer c, accounts a, accounts a2,
        (select acc, r013
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4')) s,
        (select distinct nd, fin, kat, obs, pawn, k
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') and rownum = 1) n,
        (select nd, sum(rezq) rezq, sum(reznq) reznq, sum(rezq-reznq) r_rez, sum(bvq) bvq, sum(pvq) pvq
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') group by nd) n1,
	(select acc, t.rezq rezq
           from nbu23_rez t
          where t.nbs='9129' and fdat = trunc(last_day(l_dat)+1,'MM')  and substr(id,1,2) in ('BP','W4') ) t36
  where ba.acc_ovr = a2.acc and a2.daos > l_dat
    and ba.acc_9129 is not null
    and ba.acc_9129 = a.acc
    and a.daos <= l_dat
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.acc_9129= t36.acc(+)
    and ba.acc_9129= s.acc(+)
    and ba.nd      = n.nd(+)
    and ba.nd      = n1.nd(+));

   dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||': 8.Інвентаризація КП ФО-БПК,нет 2203,9129,есть 2208');
   z23.to_log_rez (user_id , 77 , l_dat ,'INV:8. Інвентаризація КП ФО-БПК,нет 2203,9129,есть 2208');

  insert into INV_CCK_FL_23
  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 , G63 , G64 , G65 ,
   G00 , GT, GR, ACC, RNK, ACC2208, ACC2209, ACC9129)
  (
  --UNION ALL
  -- БПК, по которым нет ни 2202, 2203, ни 9129, но есть 2208
  select (select name from branch where branch = nvl(a.branch,'/')) G01, a.kf G02, a.branch G03,  substr('БПК '||c.nmk,1,70) G04, null G05, c.okpo G05I, 0,  ----G05=Null - COBUMMFO-9420
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, (select prinsiderlv1  from prinsider where prinsider = c.prinsider) G17, null, a.nbs G19, null G20,
       0 G21,
       0 G22, 0 G23, null,
       0 G25,
       0 G26,
       0 G27,
       null G28,
       -f_get_ost(ba.acc_2208,DI_,1,8)/100-f_get_ost(ba.acc_2627,DI_,1,8)/100 G29, -f_get_ost(ba.acc_2209,DI_,1,8)/100 G30,
       null G31, n.fin G32, F_GET_CUSTW_H(c.rnk,'VNCRR',l_dat) G33, null G34, n.kat G35, n.obs G36, n.pawn G37, null G38,
       0 G39, 0 G40,
       n.k G41, n1.rezq G42, n1.reznq G43, n1.r_rez G44, 0 G45, null G46, null G47,
       null G48, null G49, null G50, 0 G51, ba.nd G52,
       0 G53,  0 G54, null G55,
       n1.bvq G56, n1.pvq G57,
       null G58,  null G59,null G60, null G61,  null G62,null G63,  null G64,
       decode (sign(nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0)),-1,-f_get_ost(ba.acc_pk,DI_,1,8)/100,0) G65,
       l_dat G00, 1 GT, 'R' GR, a.acc ACC, a.rnk RNK, ba.acc_2208 ACC2208,  ba.acc_2209 ACC2209, ba.acc_9129  ACC9129
   from bpk_all_accounts ba, customer c, accounts a, 
        (select distinct nd, fin, kat, obs, pawn, k
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') and rownum = 1) n,
        (select nd, sum(rezq) rezq, sum(reznq) reznq, sum(rezq-reznq) r_rez, sum(bvq) bvq, sum(pvq) pvq
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') group by nd) n1
  where (ba.acc_ovr is null or (ba.acc_ovr is not null and exists (select 1 from accounts where acc = ba.acc_ovr and daos > l_dat)) )
    and (ba.acc_9129 is null or (ba.acc_9129 is not null and exists (select 1 from accounts where acc = ba.acc_9129 and daos > l_dat)) )
    and ba.acc_2208 = a.acc
    and a.daos <= l_dat
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.nd      = n.nd(+)
    and ba.nd      = n1.nd(+));

   dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||': 9.Інвентаризація КП ФО-БПК,есть только 2625');
   z23.to_log_rez (user_id , 77 , l_dat ,'INV:9. Інвентаризація КП ФО-БПК,есть только 2625');

  insert into INV_CCK_FL_23
  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 , G63 , G64 , G65 ,
   G00 , GT, GR, ACC, RNK, ACC2208, ACC2209, ACC9129) 
  (
-- БПК, по которым нет ни 2202, 2203, ни 9129, ни 2207, 2208, 2209, но есть 2625
  select (select name from branch where branch = nvl(a.branch,'/')) G01, a.kf G02, a.branch G03,  substr('БПК '||c.nmk,1,70) G04, NULL G05, c.okpo G05I, 0,  --G05=Null - COBUMMFO-9420
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, (select prinsiderlv1  from prinsider where prinsider = c.prinsider) G17, null, a.nbs G19, null G20,
       0 G21,
       0 G22, 0 G23, null,
       0 G25,
       0 G26,
       0 G27,
       null G28,
       -f_get_ost(ba.acc_2627,DI_,1,8)/100 G29, 0 G30,
       null G31, n.fin G32, F_GET_CUSTW_H(c.rnk,'VNCRR',l_dat) G33, null G34, n.kat G35, n.obs G36, n.pawn G37, null G38,
       0 G39, 0 G40,
       n.k G41, n1.rezq G42, n1.reznq G43, n1.r_rez G44, 0 G45, null G46, null G47,
       null G48, null G49, null G50, 0 G51, ba.nd G52,
       0 G53,  0 G54, null G55,
       n1.bvq G56, n1.pvq G57,
       null G58,  null G59,null G60, null G61,  null G62,null G63,  null G64,
       decode (sign(nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0)),-1,-f_get_ost(ba.acc_pk,DI_,1,8)/100,0) G65,
       l_dat G00, 1 GT, 'R' GR, a.acc ACC, a.rnk RNK, null ACC2208,  null ACC2209, null  ACC9129
   from bpk_all_accounts ba, customer c, accounts a, 
        (select distinct nd, fin, kat, obs, pawn, k
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') and rownum = 1) n,
        (select nd, sum(rezq) rezq, sum(reznq) reznq, sum(rezq-reznq) r_rez, sum(bvq) bvq, sum(pvq) pvq
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') group by nd) n1
  where (ba.acc_ovr is null or (ba.acc_ovr is not null and exists (select 1 from accounts where acc = ba.acc_ovr and daos > l_dat)) )
    and (ba.acc_9129 is null or (ba.acc_9129 is not null and exists (select 1 from accounts where acc = ba.acc_9129 and daos > l_dat)) )
    and (ba.acc_2207 is null or (ba.acc_2207 is not null and exists (select 1 from accounts where acc = ba.acc_2207 and daos > l_dat)) )
    and (ba.acc_2208 is null or (ba.acc_2208 is not null and exists (select 1 from accounts where acc = ba.acc_2208 and daos > l_dat)) )
    and (ba.acc_2209 is null or (ba.acc_2209 is not null and exists (select 1 from accounts where acc = ba.acc_2208 and daos > l_dat)) )
    and ba.acc_pk  = a.acc
    and a.daos    <= l_dat
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.nd      = n.nd(+)
    and ba.nd      = n1.nd(+)
    and ( nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0) < 0  or  ( nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0) = 0   and ba.acc_2627 is not null ) ));

   dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||': 10.Інвентаризація КП ФО-БПК, 2207 остаток существует(может 0)');
   z23.to_log_rez (user_id , 77 , l_dat ,'INV:10. Інвентаризація КП ФО-БПК, 2207 остаток существует(может 0)');

  insert into INV_CCK_FL_23
  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 , G63 , G64 , G65 ,
   G00 , GT, GR, ACC, RNK, ACC2208, ACC2209, ACC9129) 
  (

-- БПК 2207, у которых остаток в принципе существует (может 0)
  select (select name from branch where branch = nvl(a.branch,'/')) G01, a.kf G02, a.branch G03, substr('БПК '||c.nmk,1,70) G04, NULL G05, c.okpo G05I, 0 G06,   --G05=Null - COBUMMFO-9420
       a.kv G07, ba.nd G08, to_char(get_dat_first_turn(ba.acc_2207),fd_) G09,
       null G10, null G11, null G12, 0 G13, null G14, null G15, null G16, (select prinsiderlv1  from prinsider where prinsider = c.prinsider) G17, null G18, a.nbs G19, a.ob22 G20,
       -f_get_ost(a.acc,DI_,1,7)/100 G21,
       -f_get_ost(a.acc,DI_,1,8)/100 G22, 0 G23, null G24,
       decode(ba.acc_ovr, null, decode(s.r013,'9',-(nvl(f_get_ost(ba.acc_9129,DI_,1,8)/100,0)), 0), 0) G25,
       decode(ba.acc_ovr, null, decode(s.r013,'1',-(nvl(f_get_ost(ba.acc_9129,DI_,1,8)/100,0)), 0), 0) G26,
       nvl(acrn.fprocn(ba.acc_2207,0,l_dat),0) G27,
       null G28,
       0 G29, decode(ba.acc_ovr, null, -f_get_ost(ba.acc_2209,DI_,1,8)/100,0) G30,
       null G31, n.fin G32, F_GET_CUSTW_H(c.rnk,'VNCRR',l_dat) G33, null G34, n.kat G35, n.obs G36, n.pawn G37, null G38,
       0 G39, 0 G40,
       n.k G41, n1.rezq G42, n1.reznq G43, n1.r_rez G44, 0 G45, null G46, null G47,
       null G48, null G49, null G50, 0 G51, ba.nd G52,
       0 G53,  t36.rezq G54, null G55,
       n1.bvq G56, n1.pvq G57,
       null G58,  null G59,null G60, null G61,  null G62,null G63,  null G64,
       decode (sign(nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0)),-1,-f_get_ost(ba.acc_pk,DI_,1,8)/100,0) G65,
       l_dat G00, 1 GT, 'R' GR, a.acc ACC, a.rnk RNK, null ACC2208, decode(ba.acc_ovr, null, ba.acc_2209, null) ACC2209, decode(ba.acc_ovr, null, ba.acc_9129, null)  ACC9129
   from bpk_all_accounts ba, customer c, accounts a, 
        (select acc, r013
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4')) s,
        (select distinct nd, fin, kat, obs, pawn, k
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') and rownum = 1) n,
        (select nd, sum(rezq) rezq, sum(reznq) reznq, sum(rezq-reznq) r_rez, sum(bvq) bvq, sum(pvq) pvq
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') group by nd) n1,
	(select acc, t.rezq rezq
           from nbu23_rez t
          where t.nbs='9129' and fdat = trunc(last_day(l_dat)+1,'MM')  and substr(id,1,2) in ('BP','W4') ) t36
  where (ba.acc_ovr is null or (ba.acc_ovr is not null and exists (select 1 from accounts where acc = ba.acc_ovr and daos > l_dat)) )
    and (ba.acc_9129 is null or (ba.acc_9129 is not null and exists (select 1 from accounts where acc = ba.acc_9129 and daos > l_dat)) )
    and ba.acc_2207 is not null
    and ba.acc_2207 = a.acc
    and a.daos <= l_dat
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.acc_9129= s.acc(+)
    and ba.nd      = n.nd(+)
    and ba.nd      = n1.nd(+)
    and ba.acc_9129= t36.acc(+));

   dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||': 11.Інвентаризація КП ФО - БПК, нет ни 2203, 2207, 2208, ни 9129, но есть 2209');
   z23.to_log_rez (user_id , 77 , l_dat ,'INV:11. Інвентаризація КП ФО - БПК, нет ни 2203, 2207, 2208, ни 9129, но есть 2209');

  insert into INV_CCK_FL_23
  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 , G63 , G64 , G65 ,
   G00 , GT, GR, ACC, RNK, ACC2208, ACC2209, ACC9129) 
  (
-- БПК, по которым нет ни 2202, 2203, 2207, 2208, ни 9129, но есть 2209
  select (select name from branch where branch = nvl(a.branch,'/')) G01, a.kf G02, a.branch G03,  substr('БПК '||c.nmk,1,70) G04, null G05, c.okpo G05I, 0,  --G05=Null - COBUMMFO-9420
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, (select prinsiderlv1  from prinsider where prinsider = c.prinsider) G17, null, a.nbs G19, null G20,
       0 G21,
       0 G22, 0 G23, null,
       0 G25,
       0 G26,
       0 G27,
       null G28,
       0 G29, -f_get_ost(ba.acc_2209,DI_,1,8)/100 G30,
       null G31, n.fin G32, F_GET_CUSTW_H(c.rnk,'VNCRR',l_dat) G33, null G34, n.kat G35, n.obs G36, n.pawn G37, null G38,
       0 G39, 0 G40,
       n.k G41, n1.rezq G42, n1.reznq G43, n1.r_rez G44, 0 G45, null G46, null G47,
       null G48, null G49, null G50, 0 G51, ba.nd G52,
       0 G53,  0 G54, null G55,
       n1.bvq G56, n1.pvq G57,
       null G58,  null G59,null G60, null G61,  null G62,null G63,  null G64,
       decode (sign(nvl(f_get_ost(ba.acc_pk,DI_,1,7)/100,0)),-1,-f_get_ost(ba.acc_pk,DI_,1,8)/100,0) G65,
       l_dat G00, 1 GT, 'R' GR, a.acc ACC, a.rnk RNK, null ACC2208,  ba.acc_2209 ACC2209, null  ACC9129
   from bpk_all_accounts ba, customer c, accounts a, 
        (select distinct nd, fin, kat, obs, pawn, k
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') and rownum = 1) n,
        (select nd, sum(rezq) rezq, sum(reznq) reznq, sum(rezq-reznq) r_rez, sum(bvq) bvq, sum(pvq) pvq
           from nbu23_rez
          where fdat = trunc(last_day(l_dat)+1,'MM') and substr(id,1,2) in ('BP','W4') group by nd) n1
  where (ba.acc_ovr is null or (ba.acc_ovr is not null and exists (select 1 from accounts where acc = ba.acc_ovr and daos > l_dat)) )
    and (ba.acc_9129 is null or (ba.acc_9129 is not null and exists (select 1 from accounts where acc = ba.acc_9129 and daos > l_dat)) )
    and (ba.acc_2207 is null or (ba.acc_2207 is not null and exists (select 1 from accounts where acc = ba.acc_2207 and daos > l_dat)) )
    and (ba.acc_2208 is null or (ba.acc_2208 is not null and exists (select 1 from accounts where acc = ba.acc_2208 and daos > l_dat)) )
    and ba.acc_2209 = a.acc
    and a.daos <= l_dat
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.nd      = n.nd(+)
    and ba.nd      = n1.nd(+)
	  );

--------------------------!! БПК консолидированные !!-------------------------
  bars_audit.trace('%s 18-2.Вставляем данные по БПК ФЛ консолидированные.',l_title);
  dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||': 12.Інвентаризація БПК ФО консолидированные');
  z23.to_log_rez (user_id , 77 , l_dat ,'INV:12. Інвентаризація БПК ФО консолидированные');
  insert into INV_CCK_FL_BPKK_23
  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 , G63, G64, G65,
   G00 , GT, GR, ACC, RNK)
 (
select G01, G02, G03, 'БПК' G04, null, null, 0, G07, null, null, null, null, null, 0, null, 0, null,
         G17, null, G19, G20, sum(G21), sum(G22), 0, null,
         sum(G25), sum(G26), null, null, sum(G29), sum(G30), null , G32 , null , null , G35 ,  G36 ,
         G37, null, sum(G39), sum(G40), G41, sum(G42),
         sum(G43), sum(G44), 0, null, null, null, null, null,
         null,  null,  null,   sum(G54),  null,  sum(G56), sum(G57), null, null, null, null, null, null, null, sum(G65),
         l_dat, 1, 'K',  null, null
    from inv_cck_fl_23
   where G00 = l_dat
     and GT  = 1
     and GR  = 'R'
  group by G01, G02, G03, G07, G17, G19, G20, G32, G33, G35, G36, G37, G41
 );


--------------------------!!!!!!!!!!!!!!!!! Другие !!!!!!!!!!!!!!!!!--------------------------
bars_audit.trace('%s 19.Вставляем то, что никуда не вошло',l_title);
dbms_application_info.set_client_info('INV_FL_JOB:'|| GG.kf ||':13.Інвентаризація - то, что никуда не вошло');
z23.to_log_rez (user_id , 77 , l_dat ,'INV:13.Інвентаризація - то, что никуда не вошло');

  if getglobaloption('HAVETOBO') = 2 then
execute immediate
'  declare
   Di_       number :=to_number('||to_char(Di_)||') ;
   l_dat     date := to_date('''||to_char(p_dat,fd_)||''','''||fd_||''');
   l_newnbs number;
   begin
   l_newnbs := NEWNBS.GET_STATE;
    for nn in
    -- кред.счета, которые не попали в ведомость, но есть в снапах
       (select b.name G01, a.kf G02, a.branch G03,  substr(''Iншi ''||c.nmk,1,70) G04, a.kv G07,
               a.nbs G19, a.ob22 G20,
               decode (a.nbs, ''2203'', -f_get_ost(a.acc,di_,1,7),
                      	      ''2233'', -f_get_ost(a.acc,di_,1,7),
               	       0 )/100 G21,
               decode (a.nbs, ''2203'', -f_get_ost(a.acc,di_,1,8),
                      	      ''2233'', -f_get_ost(a.acc,di_,1,8),
                       0 )/100 G22,
               decode (a.nbs, ''9129'', -f_get_ost(a.acc,di_,1,8),
                       0 )/100 G25,
               decode (a.nbs, ''2208'', -f_get_ost(a.acc,di_,1,8),
                              ''2238'', -f_get_ost(a.acc,di_,1,8),
                       0 )/100 G29,  0 G30,
	       a.acc acc, a.rnk rnk
          from ACCM_AGG_MONBALS bb, accounts a, customer c, branch b
         where bb.acc = a.acc
           and (   a.nbs in (''2203'',''2208'',''2233'',''2238'')
	        or (a.nbs = ''9129'' and c.custtype = 3 and nvl(trim(c.sed),''00'')<>''91'') )
           and caldt_ID = di_
           -- смотрим, что счета нет среди INV_CCK_FL_23.ACC
           and not exists (select 1 from inv_cck_fl_23 where acc = a.acc and g00 = l_dat and gt = 1)
           -- смотрим, что счета нет среди INV_CCK_FL_23.ACC2208
           and not exists (select 1 from inv_cck_fl_23 where acc2208 is not null and acc2208 = a.acc and g00 = l_dat and gt = 1)
           -- смотрим, что счета нет среди INV_CCK_FL_23.ACC2209
           and not exists (select 1 from inv_cck_fl_23 where acc2209 is not null and acc2209 = a.acc and g00 = l_dat and gt = 1)
           -- смотрим, что счета нет среди INV_CCK_FL_23.ACC9129
           and not exists (select 1 from inv_cck_fl_23 where acc9129 is not null and acc9129 = a.acc and g00 = l_dat and gt = 1)
           -- смотрим, что счета нет среди TMP_INV_2208_23.ACC
           and not exists (select 1 from TMP_INV_2208_23 where acc = a.acc)
           and ( bb.ost + CRkos-CRdos <>0 or bb.ostQ + CRkosQ-CRdosQ <>0)
           and nvl(a.branch,''/'') = b.branch
           and a.rnk = c.rnk    )
       loop
       	   insert into INV_CCK_FL_23
           	  (G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
           	   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
           	   G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
           	   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
           	   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62, G63, G64, G00 , GT, GR, ACC, RNK)
     		   values
          	   (nn.G01, nn.G02, nn.G03, nn.G04, null, null, 0, nn.G07, null, null, null, null, null,
	   	   0, null, null, null, 0, null, nn.G19, nn.G20, nn.G21, nn.G22, 0, 0,
           	   nn.G25, 0, 0, null, nn.G29, nn.G30, 0 , null, null, null, null, null, null, null, 0, 0, 0, 0,
	   	   0, 0, 0, null, null, null, null, 0, 0,  0,  null,   0,  0,  0, 0,  null, 0, null,  0, null, 0, null, l_dat , 1, ''I'', nn.ACC, nn.RNK);
       end loop;
  end;  ';
end if;

/*
   --
   -- заполнение статуса выполнения инв. ведомости
   --
   if l_usedwh = '1' then
       bars.bars_dwhcck.set_import_status(
                 p_date        => p_dat,
                 p_daymon_flag => 1);

   end if;

*/
  
  z23.to_log_rez (user_id , 77 , l_dat ,'INV:1. Инвентаризация ФО-23 - фініш');
  bars_audit.trace('%s 20.Финиш инвентаризации КП ФЛ.',l_title);
  l_mes := 'Формування інвернтарізації КП ФО по філії ' || GG.kf || ' ЗАВЕРШЕНО!';
  --PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg )
  bms.send_message(p_receiver_id     => user_id,
     p_message_type_id => 1,
     p_message_text    => l_mes,
     p_delay           => 0,
     p_expiration      => 0);
  commit;
 else

    begin
       l_kf      := sys_context('bars_context','user_mfo');
       BEGIN
          SYS.DBMS_SCHEDULER.DROP_JOB (job_name  => 'INV_'|| l_kf);
       exception when others then  if sqlcode = -27475 then null; else raise; end if;
       end;    
       EXECUTE IMMEDIATE  'begin
                           BARS.bars_login.set_long_session;
                           end;';
       SYS.DBMS_SCHEDULER.CREATE_JOB
          (job_name         => 'INV_'|| l_kf,
           job_type         => 'PLSQL_BLOCK',
           job_action       => 'declare 
                                   dat_   DATE   := TO_DATE('''||TO_CHAR(p_dat,'ddmmyyyy')||''',''ddmmyyyy'');
                                   l_frm  int    :=' || p_frm  ||';
                                begin 
                                   bc.go(' || l_kf || '); 
                                   P_INV_CCK_FL_23(dat_, l_frm, 0 ); 
                                   commit;
                                end;',
           enabled         => true,
           --repeat_interval => 'FREQ=DAILY;BYDAY=SUN,MON,SAT,TUE,WED,THU,FRI;BYHOUR=12;BYMINUTE=58;BYSECOND=0',
           comments => 'INV: Інвентарізація КП ФО за ' || p_dat
          );
    END;
 end if;

exception when others then
    bars_audit.error (dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
    raise_application_error(-20000, l_err||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());


end P_INV_CCK_FL_23 ;
/
show err;

PROMPT *** Create  grants  P_INV_CCK_FL_23 ***
grant EXECUTE                                                                on P_INV_CCK_FL_23 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_INV_CCK_FL_23 to RCC_DEAL;
grant EXECUTE                                                                on P_INV_CCK_FL_23 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INV_CCK_FL_23.sql =========*** E
PROMPT ===================================================================================== 
