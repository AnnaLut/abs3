
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sk_test.sql =========*** 
 PROMPT ===================================================================================== 
 
 create or replace package SK_TEST is

  title              CONSTANT VARCHAR2 (19) := 'sk_test:';

  TYPE t_cursor IS REF CURSOR;

  g_header_version   CONSTANT VARCHAR2 (64) := 'version 1.01 06.06.2018';

  function header_version
      return varchar2;

  function body_version
      return varchar2;
      
  procedure init ;
  function get_tvbv return char;
  function get_flag_name return number;
  procedure new_load_file (p_filename in varchar2,  p_filebody in blob) ;
  procedure new_sk_create_dptASIM;

  procedure new_create_dptASIM_ (p_tvbv in  char    ,
                                 p_open out number  ,
                                 p_code out number  ,
                                 p_errmask  varchar2,
                                 p_dasvox   date);
  procedure new_sk_load_IM4KOTL2S;
  procedure new_load_IM4KOTL2S      (p_tvbv in  char    ,
                                 p_open out number  ,
                                 p_code out number  ,
                                 p_errmask  varchar2,
                                 p_dasvox   date);

  procedure new_sk_drop_IM4KOTL2S;

  procedure new_drop_IM4KOTL2S      (p_tvbv in  char    ,
                                 p_open out number  ,
                                 p_code out number  ,
                                 p_errmask  varchar2,
                                 p_dasvox   date);

  procedure new_sk_drop_deposASIM;

  procedure new_drop_deposASIM      (p_tvbv in  char    ,
                                 p_open out number  ,
                                 p_code out number  ,
                                 p_errmask  varchar2,
                                 p_dasvox   date);

end SK_TEST;
/
create or replace package body SK_TEST is
  g_body_version   CONSTANT VARCHAR2 (64) := 'version 1.01 06.06.2018';
  
  function body_version
      return varchar2
   is
   begin
      return 'Package body sk_test ' || g_body_version;
  end body_version;

  function header_version
      return varchar2
   is
   begin
      return 'Package body sk_test' || g_body_version;
  end header_version;
   
  function get_flag_name return number
  is
    val number;
  begin
    select max(p.pasteid) into val from P_MIGRAASIMM p;
        return val;
  end get_flag_name;

  function get_tvbv return char
  is
    val char(3);
    num_load number :=get_flag_name();
  begin
    select max(imp.tvbv) into val from bars.imp_asvo imp  where imp.nnomer = num_load  ;
        return val;
  end get_tvbv;

procedure init
is
r varchar2(255);
num number;
  p_num_ins number;
  p_num_ins2 varchar2(255);
  a varchar2(255);
begin
  select bars.imp_asvo_init.nextval into p_num_ins from dual;
  --select BARS.imp_asvo_load.nextval into num from dual;
  r:=SUBSTR(pul.Get_Mas_Ini_Val('FFF'),1,3);
  pul.Set_Mas_Ini('FFF',val_ => get_tvbv(),comm_ => 'ТВБВ в АСВО');
 -- update P_MIGRAASIMM pm set pm.date_begin=sysdate,pm.prov_sql=r where pm.n = 1;
 ----------------------------------------------------------
 -- Ініціалізація для параметру вставки файлів
 -- dbms_output.put_line(sys_context('sk_cont','IMP_NEW_FILE22'));
 ----------------------------------------------------------
 update P_MIGRAASIMM pm set pm.date_begin='',pm.date_end='',pm.done=num,pm.err='0',pm.pasteid=p_num_ins;
