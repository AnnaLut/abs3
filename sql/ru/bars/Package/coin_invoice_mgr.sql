CREATE OR REPLACE package body BARS.coin_invoice_mgr is

  --
  -- Автор  : VIT
  -- Создан : 27.06.2016
  --
  -- Purpose : Робота з оприбуткуванням монет
  --

  -- Private constant declarations
  g_body_version  constant varchar2(64) := 'version 1.0.0 27/06/2016';
  g_awk_body_defs constant varchar2(512) := '';
  g_dbgcode       constant varchar2(20) := 'coin_invoice_mgr.';
  CRLF            constant varchar2(5) := '\r\n'; --'.';

  RES_OK  constant number(1) := 0;
  RES_ERR constant number(1) := -1;

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body ' || g_dbgcode || ' ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;

  --------------------------------------------------------------------------------
  -- clear_invoice -чистим данные 
  --
  procedure clear_invoice(p_nd in tmp_coin_invoice.nd%type) is
  begin
    delete from bars.tmp_coin_invoice i where i.userid = bars.user_id;
    delete from bars.tmp_coin_invoice_detail d
     where d.userid = bars.user_id;
  end clear_invoice;

  --------------------------------------------------------------------------------
  -- create_invoice - создаём заголовок накладной
  --
  procedure create_invoice(p_type_id             in tmp_coin_invoice.type_id%type,
                           p_nd                  in tmp_coin_invoice.nd%type,
                           p_dat                 in tmp_coin_invoice.dat%type,
                           p_reason              in tmp_coin_invoice.reason%type,
                           p_bailee              in tmp_coin_invoice.bailee%type,
                           p_proxy               in tmp_coin_invoice.proxy%type,
                           p_total_count         in tmp_coin_invoice.total_count%type,
                           p_total_nominal       in tmp_coin_invoice.total_nominal%type,
                           p_total_sum           in tmp_coin_invoice.total_sum%type,
                           p_total_without_vat   in tmp_coin_invoice.total_without_vat%type,
                           p_vat_percent         in tmp_coin_invoice.vat_percent%type,
                           p_vat_sum             in tmp_coin_invoice.vat_sum%type,
                           p_total_nominal_price in tmp_coin_invoice.total_nominal_price%type,
                           p_total_with_vat      in tmp_coin_invoice.total_with_vat%type) is
  begin
    update bars.tmp_coin_invoice c
       set c.type_id             = p_type_id,
           c.nd                  = p_nd,
           c.dat                 = p_dat,
           c.reason              = p_reason,
           c.proxy               = p_proxy,
           c.total_count         = p_total_count,
           c.total_nominal       = p_total_nominal * 100,
           c.total_sum           = p_total_sum * 100,
           c.total_without_vat   = p_total_without_vat * 100,
           c.vat_percent         = p_vat_percent,
           c.vat_sum             = p_vat_sum * 100,
           c.total_nominal_price = p_total_nominal_price * 100,
           c.total_with_vat      = p_total_with_vat * 100
     where c.userid = bars.user_id;
  
    if sql%rowcount = 0 then
      insert into bars.tmp_coin_invoice
      values
        (p_type_id,
         p_nd,
         p_dat,
         p_reason,
         p_bailee,
         p_proxy,
         nvl(p_total_count, 0),
         nvl(p_total_nominal, 0) * 100,
         nvl(p_total_sum, 0) * 100,
         nvl(p_total_without_vat, 0) * 100,
         nvl(p_vat_percent, 0),
         nvl(p_vat_sum, 0) * 100,
         nvl(p_total_nominal_price, 0) * 100,
         nvl(p_total_with_vat, 0) * 100,
         bars.user_id,
         null);
    end if;
  end create_invoice;

  --------------------------------------------------------------------------------
  -- pay_invoice - оплатить накладную
  --
  procedure pay_invoice(p_nd in varchar2) is
  ii TMP_COIN_INVOICE%rowtype;
  nS_    Number ; 
  nS1_   Number ; 
  nS2a_  Number ;
  nS2b_  Number ;
  nS3_   Number ;
  nS4_   Number ; 
  nD_    Number ;
  n980_  int    := gl.baseval;
  nRef_  Number ; 
  -------------------
  NLSD1_  accounts.NLS%type;  NLSK1_ accounts.NLS%type; 
  NLSD2a_ accounts.NLS%type;        
  NLSD2b_ accounts.NLS%type;  NLSK2_ accounts.NLS%type; 
  NLSD3_  accounts.NLS%type;  NLSK3_ accounts.NLS%type; 
  NLSD4_  accounts.NLS%type;  NLSK4_ accounts.NLS%type; 
  NMSK_   accounts.Nms%type;
