

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LICSBB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LICSBB ***

  CREATE OR REPLACE PROCEDURE BARS.P_LICSBB 
 (id_        SMALLINT,
  dt1_       DATE    ,  -- дата с
  dt2_       DATE    ,  -- дата по
  maskasab_  varchar2,  -- код эл. клиента
  kvz_       SMALLINT,  -- код валюты (не используется)
  maskanls_  varchar2,  -- маска счета
  vptype_    char)      -- тип выписки (Z,V,C,O)
IS
--------------------------------------------------------------------
-- Формирование выписок для эл.клиентов (СберБанк)                --
-- auth: mom                                                      --
-- v.2.00 (21.03.2009) anny                                       --
-- v.2.01 (31.08.2010) mom                                        --
-- v.2.02 (11.10.2010) mom                                        --
-- v.2.03 (11.10.2010) mom  добавлено okpoz                       --
-- v.2.04 (18.10.2010) mom  устранена описка по ОКПО              --
-- v.2.05 (04.11.2010) mom  отрихтованы даты банков в Z           --
-- v.2.06 (08.11.2010) mom  опять какой-то бред с датой           --
-- v.2.07 (16.11.2010) mom  дурдом с информационными              --
-- v.2.08 (19.11.2010) mom  дурдом без информационных             --
-- v.2.09 (24.11.2010) mom  информационные без миграции           --
-- v.2.10 (17.03.2012) mom  комиссия в C по операциям аля 00A     --
-- v.2.11 (24.10.2012) mom  обработка документов с VOB=6          --
-- v.2.12 (26.11.2012) mom  переоценочные проводки для Крыма      --
-- v.2.13 (24.06.2014) mom  Оптимизировано формирование файлов C  --
--------------------------------------------------------------------
  dk_        int;
  s1_        int;
  k14_       varchar2(15);
  n38_       varchar2(38);
  acc_       number;
  fdat_      DATE;
  dapp_      DATE;
  datd_      DATE;
  ostf_      DECIMAL(24);
  ostc_      DECIMAL(24);
  dos_       DECIMAL(24);
  kos_       DECIMAL(24);
  nls_       varchar2(15);
  kv_        SMALLINT;
  ref_       SMALLINT;
  tip_       char(3);
  tt_        char(3);
  tto_       char(3);
  s_         DECIMAL(24);
  vdat_      DATE;
  pdat_      DATE;
  nd_        char(10);
  mfoa_      varchar2(12);
  nlsa_      varchar2(15);
  txt_       varchar2(160);
  nama_      varchar2(38);
  mfob_      varchar2(12);
  nlsb_      varchar2(15);
  namb_      varchar2(38);
  nazn_      varchar2(160);
  nazn1      varchar2(160);
  userid_    SMALLINT;
  sk_        SMALLINT;
  kvs_       SMALLINT;
  isp_       SMALLINT;
  nms_       varchar2(38);
  pond_      varchar2(10);
  filename_  varchar2(12);
  kokb_      varchar2(14);
  koka_      varchar2(14);
  id_a_      varchar2(14);
  vob_       SMALLINT;
  nazns_     VARCHAR2(2);
  bis_       NUMBER;
  naznk_     VARCHAR2(3);
  d_rec_     VARCHAR2(80);
  fn_a_      VARCHAR2(12);
  amfo_      varchar2(12);
  sosa_      SMALLINT;
  rec_       int;
  kokb1_     varchar2(14);
  datp_      DATE;
  data_      DATE;
  datb_      DATE;
  datb1_     DATE;
  datb2_     DATE;
  datOV_     DATE;
  datbis_    DATE;
  operbis_   int;
  okpo_      varchar2(12);
  okpoz_     varchar2(12);
  nonot_     int;
  isx_       int;
  rpo_       number;
  skr_       varchar2(1);
  namv_      varchar2(38);
  nlsaoper_  varchar2(15);
  nlsboper_  varchar2(15);
  id_aoper_  varchar2(14);
  id_boper_  varchar2(14);
  type       cur is ref cursor;
  cur_       cur;
  sql_       varchar2(32767);
--infref_    varchar2(32000);

  CURSOR OPLDOK1 IS
         SELECT dk             ,  --dk_
                s              ,  --s1_
                ref            ,  --ref_
                tt             ,  --tt_
                ABS(s*(2*dk-1)),  --s_
                txt               --txt_
         FROM   opldok
         WHERE  acc=acc_   and
                fdat=fdat_ and
                sos=5
         order  by ref;

  CURSOR OPER1 IS
         SELECT o.tt                                      ,  --tto_
                o.vdat                                    ,  --vdat_
                o.pdat                                    ,  --pdat_
                o.nd                                      ,  --nd_
                o.mfoa                                    ,  --mfoa_
                o.nlsa                                    ,  --nlsa_
                o.nam_a                                   ,  --nama_
                o.mfob                                    ,  --mfob_
                o.nlsb                                    ,  --nlsb_
                o.nam_b                                   ,  --namb_
                o.nazn                                    ,  --nazn_
                o.userid                                  ,  --userid_
                o.sk                                      ,  --sk_
                o.kv                                      ,  --kvs_
--              o.vob                                     ,  --vob_
--              decode(o.vob,7,6,o.vob)                   ,  --vob_
                decode(o.vob,7,5,o.vob)                   ,  --vob_
                o.datd                                    ,  --datd_
                o.id_b                                    ,  --kokb_
                o.id_a                                    ,  --kokb1_
                o.datp                                    ,  --datp_
                convert(o.d_rec,'RU8PC866','CL8MSWIN1251'),  --d_rec_
                o.bis                                     ,  --operbis_
                o.nlsa                                    ,  --nlsaoper_
                o.nlsb                                    ,  --nlsboper_
                o.id_a                                    ,  --id_aoper_
                o.id_b                                       --id_boper_
         FROM   oper o
         WHERE  o.ref=ref_;

BEGIN

  begin
    select nvl(val,'0')
    into   skr_
    from   params$base
    where  par='KL_SKR';
  exception when no_data_found then
    skr_ := '0';
  end;

  delete
  from   tmp_lics
  where  id=id_;

--выписка заключительная - убрать все референсы за "сегодня"
  if vptype_='Z' and dt1_=gl.bd then
    delete from klop_cref;
  end if;

  begin
    select f_ourmfo
    into   amfo_
    from   dual;
  exception when OTHERS then
    begin
      select f_ourmfo_g
      into   amfo_
      from   dual;
    exception when OTHERS then
      amfo_ := '300465';
    end;
  end;

  sql_:='SELECT s.acc                   ,  --acc_
                s.fdat                  ,  --fdat_
                s.ostf                  ,  --ostf_
                s.dos                   ,  --dos_
                s.kos                   ,  --kos_
                a.nls                   ,  --nls_
                a.kv                    ,  --kv_
                s.pdat                  ,  --dapp_
                a.isp                   ,  --isp_
                trim(substr(a.nms,1,38)),  --nms_
                c.okpo                  ,  --koka_
                c.okpo                     --okpoz_
         FROM   saldoa   s,
                accounts a,
                customer c
         WHERE  a.acc=s.acc                                                                           and
                a.acc IN (SELECT acc FROM acc'||iif_s(vptype_,'C','','c','e')||' WHERE nvl(pers,0)=1) and
                s.fdat>=to_date('''||dt1_||''')                                                       and
                s.fdat<=to_date('''||dt2_||''')                                                       and
                a.rnk=c.rnk                                                                           and
                c.sab='''||maskasab_||'''                                                             and
                c.stmt=5                                                          /* and a.kv=kvz_ */ and
                a.nls like '''||maskanls_||'''                                                        and
                a.tip not in
                (''N99'',''L99'',''N00'',''T00'',''T0D'',''TNB'',''TND'',''TUR'',''TUD'',''L00'')
         union all
         SELECT s.acc                   ,
                s.fdat                  ,
                s.ostf                  ,
                s.dos                   ,
                s.kos                   ,
                a.nls                   ,
                a.kv                    ,
                s.pdat                  ,
                a.isp                   ,
                trim(substr(a.nms,1,38)),
                r.okpo                  ,
                g.okpo
         FROM   saldoa   s,
                accounts a,
                klp_top  c,
                customer r,
                customer g
         WHERE  a.acc=s.acc                                                                           and
                a.acc IN (SELECT acc FROM acc'||iif_s(vptype_,'C','','c','e')||' WHERE nvl(high,0)=1) and
                s.fdat>=to_date('''||dt1_||''')                                                       and
                s.fdat<=to_date('''||dt2_||''')                                                       and
                a.rnk=c.rnk                                                                           and
                a.rnk=g.rnk                                                                           and
                r.sab='''||maskasab_||'''                                                             and
                r.stmt=5                                                                              and
                r.rnk=c.rnkp                                                      /* and a.kv=kvz_ */ and
                a.nls like '''||maskanls_||'''                                                        and
                a.tip not in
                (''N99'',''L99'',''N00'',''T00'',''T0D'',''TNB'',''TND'',''TUR'',''TUD'',''L00'')';

  open cur_ for sql_;
  LOOP
    fetch cur_ into acc_  ,
                    fdat_ ,
                    ostf_ ,
                    dos_  ,
                    kos_  ,
                    nls_  ,
                    kv_   ,
                    dapp_ ,
                    isp_  ,
                    nms_  ,
                    koka_ ,
                    okpoz_;
    EXIT WHEN cur_%NOTFOUND;
    bars_audit.trace('p_licsbb: счет '||nls_||'('||kv_||')');

    OPEN OPLDOK1;
    LOOP
      FETCH OPLDOK1
      INTO  dk_ ,
            s1_ ,
            ref_,
            tt_ ,
            s_  ,
            txt_;
      EXIT WHEN OPLDOK1%NOTFOUND;

      OPEN OPER1;
      LOOP
        if vptype_='C' then