end init;
 
 procedure new_load_file(p_filename in varchar2,  p_filebody in blob)
 is
  check_file_name number;
  p_table_name  varchar2(255);
  check_done number;
  p_num_ins number;
  begin
  -- Початок завантаження
  update P_MIGRAASIMM pm set pm.date_begin=sysdate where pm.n = 1;
  p_num_ins:=get_flag_name();

  select count(*)
    into check_file_name
    from (select p_filename sr from dual) p
   where regexp_like(p.sr, 'FD(((EP0)[0-9]{3}+$)|((PI0)[0-9]{3}+$))');
  -- Перевірка імені файла за зразком
  if check_file_name = 0 then
       bars_audit.error('create_tblASIM - err' ||
                             'Назва файлу('        ||p_filename || ') не відповідає FDEP0***.DBF або FPI0***.DBF '||
                             'Дата завантаження'  || sysdate
                       );
  end if;
  -- Визначаємо в яку таблицю будемо проводити заливку
  select case substr(p_filename, 0, 5)
           when 'FDPI0' then
            'TMP_SK_ASVO_FDPI'
           else
            'TMP_SK_ASVO_FDEP'
         end
    into p_table_name
    from dual;
  -- Завантажуємо файли
  insert into bars.imp_asvo (nd, filename, nnomer,TVBV,doneby,file_blob)
       values (bars.imp_asvo_load.nextval,p_filename,p_num_ins,substr(p_filename,6),sys_context('bars_global', 'user_id'),p_filebody);
  -- Вивантажуємо з dbf до таблиці
   begin
   bars.bars_dbf.load_dbf(p_filebody,
                          p_table_name,
                          3
                         );

   if substr(p_filename, 0, 5) = 'FDPI0' then
      insert into SK_ASVO_FDPI(branch,acc_card, mark ,datprc,prc,num_load)
      select branch,acc_card, mark ,datprc,prc,p_num_ins from TMP_SK_ASVO_FDPI;
   else
      insert into SK_ASVO_FDEP(FIO, IDCODE, DOCTYPE, PASP_S, PASP_N, PASP_W, PASP_D, BIRTHDAT, BIRTHPL, SEX, POSTIDX, REGION, DISTRICT, CITY, ADDRESS, PHONE_H, PHONE_J, LANDCOD, REGDATE, DEPCODE, DEPVIDNAME, ACC_CARD, DEPNAME, NLS, ID, DATO, OST, SUM, DATN, ATTR, MARK, VER, KOD_OTD, BRANCH, BSD, OB22DE, BSN, OB22IE, BSD7, OB22D7, NUM_LOAD)
      select FIO, IDCODE, DOCTYPE, PASP_S, PASP_N, PASP_W, PASP_D, BIRTHDAT, BIRTHPL, SEX, POSTIDX, REGION, DISTRICT, CITY, ADDRESS, PHONE_H, PHONE_J, LANDCOD, REGDATE, DEPCODE, DEPVIDNAME, ACC_CARD, DEPNAME, NLS, ID, DATO, OST, SUM, DATN, ATTR, MARK, VER, KOD_OTD, BRANCH, BSD, OB22DE, BSN, OB22IE, BSD7, OB22D7,p_num_ins
        from TMP_SK_ASVO_FDEP;
   end if;

   exception
   when others then
           bars_audit.error('create_tblASIM - err ' || sqlerrm);
   end;
   select  count(pm.done) into check_done  from P_MIGRAASIMM pm  where pm.n = 1 ;
   if check_done!=1 then
     update P_MIGRAASIMM pm set pm.done=1 where pm.n = 1;
   else
     update P_MIGRAASIMM pm set pm.done=pm.done*2 where pm.n = 1;
   end if;
     update P_MIGRAASIMM pm set pm.date_end=sysdate where pm.n = 1;

   commit;
   
 -- exception
 --  when others then
  --   bars_audit.error('create_tblASIM - err ' || sqlerrm);
  end new_load_file;

  procedure new_sk_create_dptASIM
  is
  p_tvbv  char(3):=get_tvbv();
  p_open  number;
  p_code  number;
  p_errmask varchar2(255):='create_dptASIM - err';
  p_dasvox date;
  begin
   --SELECT to_date(val,'mm.dd.yyyy') into p_dasvox FROM bars.params$base WHERE par = 'BANKDATE' and kf='300465';
   select gl.bd into p_dasvox from dual;
   update P_MIGRAASIMM pm set pm.date_begin=sysdate where pm.n = 2;
   new_create_dptASIM_(p_tvbv,p_open,p_code,p_errmask,p_dasvox);
   update P_MIGRAASIMM pm set pm.date_end=sysdate,pm.done = p_open,pm.err = p_code where pm.n = 2;
   dbms_output.put_line('create_dptASIM_p_open=>'||p_open);
   dbms_output.put_line('create_dptASIM_p_code=>'||p_code);
  end new_sk_create_dptASIM;

  procedure new_create_dptASIM_ (p_tvbv in  char    ,
                            p_open out number  ,
                            p_code out number  ,
                            p_errmask  varchar2,
                            p_dasvox   date)
  is

    FIO_         varchar2(60);
    IDCODE_      varchar2(10);
    DOCTYPE_     number(1);
    PASP_S_      varchar2(2);
    PASP_N_      varchar2(8);
    PASP_W_      varchar2(120);
    PASP_D_      date;
    BIRTHDAT_    date;
    BIRTHPL_     varchar2(120);
    SEX_         number(1);
    POSTIDX_     varchar2(10);
    REGION_      varchar2(30);
    DISTRICT_    varchar2(30);
    CITY_        varchar2(30);
    ADDRESS_     varchar2(120);
    PHONE_H_     varchar2(20);
    PHONE_J_     varchar2(20);
    LANDCOD_     number(5);
    REGDATE_     date;
    DEPCODE_     varchar2(16);
    DEPVIDNAME_  varchar2(120);
    ACC_CARD_    varchar2(10);
    DEPNAME_     varchar2(120);
    NLS_         varchar2(20);
    ID_          varchar2(7);
    DATO_        date;
    OST_         number(16);
    SUM_         number(16);
    DATN_        date;
    ATTR_        varchar2(16);
    MARK_        varchar2(1);
    VER_         number(4);
    KOD_OTD_     varchar2(10);
    BRANCH_      varchar2(30);
    BSD_         varchar2(7);
    OB22DE_      varchar2(2);
    BSN_         varchar2(7);
    OB22IE_      varchar2(7);
    BSD7_        varchar2(7);
    OB22D7_      varchar2(2);

    DZAGR_       date;
    tvbv_        char(3);
    fl_          int;
    DATPRC_      date;
    PRC_         number(8,4);

    type         cur is ref cursor;
    cur_         cur;
    sql_         varchar2(4000);
    num_load number :=get_flag_name();
  begin

    p_open := 0;
    p_code := 0;

    sql_:='select FIO                 , --FIO_
                  IDCODE              , --IDCODE_
                  DOCTYPE             , --DOCTYPE_
                  PASP_S              , --PASP_S_
                  PASP_N              , --PASP_N_
                  PASP_W              , --PASP_W_
                  PASP_D              , --PASP_D_
                  BIRTHDAT            , --BIRTHDAT_
                  BIRTHPL             , --BIRTHPL_
                  SEX                 , --SEX_
                  POSTIDX             , --POSTIDX_
                  REGION              , --REGION_
                  DISTRICT            , --DISTRICT_
                  CITY                , --CITY_
                  ADDRESS             , --ADDRESS_
                  PHONE_H             , --PHONE_H_
                  PHONE_J             , --PHONE_J_
                  LANDCOD             , --LANDCOD_
                  REGDATE             , --REGDATE_
                  DEPCODE             , --DEPCODE_
                  DEPVIDNAME          , --DEPVIDNAME_
                  ACC_CARD            , --ACC_CARD_
                  DEPNAME             , --DEPNAME_
                  NLS                 , --NLS_
                  ID                  , --ID_
                  DATO                , --DATO_
                  OST                 , --OST_
                  SUM                 , --SUM_
                  DATN                , --DATN_
                  ATTR                , --ATTR_
                  MARK                , --MARK_
                  VER                 , --VER_
                  KOD_OTD             , --KOD_OTD_
                  BRANCH              , --BRANCH_
                  BSD                 , --BSD_
                  lpad(OB22DE,2,''0''), --OB22DE_
                  BSN                 , --BSN_
                  lpad(OB22IE,2,''0''), --OB22IE_
                  BSD7                , --BSD7_
                  lpad(OB22D7,2,''0'')  --OB22D7_
           from   SK_ASVO_FDEP fd where fd.num_load ='||num_load;--where idcode=2400603890';
    open cur_ for sql_;

    loop

      fetch cur_ into FIO_       ,
                      IDCODE_    ,
                      DOCTYPE_   ,
                      PASP_S_    ,
                      PASP_N_    ,
                      PASP_W_    ,
                      PASP_D_    ,
                      BIRTHDAT_  ,
                      BIRTHPL_   ,
                      SEX_       ,
                      POSTIDX_   ,
                      REGION_    ,
                      DISTRICT_  ,
                      CITY_      ,
                      ADDRESS_   ,
                      PHONE_H_   ,
                      PHONE_J_   ,
                      LANDCOD_   ,
                      REGDATE_   ,
                      DEPCODE_   ,
                      DEPVIDNAME_,
                      ACC_CARD_  ,
                      DEPNAME_   ,
                      NLS_       ,
                      ID_        ,
                      DATO_      ,
                      OST_       ,
                      SUM_       ,
                      DATN_      ,
                      ATTR_      ,
                      MARK_      ,
                      VER_       ,
                      KOD_OTD_   ,
                      BRANCH_    ,
                      BSD_       ,
                      OB22DE_    ,
                      BSN_       ,
                      OB22IE_    ,
                      BSD7_      ,
                      OB22D7_;

      exit when cur_%notfound;

