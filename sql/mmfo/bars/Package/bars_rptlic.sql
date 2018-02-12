
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_rptlic.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_RPTLIC 
is

    -----------------------------------------------------------------
    --                                                             --
    --         Пакет для функций печати разных видов выписок       --                                                             --
    --                                                             --
    --  created: by anny                                           --
    --                                                             --
    --  Мульти МФО схема                                           --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    VERSION_HEADER    constant varchar2(64)  := 'version 7.2 10.02.2015';

    G_ROWTYPE_ACC      constant number    := 10;  -- строка, содержащая входящий остаток и входящий остаток в эквиваленте
    G_ROWTYPE_DOC      constant number    := 20;  -- строка, содержащая документ
    G_ROWTYPE_REV      constant number    := 30;  -- строка, содержащая переоценку

    VERSION_AWK_HDR    constant varchar2(64)  := 'awk version: '||
    'Мульти МФО схема'
    ;


    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2;



    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2;



    -----------------------------------------------------------------
    --  ROWTYPE_ACC()
    --
    function rowtype_acc return number;

    -----------------------------------------------------------------
    --  ROWTYPE_DOC()
    --
    function rowtype_doc return number;

    -----------------------------------------------------------------
    --  ROWTYPE_REV()
    --
    function rowtype_rev return number;



    -----------------------------------------------------------------
    --  LIC_GRNB()
    --
    --   Выписки по гривне за период.
    --   С возможностью указания маски по счету, исполнителя счета
    --
    --   p_date1   - дата с
    --   p_date2   - дата по
    --   p_mask    - маска       (по умолчанию - все)
    --   p_isp     - исполнитель (по умолчанию - все)
    --   p_branch  -  бранч
    --   p_inform  - информационные сообщения (=1 - вносить, =0 - не вносить)
    --
    procedure lic_grnb(  p_date1   date,
                         p_date2   date,
                         p_mask    varchar2           default '%',
                         p_isp     number             default 0,
                         p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                         p_inform  smallint           default 1);



    -----------------------------------------------------------------
    --  LIC_VALB()
    --
    --   Выписки по валюте за период.
    --   С возможностью указания маски по счету, исполнителя счета
    --
    --   p_date1   - дата с
    --   p_date2   - дата по
    --   p_mask    - маска       (по умолчанию - все)
    --   p_isp     - исполнитель (по умолчанию - все)
    --   p_branch  -  бранч
    --   p_inform  - информационные сообщения (=1 - вносить, =0 - не вносить)
    --
    procedure lic_valb(
                  p_date1   date,
                  p_date2   date,
                  p_mask    varchar2            default '%',
                  p_kv      number              default 0,
                  p_isp     number              default 0,
                  p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                  p_inform  smallint            default 1);



    -----------------------------------------------------------------
    --  VALIDATE_NLSMASK()
    --
    --   Валидация коррекности введенной маски счтеа
    --   должно быть введено хотябы 4ре символа слева
    --
    --   p_mask    -  маска
    --
    --
    procedure validate_nlsmask(p_mask varchar2);


    -----------------------------------------------------------------
    --  VALIDATE_NLSMASKS()
    --
    --   Валидация коррекности введенных масок счтета
    --
    --
    procedure validate_nlsmasks(p_mask1 varchar2, p_mask2 varchar2);



    -----------------------------------------------------------------
    --  LIC_GROUP
    --
    --   Формирование выписок по отчетным группам
    --
    --   p_date1   -  дата с
    --   p_date2   -  дата по
    --   p_inform  -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_kv      -  (0-все)
    --   p_mltval  -  вылютная
    --   p_valeqv  -  с эквивалентами
    --   p_valrev  -  с переоценкой (revaluation)
    --   p_repgrp  -  отчетная группа
    --
    procedure lic_group(
                  p_date1   date,
                  p_date2   date,
          p_inform  smallint            default 1,
          p_kv      smallint            default 0,
                  p_mltval  smallint            default 0,
                  p_valeqv  smallint            default 0,
                  p_valrev  smallint            default 0,
          p_repgrp  smallint);



    -----------------------------------------------------------------
    --  LIC_DYNSQL
    --
    --   Формирование выписок по динамическому запросу из справочника REPVP_DYNSQL
    --
    --   p_date1   -  дата с
    --   p_date2   -  дата по
    --   p_inform  -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_kv      -  (0-все)
    --   p_mltval  -  вылютная (если =2, включает тогда и гривну с валютой)
    --   p_valeqv  -  с эквивалентами
    --   p_valrev  -  с переоценкой (revaluation)
    --   p_sqlid   -  № динамич. запроса    из справочника REPVP_DYNSQL
    --
    procedure lic_sqldyn(
                  p_date1   date,
                  p_date2   date,
                  p_inform  smallint            default 1,
                  p_kv      smallint            default 0,
                  p_mltval  smallint            default 0,
                  p_valeqv  smallint            default 0,
                  p_valrev  smallint            default 0,
                  p_sqlid   number);


    -----------------------------------------------------------------
    --  LIC_GRNB_OB()
    --
    --   Выписки по гривне за период c указанием ОБ22
    --   С возможностью указания маски по счету, исполнителя счета
    --
    --   p_date1   - дата с
    --   p_date2   - дата по
    --   p_mask    - маска       (по умолчанию - все)
    --   p_isp     - исполнитель (по умолчанию - все)
    --   p_branch  -  бранч
    --   p_inform  - информационные сообщения (=1 - вносить, =0 - не вносить)
    --
    procedure lic_grnb_ob(  p_date1   date,
                         p_date2   date,
                         p_mask    varchar2           default '%',
                         p_isp     varchar2             default '%',
                         p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                         p_inform  smallint           default 1,
                         p_ob22    varchar2   default '%');


    -----------------------------------------------------------------
    --  LIC_VALB_OB()
    --
    --   Выписки по валюте за период c указанием ОБ22.
    --   С возможностью указания маски по счету, исполнителя счета
    --
    --   p_date1   - дата с
    --   p_date2   - дата по
    --   p_mask    - маска       (по умолчанию - все)
    --   p_isp     - исполнитель (по умолчанию - все)
    --   p_branch  -  бранч
    --   p_inform  - информационные сообщения (=1 - вносить, =0 - не вносить)
    --
    procedure lic_valb_ob(
                  p_date1   date,
                  p_date2   date,
                  p_mask    varchar2            default '%',
                  p_kv      number              default 0,
                  p_isp     varchar2            default '%',
                  p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                  p_inform  smallint            default 1,
                  p_ob22    varchar2            default '%');