--        для файлов С только поступления
          if dk_=0 then
            exit;
          end if;

          begin
            insert
            into   klop_cref (ref,
                              sab)
                      values (ref_,
                              maskasab_);
            bars_audit.trace('p_licsbb: !! новый реф '||ref_);
          exception when dup_val_on_index then
--          если референс уже отбирали - не отбирать и выйти из цикла по opldok
            bars_audit.trace('p_licsbb: реф уже отбирался '||ref_);
            exit;
          end;
        end if;

        FETCH OPER1
        INTO  tto_     ,
              vdat_    ,
              pdat_    ,
              nd_      ,
              mfoa_    ,
              nlsa_    ,
              nama_    ,
              mfob_    ,
              nlsb_    ,
              namb_    ,
              nazn_    ,
              userid_  ,
              sk_      ,
              kvs_     ,
              vob_     ,
              datd_    ,
              kokb_    ,
              kokb1_   ,
              datp_    ,
              d_rec_   ,
              operbis_ ,
              nlsaoper_,
              nlsboper_,
              id_aoper_,
              id_boper_;
        EXIT WHEN OPER1%NOTFOUND;

        sosa_   := null;
        datbis_ := null;
--      kokb_   := null;

        SELECT max(dat)
        INTO   datOV_
        FROM   oper_visa
        WHERE  ref=ref_;

        if tt_<>tto_ then
          pond_     := '';
          filename_ := '';
          nazns_    := '';
          bis_      := null;
          naznk_    := '';
          d_rec_    := '';
          fn_a_     := '';
          rec_      := null;
--        mfob_     := '';
--        mfoa_     := '';
          sk_       := null;
          if tto_ in ('ЭНК','ЭНД') then
            kokb_   := kokb1_;
          end if;
--        kokb_     := null;
--        nazn_     := txt_;
          if tt_ not in ('R00','R01','D01','901') then
            nazn_   := txt_;
          end if;
          if (tt_='901' and tto_ in ('R01','D01')) or
             (tt_ in ('R01','D01') and tto_='R00') THEN
            begin
              select mfoa                                    ,
                     id_a                                    ,
                     nazns                                   ,
                     bis                                     ,
                     naznk                                   ,
                     convert(d_rec,'RU8PC866','CL8MSWIN1251'),
                     nvl(fn_a,fn_b)                          ,
                     id_a                                    ,
                     rec                                     ,
                     dat_a
              into   mfoa_ ,
                     kokb_ ,
                     nazns_,
                     bis_  ,
                     naznk_,
                     d_rec_,
                     fn_a_ ,
                     id_a_ ,
                     rec_  ,
                     datbis_
              from   arc_rrp
              where  ref=ref_ and
                     bis<=1;
            exception when no_data_found then
--            mfoa_   := mfoa_;
--            kokb_   := kokb_;
              nazns_  := '';
              bis_    := null;
              naznk_  := '';
--            d_rec_  := '';
              fn_a_   := '';
              id_a_   := null;
              rec_    := null;
              datbis_ := null;
            end;
          end if;
          begin
            select a.nls,
                   trim(substr(a.nms,1,38))
            into   k14_,
                   n38_
            from   opldok   o,
                   accounts a
            where  rownum<2           and
                   a.kv=kv_ /* 980 */ and
                   o.ref=ref_         and
                   o.tt=tt_           and
                   o.s=s1_            and
                   o.acc=a.acc        and
                   o.dk=decode(dk_,1,0,1);
          exception when no_data_found then
            k14_ := null;
            n38_ := null;
          end;
        else
--        if dk_=1 and mfoa_=mfob_ then
--          kokb_ := kokb1_;
--        end if;
          begin
--          select k1.pond,
--                 k1.filename /* ,k2.kokb */
--          into   pond_,
--                 filename_   /* ,kokb_   */
--          from   klpond k1,
--                 klp    k2
--          where  rownum<2        and
--                 k1.ref=ref_     and
--                 k1.pond=k2.pond and
--                 substr(k2.naex,8,1)||substr(k2.naex,10,3)=maskasab_;
            select pond,
                   filename
            into   pond_,
                   filename_
            from   klpond
            where  rownum<2 and
                   ref=ref_ and
                   substr(filename,8,1)||substr(filename,10,3)=maskasab_;
          exception when no_data_found then
            pond_     := '';
            filename_ := '';
          end;
          begin
            select nazns                                   ,
                   bis                                     ,
                   naznk                                   ,
                   convert(d_rec,'RU8PC866','CL8MSWIN1251'),
                   nvl(fn_a,fn_b)                          ,
                   id_a                                    ,
                   sos                                     ,
                   rec                                     ,
                   dat_a
            into   nazns_,
                   bis_  ,
                   naznk_,
                   d_rec_,
                   fn_a_ ,
                   id_a_ ,
                   sosa_ ,
                   rec_  ,
                   datbis_
            from   arc_rrp
            where  ref=ref_ and
                   bis<=1;
          exception when no_data_found then
            nazns_  := '';
            bis_    := null;
            naznk_  := '';
--          d_rec_  := '';
            fn_a_   := '';
            id_a_   := null;
            rec_    := null;
            datbis_ := null;
          end;
--        if id_a_<>koka_ and id_a_ is not null then
--          kokb_   := id_a_;
--        end if;
          bars_audit.trace('p_licsbb: tt_='||tt_);

          begin
            select dk_
            into   isx_
            from   operw
            where  ref=ref_ and
                   tag='REF92';
          exception when no_data_found then
             isx_ := 0;
          end;

          bars_audit.trace('p_licsbb: isx_='||isx_||
                                   ', s_='  ||s_  ||
                                   ', tt_=' ||tt_ ||
                                   ', tto_='||tto_);

--        if tt_='901' THEN
          if isx_=1 THEN
            begin
              select a.nazns                                   ,
                     convert(a.d_rec,'RU8PC866','CL8MSWIN1251'),
                     a.bis                                     ,
                     a.naznk                                   ,
                     nvl(a.fn_a,a.fn_b)                        ,
                     a.rec                                     ,
                     a.dat_a                                   ,
                     a.nlsa                                    ,
                     a.mfoa                                    ,
                     a.nam_a                                   ,
                     a.id_a
              into   nazns_ ,
                     d_rec_ ,
                     bis_   ,
                     naznk_ ,
                     fn_a_  ,
                     rec_   ,
                     datbis_,
                     nlsb_  ,
                     mfob_  ,
                     namb_  ,
                     kokb_
              from   arc_rrp a,
                     operw   w
              where  w.ref=ref_               and
                     w.tag='REF92'            and
                     a.ref=to_number(w.value) and
                     a.bis<=1;
            exception when no_data_found then
               null;
            end;
          end if;
        end if;
        bars_audit.trace('p_licsbb: nlsb_='||nlsb_||
                                 ', mfob_='||mfob_||
                                 ', namb_='||namb_);
--      мы плательщик
        IF nls_=nlsa_ and kv_=kvs_ THEN
          IF tt_ not in (tto_,'R00','R01','D01') THEN
            IF k14_ is not null THEN
              nlsb_ := k14_;
            END IF;
            IF n38_ is not null THEN
              namb_ := n38_;
            END IF;
          END IF;
          if kokb_ is null and (mfob_=amfo_ or mfob_ is null) THEN
            begin
              select c.okpo
              into   kokb_
              from   customer c,
                     accounts a
              where  a.nls=nlsb_ and
                     a.kv=kv_    and
                     a.rnk=c.rnk;
            exception when no_data_found then
              null;
            end;
          end if;
--        if koka_=kokb_ then
--          kokb_ := null;
--        end if;
          if mfoa_ is not null and mfob_ is not null and mfoa_<>mfob_ then
            begin
              select dat_a,
                     dat_b
              into   data_,
                     datb_
              from   arc_rrp
              where  ref=ref_ and
                     bis<=1;
            exception when no_data_found then
              data_ := pdat_;
              datb_ := pdat_;
            end;
            if datOV_ is null then
              datOV_ := datb_;
            end if;
          else
            data_ := pdat_;
            datb_ := pdat_;
          end if;
          datb1_ := datp_;
          if mfoa_=amfo_ or mfoa_ is null then