--    убираем нецифровые символы в полях PHONE_H, PHONE_J, PASP_N, IDCODE
--    убираем непечатные символы в полях ATTR, MARK

      PHONE_H_ := f_drop_undigital(PHONE_H_);
      PHONE_J_ := f_drop_undigital(PHONE_J_);
      PASP_N_  := f_drop_undigital(PASP_N_);
      IDCODE_  := f_drop_undigital(IDCODE_);
      ATTR_    := f_drop_nonprinting(ATTR_);
      MARK_    := f_drop_nonprinting(MARK_);

      dbms_application_info.set_client_info('open='||to_char(p_open)||
                                         ', error='||to_char(p_code));

      bars_audit.info(substr(p_errmask,1,length(p_errmask)-3)||'DEPCODE=' ||DEPCODE_ ||
                                                              ' BRANCH='  ||BRANCH_  ||
                                                              ' ACC_CARD='||ACC_CARD_||
                                                              ' NLS='     ||NLS_     ||
                                                              ' ID='      ||ID_      ||
                                                              ' ost='     ||ost_     ||
                                                              ' sum='     ||sum_     ||
                                                              ' ATTR='    ||ATTR_    ||
                                                              ' MARK='    ||MARK_    ||
                                                              ' KOD_OTD=' ||KOD_OTD_ ||
                                                              ' idcode='  ||IDCODE_  ||
                                                              ' fio='     ||FIO_);
      begin
        insert
        into   bars.ASVO_IMMOBILE (TVBV      ,
                              FIO       ,
                              IDCODE    ,
                              DOCTYPE   ,
                              PASP_S    ,
                              PASP_N    ,
                              PASP_W    ,
                              PASP_D    ,
                              BIRTHDAT  ,
                              BIRTHPL   ,
                              SEX       ,
                              POSTIDX   ,
                              REGION    ,
                              DISTRICT  ,
                              CITY      ,
                              ADDRESS   ,
                              PHONE_H   ,
                              PHONE_J   ,
                              LANDCOD   ,
                              REGDATE   ,
                              DEPCODE   ,
                              DEPVIDNAME,
                              ACC_CARD  ,
                              DEPNAME   ,
                              NLS       ,
                              ID        ,
                              DATO      ,
                              OST       ,
                              SUM       ,
                              DATN      ,
                              ATTR      ,
                              MARK      ,
                              VER       ,
                              KOD_OTD   ,
                              BRANCH    ,
                              BSD       ,
                              OB22DE    ,
                              BSN       ,
                              OB22IE    ,
                              BSD7      ,
                              OB22D7    ,
                              FL        ,
                              DZAGR)
                      values (p_tvbv       ,
                              FIO_         ,
                              IDCODE_      ,
                              DOCTYPE_     ,
                              PASP_S_      ,
                              PASP_N_      ,
                              PASP_W_      ,
                              PASP_D_      ,
                              BIRTHDAT_    ,
                              BIRTHPL_     ,
                              SEX_         ,
                              POSTIDX_     ,
                              REGION_      ,
                              DISTRICT_    ,
                              CITY_        ,
                              ADDRESS_     ,
                              PHONE_H_     ,
                              PHONE_J_     ,
                              LANDCOD_     ,
                              REGDATE_     ,
                              DEPCODE_     ,
                              DEPVIDNAME_  ,
                              ACC_CARD_    ,
                              DEPNAME_     ,
                              NLS_         ,
                              ID_          ,
                              DATO_        ,
                              OST_         ,
                              SUM_         ,
                              DATN_        ,
                              ATTR_        ,
                              nvl(MARK_,' '),
                              VER_         ,
                              KOD_OTD_     ,
                              BRANCH_      ,
                              BSD_         ,
                              OB22DE_      ,
                              BSN_         ,
                              OB22IE_      ,
                              BSD7_        ,
                              OB22D7_      ,
                              -10          ,
                              sysdate);
        p_open := p_open+1;
        commit;
      EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
        begin
          select DZAGR,
                 tvbv ,
                 fl
          into   DZAGR_,
                 tvbv_ ,
                 fl_
          from   bars.asvo_immobile
          where  KOD_OTD =KOD_OTD_       and
                 BRANCH  =BRANCH_        and
                 ACC_CARD=ACC_CARD_      and
                 MARK    =nvl(MARK_,' ') and
                 NLS     =NLS_           and
                 ID      =ID_;
          p_code := p_code+1;
          bars_audit.error(p_errmask          ||'(1): '           ||
                           'код ТВБВ='        ||tvbv_             ||
                           ', код отделения=' ||KOD_OTD_          ||
                           ', бранч='         ||BRANCH_           ||
                           ', код картотеки=' ||ACC_CARD_         ||
                           ', учетный символ='||MARK_             ||
                           ', номер вклада='  ||NLS_              ||
                           ', ID='            ||ID_               ||
                           ', ФИО='           ||FIO_              ||
                           ', ид.код='        ||IDCODE_           ||
                           ' - вклад УЖЕ загружен ('              ||
                           to_char(DZAGR_,'dd.mm.yyyy hh24:mi:ss')||
                           '), флаг обработки='||to_char(fl_));
        EXCEPTION WHEN no_data_found THEN
          p_code := p_code+1;
          bars_audit.error(p_errmask                ||'(0): '           ||
                           'код ТВБВ='              ||tvbv_             ||
                           ', код отделения='       ||KOD_OTD_          ||
                           ', бранч='               ||BRANCH_           ||
                           ', код картотеки='       ||ACC_CARD_         ||
                           ', учетный символ='      ||MARK_             ||
                           ', номер вклада='        ||NLS_              ||
                           ', ID='                  ||ID_               ||
                           ', ФИО='                 ||FIO_              ||
                           ', ид.код='              ||IDCODE_           ||
                           ' - неизвестная ошибка: '||sqlerrm);
