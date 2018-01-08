
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sno.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SNO IS
 g_header_version CONSTANT VARCHAR2 (64) := 'version 3 ,  17.08.2016';

/*
 17.08.2016 -- отмена. возврат назад. ---нет разбалансировки/ только передвижка вверх/вниз
 09.08.2016 MMFO  ВЕБ + Вибраний інтревал для ГПП
 30.11.2015 Sta Вынесла в самостоятельные процедуры add31 add32
 16.11.2015 Sta Совмещение операции KK1 + GPK + другое
 21.10.2015 Sta Совмещение операции KK1 + GPK
 12.08.2015 STA Реструктуризация типа АТО
 06.11.2014 Sta Переименование пакеджа cck_dop_nadra - > SNO и оставила только то, что касается SNO
*/
---------------------------------------------------------------------
function GET_REF_BAK (p_REF number) return number ;
-----------------------------------------
function check_partition_exist(p_table_name in varchar2, p_date in date) return number ;
-- Проверка наличия партиций - от С.Горобца
-------------------------------------------------
procedure BEK_REF_GPP ( p_ref number);   -- БЕК или снять с визы GPP
------------------------------------------
procedure ATO1
 ( p_ND      number,  -- Реф КД~в АБС
   p_acc_SNO number,
   p_REFP    number,  -- Реф.док.~реструкруриз~~ДОК ГПП
   p_DAT     date  ,  -- Дата~GRACE
   p_KK1     int   ,  -- =1 KK1~Виконати~згорнення~залишків
   p_ADD3    int   ,  -- =1 GPP3~Добавити~різницю~рівн.долями
   p_OTM1    int   ,  -- =1 GPP2~Скоротити~переплату~знизу ГПП
   p_OTM2    int   ,  -- =1 GPP1~Анулювати~майбутній~ГПП
   p_GPP     int     ---- поки що НЕ використовуэться
  ) ;
------------
procedure ADD31 (p_acc number, p_REF number, p_KV OUT int,  S_err OUT varchar2 ) ; --=1 GPP3~Добавити~різницю~рівн.долями
procedure ADD32 (p_acc number, p_REF number, p_kv int, p_del int ) ;  ----  делает замену в проц.карточке,  якщо банківська дата рівна «Дата GRACE»( або менше у випадку якщо «Дата GRACE» припадає на вихідний день ):
procedure ADD3  (p_acc number, p_REF number )  ; --=1 GPP3~Добавити~різницю~рівн.долями
procedure ATO2_all (              p_dat date ) ;
procedure ATO2     ( p_ND number, p_dat date ) ;
-------------------------------------------------
 procedure DEL1 (p_otm1 int, -- = 1 Выровнять ГПП с остатком на счете
                 p_otm2 int, -- = 1 Отменить весь остаточный ГПП
                 p_bal  int,
                 p_acc number) ;
----------------------------------------------
 procedure P1_SNO (p_nd number, p_kv number, p_nls varchar2, p_sno number, p_ACC number, p_Dat_Beg date, p_Dat_End date ) ;
 -- умолчательная (предварительная) разметка ГПП на основе основного ГПК
 ----------------------------------------------
 procedure P0_SNO (p_nd number, p_kv number, p_nls varchar2, p_spn number,                p_Dat_Beg date, p_Dat_End date) ;
 -- Відкрити рах SNO та дати проект ГПП
 ---------------------------------------------
 procedure P2_SNO (p_bAL INT, p_nUM number, p_VCH varchar2 ) ;
 -- собственно генерация планово-форвардного платежа
 ----------------------------------------------
 procedure p3_sno(p_mode int, p_ID int, p_DAT date, p_S number, p_SA number );
 -- Вставка/удаление/изм в ГПП
----------------------------------------------------------------
 FUNCTION header_version RETURN VARCHAR2;
 FUNCTION body_version   RETURN VARCHAR2;