--          datb1_ := datp_;
            datb2_ := nvl(datb_,pdat_);
          else
--          datb1_ := datp_;
            datb2_ := pdat_;
          end if;

--        внутренние бисы (ANNY)
          if mfoa_=mfob_ and operbis_=1 then
            select count(*)
            into   bis_
            from   operw
            where  ref=ref_ and
                   regexp_like(trim(tag),'C[0-9]{1,2}$');
          end if;

          bars_audit.trace('p_licsbb: nlsa_='||nlsa_||
                                   ', mfoa_='||mfoa_||
                                   ', nlsb_='||nlsb_||
                                   ', mfob_='||mfob_);

--        "рихтуем" ОКПОА и ОКПОБ

--        begin
--          select nlsa,
--                 nlsb,
--                 id_a,
--                 id_b
--          into   nlsaoper_,
--                 nlsboper_,
--                 id_aoper_,
--                 id_boper_
--          from   oper
--          where  ref=ref_;
          if nls_=nlsaoper_ then
            koka_ := id_aoper_;
          end if;
          if nlsb_=nlsboper_ then
            kokb_ := id_boper_;
          end if;
          if nls_=nlsboper_ then
            koka_ := id_boper_;
          end if;
          if nlsb_=nlsaoper_ then
            kokb_ := id_aoper_;
          end if;
--        exception when no_data_found then
--          null;
--        end;

          bars_audit.trace('p_licsbb: вставка в tmp_lics (1)');
          INSERT
          INTO   tmp_lics (id       ,  --id_
                           daopl    ,  --fdat_
                           acc      ,  --acc_
                           s        ,  --s_
                           nd       ,  --nd_
                           mfob     ,  --mfob_
                           nazn     ,  --nazn_
                           isp      ,  --isp_
                           nlsa     ,  --nls_
                           kv       ,  --kv_
                           nama     ,  --nms_
                           nlsb     ,  --nlsb_
                           namb     ,  --namb_
                           ref      ,  --ref_
                           tt       ,  --tt_
                           iost     ,  --ostf_
                           dos      ,  --dos_
                           kos      ,  --kos_
                           vdat     ,  --vdat_
                           pdat     ,  --pdat_
                           sk       ,  --sk_
                           dapp     ,  --nvl(dapp_,fdat_)
                           okpoa    ,  --koka_
                           okpob    ,  --kokb_
                           dk       ,  --dk_
                           vob      ,  --vob_
                           pond     ,  --pond_
                           namefilea,  --filename_
                           kodirowka,  --0
                           nazns    ,  --nazns_
                           bis      ,  --bis_
                           naznk    ,  --naznk_
                           d_rec    ,  --d_rec_
                           fn_a     ,  --fn_a_
                           rec      ,  --rec_
                           datd     ,  --datd_
                           datb1    ,  --nvl(datb1_,fdat_)
                           datb2    ,  --datb2_
                           datov    ,  --nvl(datOV_,fdat_)
                           datbis   ,  --datbis_
                           okpoz)      --okpoz_
                   VALUES (id_              ,
                           fdat_            ,
                           acc_             ,
                           s_               ,
                           nd_              ,
                           mfob_            ,
                           nazn_            ,
                           isp_             ,
                           nls_             ,
                           kv_              ,
                           nms_             ,
                           nlsb_            ,
                           namb_            ,
                           ref_             ,
                           tt_              ,
                           ostf_            ,
                           dos_             ,
                           kos_             ,
                           vdat_            ,
                           pdat_            ,
                           sk_              ,
                           nvl(dapp_,fdat_) ,
                           koka_            ,
                           kokb_            ,
                           dk_              ,
                           vob_             ,
                           pond_            ,
                           filename_        ,
                           0                ,
                           nazns_           ,
                           bis_             ,
                           naznk_           ,
                           d_rec_           ,
                           fn_a_            ,
                           rec_             ,
                           datd_            ,
                           nvl(datb1_,fdat_),
                           datb2_           ,
                           nvl(datOV_,fdat_),
                           datbis_          ,
                           okpoz_);

--      мы получатель
        ELSE
          pond_     := '';
          filename_ := '';
          IF tt_ not in (tto_,'R00','R01','D01','901') THEN
            IF k14_ is not null THEN
              nlsa_ := k14_;
            END IF;
            IF n38_ is not null THEN
              nama_ := n38_;
            END IF;
          END IF;
          if kokb_ is null and (mfoa_=amfo_ or mfoa_ is null) THEN
            begin
              select c.okpo
              into   kokb_
              from   customer c,
                     accounts a
              where  a.nls=nlsa_ and
                     a.kv=kv_    and
                     a.rnk=c.rnk;
            exception when no_data_found then
              null;
            end;
          end if;
--        if koka_=kokb_ then
--          kokb_ := null;
--        end if;
          if mfoa_ is not null and mfob_ is not null and mfoa_<>mfob_ then
            begin
              select dat_a,
                     dat_b
              into   data_,
                     datb_
              from   arc_rrp
              where  ref=ref_ and
                     bis<=1;
            exception when no_data_found then
              data_ := pdat_;
              datb_ := pdat_;
            end;
            if datOV_ is null then
              datOV_ := datb_;
            end if;
          else
            data_ := pdat_;
            datb_ := pdat_;
          end if;
          datb1_ := datp_;
          if mfoa_=amfo_ or mfoa_ is null then
--          datb1_ := datp_;
            datb2_ := nvl(data_,pdat_);
          else
--          datb1_ := datp_;
            datb2_ := pdat_;
          end if;

--        внутренние бисы (ANNY)
          if mfoa_=mfob_ and operbis_=1 then
            select count(*)
            into   bis_
            from   operw
            where  ref=ref_ and
                   regexp_like(trim(tag),'C[0-9]{1,2}$');
          end if;

          bars_audit.trace('p_licsbb: isx_='||isx_||
                                   ', s_='  ||s_  ||
                                   ', tt_=' ||tt_ ||
                                   ', tto_='||tto_);

--        if tt_='901' then
          if isx_=1 then
            nlsa_ := nlsb_;
            mfoa_ := mfob_;
            nama_ := namb_;
          end if;

          if kokb_=koka_ then
            kokb_ := kokb1_;
          end if;

          bars_audit.trace('p_licsbb: nlsa_='||nlsa_||
                                   ', mfoa_='||mfoa_||
                                   ', nlsb_='||nlsb_||
                                   ', mfob_='||mfob_);

--        "рихтуем" ОКПОА и ОКПОБ

--        begin
--          select nlsa,
--                 nlsb,
--                 id_a,
--                 id_b
--          into   nlsaoper_,
--                 nlsboper_,
--                 id_aoper_,
--                 id_boper_
--          from   oper
--          where  ref=ref_;
          if nls_=nlsaoper_ then
            koka_ := id_aoper_;
          end if;
          if nlsa_=nlsboper_ then
            kokb_ := id_boper_;
          end if;
          if nls_=nlsboper_ then
            koka_ := id_boper_;
          end if;
          if nlsa_=nlsaoper_ then
            kokb_ := id_aoper_;
          end if;
--        exception when no_data_found then
--          null;
--        end;

          bars_audit.trace('p_licsbb: вставка в tmp_lics (2)');
          INSERT
          INTO   tmp_lics (id       ,  --id_
                           daopl    ,  --fdat_
                           acc      ,  --acc_
                           s        ,  --s_
                           nd       ,  --nd_
                           mfob     ,  --mfoa_
                           nazn     ,  --nazn_
                           isp      ,  --isp_
                           nlsa     ,  --nls_
                           kv       ,  --kv_
                           nama     ,  --nms_
                           nlsb     ,  --nlsa_
                           namb     ,  --nama_
                           ref      ,  --ref_
                           tt       ,  --tt_
                           iost     ,  --ostf_
                           dos      ,  --dos_
                           kos      ,  --kos_
                           vdat     ,  --vdat_
                           pdat     ,  --pdat_
                           sk       ,  --sk_
                           dapp     ,  --nvl(dapp_,fdat_)
                           okpoa    ,  --koka_
                           okpob    ,  --kokb_
                           dk       ,  --dk_
                           vob      ,  --vob_
                           pond     ,  --pond_
                           namefilea,  --filename_
                           kodirowka,  --0
                           nazns    ,  --nazns_
                           bis      ,  --bis_
                           naznk    ,  --naznk_
                           d_rec    ,  --d_rec_
                           fn_a     ,  --fn_a_
                           rec      ,  --rec_
                           datd     ,  --datd_
                           datb1    ,  --nvl(datb1_,fdat_)
                           datb2    ,  --datb2_
                           datov    ,  --nvl(datOV_,fdat_)
                           datbis   ,  --datbis_
                           okpoz)      --okpoz_
                   VALUES (id_              ,
                           fdat_            ,
                           acc_             ,
                           s_               ,
                           nd_              ,
                           mfoa_            ,
                           nazn_            ,
                           isp_             ,
                           nls_             ,
                           kv_              ,
                           nms_             ,
                           nlsa_            ,
                           nama_            ,
                           ref_             ,
                           tt_              ,
                           ostf_            ,
                           dos_             ,
                           kos_             ,
                           vdat_            ,
                           pdat_            ,
                           sk_              ,
                           nvl(dapp_,fdat_) ,
                           koka_            ,
                           kokb_            ,
                           dk_              ,
                           vob_             ,
                           pond_            ,
                           filename_        ,
                           0                ,
                           nazns_           ,
                           bis_             ,
                           naznk_           ,
                           d_rec_           ,
                           fn_a_            ,
                           rec_             ,
                           datd_            ,
                           nvl(datb1_,fdat_),
                           datb2_           ,
                           nvl(datOV_,fdat_),
                           datbis_          ,
                           okpoz_);
        END IF;
      END LOOP;
      CLOSE OPER1;
    END LOOP;
    CLOSE OPLDOK1;