--        tvbv_  := p_tvbv;
--        DZAGR_ := sysdate;
        end;
      end;

    end loop;
    close cur_;

    dbms_application_info.set_client_info('Загрузка процентных ставок...');

--  загрузка процентных ставок

    sql_:='select BRANCH  , --BRANCH_
                  ACC_CARD, --ACC_CARD_
                  MARK    , --MARK_
                  DATPRC  , --DATPRC_
                  PRC       --PRC_
           from   BARS.SK_ASVO_FDPI fdpi where fdpi.num_load ='||num_load;
    open cur_ for sql_;

    loop

      fetch cur_ into BRANCH_  ,
                      ACC_CARD_,
                      MARK_    ,
                      DATPRC_  ,
                      PRC_;

      exit when cur_%notfound;

      bars_audit.info(substr(p_errmask,1,length(p_errmask)-3)||'BRANCH='  ||BRANCH_                      ||
                                                              ' ACC_CARD='||ACC_CARD_                    ||
                                                              ' MARK='    ||MARK_                        ||
                                                              ' DATPRC='  ||to_char(DATPRC_,'dd.mm.yyyy')||
                                                              ' PRC='     ||to_char(PRC_));

      begin
        insert
        into   BARS.ASVO_IMMOBILE_PERCENT (TVBV    ,
                                      BRANCH  ,
                                      ACC_CARD,
                                      MARK    ,
                                      DATPRC  ,
                                      PRC)
                              values (p_tvbv        ,
                                      BRANCH_       ,
                                      ACC_CARD_     ,
                                      nvl(MARK_,' '),
                                      DATPRC_       ,
                                      PRC_);
        commit;
      EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
        begin
          select PRC,
                 tvbv
          into   PRC_,
                 tvbv_
          from   bars.asvo_immobile_percent
          where  BRANCH  =BRANCH_        and
                 ACC_CARD=ACC_CARD_      and
                 MARK    =nvl(MARK_,' ') and
                 DATPRC  =DATPRC_;
        EXCEPTION WHEN others THEN
          tvbv_  := p_tvbv;
        end;
        p_code := p_code+1;
        bars_audit.error(p_errmask          ||'(2): '          ||
                         'код ТВБВ='        ||tvbv_            ||
                         ', бранч='         ||BRANCH_          ||
                         ', код картотеки=' ||ACC_CARD_        ||
                         ', учетный символ='||MARK_            ||
                         ' - процентная ставка УЖЕ загружена ('||
                         to_char(DATPRC_,'dd.mm.yyyy')         ||
                         '), ставка='||to_char(PRC_));
      end;

    end loop;
    close cur_;

    dbms_application_info.set_client_info(' ');

  exception when others then
    bars_audit.error(p_errmask||'(Z): неожиданная ошибка - '||sqlerrm||' '||dbms_utility.format_error_backtrace||' ('||migraas.header_version||' '||migraas.body_version||')');
    p_code := p_code+1;

  end new_create_dptASIM_;

  procedure new_sk_load_IM4KOTL2S
  is
  p_tvbv  char(3):=get_tvbv();
  p_open  number;
  p_code  number;
  p_errmask varchar2(255):='create_dptASIM - err';
  p_dasvox date;
  begin
   --SELECT to_date(val,'mm.dd.yyyy') into p_dasvox FROM bars. params$base WHERE par = 'BANKDATE' and kf='300465';
   select gl.bd into p_dasvox from dual;
   p_errmask:='load_IM4KOTL2S - err';
   update P_MIGRAASIMM pm set pm.date_begin=sysdate where pm.n = 4;
   --bc.go('/322669/');
   new_load_IM4KOTL2S(p_tvbv,p_open,p_code,p_errmask,p_dasvox);
   --bc.home();
   update P_MIGRAASIMM pm set pm.date_end=sysdate ,pm.done = p_open,pm.err = p_code where pm.n = 4;
   dbms_output.put_line('load_IM4KOTL2S_p_open=>'||p_open);
   dbms_output.put_line('load_IM4KOTL2S_p_code=>'||p_code);
   commit;
  end;
  procedure new_load_IM4KOTL2S (p_tvbv in  char    ,
                                p_open out number  ,
                                p_code out number  ,
                                p_errmask  varchar2,
                                p_dasvox   date)
  is
    TT_       oper.TT%type  := 'N24';
    VOB_      oper.VOB%type := 6;
    REF_      oper.REF%type;
    daos_ru_  accounts.daos%type;
    acc_ru_   accounts.acc%type;
    S_RU_     accounts.nls%type;
    nms_ru_   accounts.nms%type;
    KOTL_     accounts.nls%type;
    nms_      accounts.nms%type;
    p_num_ins number;
    p_branch varchar2(255):= sys_context('bars_context','user_branch');
  begin
    --bars_alerter(0);
    p_num_ins:=get_flag_name();
    p_open := 0;
    p_code := 0;