-------------------
END SNO;
/
CREATE OR REPLACE PACKAGE BODY BARS.SNO IS
  g_body_version CONSTANT VARCHAR2(64) := 'version 4.0.1 , 27/03/2017';

  SNO_31 char(1); -- гл.параметр = SNO_31 = 1 = Режим построения ГПП = Амортиз дата = посл.раб день пред мес перед платежной
  --              = иначе = 0 =                        Амортиз дата = платежной дате
  /*
   12.10.2016 Sta "31" числдо - по ГЛ.параетру
   18.08.2016   -- БЕК или снять с визы GPP    -- отмена. возврат назад. ---нет разбалансировки/ только передвижка вверх/вниз
   09.08.2016 MMFO  ВЕБ + Вибраний інтревал для ГПП
   25.11.2015 COBUSUPABS-3466  доопрацювання.docx
   18.11.2015 Sta GPP3 добавить равными долями
   16.11.2015 Sta Совмещение операции KK1 + GPK + другое
   21.10.2015 Sta Совмещение операции KK1 + GPK 21.10.2015
   12.10.2015 Sta Добавила ексепшен  'GRACE= ... БІЛЬШЕ дати завершення КД= ...
   12.08.2015 STA Реструктуризация типа АТО
   06.11.2014 Sta Переименование пакеджа cck_dop_nadra - > SNO и оставила только то, что касается SNO
  */
  ------------------------------------------------
  function GET_REF_BAK(p_REF number) return number is
    l_ref number;
  begin
    select max(ref)
      into l_REF
      from oper
     where sos = -1
       and pdat > sysdate - 5;
    If l_REF is null then
      select max(ref)
        into l_REF
        from oper
       where sos = -1
         and pdat > sysdate - 30;
    end if;
    If l_REF is null then
      select max(ref)
        into l_REF
        from oper
       where sos = -1
         and pdat > sysdate - 90;
    end if;
    RETURN l_ref;
  end GET_REF_BAK;
  ------------------
  function check_partition_exist(p_table_name in varchar2, p_date in date)
    return number is
    -- Проверка наличия партиций - от С.Горобца
    d date;
    part_date clob;
  begin
    for x in (select *
                from user_tab_partitions
               where table_name = p_table_name
               order by partition_position desc) loop
     -- part_date:=to_
      d := to_date(substr(x.high_value, 11, 10), 'yyyy-mm-dd');
      if (p_date > d) then
        return 0;
      else
        return 1;
      end if;
    end loop;
  end check_partition_exist;

  procedure BEK_REF_GPP(p_ref number) is -- БЕК или снять с визы GPP
  begin
    ful_bak(p_ref);
    delete from sno_gpp
     where acc = (select acc from sno_ref where ref = p_REF);
    delete from sno_ref where ref = p_ref;
  end BEK_REF_GPP;

  -----------------------------------------------------
  --SNO.ATO1 ( :ND, :P_DAT, :OTM1 )
  ----------------------------------------------
  procedure ATO1(p_ND      number, -- Реф КД~в АБС
                 p_acc_SNO number,
                 p_REFP    number, -- Реф.док.~реструкруриз~~ДОК ГПП
                 p_DAT     date, -- Дата~GRACE
                 p_KK1     int, -- =1 KK1~Виконати~згорнення~залишків
                 p_ADD3    int, -- =1 GPP3~Добавити~різницю~рівн.долями
                 p_OTM1    int, -- =1 GPP2~Скоротити~переплату~знизу ГПП
                 p_OTM2    int, -- =1 GPP1~Анулювати~майбутній~ГПП
                 p_GPP     int ---- поки що НЕ використовуэться
                 ) IS
    oo     oper%rowtype;
    aa_SNO accounts%rowtype;
    aa_SS  accounts%rowtype;
    dd     cc_deal%rowtype;
    ir_    number;
    lim2_  number;
    dd_    int;
    sum1_  number;
    basey_ int;
    l_kk1  int := nvl(p_kk1, 0);
    l_add3 int := nvl(p_add3, 0);
    l_otm1 int := nvl(p_otm1, 0);
    l_otm2 int := nvl(p_otm2, 0);
    ------------------------
    procedure OPl1(oo IN OUT oper%rowtype) is -- оплата 1 проводки
    begin
      If nvl(oo.s, 0) <= 0 then
        return;
      end if;
      if oo.ref is null then
        gl.ref(oo.REF);
        gl.in_doc3(ref_   => oo.ref,
                   tt_    => oo.tt,
                   vob_   => 6,
                   nd_    => oo.nd,
                   pdat_  => SYSDATE,
                   vdat_  => gl.bdate,
                   dk_    => oo.dk,
                   kv_    => oo.kv,
                   s_     => oo.S,
                   kv2_   => oo.kv,
                   s2_    => oo.s,
                   sk_    => null,
                   data_  => gl.bdate,
                   datp_  => gl.bdate,
                   nam_a_ => oo.nam_a,
                   nlsa_  => oo.nlsa,
                   mfoa_  => gl.aMfo,
                   nam_b_ => oo.nam_b,
                   nlsb_  => oo.nlsb,
                   mfob_  => gl.aMfo,
                   nazn_  => oo.nazn,
                   d_rec_ => null,
                   id_a_  => null,
                   id_b_  => null,
                   id_o_  => null,
                   sign_  => null,
                   sos_   => 1,
                   prty_  => null,
                   uid_   => null);
      end if;
      gl.payv(0,
              oo.ref,
              gl.bdate,
              oo.tt,
              oo.dk,
              oo.kv,
              oo.nlsa,
              oo.s,
              oo.kv,
              oo.nlsb,
              oo.s);
    end opl1;
    ---------
    procedure op_sno(p_nd   number,
                     aa_SPN accounts%rowtype,
                     aa_SNO IN OUT accounts%rowtype) is
    begin
      if aa_SNO.acc is null then
        aa_sno.nls := F_NEWNLS(aa_SPN.acc,
                               'SN ',
                               substr(aa_SPN.nbs, 1, 3) || '8');
        CCK.cc_op_nls(p_ND,
                      aa_spn.KV,
                      aa_sno.NLS,
                      'SNO',
                      aa_spn.ISP,
                      aa_spn.GRP,
                      null,
                      aa_spn.MDATE,
                      aa_sno.ACC);
        select * into aa_sno from accounts where acc = aa_sno.acc;
      end if;
    end op_sno;
    -----------
  begin

    If l_kk1 = 1 then

      If p_dat is null then
        raise_application_error(- (20203), 'GRACE=ПУСТО');
      ElsIf p_dat <= gl.bdate then
        raise_application_error(- (20203), 'GRACE<=Банк-даты');
      Else
        begin
          select *
            into dd
            from cc_deal
           where nd = p_nd
             and sos >= 10
             and sos < 14;
          if p_dat > dd.wdate then
            raise_application_error(- (20203),
                                    'GRACE=' ||
                                    to_char(p_dat, 'dd.mm.yyyy') ||
                                    ' БІЛЬШЕ дати заверш.КД=' ||
                                    to_char(dd.wdate, 'dd.mm.yyyy'));
          end if;
        EXCEPTION
          WHEN NO_DATA_FOUND then
            raise_application_error(- (20203),
                                    'НЕ знайдено КД =' || p_nd);
        end;
      end if;

    ElsIf (l_add3 + l_otm1 + l_otm2) >= 0 and p_REFP is null then
      raise_application_error(- (20203),
                              'НЕ Створено первинний ГПП ');

    ElsIf l_add3 = 1 then
      SNO.ADD3(p_acc => p_acc_SNO, p_REF => p_REFP);
      RETURN;

    ElsIf l_otm1 = 1 or l_otm2 = 1 then
      -- =1 GPP2~Скоротити~переплату~знизу ГПП
      SNO.DEL1(p_otm1 => l_OTM1,
               p_otm2 => l_OTM2,
               p_bal  => -1,
               p_acc  => p_acc_SNO);
      RETURN;
    end if;
    -----------------------------------------------------------------------------------------------------

    If l_kk1 = 1 then
      -- Переброс просрочек

      oo.tt   := 'KK1';
      oo.nd   := to_char(p_nd);
      oo.dk   := 1;
      oo.nazn := 'КД реф=' || p_nd ||
                 '. Реструктуризація простроченої заборгованості.';
      update nd_txt
         set txt = to_char(p_dat, 'dd/mm/yyyy')
       where nd = p_nd
         and tag = 'GRACE';
      if SQL%rowcount = 0 then
        insert into nd_txt
          (nd, tag, txt)
        values
          (p_nd, 'GRACE', to_char(p_dat, 'dd/mm/yyyy'));
      end if;

      for kk in (select a.*
                   from accounts a, nd_acc n
                  where a.ostc = a.ostb
                    and a.tip in ('SS ', 'SP ', 'SN ', 'SPN', 'SNO', 'LIM')
                    and a.acc = n.acc
                    and n.nd = p_nd
                  order by decode(a.tip, 'SS ', 1, 'SNO', 2, 3)) loop
        oo.kv    := kk.kv;
        oo.S     := -kk.ostc;
        oo.nam_b := substr(kk.nms, 1, 38);
        oo.nlsb  := kk.nls;

        -- 1) Об'єднання SS+SP -> SS
        if kk.tip = 'SS ' then
          If kk.dazs is not null then
            update accounts set dazs = null where acc = kk.acc;
          end if;
          aa_SS.kv    := kk.kv;
          aa_ss.nls   := kk.nls;
          aa_ss.nms   := kk.nms;
          aa_ss.mdate := kk.mdate;
          aa_ss.acc   := kk.acc;
          begin
            select basey
              into basey_
              from int_accn
             where acc = aa_ss.acc
               and id = 0;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              basey_ := 0;
          end;
        elsIf kk.tip = 'SP ' and kk.ostc < 0 then
          oo.nam_a := substr(aa_ss.nms, 1, 38);
          oo.nlsa  := aa_ss.nls;
          opl1(oo);

          -- 2) Об'єднання SNO + SN + SPN + SN`(майб.) -> SNO.
        elsIf kk.tip = 'SNO' then
          aa_SNO.kv  := kk.kv;
          aa_SNO.nls := kk.nls;
          aa_SNO.nms := kk.nms;
          aa_SNO.acc := kk.acc;
          If kk.dazs is not null then
            update accounts set dazs = null where acc = kk.acc;
          end if;
        elsIf kk.tip in ('SN ', 'SPN') then
          op_sno(p_nd, kk, aa_SNO);
          -- Заміна в проц.картці SN на SNO
          If kk.tip = 'SN ' then
            Update int_accn
               set acra = aa_sno.acc
             where acc = aa_ss.acc
               and id = 0;
          end if;
          If kk.ostc < 0 then
            oo.nam_a := substr(aa_sno.nms, 1, 38);
            oo.nlsa  := aa_sno.nls;
            opl1(oo);
          end if;
        elsIf kk.tip = 'LIM' then
          lim2_ := -kk.ostc;
          begin
            select s
              into dd_
              from int_accn
             where acc = kk.acc
               and id = 0;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              dd_ := to_number(to_char(gl.bdate, 'dd'));
          end;
        end if;
      end loop;

      --3) Анулювання всїх платежів в період від дати реструкт (gl.BD) до p_DAT
      delete from cc_lim
       where nd = p_nd
         and fdat >= gl.Bdate;
      -- 4) Зміни ГПК від p_DAT і до кінця КД cc_deal.wdate
      ir_ := acrn.fprocn(aa_SS.acc, 0, gl.bdate); -- проц.ставка
      ----- сумма 1-го пл
      sum1_ := cck.f_pl1(p_nd   => p_nd,
                         p_lim2 => lim2_, -- новый лимит
                         p_gpk  => 2, -- 4-Ануитет. 2 - Класс
                         p_dd   => dd_, -- <Платежный день>, по умол = DD от текущего банк.дня
                         p_datn => p_dat, -- дата нач КД
                         p_datk => aa_ss.mdate, -- дата конца КД
                         p_ir   => ir_, -- проц.ставка
                         p_ssr  => 0 -- признак =0= "с сохранением срока"
                         );
      -- перенести все в архив
      delete from CC_LIM_ARC
       where nd = p_nd
         and mdat = gl.bdate;
      insert into CC_LIM_ARC
        (ND,
         MDAT,
         FDAT,
         LIM2,
         ACC,
         NOT_9129,
         SUMG,
         SUMO,
         OTM,
         SUMK,
         NOT_SN,
         TYPM)
        select ND,
               gl.bdate,
               FDAT,
               LIM2,
               ACC,
               NOT_9129,
               SUMG,
               SUMO,
               OTM,
               SUMK,
               NOT_SN,
               'CCKD'
          from cc_lim
         where nd = p_ND;
      --------------------------
      --построим новую часть во врем табл
      cck.UNI_GPK_FL(p_lim2  => lim2_, -- новый лимит
                     p_gpk   => 2, -- 4-Ануитет. 2 - Класс ( -- 1-Ануитет. 0 - Класс   )
                     p_dd    => dd_, -- <Платежный день>, по умол = DD от текущего банк.дня
                     p_datn  => p_dat, -- дата нач КД
                     p_datk  => aa_ss.mdate, -- дата конца КД
                     p_ir    => ir_, -- проц.ставка
                     p_pl1   => sum1_, -- сумма 1 пл
                     p_ssr   => 0, -- признак =0= "с сохранением срока"
                     p_ss    => lim2_, -- остаток по норм телу
                     p_acrd  => p_dat, -- с какой даты начислять % acr_dat+1
                     p_basey => basey_ -- база для нач %%;
                     );
      insert into cc_lim
        (ND, FDAT, LIM2, ACC, SUMG, SUMO, SUMK)
        select p_nd, fdat, lim2, aa_ss.accc, sumg, sumo, nvl(sumk, 0)
          from tmp_gpk
         where fdat > gl.bdate;
      commit;

    end if;
    -------
  end ATO1;
  ---------
  procedure ADD31(p_acc number,
                  p_REF number,
                  p_KV  OUT int,
                  S_err OUT varchar2) is
    --=1 GPP3~Добавити~різницю~рівн.долями
    s_GPP  number;
    k_GPP  int;
    s_SNO  number;
    l_S    number;
    l_acc  number;
    l_kv   number;
    l_REF2 number;
    aa     accounts%rowtype;
  begin

    begin
      select * into aa from accounts where acc = p_acc;
      p_kv := aa.KV;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        S_Err := 'Відсутній рах SNO , acc=' || p_acc;
    end;
    If s_Err is null then
      select sum(S), count(*)
        into s_GPP, k_GPP
        from opldok
       where dk = 1
         and acc = p_acc
         and sos = 3
         and ref = p_ref;
      If k_GPP = 0 then
        S_Err := 'Відсутні майбутні суми в ГПП';
      end if;
      If aa.ostC <> aa.ostB then
        S_Err := 'НЕрівність план. та факт. залишку';
      end if;
      s_SNO := -aa.ostc;
      If s_SNO <= s_GPP then
        S_Err := 'Відсутнє перевищ.залишку над ГПП';
      end if;
    end if;
    If s_Err is not null then
      RETURN;
    end if;
    ---------------------------------------------------------------------------------------------------
    If s_SNO - s_GPP <= 100 then
      l_S := s_SNO - s_GPP;
    else
      l_S := round((s_SNO - s_GPP) / k_GPP - 5 / 10, 0);
    end if;
    l_ref2 := GET_REF_BAK(0);
    for k in (select *
                from opldok
               where dk = 1
                 and acc = p_acc
                 and sos = 3
                 and ref = p_ref
               order by stmt) loop
      k.S   := k.S + l_S;
      s_SNO := s_SNO - k.S;
      If s_SNO < l_S then
        k.S := k.S + s_SNO;
      end if;
      select acc
        into l_acc
        from opldok
       where dk = 1 - k.dk
         and ref = k.ref
         and stmt = k.stmt;
      gl.pay2(NULL,
              p_ref,
              k.fdat,
              k.tt,
              p_kv,
              1,
              to_char(P_acc),
              k.s,
              k.s,
              1,
              'Збільшити~ГПП');
      gl.pay2(NULL,
              p_ref,
              k.fdat,
              k.tt,
              p_kv,
              0,
              to_char(l_acc),
              k.s,
              k.s,
              0,
              'Збільшити~ГПП');
      update opldok
         set ref = l_ref2
       where ref = P_ref
         and stmt = k.stmt;
      If s_SNO < l_S then
        EXIT;
      end if;
    end loop;
    update oper set sos = 3 where ref = l_ref2;
    ful_bak(l_ref2);
  end ADD31;
  ----------
  procedure ADD32(p_acc number, p_REF number, p_kv int, p_del int) is
    ----  делает замену в проц.карточке,  якщо банківська дата рівна «Дата GRACE»( або менше у випадку якщо «Дата GRACE» припадає на вихідний день ):
    l_nd  number;
    l_acc number;
    g_Dat date;
  begin
    begin
      select nd
        into l_nd
        from nd_acc
       where acc = p_acc
         and rownum = 1;
      select to_date(txt, 'dd/mm/yyyy')
        into g_Dat
        from nd_txt
       where nd = l_ND
         and tag = 'GRACE';
      If g_Dat > (gl.bdate - p_Del) and g_Dat <= gl.Bdate then
        select a.acc
          into l_acc
          from accounts a, nd_acc n
         where a.kv = p_kv
           and a.tip = 'SN '
           and a.dazs is null
           and a.acc = n.acc
           and n.nd = l_nd
           and rownum = 1;
        Update int_accn I
           set acra = l_acc
         where acra = p_acc
           and acc in (select acc from nd_acc where nd = l_nd);
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;
  end ADD32;
  -------------------------------------------------------------------
  procedure ADD3(p_acc number, p_REF number) is
    --=1 GPP3~Добавити~різницю~рівн.долями
    l_Err varchar2(252);
    l_acc number;
    l_ref number;
    l_del int := 5;
    l_kv  int;
    ---------------------------------------------------------------------------------
  BEGIN
    -- Сканирование КД, у которых закончился грейс-перио
    If p_acc is null and p_REF is null then
      for G in (select t.nd, to_date(t.txt, 'dd/mm/yyyy') DAT, a.acc, x.REF
                  from nd_txt t, accounts a, nd_acc n, sno_ref x
                 where t.tag = 'GRACE'
                   and t.nd = n.nd
                   and n.acc = a.acc
                   and a.tip = 'SNO'
                   and a.acc = x.acc) loop
        If g.Dat > (gl.bdate - l_Del) and g.Dat <= gl.Bdate then
          SNO.ADD31(p_acc => G.acc,
                    p_REF => G.REF,
                    p_kv  => l_kv,
                    S_err => l_Err);
          SNO.ADD32(p_acc => G.acc,
                    p_REF => G.REF,
                    p_kv  => l_kv,
                    p_Del => l_Del);
        end if;
      end loop;
    else
      -- по одному КД ,по требованию
      begin
        If p_acc is not null and p_REF is not null then
          l_acc := p_acc;
          l_ref := p_ref;
        ElsIf p_acc is not null and p_REF is null then
          select o.ref, n.acc
            into l_ref, l_acc
            from oper o, nd_acc n, SNO_REF x
           where n.acc = p_acc
             and n.acc = x.acc
             and x.ref = o.ref
             and o.sos > 0;
        ElsIf p_acc is null and p_REF is not null then
          select o.ref, o.acc
            into l_ref, l_acc
            from opldok o, accounts a
           where o.ref = p_ref
             and o.acc = a.acc
             and a.tip = 'SNO'
             and rownum = 1;
        end if;
      end;
      SNO.ADD31(p_acc => l_acc,
                p_REF => l_ref,
                p_kv  => l_kv,
                S_err => l_Err);
      If l_Err is not null then
        raise_application_error(- (20203), l_Err);
      end if;
      SNO.ADD32(p_acc => l_acc,
                p_REF => l_ref,
                p_kv  => l_kv,
                p_Del => l_Del);

    end if;

  END ADD3;

  ----------------------------

  procedure ATO2_all(p_dat date) is
    BD_prev date;
    BD_next date;
    BD_txt  date;
  begin
    BD_prev := DAT_NEXT_U(p_dat, -1);
    BD_next := DAT_NEXT_U(p_dat, 0);
    for k in (select *
                from nd_txt
               where tag = 'GRACE'
              --and nd = 1379355
              ) loop
      BD_txt := to_date(k.txt, 'dd/mm/yyyy');
      If BD_txt > BD_prev and BD_txt <= BD_next then
        sno.ATO2(k.nd, p_dat);
      end if;
    end loop;
  end ATO2_all;
  ------------------------------------------------
  procedure ATO2(p_ND number, p_dat date) is
    aa_sno accounts%rowtype;
    aa_sn  accounts%rowtype;
  begin

    -- Побудова ГПП - графіка погашення процентів SNO з розбавкою суми згідно вашого алгоритму.
    begin
      SELECT a.*
        into aa_sno
        FROM accounts a, nd_acc n
       WHERE A.ACC = N.ACC
         AND A.TIP = 'SNO'
         AND N.ND = p_nd;
      SNO.P1_SNO(p_nd,
                 aa_sno.KV,
                 aa_sno.NLS,
                 0,
                 aa_sno.ACC,
                 to_date(null),
                 to_date(null));
      SNO.P2_SNO(-1, 0, null);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;

    -- Повернення в проц.картці SNO на SN
    begin
      SELECT a.*
        into aa_sn
        FROM accounts a, nd_acc n
       WHERE A.ACC = N.ACC
         AND A.TIP = 'SN '
         AND N.ND = p_nd
         AND A.dazs is null;
      update int_accn i
         set i.acra = aa_sn.acc
       where i.acra = aa_sno.acc
         and i.id = 0
         and i.acc in (select acc from nd_acc where nd = p_nd);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;
  end ATO2;

  ----########################################
  procedure DEL1(p_otm1 int, -- = 1 Выровнять ГПП с остатком на счете
                 p_otm2 int, -- = 1 Отменить весь остаточный ГПП
                 p_bal  int, -- = -1 - зменшити с конца ГПП = подтянуть вверх
                 -- =  1 - зменшити с начала ГПП= опустить вниз
                 p_acc number) is
    sno     accounts%rowtype;
    l_nd    number;
    l_ref1  number;
    l_ref2  number;
    l_S     number;
    l_acc   number;
    l_koeff number;
    l_del   number;

    procedure RAW_GPP(p_ND  number,
                      p_Bal number,
                      p_Ref number,
                      p_acc number) is
      l_Dat31 date;
      l_fdat  date;
      xx      opldok%rowtype;
      LL      SYS_REFCURSOR;
      OO      SYS_REFCURSOR;
    begin

      OPEN LL FOR
        select Dat_Next_U(trunc(fdat, 'MM'), -1), FDAT
          from cc_lim
         where nd = p_ND
           and Dat_Next_U(trunc(fdat, 'MM'), -1) > gl.bdate
           and nvl(NOT_SN, 0) <> 1
         order by fdat;

      OPEN OO FOR
        select *
          from opldok
         where ref = p_ref
           and sos = 3
           and dk = 1
           and acc = p_acc
         order by fdat;

      FETCH LL
        into l_Dat31, l_FDAT;
      If LL%NOTFOUND then
        goto END_1;
      end if;
      FETCH OO
        into XX;
      If OO%NOTFOUND then
        goto END_1;
      end if;
      ------------------------------------------------------------
      LOOP
        If l_dat31 < xx.fdat then
          FETCH LL
            into l_Dat31, l_FDAT;
          If LL%NOTFOUND then
            goto END_1;
          end if;
        elsIf l_dat31 = xx.fdat then
          insert into sno_gpp
            (nd, acc, fdat, dat31, sump1)
          values
            (p_nd, p_acc, L_FDAT, l_dat31, xx.s);
          FETCH LL
            into l_Dat31, l_FDAT;
          If LL%NOTFOUND then
            goto END_1;
          end if;
          FETCH OO
            into XX;
          If OO%NOTFOUND then
            goto END_1;
          end if;
        else
          goto END_1;
        end if;
      end loop;
      ---------------------------------------
      <<END_1>>
      null;
      close LL;
      close OO;

    end RAW_GPP;

  begin

    begin
      select nd
        into l_nd
        from nd_acc
       where acc = p_acc
         and rownum = 1;
      PUL.Set_Mas_Ini('WACC',
                      'a.acc in (select acc from nd_acc where nd=' || l_ND || ')',
                      null);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                'Не знайдено угоду для рахунку SNO');
    end;

    If p_otm1 = 1 and p_otm2 = 1 then
      raise_application_error(- (20203),
                              'Не можна одночасно CКОРОТИТИ та ВІДМІНИТИ залишок~ГПП');
    end if;
    If p_otm1 = 0 and p_otm2 = 0 then
      raise_application_error(- (20203),
                              'Потрiбно задати  CКОРОТИТИ або ВІДМІНИТИ залишок~ГПП');
    end if;

    begin
      select *
        into sno
        from accounts
       where acc = p_acc
         and ostc = ostb;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                'Є незавiзованi документи по рах.SNO');
    end;

    begin
      select ref
        into l_ref1
        from sno_ref x
       where acc = p_acc
         and exists (select 1
                from opldok
               where ref = x.ref
                 and sos = 3
                 and tt = 'GPP');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                'Не знайдено реф.ГПП ');
    end;

    l_ref2 := GET_REF_BAK(0);
    ----------------------------------------
    delete from sno_GPP
     where nd = l_nd
       and acc = p_acc;

    If p_otm2 = 1 then
      ---------- Вiдмiнити залишок~ГПП
      update opldok
         set ref = l_ref2
       where ref = l_ref1
         and sos in (1, 3)
         and tt = 'GPP';
      update oper set sos = 3 where ref = l_ref2;
      ful_bak(l_ref2);
      delete from sno_ref
       where nd = l_nd
         and acc = p_acc;

      ------ begin select nd into l_nd from sno_ref where nd = l_nd and acc <> p_acc and rownum=1 ; -- перестроить sno_gpp - пока нет
      ------ EXCEPTION WHEN NO_DATA_FOUND THEN null;
      ------ end;

      INSERT INTO cc_sob
        (ND, FDAT, ISP, TXT, otm)
      VALUES
        (l_ND,
         gl.bDATE,
         gl.aUid,
         'Вiдмiнити залишок~ГПП',
         6);
      RETURN;
    end if;

    -- Вирівняти   залишок~ГПП
    If p_bal not in (1, -1) then
      raise_application_error(- (20203),
                              'Невірний спосіб балансування =' || p_bal);
    end if;
    l_S := (sno.ostf + sno.ostc);

    If l_S = 0 then
      ----  RAW_GPP(l_ND, (-1)*p_Bal , l_Ref1, p_acc ) ;    -- движок вверх/вниз
      RETURN;
    end if;

    If l_s > 0 then
      -- На SNO меньше, чем в ГПК. сокращение сверху/снизу
      INSERT INTO cc_sob
        (ND, FDAT, ISP, TXT, otm)
      VALUES
        (l_ND,
         gl.bDATE,
         gl.aUid,
         'Скорочено залишок ГПП на ' || l_S || ', баланс= ' || p_bal,
         6);

      for k in (select *
                  from opldok
                 where ref = l_ref1
                   and acc = sno.acc
                   and dk = 1
                   and sos = 3
                   and tt = 'GPP'
                 order by p_bal * to_number(to_char(fdat, 'yyyymmdd'))) loop
        if l_s > 0 then
          if l_s >= k.S then
            l_s := l_s - k.S;
          else
            l_s := k.s - l_s;
            select acc
              into l_acc
              from opldok
             where dk = 1 - k.dk
               and ref = k.ref
               and stmt = k.stmt;
            gl.pay2(NULL,
                    l_ref1,
                    k.fdat,
                    k.tt,
                    sno.kv,
                    1,
                    to_char(sno.acc),
                    l_s,
                    l_s,
                    1,
                    'Скоротити~ГПП');
            gl.pay2(NULL,
                    l_ref1,
                    k.fdat,
                    k.tt,
                    sno.kv,
                    0,
                    to_char(l_acc),
                    l_s,
                    l_s,
                    0,
                    'Скоротити~ГПП');
            l_s := 0;
          end if;
          update opldok
             set ref = l_ref2
           where ref = l_ref1
             and stmt = k.stmt;
          if l_s = 0 then
            EXIT;
          end if;
          ------------------------------
        end if;
      end loop;

    ElsIf l_s < 0 then
      -- На SNO больше, чем в ГПК. добавить в удельном весе каждоме платежу и сбалансировать
      l_s     := -l_S;
      l_koeff := l_S / sno.ostF;
      INSERT INTO cc_sob
        (ND, FDAT, ISP, TXT, otm)
      VALUES
        (l_ND,
         gl.bDATE,
         gl.aUid,
         'Збільшено залишок ГПП на ' || l_S ||
         ' зі збільш.пл в питомій вазі ' || l_koeff,
         6);

      select l_S - sum(round(s * l_koeff, 0))
        into l_del
        from opldok
       where ref = l_ref1
         and acc = sno.acc
         and dk = 1
         and sos = 3
         and tt = 'GPP';

      for k in (select *
                  from opldok
                 where ref = l_ref1
                   and acc = sno.acc
                   and dk = 1
                   and sos = 3
                   and tt = 'GPP'
                 order by p_bal * to_number(to_char(fdat, 'yyyymmdd'))) loop
        k.S   := k.S + round(k.s * l_koeff, 0) + l_Del;
        l_Del := 0;
        If k.s > 0 then
          select acc
            into l_acc
            from opldok
           where dk = 1 - k.dk
             and ref = k.ref
             and stmt = k.stmt;
          gl.pay2(NULL,
                  l_ref1,
                  k.fdat,
                  k.tt,
                  sno.kv,
                  1,
                  to_char(sno.acc),
                  k.s,
                  k.s,
                  1,
                  'Збільшити ГПП');
          gl.pay2(NULL,
                  l_ref1,
                  k.fdat,
                  k.tt,
                  sno.kv,
                  0,
                  to_char(l_acc),
                  k.s,
                  k.s,
                  0,
                  'Збільшити ГПП');
        end if;
        update opldok
           set ref = l_ref2
         where ref = l_ref1
           and stmt = k.stmt;
      end loop;
    end if;
    update oper set sos = 3 where ref = l_ref2;
    ful_bak(l_ref2);

    RAW_GPP(l_ND, p_Bal, l_Ref1, p_acc);

  end DEL1;

  -----------------------------------------------------
  procedure P1_SNO(p_nd      number,
                   p_kv      number,
                   p_nls     varchar2,
                   p_sno     number,
                   p_ACC     number,
                   p_Dat_Beg date,
                   p_Dat_End date) is
    -- умолчательная (предварительная) разметка ГПП на основе основного ГПК =
    -- Даты = последнему раб.дню предыдущего мес. типа "31" числа
    l_acc     number;
    sno       accounts%rowtype;
    SR        sno_ref%rowtype;
    s0_       number;
    s1_       number;
    kol_      int := 0;
    i_        int := 0;
    l_dat31   date;
    l_dat_Beg date;
    l_Dat_End date;

  begin

    SNO_31 := PUL.get(tag_ => 'SNO_31');

    If p_acc is null then
      l_acc := TO_NUMBER(pul.Get_Mas_Ini_Val('ACC'));
    else
      l_acc := p_acc;
      PUL.Set_Mas_Ini('ACC', to_char(l_acc), 'ACC');
    end if;

    PUL.Set_Mas_Ini('WACC',
                    'a.acc in (select acc from nd_acc where nd=' || p_ND || ')',
                    null);

    begin
      select *
        into sno
        from accounts
       where acc = l_acc
         and ostc = ostb
         and dazs is null;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                'P1: Проблема з Рах.SNO ' || p_kv || '/' ||
                                p_nls);
    end;

    begin
      select * into SR from SNO_REF where acc = l_acc;
      If SR.ref > 0 then
        raise_application_error(- (20203),
                                'P1: ГПП уже побудовано.Реф_Док=' || SR.ref);
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;

    l_Dat_Beg := gl.Bdate + 1;
    l_Dat_Beg := GREATEST(NVL(p_Dat_Beg, l_Dat_Beg), l_Dat_Beg);

    l_Dat_End := NVL(p_Dat_End, sno.mdate);
    If l_Dat_End is null then
      select max(fdat)
        into l_Dat_End
        from cc_lim
       where nd = p_nd
         and Dat_Next_U(trunc(fdat, 'MM'), -1) > gl.BDate
         and nvl(NOT_SN, 0) <> 1;
    end if;

    If l_Dat_Beg >= l_Dat_End then
      raise_application_error(- (20203),
                              'P1:Помилкові дати <з>= ' ||
                              to_char(l_Dat_Beg, 'dd.mm.yyyy') || ' <по>=' ||
                              to_char(l_Dat_End, 'dd.mm.yyyy'));
    end if;

    delete from T2_sno where acc = l_acc;
    s0_ := p_sno * 100;

    If SNO_31 = '0' THEN
      --------------------------------------- Требование Амортиз дата = платежной дате (ЦА ОБ, Стяжкина Л.+Русаков С.)
      select count(*)
        into kol_
        from cc_lim
       where nd = p_nd
         and nvl(NOT_SN, 0) <> 1
         and fdat >= l_Dat_Beg
         and fdat <= l_Dat_End;
      If kol_ = 0 then
        raise_application_error(- (20203),
                                'P1: Відсутні можливі майбутні плат.дати з %%');
      end if;
      s1_ := round(s0_ / kol_, 0);
      insert into T2_sno
        (dat, FDAT, s, id, otm, ostf, KV, nd, nls, spn, acc)
        select FDAT,
               FDAT,
               s1_,
               ROWNUM,
               0,
               p_sno * 100,
               p_kv,
               p_nd,
               p_nls,
               p_sno,
               l_acc
          from (select FDAT
                  from cc_lim
                 where nd = p_nd
                   and nvl(NOT_SN, 0) <> 1
                   and fdat >= l_Dat_Beg
                   and fdat <= l_Dat_End
                 order by fdat);

    else
      --------------------------------- Здравый смысл: Режим построения ГПП = Амортиз дата = посл.раб день пред мес перед платежной
      select count(*)
        into kol_
        from cc_lim
       where nd = p_nd
         and nvl(NOT_SN, 0) <> 1
         and fdat >= l_Dat_Beg
         and fdat <= l_Dat_End
         and Dat_Next_U(trunc(fdat, 'MM'), -1) > gl.BDate; -- первое 31 число тоже в будущем
      If kol_ = 0 then
        raise_application_error(- (20203),
                                'P1: Відсутні можливі майбутні амортиз.дати (типу "31" число)');
      end if;
      s1_ := round(s0_ / kol_, 0);
      insert into T2_sno
        (dat, FDAT, s, id, otm, ostf, KV, nd, nls, spn, acc)
        select DAT31,
               FDAT,
               s1_,
               ROWNUM,
               0,
               p_sno * 100,
               p_kv,
               p_nd,
               p_nls,
               p_sno,
               l_acc
          from (select Dat_Next_U(trunc(fdat, 'MM'), -1) DAT31, FDAT
                  from cc_lim
                 where nd = p_nd
                   and nvl(NOT_SN, 0) <> 1 -----------------------------  пл.день с процентами
                   and fdat >= l_Dat_Beg
                   and fdat <= l_Dat_End
                   and Dat_Next_U(trunc(fdat, 'MM'), -1) > gl.BDate -- первое 31 число тоже в будущем
                 order by fdat);
    end if;
    --------------------------------
    PUL.Set_Mas_Ini('P_ND', to_char(p_nd), 'P_ND');
    PUL.Set_Mas_Ini('P_KV', to_char(sno.kv), 'P_KV');
    PUL.Set_Mas_Ini('P_NLS', to_char(sno.nls), 'P_NLS');
    --------------------------------
  end P1_SNO;
  -----------------------------

  procedure P0_SNO(p_nd      number,
                   p_kv      number,
                   p_nls     varchar2,
                   p_spn     number,
                   p_Dat_Beg date,
                   p_Dat_End date) is
    aa_spn accounts%rowtype;
    aa_sno accounts%rowtype;
    l_sno  number;
    -- Відкрити рах SNO та дати проект ГПП
  begin
    begin
      select a.*
        into aa_spn
        from accounts a, nd_acc n
       where a.kv = p_kv
         and a.nls = p_nls
         and a.acc = n.acc
         and n.nd = p_nd
         and a.ostc < 0
         and a.ostc = a.ostb
         and abs(a.ostc) / 100 >= nvl(p_SPN, 0);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                'P0: Проблема з Рах.SPN ' || p_kv || '/' ||
                                p_nls);
    end;

    aa_sno.nls := F_NEWNLS(aa_spn.ACC,
                           'SN ',
                           substr(aa_spn.nbs, 1, 3) || '8');
    aa_sno.nls := vkrzn(substr(gl.aMfo, 1, 5), aa_sno.NLS);
    aa_sno.kv  := aa_spn.KV;
    CCK.cc_op_nls(p_ND,
                  aa_sno.KV,
                  aa_sno.NLS,
                  'SNO',
                  aa_spn.ISP,
                  aa_spn.GRP,
                  null,
                  aa_spn.MDATE,
                  aa_sno.ACC);
    PUL.Set_Mas_Ini('ACC', to_char(aa_sno.ACC), 'ACC');
    PUL.Set_Mas_Ini('WACC',
                    'a.acc in (select acc from nd_acc where nd=' || p_ND || ')',
                    null);

    l_sno := NVL(p_spn, -aa_spn.ostc / 100);
    --------------------------------------------------------------------------
    SNO.P1_SNO(p_nd, p_kv, p_nls, l_sno, aa_sno.ACC, p_Dat_Beg, p_Dat_End);
    --------------------------------------------------------------------------
  end p0_SNO;

  -------------------------------------------------------------------------------
  procedure P2_SNO(p_bAL INT, p_nUM number, p_VCH varchar2) is
    --собственно генерация планово-форвардного платежа на основе введенной врем таблицы
    -- p_bAL = -1 - с БАЛАНСИРОВКОЙ с конца ГПП
    -- = 1 - с БАЛАНСИРОВКОЙ с начала ГПП
    -- = 0 БЕЗ. ТОЛЬКО ПРОВЕРКА
    -- p_nUM number, p_VCH varchar2 - не использую, просто резерв
    l_acc  number;
    oo     oper%Rowtype;
    SPN    accounts%Rowtype;
    SNO    accounts%Rowtype;
    SN     accounts%Rowtype;
    dd     cc_deal%rowtype;
    l_si   number := 0;
    l_mdat date;
    l_ostf number;
    l_s    number;
    x_dat  date;
    sTmp_  varchar2(70);
    ---------------
    procedure Add_GPK(p_nd number, p_acc number) is
      l_SA     number;
      l_so     number;
      l_yyyymm char(6) := '******';
      l_s      number;
    begin
      for k in (select sa, dat, rowid RI
                  from T2_sno
                 WHERE acc = p_acc
                 order by dat) loop
        If k.sa > 0 then
          l_sa := k.sa;
        Elsif k.sa = 0 then
          l_sa := null;
        end if;
        If l_sa > 0 and l_yyyymm <> to_char(k.dat, 'yyyymm') then
          l_yyyymm := to_char(k.dat, 'yyyymm');
          select nvl(sum(sumo), 0)
            into l_so
            from cc_lim
           where nd = p_nd
             and to_char(fdat, 'yyyymm') = l_yyyymm;
          l_s := greatest(0, l_sa - l_so);
          update t2_sno set s = l_s, sa = 0 where rowid = k.ri;
        end if;
      end loop;
    end Add_GPK;
    --------------
    procedure Bal_GPP(p_Bal int, p_ost number, p_s number, p_acc number) is
      l_s0 number := p_ost - p_s;
    begin
      for k in (select *
                  from T2_sno
                 where s <> 0
                   and acc = p_acc
                 order by p_bal * id) loop
        If l_s0 = 0 then
          Return;
        ElsIf l_s0 > 0 OR k.s + l_s0 >= 0 then
          update t2_sno
             set s = s + l_s0
           where id = k.id
             and acc = k.acc;
          l_s0 := 0;
        else
          Update t2_sno
             set s = 0
           where id = k.id
             and acc = k.acc;
          l_s0 := l_s0 + k.s;
        end if;
      end loop;
    end Bal_Gpp;
    -------------
  begin
    begin
      l_acc := TO_NUMBER(pul.Get_Mas_Ini_Val('ACC'));
      select ostf, ND
        into l_ostf, dd.nd
        from t2_sno
       WHERE acc = l_acc
         and rownum = 1;

      -- пересчитать через общий платеж
      Add_GPK(dd.nd, l_acc);

      --проверить сбалансированность
      select nvl(sum(s), 0) into l_s from t2_sno WHERE acc = l_acc;

      If l_s <> l_ostf then
        If p_BAL in (1, -1) then
          Bal_GPP(p_Bal, l_ostf, l_s, l_acc);
        else
          raise_application_error(- (20203),
                                  'Вiдсутнiй баланс ГПП',
                                  TRUE);
        End if;
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' He знайдено записiв в ГПП',
                                TRUE);
    end;

    oo.ref  := null;
    oo.nlsa := null;
    oo.tt   := 'GPP';
    ------------------------------------------------
    select max(dat) into x_dat from t2_sno WHERE acc = l_acc;
   /* If check_partition_exist(p_table_name => 'OPLDOK', p_date => x_dat) = 0 then
      raise_application_error(- (20203),
                              ' He створено партиції по ' ||
                              to_char(x_dat, 'dd-mm-yyyy'));
    end if;
*/
    for k in (select *
                from T2_SNO
               where acc = l_acc
                 and s > 0
               order by dat) loop
      l_mdat := k.fdat;

      If oo.ref is null then
        delete from SNO_GPP
         where nd = k.nd
           and fdat >= k.dat
           and acc = l_acc;

        begin
          select * into dd from cc_deal where nd = k.ND; -- ищем только для назн пл
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            null;
        end;

        begin
          select *
            into spn
            from accounts
           where kv = k.KV
             and nls = k.NLS; --найти  счет SPN (или уже SNO), где есть сумма SNO
          select * into sno from accounts where acc = l_acc; --найти  счет SNO, куда будем переносить просрочку
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return;
        end;

        begin
          select a.*
            into sno
            from accounts a, nd_acc n
           where n.nd = k.ND
             and n.acc = a.acc
             and tip = 'SNO'
             and kv = k.KV
             and a.dazs is null
             and a.acc = l_acc;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            raise_application_error(- (20203),
                                    ' пробл.з рах SPN. SNO');
        end;
        --------------------------------------------------
        --найти/открыть первый попавш незакр счет SN,
        begin
          select a.*
            into sn
            from accounts a, nd_acc n
           where n.nd = k.ND
             and n.acc = a.acc
             and tip = 'SN '
             and kv = k.KV
             and a.dazs is null
             and rownum = 1;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            sn.nls := cck.NLS0(k.ND, 'SN ');
            CCK.cc_op_nls(k.ND,
                          k.KV,
                          sn.NLS,
                          'SN ',
                          spn.ISP,
                          spn.GRP,
                          null,
                          spn.MDATE,
                          sn.ACC);
            select * into sn from accounts where acc = sn.acc;
        end;
