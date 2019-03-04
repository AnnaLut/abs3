 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/cck_specparam.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.CCK_SPECPARAM (ACC_   int, -- вн. номер подвязываемого счета под договор
                                          NLS_   varchar2, -- лицевой номер подвязываемый счета под договор
                                          KV_    int, -- валюта подвязываемый счета под договор
                                          TIP_   varchar2, -- тип счета ('SS ','SN ' и тд)
                                          SOUR_  int, -- for S200
                                          P080_  char, -- S080
                                          SDATE_ date, -- дата начала договора
                                          MDATE_ date, -- Дата погашения счета
                                          VIDD_  int, -- вид кредитного договора
                                          ND_    int -- номер кредитного договора (пока на всякий случай)
                                          ) IS

  l_SDATL cc_prol.FDAT%type;
  l_SROK  int;
  l_S080  char(1) := null;
  l_R011  char(1) := null;
  l_S200  char(1) := null;
  l_S260  char(2) := null;
  l_R013  char(1) := null;
  l_K110  int := 0;

  /*
  09/11/2017 Pivanova додато зміну параметру l_R011 в апдейт
  30-06-2011 DAV  Выведены показатели S180, S181 поскольку заполняет корректно ОАБ
  29-06-2011 DAV  С 10.06.2011 R013 НБУ  для группы '20' and TIP in ('SS ','SPI','SDI')
                  закрыл показатель.
  31-03-2011 Nov  Добавлен режим миграции только с новым пакетом ССК

  */