--  select branch
--  into   branch_
--  from   ASVO_FFF_BRANCH
--  where  FFF=p_tvbv and
--         rownum<2;

--  bars_audit.info('load_ostcdptAS - @ branch_='||branch_);

--  депозиты

--  bc.subst_branch(branch_);

    --tokf;

    begin
      insert
      into   fdat (fdat)
           values (p_dasvox);
      commit;
    exception when OTHERS then
      null;
    end;
    --bc.go('/322669/');
    gl.pl_dat(p_dasvox);
  --  gl.amfo:='322669';
    --gl.amfo := f_ourmfo_g;

--  if gl.bdate is null then
--    gl.bdate := bankdate_g;
--  end if;

/*
    for k in (select i.ost                        ,
                     i.nls                    nsc ,
                     i.fio                        ,
                     i.key                        ,
                     i.branch                     ,
                     i.ob22de                 ob22,
                     i.bsd                        ,
                     i.kv                         ,
                     s.nls                    KOTL,
                     trim(substr(s.nms,1,38)) nms
--                   a.nls                    S_RU,
--                   a.kv                         ,
--                   trim(substr(a.nms,1,38)) nms
              from   asvo_immobile i,
--                   accounts      a,
                     accounts      s
              where  i.fl=-10                                               and
                     i.tvbv=p_tvbv                                          and
--                   a.nls=vkrzn(substr(gl.aMFO,1,5),i.bsd||'_30'||gl.aMFO) and
--                   a.kv=i.kv                                              and
--                   a.dazs is null                                         and
                     i.source='АСВО'                                        and
                     i.ost>0                                                and
                     s.branch(+)=i.branch                                   and
                     s.tip(+)='ODB'                                         and
                     s.dazs(+) is null                                      and
                     s.nbs(+)=i.bsd                                         and
                     s.ob22(+)=i.ob22de                                     and
                     s.kv(+)=i.kv)
*/

    for k in (select a.ost, a.nls nsc, a.fio, a.key, a.branch, a.ob22de ob22, a.bsd, a.kv
                from asvo_immobile a, bars.sk_asvo_fdep fdep
               where a.tvbv = p_tvbv
                 and a.kod_otd = fdep.kod_otd
                 and a.acc_card = fdep.acc_card
                 and a.nls = fdep.nls
                 and a.fl = -10
                 --and a.tvbv = '045'
                 and a.source = 'АСВО'
                 and a.ost > 0
                 and fdep.num_load =p_num_ins)
    loop

--    if k.KOTL is null then
--      bars_audit.error(p_errmask||'(1): не найден или закрыт котловой счёт для вклада '||
--                       k.nsc||' ('||k.fio||') вал.'||k.kv||' - '||sqlerrm||' '||
--                       dbms_utility.format_error_backtrace);
--      p_code := p_code+1;
--      goto nofoundi;
--    end if;

      begin
        select nls,
               trim(substr(nms,1,38))
        into   KOTL_,
               nms_
        from   accounts
        where  branch=k.branch and
               tip='ODB'       and
               dazs is null    and
               nbs=k.bsd       and
               ob22=k.ob22     and
               kv=k.kv         and
               rownum<2;
      exception when no_data_found then
        bars_audit.error(p_errmask||'(1): не найден или закрыт котловой счёт для вклада '||
                         k.nsc||' ('||k.fio||') вал.'||k.kv||', БС='||k.bsd||', ОБ22='||
                         k.ob22||' - '||sqlerrm||' '||dbms_utility.format_error_backtrace);
        p_code := p_code+1;
        goto nofoundi;
      end;