begin

  begin select * into ii from TMP_COIN_INVOICE i where i.nd = p_ND and i.USERID = gl.auid and i.ref is null   FOR UPDATE OF i.ref ;
  exception when no_data_found then RETURN ;
  end;

  nS_  := Nvl(ii.TOTAL_WITH_VAT, 0) ; If nS_  <= 0 then RETURN; end if;
  nS1_ := ii.TOTAL_NOMINAL_PRICE;
  nS4_ := ii.VAT_SUM ;
  nS3_ := 0 ;  
  nS2b_:= 0 ; 
  nS2a_:= 0 ;
  for x in (select * from TMP_COIN_INVOICE_DETAIL d  where d.CNT > 0  and d.nd = ii.nd and  d.userid = ii.userid)
  loop

      If    x.METAL = 'супутня'  then nS3_  := nS3_  + x.NOMINAL_SUM ;
      ElsIf x.NOMINAL_PRICE = 0  then nS2b_ := nS2b_ + x.NOMINAL_SUM ;
      ElsIf x.NOMINAL_PRICE > 0  then nS2a_ := nS2a_ + x.NOMINAL_SUM ;
      end if;

  end loop; --- x



  nD_     := nS_ - nS1_ - nS2a_ - nS2b_ - nS3_ - nS4_ ;  
  NLSD1_  := substr(BRANCH_USR.GET_BRANCH_PARAM2('CASHS',0),1,14) ; 
  NLSD3_  := substr(nbs_ob22 ('3400','19'),1,14) ;                  
  NLSD4_  := substr(nbs_ob22 ('3522','51'),1,14) ;   
  NLSD2a_ := substr(nbs_ob22 ('3500','07'),1,14) ;   
  NLSD2b_ := substr(nbs_ob22 ('3400','08'),1,14) ;	     
  --    TYPE_ID = Вид накладної (0 - внутрішня/ 1 - зовнішня)
  If ii.TYPE_ID = 1 then  NLSK1_ := substr(nbs_ob22 ('1819','03'),1,14) ;   NLSK3_ := NLSK1_ ; 
  Else                    NLSK1_ := substr(nbs_ob22 ('3906','02'),1,14) ;   NLSK3_ := substr(nbs_ob22 ('3902','11'),1,14) ;
  end if;

  begin select substr(nms,1,38) into NMSK_ from accounts where nls = NLSK1_ and kv = n980_;
  exception when no_data_found then RETURN ;
  end;
  NLSK2_ := NLSK1_ ;
  NLSK4_ := NLSK1_ ;
  ----------------------
  gl.ref (nRef_);
  gl.in_doc3 (ref_  => nRef_ ,
              tt_   => 'MF1' ,
              vob_  => 17    ,
               nd_  => substr(II.ND,1,10),
              pdat_ => SYSDATE ,
              vdat_ => gl.bdate,
              dk_   => 1,
              kv_   => n980_, s_  => nS_,
              kv2_  => n980_, s2_ => nS_, 
              sk_   => null, 
              data_ => Trunc(sysdate),
              datp_ => Trunc(sysdate),
              nam_a_=> 'Монети,Футляри,ПДВ',   nlsa_ => NLSD3_,  mfoa_ => gl.aMfo,
              nam_b_=>  NMSK_,                 nlsb_ => NLSK1_,  mfob_ => gl.aMfo,
              nazn_ => 'Оприбуткування монет та футлярів згідно накладної № ' || ii.ND || ' Від ' || to_char(ii.DAT, 'dd/MM/yyyy' ),
              d_rec_=>  null,  id_a_=>gl.aOkpo, id_b_ =>gl.aOkpo, id_o_=>null, sign_=>null, sos_=>1, prty_=>null, uid_=>null)  ;