--  техническая запись/документ - результат переоценки валютных счетов (Шарадов)

--  bars_audit.info('p_licsbb: (5) acc_='||acc_||', kv_='||kv_||', fdat_='||fdat_);
    if skr_='1' and (vptype_='Z' or vptype_='V') and kv_<>980 and
       (amfo_='336503' or amfo_='313957' or amfo_='324805') then
--             Ивано-Франковск,  Запорожье,        Крым
      begin
        select gl.p_icurval(kv_,fost(acc_,fdat_),fdat_)-        /* исх. ост. по тек. курсу */
               (gl.p_icurval(kv_,fost(acc_,fdat_-1),fdat_-1)-   /* вх. ост. по пред. курсу */
                gl.p_icurval(kv_,fdos(acc_,fdat_,fdat_),fdat_)+ /* дебет     по тек. курсу */
                gl.p_icurval(kv_,fkos(acc_,fdat_,fdat_),fdat_)) /* кредит    по тек. курсу */
        into   rpo_
        from   dual;
      exception when OTHERS then
        rpo_ := 0;
      end;

      if rpo_<>0 then

        begin
          select nls,
                 trim(substr(nms,1,38))
          into   nlsb_,
                 namb_
          from   accounts
          where  nls like '6204%' and
                 kv=kv_           and
                 rownum<2;
        exception when no_data_found then
          nlsb_ := vkrzn(substr(amfo_,1,5),'62040000000000');
          begin
            select name
            into   namv_
            from   tabval
            where  kv=kv_;
          exception when no_data_found then
            namv_ := to_char(kv_);
          end;
          namb_ := 'Результат вiд переоцiнки '||namv_;
        end;

        nd_       := substr(TO_CHAR(systimestamp,'JSSSSSFF'),4,10);
        ref_      := to_number(nd_);
        tt_       := 'RVP';
        vdat_     := gl.bdate;
        pdat_     := gl.bdate;
        sk_       := null;
        mfob_     := amfo_;
        nazn_     := 'Списання курсової рiзницi';
--      dk_       := greatest(rpo_/abs(rpo_),0);
        dk_       := greatest(-rpo_/abs(rpo_),0);
--      vob_      := 9;
        vob_      := (case when amfo_='336503' then
                        9
                           when amfo_='313957' or amfo_='324805' then
                        1
                           else
                        5
                      end);
        pond_     := null;
        filename_ := null;
        nazns_    := null;
        bis_      := null;
        naznk_    := null;
--      d_rec_    := '#K'||to_char(rpo_)||'#';
        d_rec_    := '#K'||to_char(-rpo_)||'#';
        rec_      := null;
        datd_     := gl.bdate;
        datb1_    := gl.bdate;
        datb2_    := gl.bdate;
        datOV_    := sysdate;
        datbis_   := null;
        s_        := 0;
        fn_a_     := null;

        begin
          select val
          into   kokb_
          from   params$base
          where  par='OKPO';
        exception when no_data_found then
          kokb_ := '000000000';
        end;

        bars_audit.trace('p_licsbb: вставка в tmp_lics (5)');
        INSERT
        INTO   tmp_lics (id       ,  --id_
                         daopl    ,  --fdat_
                         acc      ,  --acc_
                         s        ,  --s_
                         nd       ,  --nd_
                         mfob     ,  --mfob_
                         nazn     ,  --nazn_
                         isp      ,  --isp_
                         nlsa     ,  --nls_
                         kv       ,  --kv_
                         nama     ,  --nms_
                         nlsb     ,  --nlsb_
                         namb     ,  --namb_
                         ref      ,  --ref_
                         tt       ,  --tt_
                         iost     ,  --ostf_
                         dos      ,  --dos_
                         kos      ,  --kos_
                         vdat     ,  --vdat_
                         pdat     ,  --pdat_
                         sk       ,  --sk_
                         dapp     ,  --nvl(dapp_,fdat_)
                         okpoa    ,  --koka_
                         okpob    ,  --kokb_
                         dk       ,  --dk_
                         vob      ,  --vob_
                         pond     ,  --pond_
                         namefilea,  --filename_
                         kodirowka,  --0
                         nazns    ,  --nazns_
                         bis      ,  --bis_
                         naznk    ,  --naznk_
                         d_rec    ,  --d_rec_
                         fn_a     ,  --fn_a_
                         rec      ,  --rec_
                         datd     ,  --datd_
                         datb1    ,  --nvl(datb1_,fdat_)
                         datb2    ,  --datb2_
                         datov    ,  --nvl(datOV_,fdat_)
                         datbis   ,  --datbis_
                         okpoz)      --okpoz_
                 VALUES (id_              ,
                         fdat_            ,
                         acc_             ,
                         s_               ,
                         nd_              ,
                         mfob_            ,
                         nazn_            ,
                         isp_             ,
                         nls_             ,
                         kv_              ,
                         nms_             ,
                         nlsb_            ,
                         namb_            ,
                         ref_             ,
                         tt_              ,
                         ostf_            ,
                         dos_             ,
                         kos_             ,
                         vdat_            ,
                         pdat_            ,
                         sk_              ,
                         nvl(dapp_,fdat_) ,
                         koka_            ,
                         kokb_            ,
                         dk_              ,
                         vob_             ,
                         pond_            ,
                         filename_        ,
                         0                ,
                         nazns_           ,
                         bis_             ,
                         naznk_           ,
                         d_rec_           ,
                         fn_a_            ,
                         rec_             ,
                         datd_            ,
                         nvl(datb1_,fdat_),
                         datb2_           ,
                         nvl(datOV_,fdat_),
                         datbis_          ,
                         okpoz_);
      end if;
    end if;

  END LOOP;
  CLOSE cur_;

--здесь добавить информационные документы

--select SUBSTR(f_comma('oper','to_char(ref)',
--                      'vdat=to_date('''||dt1_||''') and dk>1 and sos=5 and tt<>''МГР''',
--                      ''),1,32000)
--into   infref_
--from   dual;

--if infref_ is not null then