if  SYS_CONTEXT ('bars_context', 'user_mfo')  is null or sys_context('bars_context','user_branch') is  null then
   raise_application_error(- (20203), 'Сесія користувача невалідна.Втрачено контекст');
end if;

        oo.kv := k.KV;
        gl.ref(oo.ref);
        gl.in_doc3(ref_   => oo.ref,
                   tt_    => oo.tt,
                   vob_   => 6,
                   nd_    => to_char(k.ND),
                   pdat_  => SYSDATE,
                   vdat_  => gl.bdate,
                   dk_    => 1,
                   kv_    => oo.kv,
                   s_     => k.s,
                   kv2_   => oo.kv,
                   s2_    => k.s,
                   sk_    => null,
                   data_  => gl.bdate,
                   datp_  => gl.bdate,
                   nam_a_ => substr(sno.nms, 1, 38),
                   nlsa_  => sno.nls,
                   mfoa_  => gl.amfo,
                   nam_b_ => substr(spn.nms, 1, 38),
                   nlsb_  => spn.nls,
                   mfob_  => gl.amfo,
                   nazn_  => 'Реструктуризацiя прострочених/відкладених вiдсоткiв по КД № ' ||
                             dd.cc_id || ' вiд ' ||
                             to_char(dd.sdate, 'dd.mm.yyyy'),
                   d_rec_ => null,
                   id_a_  => gl.aokpo,
                   id_b_  => gl.aokpo,
                   id_o_  => null,
                   sign_  => null,
                   sos_   => 0,
                   prty_  => null,
                   uid_   => null);
      end if;

      sTmp_ := 'SNO-відсотки до сплати ' || to_char(k.FDAT, 'dd.mm.yyyy');

      gl.pay2(p_flag => null, -- NUMBER,        -- "Last entry" flag
              p_ref  => oo.ref, -- NUMBER,        -- Doc reference
              p_vdat => k.DAT, -- Value date
              p_tt   => oo.tt, -- Transaction type
              p_kv   => k.kv, -- Currency code
              p_dk   => 0, --  Debit/Credit flag
              p_nls  => to_char(sn.acc), -- Account number
              p_s    => k.s, -- Amount
              p_sq   => 0, -- Amount (Base Equivalent)
              p_stmt => 1, -- First(1)/Next(0) Flag
              p_txt  => sTmp_);

      gl.pay2(p_flag => null, -- NUMBER,        -- "Last entry" flag
              p_ref  => oo.ref, -- NUMBER,        -- Doc reference
              p_vdat => k.DAT, -- Value date
              p_tt   => oo.tt, -- Transaction type
              p_kv   => k.kv, -- Currency code
              p_dk   => 1, --  Debit/Credit flag
              p_nls  => to_char(sno.acc), -- Account number
              p_s    => k.s, -- Amount
              p_sq   => 0, -- Amount (Base Equivalent)
              p_stmt => 0, -- First(1)/Next(0) Flag
              p_txt  => sTmp_ -- Comment
              );
      l_si := l_si + k.s;
      insert into SNO_GPP
        (nd, dat31, fdat, sump1, acc)
      values
        (k.nd, k.dat, k.fdat, k.s, k.acc);
    end loop;

    If oo.ref is not null then
      update oper set s = l_si, s2 = l_si where ref = oo.ref;
      If sno.nls <> spn.nls then
        gl.payv(0,
                oo.ref,
                gl.bdate,
                'GPP',
                1,
                oo.KV,
                sno.nls,
                l_si,
                oo.KV,
                spn.nls,
                l_si);
      end if;

      update SNO_REF set ref = oo.ref, nd = dd.nd where acc = sno.acc;
      if SQL%rowcount = 0 then
        insert into SNO_REF (acc, ref, nd) values (sno.acc, oo.ref, dd.nd);
      end if;

      ----update accounts set MDATE= l_mdat where acc = sno.acc ;
      delete from T2_sno where acc = sno.acc;
    end if;

  end p2_sno;
  ----------------------------------------------
  procedure p3_sno(p_mode int,
                   p_ID   int,
                   p_DAT  date,
                   p_S    number,
                   p_SA   number) is
    -- Вставка/удаление/изм в ГПП
    l_id  int;
    tt    t2_sno%rowtype;
    l_acc number;
  begin

    l_acc := TO_NUMBER(pul.Get_Mas_Ini_Val('ACC'));

    If p_mode = 0 then
      delete from t2_sno
       where id = p_id
         and acc = l_acc;

    ElsIf p_mode = 1 then

      begin
        select *
          into tt
          from t2_sno
         where ND is not null
           and KV is not null
           and NLS is not null
           and rownum = 1
           and acc = l_acc;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          tt.ND  := to_number(Pul.Get_Mas_Ini_Val('P_ND'));
          tt.KV  := to_number(Pul.Get_Mas_Ini_Val('P_KV'));
          tt.NLS := Pul.Get_Mas_Ini_Val('P_NLS');
      end;

      if p_id is null then
        select nvl(max(id), 0) + 1 into l_id from t2_sno;
      else
        l_id := p_id;
      end if;

      insert into T2_sno
        (dat, s, id, otm, ND, KV, NLS, sa)
      values
        (p_dat, p_s * 100, l_id, 0, tt.ND, tt.KV, tt.NLS, p_sa * 100);

    ElsIf p_mode = 2 then
      update T2_sno
         set dat = p_dat, s = p_s * 100, sa = p_sa * 100
       where id = p_id
         and acc = l_acc;

    end if;

  end p3_sno;
  -----------------------
  --------------------------------------------

  FUNCTION header_version RETURN VARCHAR2 is
  BEGIN
    RETURN 'Package header SNO ' || g_header_version;
  END header_version;
  FUNCTION body_version RETURN VARCHAR2 is
  BEGIN
    RETURN 'Package body SNO ' || g_body_version;
  END body_version;

---Аномимный блок --------------
begin

  -- гл.параметр = SNO_31 = 1 = Режим построения ГПП = 1 = Амортиз дата = посл.раб день пред мес перед платежной
  --                      = иначе = 0 = или отсутствует  = Амортиз дата = платежной дфте
  begin
    select '1'
      into SNO.SNO_31
      from params
     where par = 'SNO_31'
       and trim(val) = '1';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SNO.SNO_31 := '0';
  end;
  PUL.put(tag_ => 'SNO_31', val_ => SNO.SNO_31);

END SNO;
/
 show err;
 
PROMPT *** Create  grants  SNO ***
grant EXECUTE                                                                on SNO             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SNO             to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sno.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 