--If nS_  > 0 then                            gl.payv(0,nRef_,gl.bdate,'MF1',1,n980_,NLSD3_ ,nS_  ,n980_,NLSK1_,nS_  ); end if ;  -- до сплати всього --------
  If nS1_ > 0 then                            gl.payv(0,nRef_,gl.bdate,'M01',1,n980_,NLSD1_ ,nS1_ ,n980_,NLSK1_,nS1_ ); end if ;  -- каса - пл.номінал
  If nS2a_> 0 then nS2a_:=nS2a_+nD_; nD_:= 0; gl.payv(0,nRef_,gl.bdate,'M02',1,n980_,NLSD2a_,nS2a_,n980_,NLSK2_,nS2a_); end if ;  -- розрахунки з купўвлў-продажу юв монет з без пл.номіналом 
  If nS2b_> 0 then nS2b_:=nS2b_+nD_; nD_:= 0; gl.payv(0,nRef_,gl.bdate,'M05',1,n980_,NLSD2b_,nS2b_,n980_,NLSK3_,nS2b_); end if ;  -- ювўлейнў монети без пл.номіналу 
  If nS3_ > 0 then nS3_ :=nS3_ +nD_; nD_:= 0; gl.payv(0,nRef_,gl.bdate,'M03',1,n980_,NLSD3_ ,nS3_ ,n980_,NLSK3_,nS3_ ); end if ;  -- футляри для ювўлейних монет
  If nS4_ > 0 then                            gl.payv(0,nRef_,gl.bdate,'M04',1,n980_,NLSD4_ ,nS4_ ,n980_,NLSK4_,nS4_ ); end if ;  -- ПДВ  
  ------- Доп.рекв.
  set_operw ( nRef_, 'VA_NC', ii.ND);
  set_operw ( nRef_, 'OBDT ', to_char(ii.DAT,'dd/MM/yyyy')  );
  set_operw ( nRef_, 'PIDST', ii.REASON );
  set_operw ( nRef_, 'FIO1 ', ii.BAILEE );
  set_operw ( nRef_, 'GOLD ', ii.PROXY  );
  update TMP_COIN_INVOICE set ref = nRef_ where USERID = ii.userid and ref is null ;
  end pay_invoice;

  --------------------------------------------------------------------------------
  -- calculate_invoice - посчитать итоги накладной
  --
  procedure calculate_invoice(p_nd in varchar2) is
    l_type_id             number(1);
    l_vat                 number(2, 1);
    l_total_count         number(38) := 0;
    l_total_nominal       number(38) := 0;
    l_total_sum           number(38) := 0;
    l_total_without_vat   number(38) := 0;
    l_vat_percent         number(38) := 0;
    l_vat_sum             number(38) := 0;
    l_total_nominal_price number(38) := 0;
    l_total_with_vat      number(38) := 0;
    l_unit_price          number(38) := 0;
    l_unit_price_vat      number(38) := 0;
  begin
    select d.type_id
      into l_type_id
      from tmp_coin_invoice d
     where d.userid = bars.user_id
       and d.nd = p_nd;
    if (l_type_id = 1) then
      l_vat         := 1.2;
      l_vat_percent := 20;
    else
      l_vat         := 1;
      l_vat_percent := 0;
    end if;
  
    for c in (select d.*
                from tmp_coin_invoice_detail d
               where d.nd = p_nd
                 and d.userid = bars.user_id
               order by d.rn) loop
      l_total_count         := l_total_count + c.cnt;
      l_unit_price          := l_unit_price + c.unit_price;
      l_unit_price_vat      := l_unit_price_vat + c.unit_price_vat;
      l_total_nominal       := l_total_nominal + c.nominal;
      l_total_sum           := l_total_sum + c.nominal_sum;
      l_total_without_vat   := l_total_without_vat + c.nominal_sum;
      l_total_nominal_price := l_total_nominal_price + c.nominal_price;
      if(l_type_id = 1) then
      l_total_with_vat      := l_total_with_vat + (c.cnt * c.unit_price_vat);
      else
        l_total_with_vat := l_total_with_vat + (c.cnt * c.unit_price)+c.nominal_price;
      end if;                         
      l_total_without_vat   := l_total_without_vat + (c.cnt * c.unit_price);
    end loop;
    
    l_vat_sum := l_total_sum * l_vat - l_total_sum;
    l_total_without_vat := l_total_with_vat - l_vat_sum - l_total_nominal_price;
    
    update tmp_coin_invoice d
       set d.total_count         = l_total_count,
           d.total_nominal       = l_total_nominal,
           d.total_sum           = l_total_sum,
           d.total_without_vat   = l_total_without_vat,
           d.vat_percent         = l_vat_percent,
           d.vat_sum             = l_vat_sum,
           d.total_nominal_price = l_total_nominal_price,
           d.total_with_vat      = l_total_with_vat
     where d.userid = bars.user_id
       and d.nd = p_nd;
  
  exception
    when others then
      raise_application_error(-20001, sqlerrm);
    
  end calculate_invoice;

  --------------------------------------------------------------------------------
  -- add_invoice_detail - добавляет строки накладной
  --
  procedure add_invoice_detail(p_type_id in number,
                               p_nd      in varchar2,
                               p_code    in varchar2,
                               p_count   in number,
                               p_price   in number,
                               p_rn      in number) is
    l_rn                  bars.tmp_coin_invoice_detail.rn%type;
    l_name                bars.tmp_coin_invoice_detail.name%type;
    l_metal               bars.tmp_coin_invoice_detail.metal%type;
    l_nominal             bars.tmp_coin_invoice_detail.nominal%type;
    l_nominal_price       bars.tmp_coin_invoice_detail.nominal_price%type;
    l_unit_price          bars.tmp_coin_invoice_detail.unit_price%type;
    l_nominal_sum         bars.tmp_coin_invoice_detail.nominal_sum%type;
    l_unit_price_vat      bars.tmp_coin_invoice_detail.unit_price_vat%type;
    l_invoice_dat         bars.tmp_coin_invoice.dat%type;
    l_nominal_price_count bars.tmp_coin_invoice_detail.nominal_price%type;
  begin
    select i.dat
      into l_invoice_dat
      from tmp_coin_invoice i
     where i.userid = bars.user_id
       and i.nd = p_nd;
  
    if (p_rn = 0) then
      select nvl(max(d.rn), 0) + 1
        into l_rn
        from bars.tmp_coin_invoice_detail d
       where d.userid = bars.user_id;
    else
      l_rn := p_rn;
    end if;
  
    select s.namemoney,
           s.namemetal,
           decode(s.pr_kupon, null, s.nominal * 100, 0),
           decode(s.pr_kupon, null, s.nominal, 0) * 100,
           decode(s.pr_kupon, null, s.nominal, 0) * 100 * p_count pc
      into l_name,
           l_metal,
           l_nominal,
           l_nominal_price,
           l_nominal_price_count
      from bars.spr_mon s
     where s.kod_money = p_code;
  
    if (p_type_id = 1) then
      l_unit_price     := (p_price - l_nominal_price) / 1.2;
      l_nominal_sum    := (p_price - l_nominal_price) / 1.2 * p_count;
      l_unit_price_vat := p_price;
    elsif (p_type_id = 0) then
      l_unit_price     := p_price;
      l_nominal_sum    := (p_price - l_nominal_price) * p_count;
      l_unit_price_vat := (p_price - l_nominal_price) * 1.2;
    else
      l_unit_price     := 0;
      l_nominal_sum    := 0;
      l_unit_price_vat := 0;
    end if;
  
    update bars.tmp_coin_invoice_detail d
       set d.rn             = l_rn,
           d.nd             = p_nd,
           d.code           = p_code,
           d.name           = l_name,
           d.metal          = l_metal,
           d.nominal        = l_nominal,
           d.cnt            = p_count,
           d.nominal_price  = l_nominal_price_count,
           d.unit_price_vat = l_unit_price_vat,
           d.unit_price     = l_unit_price,
           d.nominal_sum    = l_nominal_sum
     where d.userid = bars.user_id
       and d.rn = l_rn;
  
    if sql%rowcount = 0 then
      insert into bars.tmp_coin_invoice_detail
      values
        (l_rn,
         p_nd,
         p_code,
         l_name,
         l_metal,
         l_nominal,
         p_count,
         l_nominal_price,
         l_unit_price_vat,
         l_unit_price,
         l_nominal_sum,
         bars.user_id);
    end if;
  
    calculate_invoice(p_nd);
  
    --вставляем запись в справочник монет банка
    insert into BANK_MON
      (branch,
       KOD_NBU,
       NAME_MON,
       NOM_MON,
       CENA_NBU,
       NAME_,
       TYPE,
       TYPE_MET,
       KOD,
       CENA_NBU_OTP)
      select substr(SYS_CONTEXT('bars_context', 'user_branch'), 1, 8),
             p_code,
             l_name,
             l_nominal,
             l_unit_price,
             Substr(l_name || ' ' || l_metal || ' Ціна=' || l_unit_price ||
                    ' накл. №' || p_nd || 'від ' ||
                    to_char(l_invoice_dat, 'dd.mm.yyyy'),
                    1,
                    100),
             decode(upper(l_metal), 'СУПУТНЯ', 1, 0),
             0,
             (select nvl(max(kod), 0) + 1 from BANK_MON),
             l_unit_price
        from spr_mon
       where kod_money = p_code
         and not exists (select 1
                from BANK_MON
               where KOD_NBU = p_code
                 and CENA_NBU = l_unit_price);
  
  end add_invoice_detail;

  --------------------------------------------------------------------------------
  -- remove_invoice_detail - убирает строки накладной
  --
  procedure remove_invoice_detail(p_rn in number, p_code in varchar2) is
    l_nd varchar2(20);
  begin
    select d.nd
      into l_nd
      from tmp_coin_invoice_detail d
     where d.userid = bars.user_id
       and d.rn = p_rn
       and d.code = p_code;
  
    delete from bars.tmp_coin_invoice_detail d
     where d.userid = bars.user_id
       and d.rn = p_rn
       and d.code = p_code;
    for c in (select d.*
                from tmp_coin_invoice_detail d
               where d.rn > p_rn
                 and d.userid = bars.user_id) loop
      update tmp_coin_invoice_detail set rn = c.rn - 1 where rn = c.rn;
    end loop;
  
    calculate_invoice(l_nd);
  
  end remove_invoice_detail;

begin
  -- Initialization
  null;
end coin_invoice_mgr;
/