--из OPER

  sql_:='SELECT DISTINCT
                a.acc                                                      ,  --acc_
                o.vdat                                                     ,  --fdat_
                fost(a.acc,to_date('''||dt1_||''')-1)                      ,  --ostf_
                fdos(a.acc,to_date('''||dt1_||'''),to_date('''||dt1_||''')),  --dos_
                fkos(a.acc,to_date('''||dt1_||'''),to_date('''||dt1_||''')),  --kos_
                a.nls                                                      ,  --nls_
                a.kv                                                       ,  --kv_
                a.isp                                                      ,  --isp_
                trim(substr(a.nms,1,38))                                   ,  --nms_
                c.okpo                                                     ,  --koka_
                c.okpo                                                        --okpoz_
         FROM   oper     o,
                accounts a,
                customer c
         WHERE  o.ref in (select ref
                          from   oper
                          where  vdat=to_date('''||dt1_||''') and dk>1 and sos=5 and tt<>''МГР'')      and
                a.acc IN (SELECT acc FROM acc'||iif_s(vptype_,'C','e','c','e')||' WHERE nvl(pers,0)=1) and
                ((o.nlsa=a.nls and o.kv=a.kv and o.mfoa='''||amfo_||''' and o.sos=5 and o.dk>1) or
                 (o.nlsb=a.nls and o.kv=a.kv and o.mfob='''||amfo_||''' and o.sos=5 and o.dk>1))       and
                a.rnk=c.rnk                                                                            and
                c.sab='''||maskasab_||'''                                                              and
                c.stmt=5                                                           /* and a.kv=kvz_ */ and
                a.tip not in
                (''N99'',''L99'',''N00'',''T00'',''T0D'',''TNB'',''TND'',''TUR'',''TUD'',''L00'')
         union all
         SELECT DISTINCT
                a.acc                                                      ,
                o.vdat                                                     ,
                fost(a.acc,to_date('''||dt1_||''')-1)                      ,
                fdos(a.acc,to_date('''||dt1_||'''),to_date('''||dt1_||''')),
                fkos(a.acc,to_date('''||dt1_||'''),to_date('''||dt1_||''')),
                a.nls                                                      ,
                a.kv                                                       ,
                a.isp                                                      ,
                trim(substr(a.nms,1,38))                                   ,
                r.okpo                                                     ,
                g.okpo
         FROM   oper     o,
                accounts a,
                klp_top  c,
                customer r,
                customer g
         WHERE  o.ref in (select ref
                          from   oper
                          where  vdat=to_date('''||dt1_||''') and dk>1 and sos=5 and tt<>''МГР'')      and
                a.acc IN (SELECT acc FROM acc'||iif_s(vptype_,'C','e','c','e')||' WHERE nvl(high,0)=1) and
                ((o.nlsa=a.nls and o.kv=a.kv and o.mfoa='''||amfo_||''' and o.sos=5 and o.dk>1) or
                 (o.nlsb=a.nls and o.kv=a.kv and o.mfob='''||amfo_||''' and o.sos=5 and o.dk>1))       and
                a.rnk=c.rnk                                                                            and
                a.rnk=g.rnk                                                                            and
                r.sab='''||maskasab_||'''                                                              and
                r.stmt=5                                                                               and
                r.rnk=c.rnkp                                                       /* and a.kv=kvz_ */ and
                a.tip not in
                (''N99'',''L99'',''N00'',''T00'',''T0D'',''TNB'',''TND'',''TUR'',''TUD'',''L00'')';

  open cur_ for sql_;
  LOOP
    fetch cur_ into acc_  ,
                    fdat_ ,
                    ostf_ ,
                    dos_  ,
                    kos_  ,
                    nls_  ,
                    kv_   ,
                    isp_  ,
                    nms_  ,
                    koka_ ,
                    okpoz_;
    EXIT WHEN cur_%NOTFOUND;

    for k in (select *
              from   oper
              where  sos=5     and
                     dk>1      and
                     vdat=dt1_ and
                     ((mfoa=amfo_ and nlsa=nls_ and kv=kv_) or
                      (mfob=amfo_ and nlsb=nls_ and kv=kv_))
             )
    loop

      if vptype_='C' then
--      для файлов С только поступления
        if (k.dk=3 and k.nlsa=nls_ and k.kv=kv_) or
           (k.dk=2 and k.nlsb=nls_ and k.kv=kv_) then
          goto endloop; -- пропустить списания
        end if;

        begin
          insert
          into   klop_cref (ref,
                            sab)
                    values (k.ref,
                            maskasab_);
          bars_audit.trace('p_licsbb: !! новый инф. реф '||k.ref);
        exception when dup_val_on_index then
--        если референс уже отбирали - не отбирать и перейти к следующему
          bars_audit.trace('p_licsbb: инф. реф уже отбирался '||k.ref);
          goto endloop;
        end;
      end if;

      SELECT max(dat)
      INTO   datOV_
      FROM   oper_visa
      WHERE  ref=k.ref;

      if k.mfoa<>k.mfob then
        begin
          select dat_a,
                 dat_b
          into   data_,
                 datb_
          from   arc_rrp
          where  ref=k.ref and
                 bis<=1;
        exception when no_data_found then
          data_ := k.pdat;
          datb_ := k.pdat;
        end;
        if datOV_ is null then
          datOV_ := datb_;
        end if;
      else
        data_ := k.pdat;
        datb_ := k.pdat;
      end if;
      datb1_ := k.datp;
      if k.mfoa=amfo_ then
        if (k.dk=3 and k.nlsb=nls_ and k.kv=kv_) or
           (k.dk=2 and k.nlsa=nls_ and k.kv=kv_) then
          datb2_ := nvl(datb_,k.pdat);
        else
          datb2_ := nvl(data_,k.pdat);
        end if;
      else
        datb2_ := k.pdat;
      end if;

      if    k.dk=2 and k.nlsa=nls_ and k.kv=kv_ and k.mfoa=amfo_ then
        s_    := -k.s;
        nlsa_ := k.nlsa;
        mfob_ := k.mfob;
        nlsb_ := k.nlsb;
        namb_ := k.nam_b;
        kokb_ := k.id_b;
        koka_ := k.id_a;
      elsif k.dk=2 and k.nlsb=nls_ and k.kv=kv_ and k.mfob=amfo_ then
        s_    := k.s;
        nlsa_ := k.nlsb;
        mfob_ := k.mfoa;
        nlsb_ := k.nlsa;
        namb_ := k.nam_a;
        kokb_ := k.id_a;
        koka_ := k.id_b;
      elsif k.dk=3 and k.nlsa=nls_ and k.kv=kv_ and k.mfoa=amfo_ then
        s_    := k.s;
        nlsa_ := k.nlsa;
        mfob_ := k.mfob;
        nlsb_ := k.nlsb;
        namb_ := k.nam_b;
        kokb_ := k.id_b;
        koka_ := k.id_a;
      elsif k.dk=3 and k.nlsb=nls_ and k.kv=kv_ and k.mfob=amfo_ then
        s_    := -k.s;
        nlsa_ := k.nlsb;
        mfob_ := k.mfoa;
        nlsb_ := k.nlsa;
        namb_ := k.nam_a;
        kokb_ := k.id_a;
        koka_ := k.id_b;
      end if;

      begin
        select nazns                                   ,
               bis                                     ,
               naznk                                   ,
               convert(d_rec,'RU8PC866','CL8MSWIN1251'),
               nvl(fn_a,fn_b)                          ,
               rec                                     ,
               dat_a
        into   nazns_,
               bis_  ,
               naznk_,
               d_rec_,
               fn_a_ ,
               rec_  ,
               datbis_
        from   arc_rrp
        where  ref=k.ref and
               bis<=1;
      exception when no_data_found then
        nazns_  := '';
        bis_    := null;
        naznk_  := '';
        d_rec_  := '';
        fn_a_   := '';
        rec_    := null;
        datbis_ := null;
      end;

      bars_audit.trace('p_licsbb: вставка в tmp_lics (7)');
      INSERT
      INTO   tmp_lics (id       ,  --id_
                       daopl    ,  --dt1_
                       acc      ,  --acc_
                       s        ,  --s_
                       nd       ,  --k.nd
                       mfob     ,  --mfob_
                       nazn     ,  --k.nazn
                       isp      ,  --isp_
                       nlsa     ,  --nlsa_
                       kv       ,  --kv_
                       nama     ,  --nms_
                       nlsb     ,  --nlsb_
                       namb     ,  --namb_
                       ref      ,  --k.ref
                       tt       ,  --k.tt
                       iost     ,  --ostf_
                       dos      ,  --dos_
                       kos      ,  --kos_
                       vdat     ,  --k.vdat
                       pdat     ,  --k.pdat
                       sk       ,  --k.sk
                       dapp     ,  --dt1_
                       okpoa    ,  --koka_
                       okpob    ,  --kokb_
                       dk       ,  --1 --3
                       vob      ,  --7 --k.vob
                       pond     ,  --null
                       namefilea,  --null
                       kodirowka,  --0
                       nazns    ,  --nazns_             (arc_rrp)
                       bis      ,  --bis_               (arc_rrp)
                       naznk    ,  --naznk_             (arc_rrp)
                       d_rec    ,  --d_rec_             (arc_rrp)
                       fn_a     ,  --fn_a_              (arc_rrp)
                       rec      ,  --rec_               (arc_rrp)
                       datd     ,  --k.datd
                       datb1    ,  --nvl(datb1_,fdat_)
                       datb2    ,  --datb2_
                       datov    ,  --nvl(datOV_,fdat_)
                       datbis   ,  --datbis_            (arc_rrp)
                       okpoz)      --okpoz_
               VALUES (id_              ,
                       dt1_             ,
                       acc_             ,
                       s_               ,
                       k.nd             ,
                       mfob_            ,
                       k.nazn           ,
                       isp_             ,
                       nlsa_            ,
                       kv_              ,
                       nms_             ,
                       nlsb_            ,
                       namb_            ,
                       k.ref            ,
                       k.tt             ,
                       ostf_            ,
                       dos_             ,
                       kos_             ,
                       k.vdat           ,
                       k.pdat           ,
                       k.sk             ,
                       dt1_             ,
                       koka_            ,
                       kokb_            ,
                       1  /* 3 */       ,
                       7  /* k.vob */   ,
                       null             ,
                       null             ,
                       0                ,
                       nazns_           ,
                       bis_             ,
                       naznk_           ,
                       d_rec_           ,
                       fn_a_            ,
                       rec_             ,
                       k.datd           ,
                       nvl(datb1_,fdat_),
                       datb2_           ,
                       nvl(datOV_,fdat_),
                       datbis_          ,
                       okpoz_);

<<endloop>> null;

    end loop;

  END LOOP;
  CLOSE cur_;