--    S_RU_ := vkrzn(substr(gl.aMFO,1,5),k.bsd||'_30'||gl.aMFO);               -- буде по другому
--    S_RU_ := vkrzn(substr(gl.aMFO,1,5),k.bsd||'_30'||substr(k.branch,11,4)); -- ось так
      S_RU_ := vkrzn(substr(gl.aMFO,1,5),k.bsd||'_00'||case k.bsd when '2620' then
                                                         '30'
                                                                  when '2630' then
                                                         '46'
                                                                  when '2635' then
                                                         '38'
                                                       end||substr(k.branch,11,4));
      begin
        select trim(substr(nms,1,38)),
               daos                  ,
               acc
        into   nms_ru_ ,
               daos_ru_,
               acc_ru_
        from   accounts
        where  nls=S_RU_    and
               dazs is null and
               kv=k.kv;
      exception when no_data_found then
        bars_audit.error(p_errmask||'(2): не найден или закрыт счёт РУ для вклада '||
                         k.nsc||' ('||k.fio||') вал.'||k.kv||' - '||sqlerrm||' '||
                         dbms_utility.format_error_backtrace);
        p_code := p_code+1;
        goto nofoundi;
      end;

      if daos_ru_>p_dasvox then
        update accounts
        set    daos=p_dasvox
        where  acc=acc_ru_;
      end if;
--    bars_audit.info('load_IM4KOTL2S - 1 k.nsc='||k.nsc);
      bc.subst_branch(k.branch);
      GL.REF (REF_);
--    bars_audit.info('load_IM4KOTL2S - 2');
      begin
      GL.IN_DOC3 (REF_   , TT_   , VOB_   , REF_ , SYSDATE, GL.BDATE, 1,
                    k.KV   , k.ost , k.KV   , k.ost, NULL   , GL.BDATE, GL.BDATE,
--                  k.nms  , k.KOTL, gl.AMFO,
                    nms_   , KOTL_ , gl.AMFO,
                    nms_ru_, S_RU_ , gl.AMFO,
                    'Розкриття рахунку в ЦРНВ по вкладу #'||k.nsc||', '||k.fio,
                    NULL, null, null, NULL, NULL, 0, NULL, null);
      exception when OTHERS then
        bars_audit.error(p_errmask||'(0): '||sqlerrm||' - '||dbms_utility.format_error_backtrace);
        p_code := p_code+1;
        goto nofoundi;
      end;
--    bars_audit.info('load_IM4KOTL2S - 3');

      begin
        GL.PAYV