begin
  bars_audit.trace('CCK_SPECPARAM ACC_:=' || ACC_ || ' ,NLS_' || NLS_ ||
                   ' ,KV_' || KV_ || ' ,TIP_' || TIP_ || ' ,SOUR_' ||
                   SOUR_ || ' ,P080_' || P080_ || ' ,SDATE_' || MDATE_ ||
                   ' ,SOUR_' || MDATE_ || ' ,VIDD_' || VIDD_ ||
                   ', ND_ := ' || ND_);

  begin
    select s.s200 INTO l_S200 FROM cc_source s WHERE s.sour(+) = SOUR_;
  exception
    when no_data_found then
      l_S200 := '3';
  end;

  l_srok := months_between(MDATE_, sdate_);

  --------------  S080 -------------------

  If P080_ is null then
    begin
      SELECT s080
        INTO l_S080
        FROM FIN_OBS_S080 f, customer c, cc_deal d
       WHERE f.fin = c.crisk
         and f.obs = d.obs
         and c.rnk = d.rnk
         and d.nd = ND_;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        l_S080 := 1;
    end;
  else
    l_S080 := P080_;
  end if;

  --------------  R011 -------------------

  if tip_ in ('SP ', 'SN ', 'SPN', 'SL ', 'SLN', 'SK0', 'SK9') then
    l_R011 := substr(cck.R011_S181(ACC_, ND_), 1, 1);
  end if;

  If TIP_ in ('SN ', 'SK0') then
    l_R013 := '2';
  ElsIf TIP_ in ('SPN', 'SK9') then
    l_R013 := '3';
  ElsIf TIP_ = 'SLN' then
    l_R013 := '3';
  ElsIf TIP_ = 'CR9' then
    If gl.aMFO = '353575' then
      l_R013 := '1';
    else
      l_R013 := '9';
    end if;
  end if;
  -- постановку данного блока описал банк УПБ

  if substr(nls_, 1, 2) = '20' and TIP_ in ('SS ', 'SPI', 'SDI') then
    -- С 10.06.2011  для счетов данной группы параметр R013 закрыт
    /*
         begin
         SELECT nvl(to_number(k.k110),0)
              INTO l_k110
              FROM CUSTOMER b, cc_deal d,KL_K110 k
              WHERE b.rnk = d.rnk
                    AND d.nd=ND_
                    AND b.VED = k.k110(+);

         if substr(NLS_,1,4)    in ('2010','2016','2020','2026','2030',
                                    '2036','2062','2063','2065','2066',
                                    '2073','2074','2075',
                                    '2076','2082','2083','2085','2086')
               and l_k110>=1110 and l_k110<=45500
            then l_R013:= '1';
         elsif substr(NLS_,1,4) in ('2072','2073')
               and l_k110>=1110 and l_k110<=45500
            then l_R013:= '3';
         elsif substr(NLS_,1,4) in ('2010','2016','2020','2026','2030',
                                    '2036','2062','2063','2065','2066',
                                    '2072','2073','2073','2074','2075',
                                    '2076','2082','2083','2085','2086')
               and l_k110>=50101 and l_k110<=99000
            then l_R013:= '9';
         end if;

        exception when others then null;
        end;
    -- end 10.06.2011
        */
    l_R013 := null;

  end if;
  -- end УПБ

  -- спецпараметры
  /*
  if TIP_ in ('SS ','SP ','SL ','SN ','SPN','SDI','SPI','CR9','SK0','SK9')  then
     if tip_='SS ' and substr(nls_,4,1)='2' and l_SDATL-gl.bd>365 then
        l_SDATL:=MDATE_-360;
     end if;
     if tip_='SS ' and substr(nls_,4,1)='3' and l_SDATL-gl.bd<=365 then
        l_SDATL:=MDATE_-370;
     end if;

    l_s180:=f_srok(l_SDATL,  MDATE_,2);


       if l_s180 in ('C','D','E','F','G','H') then l_S181:=2;
       else l_S181:=1;
       end if;
  */
  /*
  if TIP_='SG ' then l_s180:='1'; l_S181:='1';
  else
   l_s180:=null;
  end if;
  */

  ----------------- S260 ------------------------------------------------

  --if VIDD_ in (1,2,3) then
  --   select max(s260) into l_s260 from kl_s260 where s260='08';
  --else
  --   select max(txt) into l_s260 from nd_txt where nd=ND_ and tag='S260';
  --end if;

  -- с 01/03 изменились коды
  begin
    select substr(txt, 1, 2)
      into l_s260
      from nd_txt
     where nd = ND_
       and tag = 'S260';
  exception
    when no_data_found then
      select min(s260)
        into l_s260
        from cc_potra p, cc_deal d
       where d.nd = ND_
         and d.prod = p.id;
  end;

  -----------------------------------------------------------------------

  if cck.g_cck_migr = 0 then
    UPDATE specparam
       SET s080 = Nvl(l_S080, s080),
           R013 = Nvl(l_R013, R013), -- проставляет Толик при формировании А3 файла после первой проводки по счету
           s260 = Nvl(l_S260, s260),
           R011 = l_R011
     WHERE acc = ACC_ ;

  else
    UPDATE specparam
       SET s080 = Nvl(s080, l_S080),
           R013 = Nvl(R013, l_R013), -- проставляет Толик при формировании А3 файла после первой проводки по счету
           s260 = Nvl(s260, l_S260),
           R011 = nvl(l_R011,R011),
           S200=  l_S200
     WHERE acc = ACC_ ;

  end if;

  if SQL%rowcount = 0 then

    If TIP_ = 'SS ' then
      -- r011 отсутствует
      Insert into specparam
        (acc, s080, s200, s260, r013)
      values
        (Acc_, l_S080, l_S200, l_S260, l_r013) ;

    elsif Tip_ in ('SP ', 'SL ') then
      Insert into specparam
        (acc, R011, s080, s200, s260)
        select ACC_, l_R011, s.S080, s.s200, l_S260
          from specparam s
         where s.acc = (select accs
                          from cc_add
                         where adds = 0
                           and nd = ND_) ;

    elsif TIP_ in ('SN ', 'SPN', 'SLN') then
      Insert into specparam
        (acc, r011, s260, r013)
      values
        (ACC_, l_R011, l_S260, l_R013);

    elsif TIP_ in ('SK0', 'SK9') then
      Insert into specparam
        (acc, r011, s260, r013)
      values
        (ACC_, '1', l_S260, l_R013) ;

    elsif tip_ = 'CR9' then
      insert into specparam
        (acc, r013, s080, s260)
      values
        (acc_, l_r013, l_S080, l_S260) ;

    elsif tip_ = 'SG ' then
      insert into specparam
        (acc, r013, s260)
      values
        (acc_, l_r013, l_S260) ;

    elsif tip_ in ('SDI', 'SPI') then
      insert into specparam
        (acc, s080, s260)
      values
        (acc_, l_S080, l_S260);
    end if;

  end if;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/cck_specparam.sql =========*** End
 PROMPT ===================================================================================== 
 