--из ARC_RRP

  sql_:='SELECT DISTINCT
                a.acc                                                      ,  --acc_
                trunc(o.dat_a)                                             ,  --fdat_
                fost(a.acc,to_date('''||dt1_||''')-1)                      ,  --ostf_
                fdos(a.acc,to_date('''||dt1_||'''),to_date('''||dt1_||''')),  --dos_
                fkos(a.acc,to_date('''||dt1_||'''),to_date('''||dt1_||''')),  --kos_
                a.nls                                                      ,  --nls_
                a.kv                                                       ,  --kv_
                a.isp                                                      ,  --isp_
                trim(substr(a.nms,1,38))                                   ,  --nms_
                c.okpo                                                     ,  --koka_
                c.okpo                                                        --okpoz_
         FROM   arc_rrp  o,
                accounts a,
                customer c
         WHERE  o.ref is null                                                                          and
                o.sos>=5                                                                               and
                o.s>0                                                                                  and
                o.nlsb=a.nls                                                                           and
                o.kv=a.kv                                                                              and
                o.mfob='''||amfo_||'''                                                                 and
                o.dk>1                                                                                 and
--              trunc(o.dat_a)=to_date('''||dt1_||''')                                                 and
                o.dat_a between to_date('''||dt1_||''') and to_date('''||dt1_||''')+0.99999            and
                a.acc IN (SELECT acc FROM acc'||iif_s(vptype_,'C','e','c','e')||' WHERE nvl(pers,0)=1) and
                a.rnk=c.rnk                                                                            and
                c.sab='''||maskasab_||'''                                                              and
                c.stmt=5                                                           /* and a.kv=kvz_ */ and
                a.tip not in
                (''N99'',''L99'',''N00'',''T00'',''T0D'',''TNB'',''TND'',''TUR'',''TUD'',''L00'')
         union all
         SELECT DISTINCT
                a.acc                                                      ,
                trunc(o.dat_a)                                             ,
                fost(a.acc,to_date('''||dt1_||''')-1)                      ,
                fdos(a.acc,to_date('''||dt1_||'''),to_date('''||dt1_||''')),
                fkos(a.acc,to_date('''||dt1_||'''),to_date('''||dt1_||''')),
                a.nls                                                      ,
                a.kv                                                       ,
                a.isp                                                      ,
                trim(substr(a.nms,1,38))                                   ,
                r.okpo                                                     ,
                g.okpo
         FROM   arc_rrp  o,
                accounts a,
                klp_top  c,
                customer r,
                customer g
         WHERE  o.ref is null                                                                          and
                o.sos>=5                                                                               and
                o.s>0                                                                                  and
                o.nlsb=a.nls                                                                           and
                o.kv=a.kv                                                                              and
                o.mfob='''||amfo_||'''                                                                 and
                o.dk>1                                                                                 and
--              trunc(o.dat_a)=to_date('''||dt1_||''')                                                 and
                o.dat_a between to_date('''||dt1_||''') and to_date('''||dt1_||''')+0.99999            and
                a.acc IN (SELECT acc FROM acc'||iif_s(vptype_,'C','e','c','e')||' WHERE nvl(high,0)=1) and
                a.rnk=c.rnk                                                                            and
                a.rnk=g.rnk                                                                            and
                r.sab='''||maskasab_||'''                                                              and
                r.stmt=5                                                                               and
                r.rnk=c.rnkp                                                       /* and a.kv=kvz_ */ and
                a.tip not in
                (''N99'',''L99'',''N00'',''T00'',''T0D'',''TNB'',''TND'',''TUR'',''TUD'',''L00'')';

  open cur_ for sql_;
  LOOP
    fetch cur_ into acc_  ,
                    fdat_ ,
                    ostf_ ,
                    dos_  ,
                    kos_  ,
                    nls_  ,
                    kv_   ,
                    isp_  ,
                    nms_  ,
                    koka_ ,
                    okpoz_;
    EXIT WHEN cur_%NOTFOUND;

    for k in (select *
              from   arc_rrp
              where  sos>=5      and
                     dk>1        and
                     s>0         and
                     mfob=amfo_  and
                     nlsb=nls_   and
                     kv=kv_      and
                     ref is null and
--                   trunc(dat_a)=dt1_)
                     dat_a between dt1_ and dt1_+0.99999)
    loop

      if vptype_='C' then
--      для файлов С только поступления
        if k.dk=2 then
          goto endlooa; -- пропустить списания
        end if;

        begin
          insert
          into   klop_cref (ref,
                            sab)
                    values (9000000000000000+k.rec,
                            maskasab_);
          bars_audit.trace('p_licsbb: !! новый инф. реф '||k.ref);
        exception when dup_val_on_index then
--        если референс уже отбирали - не отбирать и перейти к следующему
          bars_audit.trace('p_licsbb: инф. реф уже отбирался '||k.ref);
          goto endlooa;
        end;
      end if;

      datOV_  := null;

      data_   := trunc(k.dat_a);
      datb_   := trunc(k.dat_a);
      datb1_  := k.datp;
      datb2_  := trunc(k.dat_a);

      nlsa_   := k.nlsb;
      mfob_   := k.mfoa;
      nlsb_   := k.nlsa;
      namb_   := k.nam_a;
      kokb_   := k.id_a;
      koka_   := k.id_b;

      if      k.dk=2 then
        s_    := k.s;
      else -- k.dk=3
        s_    := -k.s;
      end if;

      nazns_  := '';
      bis_    := null;
      naznk_  := '';
      d_rec_  := '';
      fn_a_   := '';
      rec_    := null;
      datbis_ := null;

      bars_audit.trace('p_licsbb: вставка в tmp_lics (8)');
      INSERT
      INTO   tmp_lics (id       ,  --id_
                       daopl    ,  --dt1_
                       acc      ,  --acc_
                       s        ,  --s_
                       nd       ,  --k.nd
                       mfob     ,  --mfob_
                       nazn     ,  --k.nazn
                       isp      ,  --isp_
                       nlsa     ,  --nlsa_
                       kv       ,  --kv_
                       nama     ,  --nms_
                       nlsb     ,  --nlsb_
                       namb     ,  --namb_
                       ref      ,  --k.ref
                       tt       ,  --k.tt
                       iost     ,  --ostf_
                       dos      ,  --dos_
                       kos      ,  --kos_
                       vdat     ,  --k.vdat
                       pdat     ,  --k.pdat
                       sk       ,  --k.sk
                       dapp     ,  --dt1_
                       okpoa    ,  --koka_
                       okpob    ,  --kokb_
                       dk       ,  --1 --3
                       vob      ,  --7 --k.vob
                       pond     ,  --null
                       namefilea,  --null
                       kodirowka,  --0
                       nazns    ,  --nazns_             (arc_rrp)
                       bis      ,  --bis_               (arc_rrp)
                       naznk    ,  --naznk_             (arc_rrp)
                       d_rec    ,  --d_rec_             (arc_rrp)
                       fn_a     ,  --fn_a_              (arc_rrp)
                       rec      ,  --rec_               (arc_rrp)
                       datd     ,  --k.datd
                       datb1    ,  --nvl(datb1_,fdat_)
                       datb2    ,  --datb2_
                       datov    ,  --nvl(datOV_,fdat_)
                       datbis   ,  --datbis_            (arc_rrp)
                       okpoz)      --okpoz_
               VALUES (id_                   ,
                       dt1_                  ,
                       acc_                  ,
                       s_                    ,
                       k.nd                  ,
                       mfob_                 ,
                       k.nazn                ,
                       isp_                  ,
                       nlsa_                 ,
                       kv_                   ,
                       nms_                  ,
                       nlsb_                 ,
                       namb_                 ,
                       9000000000000000+k.rec,
                       'АРК'                 ,
                       ostf_                 ,
                       dos_                  ,
                       kos_                  ,
                       trunc(k.dat_a)        ,
                       trunc(k.dat_a)        ,
                       null                  ,
                       dt1_                  ,
                       koka_                 ,
                       kokb_                 ,
                       1  /* 3 */            ,
                       7  /* k.vob */        ,
                       null                  ,
                       null                  ,
                       0                     ,
                       nazns_                ,
                       bis_                  ,
                       naznk_                ,
                       d_rec_                ,
                       fn_a_                 ,
                       rec_                  ,
                       k.datd                ,
                       nvl(datb1_,fdat_)     ,
                       datb2_                ,
                       nvl(datOV_,fdat_)     ,
                       datbis_               ,
                       okpoz_);

<<endlooa>> null;

    end loop;

  END LOOP;
  CLOSE cur_;

--end if;