--              (0, REF_, GL.BDATE, TT_, 1, k.KV, k.KOTL, k.ost,
                (0, REF_, GL.BDATE, TT_, 1, k.KV, KOTL_ , k.ost,
                                            k.KV, S_RU_ , k.ost);
      exception when OTHERS then
        bars_audit.error(p_errmask||'(3): '||sqlerrm||' - '||dbms_utility.format_error_backtrace);
        p_code := p_code+1;
        rollback;
        goto nofoundi;
      end;
--    begin
--      GL.PAY
--           (1, REF_, GL.BDATE);
--    exception when OTHERS then
--      bars_audit.error(p_errmask||'(4): '||sqlerrm||' - '||
--                       dbms_utility.format_error_backtrace);
--      p_code := p_code+1;
--      rollback;
--      goto nofoundi;
--    end;

      update asvo_immobile
      set    fl=0
      where  key=k.key;

      begin
        insert
        into   operw (ref,
                      tag,
                      value)
              values (REF_,
                      'ASVOI',
                      to_char(k.key));
      exception WHEN dup_val_on_index then
        update operw
        set    value=to_char(k.key)
        where  ref=REF_ and
               tag='ASVOI';
      end;

      begin
        insert
        into   operw (ref,
                      tag,
                      value)
              values (REF_,
                      'TVBVI',
                      p_tvbv);
      exception WHEN dup_val_on_index then
        update operw
        set    value=p_tvbv
        where  ref=REF_ and
               tag='TVBVI';
      end;

      p_open := p_open+1;

<<nofoundi>> null;

      dbms_application_info.set_client_info('load='||to_char(p_open)||
                                         ', error='||to_char(p_code));
    end loop;

    commit;

--  dbms_application_info.set_client_info('pereocenka');

--  migraAS.pereocenka(p_tvbv,p_open,p_code,p_errmask,p_dasvox);
--  commit;
--  bc.set_context;
   -- toroot;

    dbms_application_info.set_client_info(' ');
  --  bars_alerter(1);
 bc.go(p_branch);
  end new_load_IM4KOTL2S;

  procedure new_sk_drop_IM4KOTL2S
  is
   p_tvbv  char(3):=get_tvbv();
  p_open  number;
  p_code  number;
  p_errmask varchar2(255):='create_dptASIM - err';
  p_dasvox date;
  begin
   --SELECT to_date(val,'mm.dd.yyyy') into p_dasvox FROM bars. params$base WHERE par = 'BANKDATE' and kf='300465';
   select gl.bd into p_dasvox from dual;
   p_errmask:='drop_IM4KOTL2S - err';
   update P_MIGRAASIMM pm set pm.date_begin=sysdate where pm.n = 5;
   --bc.go('/322669/');
   new_drop_IM4KOTL2S(p_tvbv,p_open,p_code,p_errmask,p_dasvox);
   --bc.home();
   update P_MIGRAASIMM pm set pm.date_end=sysdate ,pm.done = p_open,pm.err = p_code where pm.n = 5;
   dbms_output.put_line('drop_IM4KOTL2S - err_p_open=>'||p_open);
   dbms_output.put_line('drop_IM4KOTL2S - err_p_code=>'||p_code);
  end new_sk_drop_IM4KOTL2S;

  procedure new_drop_IM4KOTL2S (p_tvbv in  char    ,
                            p_open out number  ,
                            p_code out number  ,
                            p_errmask  varchar2,
                            p_dasvox   date)
  is

--  branch_  varchar2(32);
    TT_      oper.TT%type := 'N24';

  begin
   -- bars_alerter(0);

    p_open := 0;
    p_code := 0;

--  select branch
--  into   branch_
--  from   ASVO_FFF_BRANCH
--  where  FFF=p_tvbv and
--         rownum<2;

--  откат документов по развороту вкладов (BAK)

--  bc.subst_branch(branch_);

   -- tokf;
    begin
      insert
      into   fdat (fdat)
           values (p_dasvox);
      commit;
    exception when OTHERS then
      null;
    end;

    gl.pl_dat(p_dasvox);
--  gl.amfo := f_ourmfo_g;

--  if gl.bdate is null then
--    gl.bdate := bankdate_g;
--  end if;

    for k in (select o.ref,
                     w.value key
              from   oper  o,
                     operw w,
                     operw w2
              where  o.tt=TT_        and
                     o.ref=w.ref     and
                     w.tag='ASVOI'   and
                     o.ref=w2.ref    and
                     w2.tag='TVBVI'  and
                     w2.value=p_tvbv and
                     o.sos=1 )
    loop
--bc.go('/322669/');
      ful_bak(k.ref);
--    bars_audit.info(substr(p_errmask,length(p_errmask)-6)||': ful_bak '||k.ref);

      delete
      from   operw
      where  ref=k.ref;

      update asvo_immobile
      set    fl=-10
      where  fl=0 and
             key=to_number(k.key);

--    update social_contracts
--    set    details=substr(details,2)
--    where  contract_id=k.dptid;

      p_open := p_open+1;

      dbms_application_info.set_client_info('drop='||to_char(p_open)||
                                         ', error='||to_char(p_code));
    end loop;

    commit;

--  bc.set_context;
   -- toroot;
    dbms_application_info.set_client_info(' ');

  --  bars_alerter(1);
  end new_drop_IM4KOTL2S;

  procedure new_sk_drop_deposASIM
  is
  p_tvbv  char(3):=get_tvbv();
  p_open  number;
  p_code  number;
  p_errmask varchar2(255):='create_dptASIM - err';
  p_dasvox date;
  begin
   --SELECT to_date(val,'mm.dd.yyyy') into p_dasvox FROM bars. params$base WHERE par = 'BANKDATE' and kf='300465';
   select gl.bd into p_dasvox from dual;
   p_errmask:='drop_deposASIM - err';
   update P_MIGRAASIMM pm set pm.date_begin=sysdate where pm.n = 6;
   --bc.go('/322669/');
   new_drop_deposASIM(p_tvbv,p_open,p_code,p_errmask,p_dasvox);
   --bc.home();
   update P_MIGRAASIMM pm set pm.date_end=sysdate ,pm.done = p_open,pm.err = p_code where pm.n = 6;
   dbms_output.put_line('drop_deposASIM - err_p_open=>'||p_open);
   dbms_output.put_line('drop_deposASIM - err_p_code=>'||p_code);
  end new_sk_drop_deposASIM;

  procedure new_drop_deposASIM (p_tvbv in  char    ,
                                p_open out number  ,
                                p_code out number  ,
                                p_errmask  varchar2,
                                p_dasvox   date)
  is

    type       cur is ref cursor;
    cur_       cur;
    sql_       varchar2(4000);

    KOD_OTD_   varchar2(10);
    BRANCH_    varchar2(30);
    ACC_CARD_  varchar2(10);
    MARK_      varchar2(1);
    NLS_       varchar2(20);
    ID_        varchar2(7);
    FIO_       varchar2(60);
    IDCODE_    varchar2(10);
    fl_        int;
    DATPRC_    date;
    num_load number :=get_flag_name();
  begin

    p_open := 0;
    p_code := 0;

    sql_:='select KOD_OTD ,  --KOD_OTD_
                  BRANCH  ,  --BRANCH_
                  ACC_CARD,  --ACC_CARD_
                  MARK    ,  --MARK_
                  NLS     ,  --NLS_
                  ID      ,  --ID_
                  FIO     ,  --FIO_
                  IDCODE     --IDCODE_
           from   SK_ASVO_FDEP fd where fd.num_load ='||num_load;
    open cur_ for sql_;

    loop

      fetch cur_ into KOD_OTD_ ,
                      BRANCH_  ,
                      ACC_CARD_,
                      MARK_    ,
                      NLS_     ,
                      ID_      ,
                      FIO_     ,
                      IDCODE_;

      exit when cur_%notfound;

      dbms_application_info.set_client_info('open='||to_char(p_open)||
                                         ', error='||to_char(p_code));

      begin
        select fl
        into   fl_
        from   ASVO_IMMOBILE
        where  tvbv    =p_tvbv         and
               KOD_OTD =KOD_OTD_       and
               BRANCH  =BRANCH_        and
               ACC_CARD=ACC_CARD_      and
               MARK    =nvl(MARK_,' ') and
               NLS     =NLS_           and
               ID      =ID_;
        if fl_!=-10 then
          bars_audit.error(p_errmask          ||'(1): '  ||
                           'код ТВБВ='        ||p_tvbv   ||
                           ', код отделения=' ||KOD_OTD_ ||
                           ', бранч='         ||BRANCH_  ||
                           ', код картотеки=' ||ACC_CARD_||
                           ', учетный символ='||MARK_    ||
                           ', номер вклада='  ||NLS_     ||
                           ', ID='            ||ID_      ||
                           ', ФИО='           ||FIO_     ||
                           ', ид.код='        ||IDCODE_  ||
                           ' - ошибка при удалении вклада (флаг обработки не равен -10)');
          p_code := p_code+1;
        else
          begin
            delete
            from   asvo_immobile
            where  tvbv    =p_tvbv         and
                   KOD_OTD =KOD_OTD_       and
                   BRANCH  =BRANCH_        and
                   ACC_CARD=ACC_CARD_      and
                   MARK    =nvl(MARK_,' ') and
                   NLS     =NLS_           and
                   ID      =ID_;
            p_open := p_open+1;
            commit;
          EXCEPTION WHEN others THEN
            bars_audit.error(p_errmask          ||'(2): '  ||
                             'код ТВБВ='        ||p_tvbv   ||
                             ', код отделения=' ||KOD_OTD_ ||
                             ', бранч='         ||BRANCH_  ||
                             ', код картотеки=' ||ACC_CARD_||
                             ', учетный символ='||MARK_    ||
                             ', номер вклада='  ||NLS_     ||
                             ', ID='            ||ID_      ||
                             ', ФИО='           ||FIO_     ||
                             ', ид.код='        ||IDCODE_  ||
                             ' - ошибка при удалении вклада ('||sqlerrm||')');
            p_code := p_code+1;
          end;
        end if;
      exception when no_data_found then
--      bars_audit.error(p_errmask          ||'(3): '  ||
--                       'код ТВБВ='        ||p_tvbv   ||
--                       ', код отделения=' ||KOD_OTD_ ||
--                       ', бранч='         ||BRANCH_  ||
--                       ', код картотеки=' ||ACC_CARD_||
--                       ', учетный символ='||MARK_    ||
--                       ', номер вклада='  ||NLS_     ||
--                       ', ID='            ||ID_      ||
--                       ', ФИО='           ||FIO_     ||
--                       ', ид.код='        ||IDCODE_  ||
--                       ' - вклад НЕ загружен');
--      p_code := p_code+1;
        null;
                 when others then
        bars_audit.error(p_errmask          ||'(4): '  ||
                         'код ТВБВ='        ||p_tvbv   ||
                         ', код отделения=' ||KOD_OTD_ ||
                         ', бранч='         ||BRANCH_  ||
                         ', код картотеки=' ||ACC_CARD_||
                         ', учетный символ='||MARK_    ||
                         ', номер вклада='  ||NLS_     ||
                         ', ID='            ||ID_      ||
                         ', ФИО='           ||FIO_     ||
                         ', ид.код='        ||IDCODE_  ||
                         ' - ошибка при удалении вклада ('||sqlerrm||')');
        p_code := p_code+1;
      end;

    end loop;
    close cur_;

--  откат процентных ставок (удаление)

    dbms_application_info.set_client_info('Откат процентных ставок...');

    sql_:='select BRANCH  ,  --BRANCH_
                  ACC_CARD,  --ACC_CARD_
                  MARK    ,  --MARK_
                  DATPRC     --DATPRC_
           from   SK_ASVO_FDPI fdpi where fdpi.num_load ='||num_load;
    open cur_ for sql_;

    loop

      fetch cur_ into BRANCH_  ,
                      ACC_CARD_,
                      MARK_    ,
                      DATPRC_;

      exit when cur_%notfound;


      begin
        delete
        from   asvo_immobile_percent
        where  tvbv    =p_tvbv         and
               BRANCH  =BRANCH_        and
               ACC_CARD=ACC_CARD_      and
               MARK    =nvl(MARK_,' ') and
               DATPRC  =DATPRC_;
        if sql%rowcount=1 then
--        p_open := p_open+1;
          commit;
--      else
--        bars_audit.error(p_errmask          ||'(5): '                      ||
--                         'код ТВБВ='        ||p_tvbv                       ||
--                         ', бранч='         ||BRANCH_                      ||
--                         ', код картотеки=' ||ACC_CARD_                    ||
--                         ', учетный символ='||MARK_                        ||
--                         ', дата % ставки=' ||to_char(DATPRC_,'dd/mm/yyyy')||
--                         ' - ставка отсутствует');
--        p_code := p_code+1;
        end if;
      EXCEPTION WHEN others THEN
        bars_audit.error(p_errmask          ||'(6): '                      ||
                         'код ТВБВ='        ||p_tvbv                       ||
                         ', бранч='         ||BRANCH_                      ||
                         ', код картотеки=' ||ACC_CARD_                    ||
                         ', учетный символ='||MARK_                        ||
                         ', дата % ставки=' ||to_char(DATPRC_,'dd/mm/yyyy')||
                         ' - ошибка при удалении ставки ('||sqlerrm||')');
        p_code := p_code+1;
      end;

    end loop;
    close cur_;

    dbms_application_info.set_client_info(' ');

  end new_drop_deposASIM;

end SK_TEST;
/

 
 
 PROMPT *** Create  grants  sk_test ***

 grant EXECUTE                                                                on SK_TEST         to WR_ALL_RIGHTS;
 grant EXECUTE                                                                on SK_TEST         to BARS_ACCESS_DEFROLE;
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sk_test.sql =========*** 
 PROMPT ===================================================================================== 
 