end bars_rptlic;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_RPTLIC 
is
    -----------------------------------------------------------------
    --                                                             --
    --  Пакет для функций печати разных видов выписок              --
    --
    --  created by: anny                                           --
    --                                                             --
    --                                                             --
    --  Мульти МФО схема                                           --
    --                                                             --
    --  Версия для Сбербанка (поддержка OB22)                      --
    --                                                             --
    --  Версия Oracle выше или 10G                                 --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    VERSION_BODY      constant varchar2(500)  := 'version 10.3E 10.12.2015';
    VERSION_AWK       constant varchar2(500)  := 'awk version: '||

    'Мульти МФО схема'
    ||'. '||
    'Версия для Сбербанка (поддержка OB22)'||'. '||
    'Версия Oracle выше или 10G'
    ;


    G_SEARCH_OPER      constant number(1)    := 0;  -- корреспондент ищется по OPER
    G_SEARCH_OPLDOK    constant number(1)    := 1;  -- корреспондент ищется по OPLDOK
    G_SEARCH_T902      constant number(1)    := 2;  -- корреспондент ищется через operw(REF92) - документ был перекредитован в ф-ции разбора невыясненных
                                                    -- (в БАРС-е перекредитация делается другим документом)

    G_PAYER            constant number(1)    := 0;  -- наш счет плательщик
    G_RECIP            constant number(1)    := 1;  -- наш счет получатель

    G_MODULE          constant char(3)      := 'REP';
    G_TRACE           constant varchar2(50) := 'bars_rptlic.';

    type t_acc     is record( acc     number           ,
                              nls     accounts.nls%type,
							  nlsalt  accounts.nlsalt%type,
                              kv      number           ,
                              tip     accounts.tip%type,
                              fdat    date             ,
                              dos     number           ,
                              kos     number           ,
                              ostf    number           ,
                              dapp    date             ,
                              isp     number           ,
                              nms     accounts.nms%type,
                              nmk     customer.nmk%type,
                              okpo    customer.okpo%type
                             );

    type t_acclist is table of t_acc index by  binary_integer;
    type t_acccur  is ref cursor;



	--  тип для заполнения операций, которіе требуют поиска назначения по OPER
	--  при поиске корреспондента по OPLDOK
	type t_nazntt_list is table of number index by rep_licnazntt.tt%type;

    G_NAZNTT_LIST   t_nazntt_list;



	--
    -- Тип, содержащий признаки наличия операций по транзитным счетам
    -- будет использован для расшифровки по-документоно проводки, которая сделана по-файлово
    -- поля типа - это соответсвующие операции с транзитами.
    -- Если в выписке по счету встречает такую операцию -  признак устанавливаем в 1 в соответствующую операцию
    --

    type t_transit_flg  is record(
                             r00  number(1),
                             rt0  number(1),
                             rt1  number(1),
                             dt0  number(1)
                           );


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_RPTLIC ' || VERSION_HEADER||' '||VERSION_AWK_HDR;
    end header_version;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_RPTLIC ' || VERSION_BODY ||' '||VERSION_AWK;
    end body_version;





    -----------------------------------------------------------------
    --  TYPE_EQV()
    --
    --   Отдать тип строки кот. содержит эквиваленты
    --
    function type_eqv return number
    is
    begin
       null;
    end;


    -----------------------------------------------------------------
    --  GET_NBS
    --
    --   Получить маску балансового по маске счета (счетов)
    --
    function get_nbs(p_nlsmask varchar2) return varchar2
    is
       i number;
    begin
       if instr(p_nlsmask,',') > 0 then
          return '%';
       else
          i := instr(p_nlsmask,'%');
          i := case when i > 4 then 4 else i end;
          return substr(p_nlsmask,1, case when i=0 then 4 else i end);
       end if;

    end;
    -----------------------------------------------------------------
    --  GET_INFORM_DOCS()
    --
    --   Добавить информационные платежи, запросы и ответы на них
    --   (вынесене для читабельности кода)
    --
    --   p_date1   -  дата с
    --   p_date2   -  дата по
    --
    --   Строка с информационными запросами\ответами\сообщениями в поле временной таблицы tmp_licm.DK содержит такие значения
    --       21 - мы посылаем запрос на уточнение реквизитов
    --       23 - мы отдаем ответ по запросу
    --       25 - мы просим вернуть деньги
    --       31 - запросы посланные на нас
    --       33 - ответы отданные по нашему запросу
    --       35 - просьба вернуть деньги с нашего счета
    --
    procedure get_inform_docs(
                  p_date1   date,
                  p_date2   date)
    is
       l_ztype     smallint;
       l_nb        varchar2(38);
       l_daybefore number;
       l_dayafter  number;
    begin


       -- nls = nlsa
       -- d_rec = '#?$A'  - мы посылаем запрос на уточнение реквизитов
       -- d_rec = '#!$A'  - мы отдаем ответ по запросу
       -- d_rec = '#-$A'  - мы отдаем ответ по запросу и просим вернуть деньги
       -- d_rec = '#+$A'  - мы отдаем ответ по запросу и просим зачислить деньги

       for c3  in ( select r.rec,
                           m.acc, m.tip, m.isp, m.nls, m.kv, m.nms, m.okpo, m.nmk,
                           mfoa, nlsa, nam_a, id_a, dat_a, fn_a,
                           mfob, nlsb, nam_b, id_b, dat_b, fn_b,
                           decode(r.dk, 2, -1, 1) * r.s s, r.nd, r.nazn, r.d_rec, r.dk
                      from arc_rrp r, ( select unique acc, tip, isp, nls, kv, nms, okpo, nmk
                                          from tmp_licm
                                         where rowtype =  G_ROWTYPE_ACC )  m
                     where r.dk>1 and r.s>0
                       and r.dat_a between p_date1 and p_date2 + 0.9999
                       and (substr(d_rec,1,2) not in ('#-','#!') or d_rec is null)
                       and m.nls = r.nlsa
                       and m.kv = r.kv
                 )
       loop

          case  substr(c3.d_rec,1,4)
             when '#?$A' then l_ztype := 21; -- мы посылаем запрос на уточнение реквизитов
             when '#!$A' then l_ztype := 23; -- мы отдаем ответ по запросу
             when '#-$A' then l_ztype := 25; -- мы просим вернуть деньги в связи с полученным от другого банка уточнением реквизитов на наш платеж
             when '#+$A' then l_ztype := 27; -- мы просим зачислить деньги в связи с полученным уточнением реквизитов
             else  l_ztype := c3.dk;
          end case;

          begin
             select nb into l_nb from banks where mfo = c3.mfob;
             exception when no_data_found then l_nb:='';
          end;

          -- наш запрос или наш ответ на их запрос уточнения
          -- modified

           insert into tmp_licm(
                  fdat,     tip,      acc,      nls,      kv,
                  nms,      okpo,     nmk,      isp,
                  ref,      nls2,     mfo2,     nb2,      nmk2,      okpo2,
                  s,        nd,       nazn,     tt,       dk,        datp,
                  bis,      rowtype   )
           values(c3.dat_b, c3.tip,   c3.acc,   c3.nls,   c3.kv,
                  c3.nms,   c3.okpo,  c3.nmk,   c3.isp,
                  c3.rec,   c3.nlsb,  c3.mfob,  l_nb,     c3.nam_b,  c3.id_b,
                  c3.s,     c3.nd,    c3.nazn,  'ЗПТ',    l_ztype,   c3.dat_b,
                  0,        G_ROWTYPE_DOC);




          -- если уточнение реквизитов
          -- найти вторую сторону (ответ на наш запрос или первый запрос на наш ответ)
          if l_ztype > 3 then

             if l_ztype = 21 then --мы посылаем запрос на уточнение реквизитов
                l_daybefore := 0;
                l_dayafter  := 5;
             else                 --мы отдаем ответ
                l_daybefore := 5;
                l_dayafter  := 0;
             end if;

             for c5 in (select nlsa, nam_a, mfoa, dat_a, id_a,
                               nlsb, nam_b, mfob, dat_b, id_b,
                               nazn, s, nd, d_rec
                          from arc_rrp
                         where d_rec like '#_'||substr(c3.d_rec,3)
                           and fn_a like '$B'||substr(c3.fn_b,3,4)||'%'
                           and dat_a between c3.dat_b - l_daybefore  and  c3.dat_b  + l_dayafter  -- смотрим ответы в диапазоне пяти дней
                       )
             loop

                insert into tmp_licm(
                  fdat,     tip,      acc,      nls,      kv,
                  nms,      okpo,     nmk,      isp,
                  ref,      nls2,     mfo2,     nb2,      nmk2,        okpo2,
                  s,        nd,       nazn,
                  tt,
                  dk,          datp,
                  bis,      rowtype)
               values(
                  c3.dat_a, c3.tip,   c3.acc,   c3.nls,   c3.kv,
                  c3.nms,   c3.okpo,  c3.nmk,   c3.isp,
                  c3.rec,   c5.nlsa,  c5.mfoa,  l_nb,     c5.nam_a,    c5.id_a,
                  c5.s,     c5.nd,    decode(l_ztype, 21, 'Вiдповiдь на iнф.пов.: ', 'Запит до iнф.пов.: ')||c5.nazn,
                  decode(l_ztype, 21, 'ВДП', 'ЗПТ'),
                  l_ztype + 1, c5.dat_a,
                  0,        G_ROWTYPE_DOC);

             end loop;


          end if;


       end loop;  -- c3






       -- nls = nlsb
       -- d_rec = '#?$A'  - запросы посланные на нас
       -- d_rec = '#!$A'  - ответы отданные по нашему запросу
       -- d_rec = '#-$A'  - ответы отданные по нашему запросу с просьбой вернуть деньги с нашего счета
       -- d_rec = '#+$A'  - ответы отданные по нашему запросу с просьбой зачислить на наш счет


       for c3 in ( select r.rec, m.isp,   m.tip,
                          m.acc, m.nls, m.kv, m.nms, m.okpo, m.nmk,
                          mfoa, nlsa, nam_a, id_a, dat_a, fn_a,
                          mfob, nlsb, nam_b, id_b, dat_b, fn_b,
                          decode(r.dk, 2, -1, 1) * r.s s, r.nd, r.nazn, r.d_rec, r.dk
                     from arc_rrp r, (select unique acc, tip, isp, nls, kv, nms, okpo, nmk
                                          from tmp_licm
                                         where rowtype =  G_ROWTYPE_ACC
                                      ) m
                    where r.dk>1 and r.s>0
                      and r.dat_b between p_date1 and p_date2 + 0.9999
                      and (substr(d_rec,1,2) not in ('#-','#!') or d_rec is null)
                      and m.kv = r.kv
                      and m.nls = r.nlsb
                 )
       loop

           case  substr(c3.d_rec,1,4)
               when '#?$A' then l_ztype := 31; -- запросы посланные на нас
               when '#!$A' then l_ztype := 33; -- ответы отданные по нашему запросу
               when '#-$A' then l_ztype := 35; -- просьба вернуть деньги с нашего счета по ответу на запрос
               when '#+$A' then l_ztype := 37; -- просьба зачислить деньги с наш счета  по ответу на запрос
               else  l_ztype := c3.dk;
           end case;

           begin
              select nb into l_nb from banks where mfo = c3.mfoa;
           exception when no_data_found then l_nb:='';
           end;

            -- нам прислали зaпрос или нам прислали ответ на наш запрос
            insert into tmp_licm(
                  fdat,     tip,     acc,     nls,    kv,
                  nms,      okpo,    nmk,     isp,
                  ref,      nls2,    mfo2,    nb2,    nmk2,     okpo2,
                  s,        nd,      nazn,
                  tt,
                  dk,       datp,
                  bis,      rowtype)
               values(
                  c3.dat_b, c3.tip,  c3.acc,  c3.nls, c3.kv,
                  c3.nms,   c3.okpo, c3.nmk,  c3.isp,
                  c3.rec,   c3.nlsa, c3.mfoa, l_nb,   c3.nam_a, c3.id_a,
                  c3.s,     c3.nd,   c3.nazn,
                  decode(l_ztype, 31, 'ЗПТ', 'ВДП'),
                  l_ztype,  c3.dat_a,
                  0, G_ROWTYPE_DOC);


           -- если уточнение реквизитов
           if l_ztype > 3 then

              if l_ztype = 31 then --мы получили запрос на уточнение реквизитов
                 l_daybefore := 0;
                 l_dayafter  := 5;
              else                 --мы ролучили ответы на наш запрос
                 l_daybefore := 5;
                 l_dayafter  := 0;
              end if;

              -- найти вторую сторону (ответ на наш запрос или первый запрос на наш ответ)
              for c5 in (select nlsa, nam_a, mfoa, dat_a, id_a, fn_a,
                                nlsb, nam_b, mfob, dat_b, id_b, fn_b,
                                nazn, s, nd
                           from arc_rrp
                          where fn_b like '$A'||substr(c3.fn_a,3,4)||'%'
                            and dat_b between to_date(c3.dat_a) - l_daybefore and  to_date(c3.dat_a) + l_dayafter
                            and d_rec like '#_'||substr(c3.d_rec,3)
                            and rec <> c3.rec
                       )
              loop

                    insert into tmp_licm(
                      fdat,     tip,     acc,     nls,     kv,
                      nms,      okpo,    nmk,     isp,
                      ref,      nls2,    mfo2,    nmk2,    okpo2,
                      s,        nd,      nazn,
                      tt,
                      dk,     datp,
                      bis,      rowtype)
                    values(
                      c3.dat_b, c3.tip,  c3.acc,  c3.nls,   c3.kv,
                      c3.nms,   c3.okpo, c3.nmk,  c3.isp,
                      c3.rec,   c5.nlsb, c5.mfob, c5.nam_b, c5.id_b,
                      c5.s,     c5.nd,
                      decode(l_ztype, 31, 'Вiдповiдь на iнф.пов.: ', 'Запит до iнф.пов.: ')||c5.nazn,
                      decode(l_ztype, 31, 'ВДП','ЗПТ'),
                      l_ztype + 1, c5.dat_b,
                      0,        G_ROWTYPE_DOC);

              end loop;  -- c5

           end if; -- l_ztype > 3

       end loop; -- c3

    end;






    -----------------------------------------------------------------
    --  VALIDATE_NLSMASK()
    --
    --   Валидация коррекности введенной маски счтеа
    --
    --   p_mask    -  маска
    --
    --
    procedure validate_nlsmask(p_mask varchar2)
    is
    begin
       bars_report.validate_nlsmask(p_mask => p_mask, p_snum => 4);
    end;


    -----------------------------------------------------------------
    --  VALIDATE_NLSMASKS()
    --
    --   Валидация коррекности введенных масок счтета
    --
    --
    procedure validate_nlsmasks(p_mask1 varchar2, p_mask2 varchar2)
    is
    begin
       bars_report.validate_two_nlsmasks(
                  p_mask1  => p_mask1,
                  p_snum1  => 4,
                  p_mask2  => p_mask2,
                  p_snum2  => 4,
                  p_condition => 'AND');
    end;

    -----------------------------------------------------------------
    --  ROWTYPE_ACC()
    --
    --
    function rowtype_acc return number
    is
    begin
       return G_ROWTYPE_ACC;
    end;

    -----------------------------------------------------------------
    --  ROWTYPE_DOC()
    --
    --
    function rowtype_doc return number
    is
    begin
       return G_ROWTYPE_DOC;
    end;

    -----------------------------------------------------------------
    --  ROWTYPE_REV()
    --
    --
    function rowtype_rev return number
    is
    begin
       return G_ROWTYPE_REV;
    end;


    -----------------------------------------------------------------
    --  CONSTRUCT_NLSMASK_SQL
    --
    --  По скписку масок счетов через запятую отдать строку для конкатенации ее в
    --  запрос для выбора счета
    --
    function construct_nlsmask_sql(p_nlsmask  varchar2) return varchar2
    is
       l_nlsmask varchar2(2000);
       i         number;
    begin

      if  instr(p_nlsmask ,',')>0   then
         i := 1;
         for c in (select column_value nlsmask from  table(getTokens(p_nlsmask)) ) loop
             if i = 1 then
                l_nlsmask := ' a.nls like '''||c.nlsmask||'''  ';
                i := i + 1;
             else
                l_nlsmask := l_nlsmask || ' or a.nls like '''||c.nlsmask||''' ';
             end if;
         end loop;

      else
         l_nlsmask := ' a.nls like '''||p_nlsmask||''' ';
      end if;

      return l_nlsmask;
    end;



    -----------------------------------------------------------------
    --  VALIDATE_MASK_AND_PERIOD()
    --
    --  Валидирование периода выписки и корректности ввода маски.
    --  Если не прошла валидация  - выкидывается соответствующая ошибка
    --
    --   p_date1    -  дата с
    --   p_date2    -  дата по
    --   p_nlsmasks - маска
    --
    procedure validate_mask_and_period(p_date1    date,
                                       p_date2    date,
                                       p_nlsmasks varchar2 )
    is
       l_userid   number;
       l_period   number;
	   l_unlimnls number(1);
    begin

       begin
          select userid into l_userid
            from repvp_nolimitusr
           where userid = user_id;
          l_period   := 534;  -- полтора года( 356 * 1.5)
		  l_unlimnls := 1;    -- не лимитировано 4-е симовол для счета
      exception when no_data_found then
          l_period   := 32;  -- месяц
		  l_unlimnls := 0;
      end;

      -- валидация периода
      bars_report.validate_period(p_date1, p_date2, l_period);


	  -- валидация маски счета
	  if l_unlimnls = 0 then
   	     if instr(p_nlsmasks,',')  > 0 then
            for c in (select column_value nlsmask from  table(getTokens(p_nlsmasks)) ) loop
                bars_report.validate_nlsmask(c.nlsmask,4);
            end loop;
         else
            bars_report.validate_nlsmask(p_nlsmasks,4);
		 end if;
      end if;


    end;



    -----------------------------------------------------------------
    --  REPLACE_TRANSIT_DOCS()
    --
    --
    --  Для всех документов суть которых - проводки по-файлово - расскрыть
    --  по-документо по имени файла
    --
    --
    procedure replace_transit_docs(p_trs     t_transit_flg,
                                   p_mltval  number,
                                   p_valeqv  number,
                                   p_inform  number default 0)
    is
       l_s    number;
       l_sq   number;
       l_fn   varchar2(160);
       l_fdat date;
    begin

       if p_trs.r00 = 0 and
          p_trs.rt0 = 0 and
          p_trs.rt1 = 0 and
          p_trs.dt0 = 0 then
          return;
       end if;

       --
       -- Платежи идут от наших подчиненных МФО трензитом через нас
       -- на ГРЦ или на другое наше МФО или на межбанк,
       -- R00 - операция списания с коррсчета подчиненного МФО и зачисления на наш транзит
       -- Дб\L00 -> Kр\T00
       --
       -- mfoa - наше подчиненное, fn_a - имя файла от нашего подчиненного
       -- fn_b - это файл в котором мы отправили это платеж дальше
       --
       if p_trs.r00 = 1 then  -- 'R00'
          for c in (select * from tmp_licm  where tt = 'R00') loop

             select txt, fdat  into l_fn, l_fdat
               from opldok
              where ref = c.ref
                and dk = 0 and tt = 'R00'  and rownum = 1;

             delete from tmp_licm where ref = c.ref;

             for k in (select bis, ref,
                              -- в любом случае - это дебет счета (информационный или платежный)
                              case when dk > 1 then 2 else 0 end dk,
                              decode(bis, 0, rec, max(rec) over (partition by nd, bis-rec_b)) rec,
                              kv, mfob, nlsb, nam_b, id_b,
                               (case when (bis = 0 or bis = 1) then l_fn||': '
                                     else '' end)||nazn nazn,
                              nd, nb, datd, dat_a,
                              decode(bis, 0, s, max(s) over (partition by nd, bis-rec_b)) s
                         from arc_rrp a, banks b
                        where fn_a = l_fn
                          and dat_a between  l_fdat  and l_fdat   + 0.999
                          and a.mfob = b.mfo
                        )  loop

                 if k.kv <> gl.baseval and (p_mltval = 1 or p_mltval = 2) and p_valeqv = 1 then
                    l_sq    := gl.p_icurval( k.kv, k.s,    k.dat_a);
                 else
                    l_sq    := k.s;
                 end if;

                 insert into tmp_licm(
                         fdat,    tip,     acc,    nls,      kv,        nms,
                         okpo,    nmk,     isp,    dapp,
                         ostf,    ostfq,   dosr,   kosr,
                         ref,     nls2,    mfo2,   nb2,      nmk2,      okpo2,
                         s,       sq,      nd,     nazn,     tt,        sk,       vob,
                         bis,     dk,      datd,   datp,     vdat,      userid,   branch,
                         rowtype)
                 values(
                         c.fdat, c.tip,     c.acc,  c.nls,  c.kv,  c.nms,
                         c.okpo, c.nmk,     c.isp,  c.dapp,
                         c.ostf,  c.ostfq,  c.dosr,  c.kosr,
                         k.rec,   k.nlsb,   k.mfob,  k.nb,    k.nam_b,   k.id_b,
                         -1*k.s,   -1*l_sq, k.nd,    k.nazn,  c.tt,      null,     null,
                         k.bis,   k.dk,     k.datd,  k.dat_a, k.dat_a,  null,     l_fn,
                         G_ROWTYPE_DOC);
             end loop;

          end loop;
       end if;



       --
       -- Платежи идут от НБУ, от нас, от других наших МФО на наши подчиненные МФО.
       -- Данная опреация для кредитовой суммы файла. Операция выполняется по квитовке файла $B,
       -- который идет на подчиненные МФО
       -- Дб\TUR -> Кр\L00
       --
       if p_trs.rt0 = 1 then  --p_tt = 'RT0'
          for c in (select * from tmp_licm  where tt in ('RT0') ) loop

              select txt, fdat into l_fn, l_fdat
                from opldok
               where ref = c.ref
                 and dk = 1 and tt in ('RT0') and rownum = 1;

              delete from tmp_licm where ref = c.ref ;

              for k in (select decode(bis, 0, rec, max(rec) over (partition by nd, bis-rec_b)) rec,
                               bis, ref,
                               -- в любом случае - это кредит счета (информационный или платежный)
                               dk,
                               kv, mfoa, nlsa, nam_a, id_a,
                               (case when (bis = 0 or bis = 1) then l_fn||': '
                                    else '' end)||nazn nazn,
                               nd, nb, datd, dat_b,
                               decode(bis, 0, s, max(s) over (partition by nd, bis-rec_b)) s
                          from arc_rrp a, banks b
                         where fn_b = l_fn  and dat_b between l_fdat and l_fdat  + 0.999
                           and a.mfoa = b.mfo
                       )  loop


                  if k.kv <> gl.baseval and (p_mltval = 1 or p_mltval = 2) and p_valeqv = 1 then
                     l_sq    := gl.p_icurval( k.kv, k.s,    k.dat_b);
                  else
                     l_sq    := k.s;
                  end if;

                  insert into tmp_licm(
                         fdat,    tip,     acc,    nls,      kv,        nms,
                         okpo,    nmk,     isp,    dapp,
                         ostf,    ostfq,   dosr,   kosr,
                         ref,     nls2,    mfo2,   nb2,      nmk2,      okpo2,
                         s,       sq,      nd,     nazn,     tt,        sk,       vob,
                         bis,     dk,      datd,   datp,     vdat,      userid,   branch,
                         rowtype)
                  values(
                         c.fdat, c.tip,  c.acc,  c.nls,  c.kv,  c.nms,
                         c.okpo, c.nmk,  c.isp,  c.dapp,
                         c.ostf,  c.ostfq, c.dosr,  c.kosr,
                         k.rec,   k.nlsa,  k.mfoa,  k.nb,    k.nam_a,   k.id_a,
                         decode(k.dk, 0, -1, 1)*k.s,     decode(k.dk, 0, -1, 1)*l_sq,
                         k.nd,    k.nazn,  c.tt,      null,     null,
                         k.bis,       k.dk,       k.datd,  k.dat_b, k.dat_b,  null,     l_fn,
                         G_ROWTYPE_DOC);
              end loop;
           end loop;
        end if;


       --
       -- Платежи идут от НБУ на наши подчиненные МФО и на наше МФО
       -- Данная операция отражает поступление на наш коррсчет (N00)
       -- поскольку он активен, то dk=0
       --
       --

       if p_trs.rt1 = 1  then  -- p_tt = 'RT1'
          for c in (select * from tmp_licm  where tt in ('RT1') ) loop

              select txt, fdat into l_fn, l_fdat
                from opldok
               where ref = c.ref
                 and dk = 0 and tt in ('RT1') and rownum = 1;

              delete from tmp_licm where ref = c.ref;

              for k in (select decode(bis, 0, rec, max(rec) over (partition by nd, bis-rec_b)) rec,
                               bis, ref,
                               -- в любом случае - это дебет счета (информационный или платежный)
                               case when dk > 1 then 2 else 0 end dk,
                               kv, mfoa, nlsa, nam_a, id_a,
                               (case when (bis = 0 or bis = 1) then l_fn||': '
                                    else '' end)||nazn nazn,
                               nd, nb, datd, dat_b,
                               decode(bis, 0, s, max(s) over (partition by nd, bis-rec_b)) s
                          from arc_rrp a, banks b
                         where fn_a = l_fn  and dat_a between l_fdat and l_fdat  + 0.999
                           and a.mfoa = b.mfo
                       )  loop


                  if k.kv <> gl.baseval and (p_mltval = 1 or p_mltval = 2) and p_valeqv = 1 then
                     l_sq    := gl.p_icurval( k.kv, k.s,    k.dat_b);
                  else
                     l_sq    := k.s;
                  end if;

                  insert into tmp_licm(
                         fdat,    tip,     acc,    nls,      kv,        nms,
                         okpo,    nmk,     isp,    dapp,
                         ostf,    ostfq,   dosr,   kosr,
                         ref,     nls2,    mfo2,   nb2,      nmk2,      okpo2,
                         s,       sq,      nd,     nazn,     tt,        sk,       vob,
                         bis,     dk,      datd,   datp,     vdat,      userid,   branch,
                         rowtype)
                  values(
                         c.fdat, c.tip,  c.acc,  c.nls,  c.kv,  c.nms,
                         c.okpo, c.nmk,  c.isp,  c.dapp,
                         c.ostf,  c.ostfq, c.dosr,  c.kosr,
                         k.rec,   k.nlsa,  k.mfoa,  k.nb,    k.nam_a,   k.id_a,
                         -1*k.s,   -1*l_sq,
                         k.nd,    k.nazn,  c.tt,      null,     null,
                         k.bis,       k.dk,       k.datd,  k.dat_b, k.dat_b,  null,     l_fn,
                         G_ROWTYPE_DOC);
              end loop;
           end loop;
        end if;


       --
       -- Платежи идут от НБУ, от нас, от других наших МФО на наши подчиненные МФО.
       -- Данная опреация для дебетовой суммы файла. Операция выполняется по квитовке файла $B,
       -- который идет на подчиненные МФО
       -- Дб\L00 -> Кр\TUD
       --
        if p_trs.dt0 = 1  then  --p_tt = 'DT0'

           for c in (select * from tmp_licm  where tt in ('DT0') ) loop

               select txt, fdat into l_fn, l_fdat
                 from opldok
                where ref = c.ref
                  and dk = 0 and tt in ('DT0') and rownum = 1;

               delete from tmp_licm where ref = c.ref;

               for k in (select decode(bis, 0, rec, max(rec) over (partition by nd, bis-rec_b)) rec,
                                bis, ref,
                                case when dk > 1 then 2 else 0 end dk,
                                kv, mfoa, nlsa, nam_a, id_a,
                               (case when (bis = 0 or bis = 1) then l_fn||': '
                                     else '' end)||nazn nazn,
                                nd, nb, datd, dat_b,
                                decode(bis, 0, s, max(s) over (partition by nd, bis-rec_b)) s
                          from arc_rrp a, banks b
                           where fn_b = l_fn  and dat_b between l_fdat and l_fdat  + 0.999
                             and a.mfoa = b.mfo and dk in (0,1)
                    )  loop



                    if k.kv <> gl.baseval and (p_mltval = 1 or p_mltval = 2) and p_valeqv = 1 then
                       l_sq    := gl.p_icurval( k.kv, k.s,    k.dat_b);
                    else
                       l_sq    := k.s;
                    end if;

                    insert into tmp_licm(
                         fdat,    tip,     acc,    nls,      kv,        nms,
                         okpo,    nmk,     isp,    dapp,
                         ostf,    ostfq,   dosr,   kosr,
                         ref,     nls2,    mfo2,   nb2,      nmk2,      okpo2,
                         s,       sq,      nd,     nazn,     tt,        sk,       vob,
                         bis,     dk,      datd,   datp,     vdat,      userid,   branch,
                         rowtype)
                    values(
                         c.fdat, c.tip,  c.acc,  c.nls,  c.kv,  c.nms,
                         c.okpo, c.nmk,  c.isp,  c.dapp,
                         c.ostf,  c.ostfq, c.dosr,  c.kosr,
                         k.rec,   k.nlsa,  k.mfoa,  k.nb,    k.nam_a,   k.id_a,
                         decode(k.dk, 0, -1, 1)*k.s,     decode(k.dk, 0, -1, 1)*l_sq,
                         k.nd,    k.nazn,  c.tt,      null,     null,
                         k.bis,       k.dk,       k.datd,  k.dat_b, k.dat_b,  null,     l_fn,
                         G_ROWTYPE_DOC);
               end loop;
           end loop;
        end if;


    end;



    -----------------------------------------------------------------
    --  GET_DOCS()
    --
    --   по укзанному acc  и дате получает документы из opldok + oper И помещает их
    --   во временную таблицу tmp_licm
    --
    --   p_fdat - дата движения по счету
    --   p_acc  - поля из accounts
    --   p_mltval - мультивалютные
    --   p_valeqv - с переоценкой
    --   p_refacc - асс дочернего  счета
    --   p_refnls - дочерний счет
    --   p_trs  - структура, которая содержит информацию о том, есть ли в
    --            выписке по данному счету документы, которые 'по-файлово', тоесть проводки по транзиту
    --
    procedure get_docs(
                  p_fdat        date  ,
                  p_acc         t_acc ,
                  p_mltval      number,
                  p_valeqv      number,
                  p_refacc      number,
                  p_refnls      varchar2,
                  p_trs  in out t_transit_flg  )

    is
       l_trace    varchar2(1000) := G_TRACE||'get_docs:';
       l_nls2     varchar2(14);
       l_nbs      varchar2(6);
       l_okpo     varchar2(16);
       l_nam      varchar2(80);
       l_count    number := 0;
       l_srchtype number;
       l_whoami   smallint;    -- кто я =0 плательщик, =1-получалеь
       l_ref902   number;
       l_mfo      varchar2(12);
       l_nb       varchar2(38);
       l_nazn     varchar2(160);
       l_tt       varchar2(10);
       l_sq       number;
       l_ostfq    number;
       l_ostfr    number;
       l_dosr     number;
       l_kosr     number;

       l_acc      number;
       l_nls      varchar2(14);
       l_value    varchar2(220);
    begin

       bars_audit.trace(l_trace||' находим документы по счету: acc='||p_acc.acc||' '||p_acc.nls||'('||p_acc.kv||') за '||to_char(p_fdat, 'dd\mm\yyyy'));

       -- по какому счету искать - дочернему или главному
       l_acc := case when p_refacc is null then p_acc.acc else p_refacc end;
       l_nls := case when p_refacc is null then p_acc.nls else p_refnls end;

       ----------------
       -- По проводкам
       ----------------


         for c1 in ( select o1.stmt, o1.ref ,o1.tt ,
                          o1.s *decode(o1.dk,0,-1,1) s,
                          --o1.sq*decode(o1.dk,0,-1,1) sq,
                          -- Тут ми пошаманили
                          --case when o1.sq is not null then o1.sq else gl.p_icurval( p_acc.kv, o1.s, fdat) end *decode(o1.dk,0,-1,1) sq,
						  gl.p_icurval( p_acc.kv, o1.s, fdat)*decode(o1.dk,0,-1,1) sq,
                          dk, txt, o1.kf
                     from opldok o1
                    where o1.acc = l_acc and o1.fdat = p_fdat and o1.sos=5 )
       loop

           bars_audit.trace(l_trace||'ref = '||c1.ref);
           l_nls2 := null;
           l_nbs  := null;
           l_okpo := null;
           l_nam  := null;
           ----------------
           -- по документам
           ----------------
           for c2 in ( select o.vdat,o.vob, o.nd, o.mfoa, o.nlsa, o.nam_a, o.id_a,
                              o.mfob, o.nlsb,        o.nam_b, o.id_b, o.kv, o.kv2,
                              decode(c1.tt,'RT1', c1.txt,o.nazn) nazn,
                                o.branch branch,
                                o.datd, o.userid, o.sk, o.d_rec, o.tt, datp, o.bis as existbis
                         from   oper o, tts t
                         where o.ref = c1.ref and c1.tt = t.tt)
             loop
                bars_audit.trace(l_trace||'nd='||c2.nd);

                l_count := l_count  + 1;

                ----------------------------------------------------
                --  установим по какой таблице смотреть коррекпондента
                ----------------------------------------------------

                if ( (c1.tt  <> c2.tt  and c1.tt <> 'R01')           or      -- операция дочерняя и не равна главной
                     (p_acc.nls <> c2.nlsb and p_acc.nls <> c2.nlsa) or      -- главный(недоерний) счет не фигурирует в главной операции
                     (c2.kv2 <> c2.kv )                              or      -- разновалютная
                     (c2.nlsb is null )                              or      -- зарахування
                     (c2.tt like 'RT%' or c2.tt like 'DT1' )
--                     (c2.tt like 'PS1')                                      -- перекрытие внутренее
                   ) then
                   l_srchtype := G_SEARCH_OPLDOK;
                else
                   if c2.tt = '901' then
                      l_srchtype := G_SEARCH_T902;             -- перекредитация на другой счет со счета невыясненных
                      begin
                         -- найти первичний реф.
                         select value into l_ref902
                           from operw
                          where ref = c1.ref and tag = 'REF92';
                      exception when no_data_found then
                         l_srchtype := G_SEARCH_OPER;
                      end;
                   else
                       l_srchtype := G_SEARCH_OPER;
                   end if;
                end if;


                case c1.tt when 'R00' then p_trs.r00 := 1;
                           when 'RT0' then p_trs.rt0 := 1;
                           when 'DT0' then p_trs.dt0 := 1;
                           when 'RT1' then p_trs.rt1 := 1;
                           else null;
                end case;

                ----------------------------------------------------
                --  Вичитаем параметры корреспондента
                ----------------------------------------------------

                 case l_srchtype
                     --корреспондента смотрим по OPLDOK
                     when G_SEARCH_OPLDOK then

						 -- а также явно указанные опреации для поиска только в OPER
                         if (c2.kv2 = c2.kv and c2.tt not like 'PS%' and not G_NAZNTT_LIST.exists(c1.tt)   ) then
                             l_nazn:= c1.txt;
                         else
                             l_nazn:= c2.nazn;
                         end if;

                         select nls, nbs,  c.okpo, c.nmk into l_nls2, l_nbs,  l_okpo, l_nam
                         from  opldok o2, accounts a1, customer c
                         where o2.acc = a1.acc and c1.stmt=o2.stmt and c1.ref=o2.ref and c1.dk<>o2.dk and c.rnk = a1.rnk;

                         l_mfo := f_ourmfo;

                         if c1.dk = 0 then
                            l_whoami := G_PAYER;
                         else
                            l_whoami := G_RECIP;
                         end if;


                     --корреспондента смотрим по OPER
                     when G_SEARCH_OPER then
                          l_nazn:= c2.nazn;
                          -- мы плательщики
                         if p_acc.nls = c2.nlsa THEN
                             l_whoami := G_PAYER;
                             l_nls2   := c2.nlsb;
                             l_okpo   := c2.id_b;
                             l_nam    := c2.nam_b;
                             l_mfo    := c2.mfob;
                         else
                            -- мы получатели
                             if (p_acc.nls = c2.nlsb) then
                                l_whoami := G_RECIP;
                                l_nls2   := c2.nlsa;
                                l_okpo   := c2.id_a;
                                l_nam    := c2.nam_a;
                                l_mfo    := c2.mfoa;
                             -- счет не фигурирует в платеже
                             else
                                if c1.dk = 0 then
                                   l_whoami := G_PAYER;
                                   l_nls2   := c2.nlsb;
                                   l_okpo   := c2.id_b;
                                   l_nam    := c2.nam_b;
                                else
                                   l_whoami := G_RECIP;
                                   l_nls2   := c2.nlsa;
                                   l_okpo   := c2.id_a;
                                   l_nam    := c2.nam_a;
                                end if;
                                l_mfo := gl.amfo;
                             end if;
                          end if;
                      --корреспондента смотрим по первичному платежу из параметра REF92 в operw

                     when G_SEARCH_T902 then
                          l_nazn   := c2.nazn;
                          l_whoami := G_RECIP;
                          -- найдем реквизиты плательщика первичного документа
                          begin
                             select nlsa,   id_a,   nam_a,   mfoa
                               into l_nls2, l_okpo, l_nam,  l_mfo
                               from oper
                              where ref = l_ref902;
                          exception when no_data_found then
                              bars_error.raise_nerror(G_MODULE, 'NO_ORIGIN_DOC', to_char(c1.ref), to_char(l_ref902) );
                          end;

                     else
                        bars_error.raise_error(G_MODULE, 29, to_char(l_srchtype));
                 end case;


                 --наименование банка контрагена
                 begin
                    select nb into l_nb from banks where mfo = l_mfo;
                 exception when no_data_found then l_nb:='';
                 end;



                 /*
                 if p_acc.kv <> gl.baseval and p_mltval = 1 and p_valeqv = 1 then
                    l_sq    := gl.p_icurval( p_acc.kv, c1.s,    p_fdat);
                 else
                    l_sq    := c1.s;
                 end if;
                 */

                 l_sq := c1.sq;
                 -- COBUSUPABS-4978
                 begin
                    select t.value into l_value from operw t where t.ref = c1.ref
                                                               and t.kf  = c1.kf
                                                               and t.tag = 'OWTRI';
                 exception when no_data_found then l_value := '';
                 end;

                 if l_value is not null then
                     l_nazn := l_value;
                     l_value := null;
                 end if;
                 --
                 if p_refacc is not null then
                    l_nazn := l_nazn;
                 end if;
                 ----------------------------------------------------
                 --  Встаквка во временную таблицу
                 ----------------------------------------------------

                 -- мы плательщик
                 if ( l_whoami = G_PAYER )  then

                     insert into tmp_licm(
                         fdat,    tip,     acc,    nls,      kv,        nms,
                         okpo,    nmk,     isp,    dapp,
                         ostf,    ostfq,   dosr,   kosr,     ostfr,
                         ref,     nls2,    mfo2,   nb2,      nmk2,      okpo2,
                         s,       sq,      nd,     nazn,     tt,        sk,       vob,
                         bis,     dk,      datd,   datp,     vdat,      userid,   d_rec,  refnls,
                         branch,
                         rowtype)
                     values(
                         p_fdat, p_acc.tip,  p_acc.acc,    p_acc.nls,  p_acc.kv,     p_acc.nms,
                         p_acc.okpo, p_acc.nmk,  p_acc.isp,    p_acc.dapp,
                         p_acc.ostf, l_ostfq, l_dosr,  l_kosr, l_ostfr,
                         c1.ref,  l_nls2,  l_mfo,   l_nb,    l_nam,     l_okpo,
                         c1.s,    l_sq,    nvl(c2.nd, substr(c1.ref,1,10)),   l_nazn,  c1.tt,     c2.sk,     c2.vob,
                         0,       c1.dk,   c2.datd, c2.datp, c2.vdat,   c2.userid,   c2.d_rec,  p_refnls,
                         c2.branch,
                         G_ROWTYPE_DOC);




                    if c2.existbis is not null and  c2.existbis = 1 then
                        -- бисы внутренние (бисы долны начинаться с 2-ки)
                        for c5 in ( select substr(trim(tag), 2)+1  bis,  value from operw
                                    where ref = c1.ref
                                      and regexp_like(trim(tag) ,'^(C)[0-9]{1,2}$')
                                  )
                        loop

                            insert into tmp_licm(
                               fdat,    acc,    nls,    kv,       nms,
                               okpo,    nmk,    isp,    dapp,
                               ref,     nls2,   mfo2,   nb2,       nmk2,    okpo2,
                               s,       sq,     nd,     nazn,      tt,      sk,     vob,
                               bis,     dk,     datd,   datp,      vdat,    userid, d_rec,  refnls,
                               branch,
                               rowtype)
                           values(
                               p_acc.fdat, p_acc.acc,  p_acc.nls,  p_acc.kv,    p_acc.nms,
                               p_acc.okpo, p_acc.nmk,  p_acc.isp,  p_acc.dapp,
                               c1.ref,  l_nls2,  l_mfo,   l_nb,     l_nam,   l_okpo,
                               c1.s,    l_sq,    nvl(c2.nd,substr(c1.ref,1,10)),   c5.value, c1.tt,   c2.sk,  c2.vob,
                               c5.bis,  c1.dk,   c2.datd, c2.datp,  c2.vdat, c2.userid,   c2.d_rec, p_refnls,
                               c2.branch,
                               G_ROWTYPE_DOC);

                        end loop;

                    end if;


                 -- мы получатель
                 else

                      insert into tmp_licm(
                         fdat,    tip,     acc,    nls,      kv,      nms,
                         okpo,    nmk,     isp,    dapp,
                         ostf,    ostfq,   dosr,   kosr,     ostfr,
                         ref,     nls2,    mfo2,   nb2,      nmk2,    okpo2,
                         s,       sq,      nd,     nazn,     tt,      sk,     vob,
                         bis,     dk,      datd,   datp,    vdat,     userid, d_rec,  refnls,
                         branch,
                         rowtype)
                     values(
                         p_acc.fdat, p_acc.tip,  p_acc.acc,    p_acc.nls,  p_acc.kv,   p_acc.nms,
                         p_acc.okpo, p_acc.nmk,  p_acc.isp,    p_acc.dapp,
                         p_acc.ostf, l_ostfq,    l_dosr,       l_kosr,     l_ostfr,
                         c1.ref,  l_nls2,  l_mfo,   l_nb,    l_nam,   l_okpo,
                         c1.s,    l_sq,    nvl(c2.nd, substr(c1.ref,1,10)),   l_nazn,  c1.tt,   c2.sk,  c2.vob,
                         0,       c1.dk,   c2.datd, c2.datp, c2.vdat, c2.userid,   c2.d_rec,  p_refnls,
                         c2.branch,
                         G_ROWTYPE_DOC);


                        -- бисы внутренние и внешение на нас
                        -- П - продолжение назначения. Для внешних документов на нас, в arc_rrp могут быть и такие
                        for c7 in ( select substr(trim(tag), 2)+1 bis,  value
                                      from operw
                                     where ref = c1.ref
                                         and regexp_like(trim(tag) ,'^(C)[0-9]{1,2}$')
                                   )
                        loop

                             insert into tmp_licm(
                                fdat,    acc,    nls,    kv,       nms,
                                okpo,    nmk,    isp,    dapp,
                                ref,     nls2,   mfo2,   nb2,       nmk2,    okpo2,
                                s,       sq,     nd,     nazn,      tt,      sk,     vob,
                                bis,     dk,     datd,   datp,      vdat,    userid, d_rec,  refnls,
                                branch,
                                rowtype)
                             values(
                                p_acc.fdat, p_acc.acc,  p_acc.nls,  p_acc.kv,    p_acc.nms,
                                p_acc.okpo, p_acc.nmk,  p_acc.isp,  p_acc.dapp,
                                c1.ref,  l_nls2,  l_mfo,   l_nb,     l_nam,   l_okpo,
                                c1.s,    l_sq,    nvl(c2.nd, substr(c1.ref,1,10)),   c7.value, c1.tt,   c2.sk,  c2.vob,
                                c7.bis,  c1.dk,   c2.datd, c2.datp,  c2.vdat, c2.userid,   c2.d_rec, p_refnls,
                                c2.branch,
                                G_ROWTYPE_DOC);
                        end loop;

                 end if;



               end loop; -- c2(oper)

            end loop;  -- c2(opldok)


    end;


    -----------------------------------------------------------------
    --  LIC_GLOBAL()
    --
    --
    --
    --   1) Процедура принмает на вход открытый курсор, который должен возвращвть данные структуры  t_acc
    --
    --   2) Процедура формирует данные во временную таблицу tmp_licm
    --      В данной таблице будут находиться строки с такими признаками  (поле rowtype)
    --       G_ROWTYPE_ACC      constant number    := 10;  -- строка, содержащая входящий остаток и входящий остаток в эквиваленте
    --       G_ROWTYPE_DOC      constant number    := 20;  -- строка, содержащая документ
    --       G_ROWTYPE_REV      constant number    := 50;  -- строка, содержащая переоценку
    --
    --   3) Каждая строка обязательно содержит все реквизиты для счета и его контрагента:
    --      fdat - дата движения (для переоценки - єто минимальная дата в указанній период)
    --      (tip, acc, nls, kv, nms) - (тип счета, acc, лицевой, валюта, наименование счета)
    --      (okpo,    nmk)           - (ОКПО контрагента, наименование контрагента)
    --      (isp,     dapp)          - (исполнитель, дата предидущего движения)
    --
    --
    --   p_date1   -  дата с
    --   p_date2   -  дата по
    --   p_c0      -- открытый курсор с данными типа  t_acc
    --   p_inform  -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_mltval  -  0-гривна, 1-валютная, 2- грн+вылютная
    --   p_valeqv  -  с эквивалентами
    --   p_valrev  -  с переоценкой (revaluation)
    --
    procedure lic_global(
                  p_date1   date     ,
                  p_date2   date     ,
                  p_c0      t_acccur ,
                  p_inform  smallint            default 1,
                  p_mltval  smallint            default 0,
                  p_valeqv  smallint            default 0,
                  p_valrev  smallint            default 0)
   is

      l_ostfq    number;
      l_ostfr    number;
      l_dosr     number;
      l_kosr     number;
      l_curs     number;
      l_prevbd   date;
	  l_prevbd_  date;
	  l_peroc    number;
      l_acc      t_acc;
      l_trs      t_transit_flg;
      l_trace    varchar2(1000) := G_TRACE||'lic_global:';
   begin

      bars_audit.trace(l_trace||'Выписка за даты с:'||to_char(p_date1,'dd\mm\yyyy')||' по '||to_char(p_date2,'dd\mm\yyyy'));
      bars_audit.trace(l_trace||'Включать информационные(1-да\0-нет):'||p_inform);
      execute immediate 'delete from tmp_licm';

      select max(fdat) into l_prevbd
      from fdat where fdat < p_date1;


      loop
         bars_audit.trace(l_trace||'перед выполнением курсора');

         fetch p_c0 into l_acc;
         exit when p_c0%notfound;

         l_trs.r00 := 0;
         l_trs.rt0 := 0;
         l_trs.dt0 := 0;
         l_trs.rt1 := 0;

         l_ostfq := 0;
         bars_audit.trace(l_trace||'fdat = '||to_char(l_acc.fdat,'dd\mm\yyyy')||' acc = '||l_acc.acc|| ' nls = '||l_acc.nls||'('||l_acc.kv||')');


		  select max(fdat) into l_prevbd
            from fdat where fdat < l_acc.fdat;

         -- подсчитаем эквивалент на предыдущую банк датудату движения
         if  l_acc.kv <> gl.baseval  and p_valeqv = 1 then
             l_ostfq := gl.p_icurval( l_acc.kv, l_acc.ostf, l_prevbd);
         else
             l_ostfq := l_acc.ostf;
         end if;


          -- строка с информацией о счете со входящими остатками
          bars_audit.trace(l_trace||'производим вставку в tmp_licm счета' );
          insert into tmp_licm(
                   fdat,    tip,     acc,     nls,     kv,     nms,
                   okpo,    nmk,     isp,     dapp,    nlsalt,
                   ostf,    ostfq,
                   rowtype)
          values( l_acc.fdat, l_acc.tip,  l_acc.acc,  l_acc.nls,  l_acc.kv,  l_acc.nms,
                  l_acc.okpo, l_acc.nmk,  l_acc.isp,  l_acc.dapp, l_acc.nlsalt,
                  l_acc.ostf, l_ostfq,
                  G_ROWTYPE_ACC);


          -- требуется информация по переоценке
		  --OSTFQ        Входящий остаток(эквив) на дату движения
          --OSTFR        Входящий остаток(с переоценкой) на дату движения
          if  p_valeqv = 1  then

              bars_audit.trace(l_trace||' требуется переоценка - найдем обороты в еквиваленте с переоценкой из saldob');
              begin
                 select dos, kos, ostf
                   into l_dosr, l_kosr, l_ostfr
                   from saldob
                  where acc = l_acc.acc and fdat = l_acc.fdat;
                 bars_audit.trace(l_trace||'l_dosr='||l_dosr||', l_kosr'||l_kosr||', l_ostfr='||l_ostfr);
              exception when no_data_found then
			      select max(fdat) into l_prevbd_
                    from fdat where fdat < l_acc.fdat;
					     if  l_acc.kv <> gl.baseval  and p_valeqv = 1 then
							 l_ostfq := gl.p_icurval( l_acc.kv, l_acc.ostf, l_prevbd_);
						 else
							 l_ostfq := l_acc.ostf;
						 end if;
                 l_ostfr := gl.p_icurval( l_acc.kv, l_acc.ostf, l_acc.fdat);
                 l_kosr  := gl.p_icurval( l_acc.kv, l_acc.kos,  l_acc.fdat);
                 l_dosr  := gl.p_icurval( l_acc.kv, l_acc.dos,  l_acc.fdat);
				-- немножко переоценки...
	 			 l_peroc := gl.p_icurval( l_acc.kv, l_acc.ostf-l_acc.dos+l_acc.kos,  l_acc.fdat) -l_kosr+l_dosr-l_ostfq;
				 l_kosr  := l_kosr + greatest(l_peroc,0);
				 l_dosr  := l_dosr - least(l_peroc,0);

              end;

              insert into tmp_licm(
                      fdat,      tip,     acc,    nls,      kv,        nms,
                      okpo,      nmk,     isp,
                      ostfr,     dosr,    kosr, nlsalt,
                      rowtype)
              values( l_acc.fdat, l_acc.tip,  l_acc.acc,  l_acc.nls,  l_acc.kv,     l_acc.nms,
                      l_acc.okpo, l_acc.nmk,  l_acc.isp,
                      l_ostfr, l_dosr,  l_kosr, l_acc.nlsalt,
                      G_ROWTYPE_REV);
          end if;


          get_docs( p_fdat   => l_acc.fdat,
                    p_acc    => l_acc,
                    p_mltval => p_mltval,
                    p_valeqv => p_valeqv,
                    p_refacc => null,
                    p_refnls => null,
                    p_trs    => l_trs );


      end loop; -- c1(accounts)



      -- заменить документы, которые есть 'проводка по-файлу', на 'по-документно'
      replace_transit_docs(l_trs, p_mltval, p_valeqv);


      -- Информационные
      if (p_inform=1) then
         get_inform_docs(
                  p_date1  =>  p_date1 ,
                  p_date2  =>  p_date2 );
      end if;



     --Выписка может быть по счету, который есть скрепкой, то-есть реальные документы прошли не по нему,
     --а по дочерним счетам, у которых в поле
     --accounts.accc стоит счет, по которому мы делам выписку...
      bars_audit.trace(l_trace||'поиск документов по дочерним счетам');
      for c2 in ( select a.acc, a.nls, a.kv
                    from accounts a
                   where accc =  l_acc.acc ) loop
          bars_audit.trace(l_trace||' есть дочерний счет: acc='||c2.acc||' '||c2.nls||'('||c2.kv||')');
          for c3 in (select fdat
                       from saldoa
                      where acc = c2.acc and fdat between p_date1 and p_date2 ) loop

                 l_acc.fdat    := c3.fdat;
                 get_docs( p_fdat   => l_acc.fdat,
                           p_acc    => l_acc,
                           p_mltval => p_mltval,
                           p_valeqv => p_valeqv,
                           p_refacc => c2.acc,
                           p_refnls => c2.nls,
                           p_trs    => l_trs );
          end loop;
      end loop;






   exception when others then
      bars_audit.trace(l_trace||' ошибка '||sqlerrm);
      raise;

   end;



    -----------------------------------------------------------------
    --  LIC_ACCLIST
    --
    --   Формирование выписок по стандартному выбору счетов.
    --   Формирование курсора для глобалной процедуры
    --
    --   p_date1    -  дата с

    --   p_date2    -  дата по
    --   p_mask     -  маска             (по умолчанию - все)
    --   p_kv       -  валюта            (по умолчанию - все)
    --   p_isp      -  исполнитель       (по умолчанию - все)
    --   p_branch   -  бранч
    --   p_inform   -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_mltval   -  вылютная
    --   p_valeqv   -  с эквивалентами
    --   p_valrev   -  с переоценкой (revaluation)
    --   p_add_cond -  дополнительное условие на запрос для выбора счета
	--              -    (условие пишется в виде and s.acc in (select acc from accounts where ob22 = 'xxx')
	--              -     используя алиасы :
	--              -     s    - saldoa,
	--              -     cus  - customer )
    --
	procedure lic_acclist(
                  p_date1    date,
                  p_date2    date,
                  p_mask     varchar2            default '%',
                  p_kv       number              default 0,
                  p_isp      varchar2            default '%',
                  p_branch   branch.branch%type  default sys_context('bars_context','user_branch'),
                  p_inform   smallint            default 1,
                  p_mltval   smallint            default 0,
                  p_valeqv   smallint            default 0,
                  p_valrev   smallint            default 0,
				  p_add_cond varchar2            default null )
   is
      l_c0       t_acccur;
      l_sql      varchar2(4000);
	  l_nbsmask  varchar2(4);
      l_trace    varchar2(1000) := G_TRACE||'lic_global:';
   begin



      validate_mask_and_period(p_date1    =>  p_date1,
                               p_date2    =>  p_date1,
                               p_nlsmasks =>  p_mask );

      l_nbsmask  := get_nbs(p_mask);

	  --сформировать строку запроса для выбора счетов
      l_sql := 'select a.acc,  a.nls, a.nlsalt, a.kv, a.tip, s.fdat, s.dos, s.kos,                '||
               '       s.ostf, s.dapp, a.isp, a.nms,  cus.nmk, cus.okpo                 '||
               '  from                                                                  '||
			   '       customer cus, saldo so,                                          '||
			   '       accounts a, sal s                                                '||
               ' where s.fdat between  :p_date1  and  :p_date2                          '||
               '   and a.acc = s.acc                                                    '||
			   '   and cus.rnk = a.rnk and a.acc= so.acc                                '||
               '   and (a.dazs is null or a.dazs >= :p_dat1)                            '||
			   case when l_nbsmask <> '%' then ' and a.nbs like '''||l_nbsmask||'''' else ' ' end||
               '   and a.branch like  :p_branch                                         '||
               '   and (' || construct_nlsmask_sql(p_mask) || ')                        '||
               case p_mltval when 0 then  ' and a.kv  =  980 '
                                    else  ' and a.kv  <> 980 '
               end                                                                       ||
               case  when p_isp <> '%' then ' and a.isp in (select column_value isp from  table(getTokens('''||p_isp||''')))    '
               end                                                                       ||
               case  when p_kv <> 0 then  ' and a.kv = '||p_kv
               end                                                                       ||
			   case when p_add_cond is not null then p_add_cond  else '' end;

     --bars_audit.info(l_trace||'sql: '||l_sql);


      open l_c0 for l_sql  using p_date1, p_date2,   p_date1, p_branch;
      bars_audit.trace(l_trace||'params: :=1'||to_char(p_date1, 'dd\mm\yyyy')||' :2='||to_char(p_date2,'dd\mm\yyyy')||' :3='||to_char(p_date2,'dd\mm\yyyy')||' :4='||p_branch);

          lic_global(
                  p_date1   =>  p_date1,
                  p_date2   =>  p_date2,
                  p_c0      =>  l_c0,
                  p_inform  =>  p_inform,
                  p_mltval  =>  p_mltval,
                  p_valeqv  =>  p_valeqv,
                  p_valrev  =>  p_valrev);

      close l_c0;
   end;

/*
-------
    -----------------------------------------------------------------
    --  LIC_ACCLIST
    --
    --   Формирование выписок по стандартному выбору счетов.
    --   Формирование курсора для глобалной процедуры
    --
    --   p_date1    -  дата с
    --   p_date2    -  дата по
    --   p_mask     -  маска             (по умолчанию - все)
    --   p_kv       -  валюта            (по умолчанию - все)
    --   p_isp      -  исполнитель       (по умолчанию - все)
    --   p_branch   -  бранч
    --   p_inform   -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_mltval   -  вылютная
    --   p_valeqv   -  с эквивалентами
    --   p_valrev   -  с переоценкой (revaluation)
    --   p_add_cond -  дополнительное условие на запрос для выбора счета
	--              -    (условие пишется в виде and s.acc in (select acc from accounts where ob22 = 'xxx')
	--              -     используя алиасы :
	--              -     s    - saldoa,
	--              -     cus  - customer )
    --
	procedure lic_acclist(
                  p_date1    date,
                  p_date2    date,
                  p_mask     varchar2            default '%',
                  p_kv       number              default 0,
                  p_isp      number              default 0,
                  p_branch   branch.branch%type  default sys_context('bars_context','user_branch'),
                  p_inform   smallint            default 1,
                  p_mltval   smallint            default 0,
                  p_valeqv   smallint            default 0,
                  p_valrev   smallint            default 0,
				  p_add_cond varchar2            default null )
   is
      l_c0       t_acccur;
      l_sql      varchar2(4000);
      l_trace    varchar2(1000) := G_TRACE||'lic_global:';
   begin


       validate_mask_and_period(p_date1    =>  p_date1,
                                p_date2    =>  p_date1,
                                p_nlsmasks =>  p_mask );

      --сформировать строку запроса для выбора счетов
      l_sql := 'select a.acc,  a.nls, a.kv, a.tip, s.fdat, s.dos, s.kos,                '||
               '       s.ostf, a.dapp, a.isp, a.nms,  cus.nmk, cus.okpo                 '||
               '  from                                                                  '||
			   '       customer cus, saldo so,                                          '||
			   '       accounts a, sal s                                                '||
               ' where s.fdat between  :p_date1  and  :p_date2                          '||
               '   and a.acc = s.acc                                                    '||
			   '   and cus.rnk = a.rnk and a.acc= so.acc                                '||
               '   and (a.dazs is null or a.dazs >= :p_dat1)                            '||
               '   and a.branch like  :p_branch                                         '||
               '   and (' || construct_nlsmask_sql(p_mask) || ')                        '||
               case p_mltval when 0 then  ' and a.kv  =  980 '
                                    else  ' and a.kv  <> 980 '
               end                                                                       ||
               case  when p_isp <> 0 then ' and a.isp = '||p_isp
               end                                                                       ||
               case  when p_kv <> 0 then  ' and a.kv = '||p_kv
               end                                                                       ||
			   case when p_add_cond is not null then p_add_cond  else '' end;

     --bars_audit.info(l_trace||'sql: '||l_sql);


      open l_c0 for l_sql  using p_date1, p_date2,   p_date1, p_branch;
      bars_audit.trace(l_trace||'params: :=1'||to_char(p_date1, 'dd\mm\yyyy')||' :2='||to_char(p_date2,'dd\mm\yyyy')||' :3='||to_char(p_date2,'dd\mm\yyyy')||' :4='||p_branch);

          lic_global(
                  p_date1   =>  p_date1,
                  p_date2   =>  p_date2,
                  p_c0      =>  l_c0,
                  p_inform  =>  p_inform,
                  p_mltval  =>  p_mltval,
                  p_valeqv  =>  p_valeqv,
                  p_valrev  =>  p_valrev);

      close l_c0;
   end;
*/







    -----------------------------------------------------------------
    --  LIC_GROUP
    --
    --   Формирование выписок по отчетным группам
    --
    --   p_date1   -  дата с
    --   p_date2   -  дата по
    --   p_inform  -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_kv      -  (0-все)
    --   p_mltval  -  вылютная (если =2, включает тогда и гривну с валютой)
    --   p_valeqv  -  с эквивалентами
    --   p_valrev  -  с переоценкой (revaluation)
    --   p_repgrp  -  отчетная группа
    --
    procedure lic_group(
                  p_date1   date,
                  p_date2   date,
                  p_inform  smallint            default 1,
                  p_kv      smallint            default 0,
                  p_mltval  smallint            default 0,
                  p_valeqv  smallint            default 0,
                  p_valrev  smallint            default 0,
                  p_repgrp  smallint)
   is
      l_c0       t_acccur;
      l_sqllike  varchar2(8000) := ' ';
      l_sqleqv   varchar2(8000) := ' ';
      l_sql      varchar2(8000) := ' ';
      l_sq       number;
      l_fn       opldok.txt%type;
      l_fdat     date;
      l_trace    varchar2(1000) := G_TRACE||'lic_group:';
   begin

       execute immediate 'truncate table tmp_nlslist';
       for c in (  select nlsmask, kv, acc.branch, acc.accgrp
                   from rep_acc acc, rep_accgrp a, rep_accg_otchg ao, rep_otchgrp o
                   where  o.otchgrp= p_repgrp and o.otchgrp=ao.otchgrp
                          and ao.accgrp=a.accgrp and acc.accgrp=a.accgrp
                ) loop
               insert into tmp_nlslist(nls, kv, branch) values (c.nlsmask, nvl(c.kv,0), c.branch);
       end loop;


       l_sql :=
               'select s.acc,  s.nls, s.kv, s.tip, s.fdat,   s.dos, s.kos,              '||
               '       s.ost - s.kos + s.dos ostf, s.dapp, s.isp, s.nms,  nmk, cus.okpo '||
               '  from sal s, customer cus, saldo so, tmp_nlslist l        '||
               ' where s.fdat between  :p_date1  and  :p_date2                          '||
               '   and s.rnk =  cus.rnk and s.acc = so.acc             '||
               '   and (s.dazs is null or s.dazs >= :p_dat1)                            '||
               '   and s.nls like l.nls and l.kv = decode(l.kv,0, 0, s.kv )             '||
               '   and s.branch like l.branch                                           '||
               case p_mltval when 0 then  ' and s.kv  =  980 '
                             when 1 then  ' and s.kv <>  980 '
                                    else  '  '
               end                                                                       ||
               case  when p_kv <> 0 then  ' and s.kv = '||p_kv
               end                                                                       ;

               bars_audit.trace(l_trace||l_sql);

       open l_c0 for l_sql  using p_date1, p_date2,  p_date1;


       lic_global(
                  p_date1   =>  p_date1,
                  p_date2   =>  p_date2,
                  p_c0      =>  l_c0,
                  p_inform  =>  p_inform,
                  p_mltval  =>  p_mltval,
                  p_valeqv  =>  p_valeqv,
                  p_valrev  =>  p_valrev);

      close l_c0;

       -- Присвоим группы отчетов
       update tmp_licm set grplist=':';

       for k in ( select kv, nlsmask, acc.accgrp
                  from rep_acc acc, rep_accg_otchg r
                  where otchgrp=p_repgrp and acc.accgrp=r.accgrp
                ) loop
          update tmp_licm set grplist=grplist||to_char(k.accgrp)||':'
          where nls like k.nlsmask and kv = decode(k.kv,0, kv, k.kv);
       end loop;



   end;



    -----------------------------------------------------------------
    --  LIC_DYNSQL
    --
    --   Формирование выписок по динамическому запросу из справочника REPVP_DYNSQL
    --
    --   p_date1   -  дата с
    --   p_date2   -  дата по
    --   p_inform  -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_kv      -  (0-все)
    --   p_mltval  -  вылютная (если =2, включает тогда и гривну с валютой)
    --   p_valeqv  -  с эквивалентами
    --   p_valrev  -  с переоценкой (revaluation)
    --   p_sqlid   -  № динамич. запроса    из справочника REPVP_DYNSQL
    --
    procedure lic_sqldyn(
                  p_date1   date,
                  p_date2   date,
                  p_inform  smallint            default 1,
                  p_kv      smallint            default 0,
                  p_mltval  smallint            default 0,
                  p_valeqv  smallint            default 0,
                  p_valrev  smallint            default 0,
                  p_sqlid   number)
   is
      l_c0       t_acccur;
      l_sql      varchar2(32000) := ' ';
      l_sq       number;
      l_trace    varchar2(1000) := G_TRACE||'lic_dynsql:';
   begin

      begin
         select sqltxt into   l_sql from repvp_dynsql where sqlid = p_sqlid;
      exception when no_data_found then
         bars_error.raise_nerror(G_MODULE,  'NO_SUCH_SQLID', to_char(p_sqlid));
      end;


      l_sql := l_sql||
               case p_mltval when 0 then  ' and s.kv  =  980 '
                             when 1 then  ' and s.kv <>  980 '
                                    else  '  '
               end                                                                       ||
               case  when p_kv <> 0 then  ' and s.kv = '||p_kv
               end                                                                       ;

      bars_audit.trace(l_trace||l_sql);

      open l_c0 for l_sql  using p_date1, p_date2,  p_date1;


      lic_global(
                  p_date1   =>  p_date1,
                  p_date2   =>  p_date2,
                  p_c0      =>  l_c0,
                  p_inform  =>  p_inform,
                  p_mltval  =>  p_mltval,
                  p_valeqv  =>  p_valeqv,
                  p_valrev  =>  p_valrev);

      close l_c0;

   end;




    -----------------------------------------------------------------
    --  LIC_VALB()
    --
    --   Выписки по валюте за период.
    --   С возможностью указания маски по счету, исполнителя счета
    --
    --   p_date1   - дата с
    --   p_date2   - дата по
    --   p_mask    - маска       (по умолчанию - все)
    --   p_isp     - исполнитель (по умолчанию % - все)
    --   p_branch  -  бранч
    --   p_inform  - информационные сообщения (=1 - вносить, =0 - не вносить)
    --
    procedure lic_valb(
                  p_date1   date,
                  p_date2   date,
                  p_mask    varchar2            default '%',
                  p_kv      number              default 0,
                  p_isp     number              default 0,
                  p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                  p_inform  smallint            default 1)
    is
    begin

       lic_acclist(
                  p_date1   => p_date1,
                  p_date2   => p_date2,
                  p_mask    => p_mask,
                  p_kv      => p_kv,
                  p_isp     => case when p_isp = 0 then '%' else to_char(p_isp) end,
                  p_branch  => p_branch,
                  p_inform  => p_inform,
                  p_mltval  => 1,
                  p_valeqv  => 1,
                  p_valrev  => 1);

    end;


    -----------------------------------------------------------------
    --  LIC_GRNB()
    --
    --   Выписки по гривне за период.
    --   С возможностью указания маски по счету, исполнителя счета
    --
    --   p_date1   - дата с
    --   p_date2   - дата по
    --   p_mask    - маска       (по умолчанию - все)
    --   p_isp     - исполнитель (по умолчанию  % - все)
    --   p_branch  -  бранч
    --   p_inform  - информационные сообщения (=1 - вносить, =0 - не вносить)
    --
    procedure lic_grnb(  p_date1   date,
                         p_date2   date,
                         p_mask    varchar2           default '%',
                         p_isp     number           default  0,
                         p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                         p_inform  smallint           default 1)
    is
    begin

       lic_acclist(
                  p_date1   => p_date1,
                  p_date2   => p_date2,
                  p_mask    => p_mask,
                  p_kv      => gl.baseval,
                  p_isp     => case when p_isp = 0 then '%' else to_char(p_isp) end,
                  p_branch  => p_branch,
                  p_inform  => p_inform,
                  p_mltval  => 0,
                  p_valeqv  => 0,
                  p_valrev  => 0);

    end;



    -----------------------------------------------------------------
    --  LIC_GRNB_OB()
    --
    --   Выписки по гривне за период c указанием ОБ22
    --   С возможностью указания маски по счету, исполнителя счета
    --
    --   p_date1   - дата с
    --   p_date2   - дата по
    --   p_mask    - маска       (по умолчанию - все)
    --   p_isp     - исполнитель (по умолчанию - все)
    --   p_branch  -  бранч
    --   p_inform  - информационные сообщения (=1 - вносить, =0 - не вносить)
    --
    procedure lic_grnb_ob(  p_date1   date,
                         p_date2   date,
                         p_mask    varchar2           default '%',
                         p_isp     varchar2           default '%',
                         p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                         p_inform  smallint           default 1,
						 p_ob22    varchar2   default '%')
    is
    begin

       lic_acclist(
                  p_date1   => p_date1,
                  p_date2   => p_date2,
                  p_mask    => p_mask,
                  p_kv      => gl.baseval,
                  p_isp     => p_isp,
                  p_branch  => p_branch,
                  p_inform  => p_inform,
                  p_mltval  => 0,
                  p_valeqv  => 0,
                  p_valrev  => 0,
				  p_add_cond => ' and nvl(a.ob22,''%'') like '''||p_ob22||'''');

    end;


    -----------------------------------------------------------------
    --  LIC_VALB_OB()
    --
    --   Выписки по валюте за период c указанием ОБ22.
    --   С возможностью указания маски по счету, исполнителя счета
    --
    --   p_date1   - дата с
    --   p_date2   - дата по
    --   p_mask    - маска       (по умолчанию - все)
    --   p_isp     - исполнитель (по умолчанию - все)
    --   p_branch  -  бранч
    --   p_inform  - информационные сообщения (=1 - вносить, =0 - не вносить)
    --
    procedure lic_valb_ob(
                  p_date1   date,
                  p_date2   date,
                  p_mask    varchar2            default '%',
                  p_kv      number              default 0,
                  p_isp     varchar2            default '%',
                  p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                  p_inform  smallint            default 1,
				  p_ob22    varchar2            default '%')
    is
    begin

       lic_acclist(
                  p_date1   => p_date1,
                  p_date2   => p_date2,
                  p_mask    => p_mask,
                  p_kv      => p_kv,
                  p_isp     => p_isp,
                  p_branch  => p_branch,
                  p_inform  => p_inform,
                  p_mltval  => 1,
                  p_valeqv  => 1,
                  p_valrev  => 1,
				  p_add_cond => ' and nvl(a.ob22,''%'') like '''||p_ob22||'''');


    end;



    -----------------------------------------------------------------
    --  INIT()
    --
    --   Инициализация пакета
    --
    --
    procedure init
	is
	begin
	   -- инициализация списка операций при которых осущетсвлять поиск назначеня платежа по OPER
	   -- при условии, что коррекспондетн ищемтся по OPLDOK
	   if G_NAZNTT_LIST.count  = 0 then
          for c in (select upper(tt) tt from rep_licnazntt) loop
                 G_NAZNTT_LIST(c.tt) := 1;
				 --bars_audit.info('insert '||c.tt);
             end loop;
      end if;

	end;


begin

   init;

end;
/
 show err;
 
PROMPT *** Create  grants  BARS_RPTLIC ***
grant EXECUTE                                                                on BARS_RPTLIC     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_RPTLIC     to RPBN001;
grant EXECUTE                                                                on BARS_RPTLIC     to TASK_LIST;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_rptlic.sql =========*** End ***
 PROMPT ===================================================================================== 
 