--добавка счетов без оборотов
  if vptype_<>'C' then
    FOR k IN (SELECT a.acc                        ,
                     dt1_ fdat                    ,
                     fost(a.acc,dt1_-1)       ostf,
                     0 dos                        ,
                     0 kos                        ,
                     a.nls                        ,
                     a.kv                         ,
                     a.dapp pdat                  ,
                     a.isp                        ,
                     trim(substr(a.nms,1,38)) nms ,
                     c.okpo
              FROM   accounts a,
                     customer c
              WHERE  a.acc IN (SELECT acc FROM acce WHERE nvl(pers,0)=1)                        and
                     a.rnk=c.rnk                                                                and
                     c.sab=maskasab_                                                            and
                     c.stmt=5                                               /* and a.kv=kvz_ */ and
                     a.nls like maskanls_                                                       and
                     a.tip not in ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00') and
                     a.acc not in (SELECT acc
                                   FROM   saldoa
                                   WHERE  fdat=dt1_ and
                                          dos+kos>0)
        union all
              SELECT a.acc                        ,
                     dt1_ fdat                    ,
                     fost(a.acc,dt1_-1)       ostf,
                     0 dos                        ,
                     0 kos                        ,
                     a.nls                        ,
                     a.kv                         ,
                     a.dapp pdat                  ,
                     a.isp                        ,
                     trim(substr(a.nms,1,38)) nms ,
                     g.okpo
              FROM   accounts a,
                     klp_top  c,
                     customer r,
                     customer g
              WHERE  a.acc IN (SELECT acc FROM acce WHERE nvl(high,0)=1)                        and
                     a.rnk=c.rnk                                                                and
                     a.rnk=g.rnk                                                                and
                     r.sab=maskasab_                                                            and
                     r.stmt=5                                                                   and
                     r.rnk=c.rnkp                                           /* and a.kv=kvz_ */ and
                     a.nls like maskanls_                                                       and
                     a.tip not in ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00') and
                     a.acc not in (SELECT acc
                                   FROM   saldoa
                                   WHERE  fdat=dt1_ and
                                          dos+kos>0)
             )
    LOOP
      bars_audit.trace('p_licsbb: вставка в tmp_lics (3)');
      INSERT
      INTO   tmp_lics (id       ,  --id_
                       daopl    ,  --k.fdat
                       acc      ,  --k.acc
                       s        ,  --0
                       nd       ,  --null
                       mfob     ,  --null
                       nazn     ,  --null
                       isp      ,  --k.isp
                       nlsa     ,  --k.nls
                       kv       ,  --k.kv
                       nama     ,  --k.nms
                       nlsb     ,  --null
                       namb     ,  --null
                       ref      ,  --null
                       tt       ,  --null
                       iost     ,  --k.ostf
                       dos      ,  --k.dos
                       kos      ,  --k.kos
                       vdat     ,  --null
                       pdat     ,  --null
                       sk       ,  --null
                       dapp     ,  --k.pdat
                       okpoa    ,  --k.okpo
                       okpob    ,  --null
                       dk       ,  --null
                       vob      ,  --0
                       pond     ,  --null
                       namefilea,  --null
                       kodirowka,  --0
                       okpoz)      --k.okpo
               VALUES (id_   ,
                       k.fdat,
                       k.acc ,
                       0     ,
                       null  ,
                       null  ,
                       null  ,
                       k.isp ,
                       k.nls ,
                       k.kv  ,
                       k.nms ,
                       null  ,
                       null  ,
                       null  ,
                       null  ,
                       k.ostf,
                       k.dos ,
                       k.kos ,
                       null  ,
                       null  ,
                       null  ,
                       k.pdat,
                       k.okpo,
                       null  ,
                       null  ,
                       0     ,
                       null  ,
                       null  ,
                       0     ,
                       k.okpo);

--    bars_audit.info('p_licsbb: (6) k.acc='||k.acc||', k.kv='||k.kv||', k.fdat='||k.fdat);
      if skr_='1' and (vptype_='Z' or vptype_='V') and k.kv<>980 and
         (amfo_='336503' or amfo_='313957' or amfo_='324805') then
--               Ивано-Франковск,  Запорожье,        Крым
--      техническая запись/документ - результат переоценки валютных счетов (Шарадов)
        begin
          select gl.p_icurval(k.kv,fost(k.acc,k.fdat),k.fdat)-         /* исх. ост. по тек. курсу */
                 (gl.p_icurval(k.kv,fost(k.acc,k.fdat-1),k.fdat-1)-    /* вх. ост. по пред. курсу */
                  gl.p_icurval(k.kv,fdos(k.acc,k.fdat,k.fdat),k.fdat)+ /* дебет     по тек. курсу */
                  gl.p_icurval(k.kv,fkos(k.acc,k.fdat,k.fdat),k.fdat)) /* кредит    по тек. курсу */
          into   rpo_
          from   dual;
        exception when OTHERS then
          rpo_ := 0;
        end;

        if rpo_<>0 then

          begin
            select nls,
                   trim(substr(nms,1,38))
            into   nlsb_,
                   namb_
            from   accounts
            where  nls like '6204%' and
                   kv=k.kv          and
                   rownum<2;
          exception when no_data_found then
            nlsb_ := vkrzn(substr(amfo_,1,5),'62040000000000');
            begin
              select name
              into   namv_
              from   tabval
              where  kv=k.kv;
            exception when no_data_found then
              namv_ := to_char(k.kv);
            end;
            namb_ := 'Результат вiд переоцiнки '||namv_;
          end;

          nd_       := substr(TO_CHAR(systimestamp,'JSSSSSFF'),4,10);
          ref_      := to_number(nd_);
          tt_       := 'RVP';
          vdat_     := gl.bdate;
          pdat_     := gl.bdate;
          sk_       := null;
          mfob_     := amfo_;
          nazn_     := 'Списання курсової рiзницi';
--        dk_       := greatest(rpo_/abs(rpo_),0);
          dk_       := greatest(-rpo_/abs(rpo_),0);
--        vob_      := 9;
          vob_      := (case when amfo_='336503' then
                          9
                             when amfo_='313957' or amfo_='324805' then
                          1
                             else
                          5
                        end);
          pond_     := null;
          filename_ := null;
          nazns_    := null;
          bis_      := null;
          naznk_    := null;
--        d_rec_    := '#K'||to_char(rpo_)||'#';
          d_rec_    := '#K'||to_char(-rpo_)||'#';
          rec_      := null;
          datd_     := gl.bdate;
          datb1_    := gl.bdate;
          datb2_    := gl.bdate;
          datOV_    := sysdate;
          datbis_   := null;
          s_        := 0;
          fn_a_     := null;

          begin
            select val
            into   kokb_
            from   params$base
            where  par='OKPO';
          exception when no_data_found then
            kokb_ := '000000000';
          end;

          bars_audit.trace('p_licsbb: вставка в tmp_lics (6)');
          INSERT
          INTO   tmp_lics (id       ,  --id_
                           daopl    ,  --k.fdat
                           acc      ,  --k.acc
                           s        ,  --s_
                           nd       ,  --nd_
                           mfob     ,  --mfob_
                           nazn     ,  --nazn_
                           isp      ,  --k.isp
                           nlsa     ,  --k.nls
                           kv       ,  --k.kv
                           nama     ,  --k.nms
                           nlsb     ,  --nlsb_
                           namb     ,  --namb_
                           ref      ,  --ref_
                           tt       ,  --tt_
                           iost     ,  --k.ostf
                           dos      ,  --k.dos
                           kos      ,  --k.kos
                           vdat     ,  --vdat_
                           pdat     ,  --pdat_
                           sk       ,  --sk_
                           dapp     ,  --nvl(k.pdat,k.fdat)
                           okpoa    ,  --k.okpo
                           okpob    ,  --kokb_
                           dk       ,  --dk_
                           vob      ,  --vob_
                           pond     ,  --pond_
                           namefilea,  --filename_
                           kodirowka,  --0
                           nazns    ,  --nazns_
                           bis      ,  --bis_
                           naznk    ,  --naznk_
                           d_rec    ,  --d_rec_
                           fn_a     ,  --fn_a_
                           rec      ,  --rec_
                           datd     ,  --datd_
                           datb1    ,  --nvl(datb1_,k.fdat)
                           datb2    ,  --datb2_
                           datov    ,  --nvl(datOV_,k.fdat)
                           datbis   ,  --datbis_
                           okpoz)      --k.okpo
                   VALUES (id_               ,
                           k.fdat            ,
                           k.acc             ,
                           s_                ,
                           nd_               ,
                           mfob_             ,
                           nazn_             ,
                           k.isp             ,
                           k.nls             ,
                           k.kv              ,
                           k.nms             ,
                           nlsb_             ,
                           namb_             ,
                           ref_              ,
                           tt_               ,
                           k.ostf            ,
                           k.dos             ,
                           k.kos             ,
                           vdat_             ,
                           pdat_             ,
                           sk_               ,
                           nvl(k.pdat,k.fdat),
                           k.okpo            ,
                           kokb_             ,
                           dk_               ,
                           vob_              ,
                           pond_             ,
                           filename_         ,
                           0                 ,
                           nazns_            ,
                           bis_              ,
                           naznk_            ,
                           d_rec_            ,
                           fn_a_             ,
                           rec_              ,
                           datd_             ,
                           nvl(datb1_,k.fdat),
                           datb2_            ,
                           nvl(datOV_,k.fdat),
                           datbis_           ,
                           k.okpo);
        end if;
      end if;

    END LOOP;
  end if;

--добавка поступлений из KLPOOW
  if vptype_='C' then
--  FOR k IN (SELECT mfoa,
--                   nlsa,
--                   mfob,
--                   nlsb,
--                   namb,
--                   s   ,
--                   nd  ,
--                   nazn,
--                   to_number(nfia) ref
--            from   klpoow
--            where  sab=maskasab_ and
--                   tip='O'       and
----                 otm is null   and
--                   otm='R'       and
--                   pond is null  and
--                   to_number(nfia) not in (SELECT ref
--                                           FROM   tmp_lics
--                                           WHERE  id=id_))
    FOR k IN (SELECT mfoa,
                     nlsa,
                     mfob,
                     nlsb,
                     namb,
                     s   ,
                     nd  ,
                     nazn,
                     to_number(nfia) ref
              from   klpoow
              where  sab=maskasab_ and
                     tip='O'       and
                     otm='R'       and
                     pond is null)

    loop

      begin
        select s
        into   s_
        FROM   tmp_lics
        WHERE  id=id_ and
               ref=k.ref;
      exception when no_data_found then

        nonot_ := 0;

        begin
          select distinct fdat
          into   fdat_
          from   opldok
          where  ref=k.ref and
                 rownum=1;
        exception when no_data_found then
--        begin
--          delete
--          from   klpoow
--          where  to_number(nfia)=k.ref;
--        exception when OTHERS then
--          null;
--        end;
          goto maybeback;
        end;

        begin
          select a.acc                   ,
                 a.isp                   ,
                 a.kv                    ,
                 trim(substr(a.nms,1,38)),
                 o.tt                    ,
                 a.ostc                  ,
                 a.dos                   ,
                 a.kos                   ,
                 a.dapp                  ,
                 o.sk                    ,
                 c.okpo                  ,
                 o.vob                   ,
                 o.datd                  ,
                 o.dk                    ,
                 o.id_b                  ,
--               (1-2*o.dk)*k.s
                 decode(o.dk,0,1,1,-1,2,1,-1)*k.s
          into   acc_ ,
                 isp_ ,
                 kv_  ,
                 nms_ ,
                 tt_  ,
                 ostc_,
                 dos_ ,
                 kos_ ,
                 dapp_,
                 sk_  ,
                 okpo_,
                 vob_ ,
                 datd_,
                 dk_  ,
                 kokb_,
                 s_
          from   accounts a,
                 oper     o,
                 customer c
          where  o.ref=k.ref   and
                 o.nlsa=k.nlsa and
                 a.nls=k.nlsa  and
                 a.kv=o.kv     and
                 c.rnk=a.rnk;
        exception when no_data_found then
          begin
            select a.acc                   ,
                   a.isp                   ,
                   a.kv                    ,
                   trim(substr(a.nms,1,38)),
                   o.tt                    ,
                   a.ostc                  ,
                   a.dos                   ,
                   a.kos                   ,
                   a.dapp                  ,
                   o.sk                    ,
                   c.okpo                  ,
                   o.vob                   ,
                   o.datd                  ,
                   1-o.dk                  ,
                   o.id_a                  ,
--                 (2*o.dk-1)*k.s
                   decode(o.dk,0,-1,1,1,2,-1,1)*k.s
            into   acc_ ,
                   isp_ ,
                   kv_  ,
                   nms_ ,
                   tt_  ,
                   ostc_,
                   dos_ ,
                   kos_ ,
                   dapp_,
                   sk_  ,
                   okpo_,
                   vob_ ,
                   datd_,
                   dk_  ,
                   kokb_,
                   s_
            from   accounts a,
                   oper     o,
                   customer c
            where  o.ref=k.ref   and
                   o.nlsb=k.nlsa and
                   a.nls=k.nlsa  and
                   a.kv=o.kv     and
                   c.rnk=a.rnk;
          exception when no_data_found then

--          в этом случае "лезем" в OPLDOK

            begin
              select a.acc                   ,
                     a.isp                   ,
                     a.kv                    ,
                     trim(substr(a.nms,1,38)),
                     p.tt                    ,
                     a.ostc                  ,
                     a.dos                   ,
                     a.kos                   ,
                     a.dapp                  ,
                     o.sk                    ,
                     c.okpo                  ,
                     o.vob                   ,
                     o.datd                  ,
                     p.dk                    ,
                     o.id_b                  ,
                     decode(p.dk,0,-1,1)*k.s
              into   acc_ ,
                     isp_ ,
                     kv_  ,
                     nms_ ,
                     tt_  ,
                     ostc_,
                     dos_ ,
                     kos_ ,
                     dapp_,
                     sk_  ,
                     okpo_,
                     vob_ ,
                     datd_,
                     dk_  ,
                     kokb_,
                     s_
              from   accounts a,
                     oper     o,
                     opldok   p,
                     customer c
              where  o.ref=k.ref  and
                     a.nls=k.nlsa and
                     a.kv=o.kv    and
                     p.acc=a.acc  and
                     p.ref=k.ref  and
                     c.rnk=a.rnk;

            exception when no_data_found then
              bars_audit.trace('p_licsbb: (NOT) такого не должно быть: ref='||k.ref);
              nonot_ := 1;
            end;
          end;
        end;

        if nonot_=0 then

          begin
            SELECT max(dat)
            INTO   datOV_
            FROM   oper_visa
            WHERE  ref=k.ref and
                   status<3;
          exception when no_data_found then
            datOV_ := fdat_;
          end;

--        if dk_=1 then \
--          s_ := -k.s;  |
--        else            >-- это неправильная белиберда, правильно написал выше!
--          s_ := k.s;   |
--        end if;       /

          bars_audit.trace('p_licsbb: вставка в tmp_lics (4)');
          INSERT
          INTO   tmp_lics (id       ,  --id_
                           daopl    ,  --fdat_
                           acc      ,  --acc_
                           s        ,  --s_
                           nd       ,  --k.nd
                           mfob     ,  --k.mfob
                           nazn     ,  --k.nazn
                           isp      ,  --isp_
                           nlsa     ,  --k.nlsa
                           kv       ,  --kv_
                           nama     ,  --nms_
                           nlsb     ,  --k.nlsb
                           namb     ,  --k.namb
                           ref      ,  --k.ref
                           tt       ,  --tt_
                           iost     ,  --ostc_
                           dos      ,  --dos_
                           kos      ,  --kos_
                           vdat     ,  --fdat_
                           pdat     ,  --fdat_
                           sk       ,  --sk_
                           dapp     ,  --fdat_
                           okpoa    ,  --okpo_
                           okpob    ,  --kokb_
                           dk       ,  --1
                           vob      ,  --vob_
                           pond     ,  --null
                           namefilea,  --null
                           kodirowka,  --0
                           datd     ,  --datd_
                           datb1    ,  --nvl(datOV_,fdat_)
                           datb2    ,  --nvl(datOV_,fdat_)
                           datov    ,  --nvl(datOV_,fdat_))
                           okpoz)      --okpoz_
                   VALUES (id_              ,
                           fdat_            ,
                           acc_             ,
                           s_               ,
                           k.nd             ,
                           k.mfob           ,
                           k.nazn           ,
                           isp_             ,
                           k.nlsa           ,
                           kv_              ,
                           nms_             ,
                           k.nlsb           ,
                           k.namb           ,
                           k.ref            ,
                           tt_              ,
                           ostc_            ,
                           dos_             ,
                           kos_             ,
                           fdat_            ,
                           fdat_            ,
                           sk_              ,
                           fdat_            ,
                           okpo_            ,
                           kokb_            ,
                           1                ,
                           vob_             ,
                           null             ,
                           null             ,
                           0                ,
                           datd_            ,
                           nvl(datOV_,fdat_),
                           nvl(datOV_,fdat_),
                           nvl(datOV_,fdat_),
                           okpoz_);
        end if;
      end;

<<maybeback>> null;

--    update klpoow
--    set    otm='1'
--    where  nfia=to_char(k.ref);

      update klpoow
      set    otm='1'
      where  nfia=to_char(k.ref) and
             sab=maskasab_       and
             otm='R'             and
             tip='O'             and
             pond is null        and
             mfoa=k.mfoa         and
             nlsa=k.nlsa         and
             mfob=k.mfob         and
             nlsb=k.nlsb         and
             namb=k.namb         and
             s=k.s               and
             nd=k.nd             and
             nazn=k.nazn;

    end loop;

  end if;

END p_licsbb;
/
show err;

PROMPT *** Create  grants  P_LICSBB ***
grant EXECUTE                                                                on P_LICSBB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_LICSBB        to OPERKKK;
grant EXECUTE                                                                on P_LICSBB        to TECH_MOM1;
grant EXECUTE                                                                on P_LICSBB        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LICSBB.sql =========*** End *** 
PROMPT ===================================================================================== 
