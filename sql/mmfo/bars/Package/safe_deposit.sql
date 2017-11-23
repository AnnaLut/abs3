 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/safe_deposit.sql =========*** Run **
 PROMPT ===================================================================================== 

create or replace package safe_deposit is

  g_header_version  constant varchar2(64) := 'version 3.2 01/08/2017';
  g_awk_header_defs constant varchar2(512) := '';
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*  Назва : safe_deposit
  Опис  : Пакет для роботи з депозитними скриньками               */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*  16.07.07  vblagun 1. Створений                      */
  /*  16.07.07  vblagun 2.Додана підтримка індивідуальних рахунків 3600         */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  g_errmsg varchar2(3000);
  g_errmsg_dim constant number not null := 3000;
  g_type_sms number(5); --  тип СМС
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура створення депозитної скриньки           */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure create_safe(p_safe_id      in skrynka.snum%type, -- Номер скриньки
                        p_safe_type_id in skrynka.o_sk%type, -- Тип скриньки
                        p_nls          in accounts.nls%type -- Номер рахунку
                        );
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура закриття депозитної скриньки            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure close_safe(p_safe_id in skrynka.n_sk%type -- Номер скриньки
                       );

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура відкриття/модифікації договору            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure deal(p_safe_id            in skrynka.n_sk%type, -- Номер скриньки
                 p_safe_type_id       in skrynka.o_sk%type,
                 p_key_used           in skrynka.keyused%type,
                 p_key_number         in skrynka.keynumber%type,
                 p_key_count          in skrynka_nd.keycount%type,
                 p_bail_sum           in skrynka_nd.sdoc%type,
                 p_safe_man_id        in skrynka.isp_mo%type,
                 p_bank_trustee_id    in skrynka_nd.isp_dov%type,
                 p_deal_id            in skrynka_nd.nd%type,
                 p_deal_num           in skrynka_nd.ndoc%type,
                 p_tarif_id           in skrynka_nd.tariff%type,
                 p_deal_date          in skrynka_nd.docdate%type,
                 p_deal_start_date    in skrynka_nd.dat_begin%type,
                 p_deal_end_date      in skrynka_nd.dat_end%type,
                 p_custtype           in skrynka_nd.custtype%type,
                 p_fio                in skrynka_nd.fio%type,
                 p_okpo               in skrynka_nd.okpo1%type,
                 p_doc                in skrynka_nd.dokum%type,
                 p_issued             in skrynka_nd.issued%type,
                 p_address            in skrynka_nd.adres%type,
                 p_birthplace         in skrynka_nd.mr%type,
                 p_birthdate          in skrynka_nd.datr%type,
                 p_phone              in skrynka_nd.tel%type,
                 p_nmk                in skrynka_nd.nmk%type,
                 p_nlsk               in skrynka_nd.nlsk%type,
                 p_mfok               in skrynka_nd.mfok%type,
                 p_trustee_fio        in skrynka_nd.fio2%type,
                 p_trustee_okpo       in skrynka_nd.okpo2%type,
                 p_trustee_doc        in skrynka_nd.pasp2%type,
                 p_trustee_issued     in skrynka_nd.issued2%type,
                 p_trustee_address    in skrynka_nd.adres2%type,
                 p_trustee_birthplace in skrynka_nd.mr2%type,
                 p_trustee_birthdate  in skrynka_nd.datr2%type,
                 p_trustee_deal_num   in skrynka_nd.dover%type,
                 p_trustee_deal_start in skrynka_nd.dov_dat1%type,
                 p_trustee_deal_end   in skrynka_nd.dov_dat2%type,
                 p_is_import          in number default 0,
                 p_rnk                in skrynka_nd.rnk%type);

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура закриття депозитної скриньки            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure getcustomer(p_rnk        in skrynka.n_sk%type,
                        p_nmk        out customer.nmk%type, --(FIO OR NMK)
                        p_custtype   out customer.custtype%type,
                        p_okpo       out customer.okpo%type,
                        p_docserial  out person.ser%type,
                        p_docnumber  out person.numdoc%type,
                        p_docdate    out varchar2,
                        p_issued     out person.organ%type,
                        p_address    out customer.adr%type,
                        p_birthplace out person.bplace%type,
                        p_birthday   out varchar2,
                        p_tel        out person.teld%type);
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура отримання інформації про клієнта            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure set_extra_field(p_nd  in nd_txt.nd%type,
                            p_tag in nd_txt.tag%type,
                            p_val in nd_txt.txt%type);
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура привязки документа до скриньки            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure bind_doc(p_nd          in skrynka_nd.nd%type,
                     p_ref         in oper.ref%type,
                     p_bind_unbind in number);
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура вставки нового документа              */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure insert_doc(p_nd       in skrynka_nd.nd%type,
                       p_template in cc_docs.id%type,
                       p_text     in cc_docs.text%type);
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура створення/оновлення довіреності               */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/

  procedure merge_skrynka_attorney(p_nd          in skrynka_attorney.nd%type,
                                   p_rnk         in skrynka_attorney.rnk%type,
                                   p_date_from   in varchar2,
                                   p_date_to     in varchar2,
                                   p_cancel_date in varchar2);
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура привязки документа до скриньки            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure open_3600(p_nd  in skrynka_nd.nd%type,
                      p_nls in accounts.nls%type);

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура заповнення спецпараметра r011           */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure set_r011(p_nd in skrynka_nd.nd%type);

  function header_version return varchar2;
  function body_version return varchar2;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура відправки SMS повідомлення по сейфам у яких дата закінчення настаєчерез 5 днів      */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure skrn_send_sms;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Функція визначення номера телефона для кліента                                                                               */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  function f_get_cust_tel(rnk_ number) return varchar2;

end safe_deposit;
/
create or replace package body safe_deposit is
  g_body_version  constant varchar2(64) := 'version 3.11 02/10/2017';
  g_awk_body_defs constant varchar2(512) := '' || 'OBU' || chr(10);
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*  Назва : safe_deposit
  Опис  : Пакет для роботи з депозитними скриньками               */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*  16.07.07  vblagun 1. Створений                      */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  modcode constant varchar2(3) := 'SKR';
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура створення депозитної скриньки           */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure create_safe(p_safe_id      in skrynka.snum%type, -- Номер скриньки
                        p_safe_type_id in skrynka.o_sk%type, -- Тип скриньки
                        p_nls          in accounts.nls%type -- Номер рахунку
                        ) is
    ob22_   specparam_int.ob22%type; -- ob22
    dep_isp branch_parameters.val%type; --  виконавець
    dep_grp branch_parameters.val%type; --  група рахунків
    our_rnk branch_parameters.val%type; --  рнк банку
  
    l_count    skrynka_tip.cell_count%type;
    l_count_nd skrynka_tip.cell_count%type;
  
    macc   accounts.acc%type; --  код рахунку
    ntmp   integer; --  не використовується
    m_n_sk skrynka.n_sk%type; --
    m_snum skrynka.snum%type; --
    m_mfo  accounts.kf%type;
  
  begin
    begin
      select snum
        into m_snum
        from skrynka
       where snum = p_safe_id
         and branch = sys_context('bars_context', 'user_branch')
      
      ;
    
      bars_error.raise_nerror(modcode,
                              'SKRYNKA_ALREADY_EXISTS',
                              to_char(p_safe_id));
    
    exception
      when no_data_found then
        null;
    end;
  
    select nvl(max(cell_count), 0)
      into l_count
      from skrynka_tip
     where o_sk = p_safe_type_id;
  
    select count(n_sk)
      into l_count_nd
      from skrynka
     where o_sk = p_safe_type_id;
  
    if l_count <= l_count_nd then
      raise_application_error(- (20777),
                              '\\' ||
                              '     Створення нової чарунки не можливо. Перевищено кількість чарунок.',
                              true);
    end if;
  
    begin
      select acc
        into macc
        from accounts
       where nls = p_nls
         and kv = 980;
    
      bars_error.raise_nerror(modcode,
                              'ACCOUNT_ALREADY_EXISTS',
                              to_char(p_nls));
    exception
      when no_data_found then
        null;
    end;
  
    select val
      into dep_isp
      from branch_parameters
     where tag = 'DEP_ISP'
       and branch = sys_context('bars_context', 'user_branch');
    select val
      into our_rnk
      from branch_parameters
     where tag = 'DEP_SKRN'
       and branch = sys_context('bars_context', 'user_branch');
    select val
      into dep_grp
      from branch_parameters
     where tag = 'DEP_GRP'
       and branch = sys_context('bars_context', 'user_branch');
  
    op_reg_ex(99,
              0,
              0,
              dep_grp,
              ntmp,
              our_rnk,
              p_nls,
              980,
              substr('Заст. за ключ від банк.сейфу № ' ||
                     to_char(p_safe_id),
                     1,
                     38),
              'ODB',
              dep_isp,
              macc,
              '1',
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              sys_context('bars_context', 'user_branch'),
              null);
  
    insert into skrynka
      (snum, o_sk, branch)
    values
      (p_safe_id,
       p_safe_type_id,
       sys_context('bars_context', 'user_branch'))
    returning n_sk into m_n_sk;
    insert into skrynka_acc (acc, n_sk, tip) values (macc, m_n_sk, 'M');
  
    -- вставка показника ОБ22
    select ob22 into ob22_ from skrynka_acc_tip where tip = 'M';
    accreg.setaccountsparam(macc, 'OB22', ob22_);
  
  end create_safe;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура закриття депозитної скриньки            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure close_safe(p_safe_id in skrynka.n_sk%type -- Номер скриньки
                       ) is
    p_nd  skrynka_nd.nd%type;
    p_acc accounts.acc%type;
  begin
    begin
      select n.nd
        into p_nd
        from skrynka s, skrynka_nd n
       where s.n_sk = n.n_sk
         and n.sos = 0
         and s.n_sk = p_safe_id;
    
      bars_error.raise_nerror(modcode,
                              'SKRYNKA_HAS_ND',
                              to_char(p_safe_id),
                              to_char(p_nd));
    exception
      when no_data_found then
        null;
    end;
  
    begin
      select a.acc
        into p_acc
        from accounts a, skrynka s, skrynka_acc g
       where s.n_sk = p_safe_id
         and s.n_sk = g.n_sk
         and g.acc = a.acc
         and a.ostc = 0
         and a.ostb = 0
         and a.ostf = 0
         and (a.dapp < bankdate or a.dapp is null)
         and g.tip = 'M';
    exception
      when no_data_found then
        bars_error.raise_nerror(modcode,
                                'CANNOT_CLOSE_ACCOUNT',
                                to_char(p_acc));
    end;
  
    delete from skrynka_nd_ref
     where nd in (select n.nd
                    from skrynka s, skrynka_nd n
                   where s.n_sk = n.n_sk
                     and n.sos = 15
                     and s.n_sk = p_safe_id);
  
    -- Ощадбанк доручення
    delete from bars.skrynka_attorney
     where nd in (select n.nd
                    from skrynka s, skrynka_nd n
                   where s.n_sk = n.n_sk
                     and n.sos = 15
                     and s.n_sk = p_safe_id);
  
    delete from skrynka_nd
     where nd in (select n.nd
                    from skrynka s, skrynka_nd n
                   where s.n_sk = n.n_sk
                     and n.sos = 15
                     and s.n_sk = p_safe_id);
  
    delete from skrynka_acc where n_sk = p_safe_id;
    delete from skrynka where n_sk = p_safe_id;
    update accounts set dazs = bankdate where acc = p_acc;
  end close_safe;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*               Процедура відкриття/модифікації договору              */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure deal(p_safe_id            in skrynka.n_sk%type, -- Номер скриньки
                 p_safe_type_id       in skrynka.o_sk%type,
                 p_key_used           in skrynka.keyused%type,
                 p_key_number         in skrynka.keynumber%type,
                 p_key_count          in skrynka_nd.keycount%type,
                 p_bail_sum           in skrynka_nd.sdoc%type,
                 p_safe_man_id        in skrynka.isp_mo%type,
                 p_bank_trustee_id    in skrynka_nd.isp_dov%type,
                 p_deal_id            in skrynka_nd.nd%type,
                 p_deal_num           in skrynka_nd.ndoc%type,
                 p_tarif_id           in skrynka_nd.tariff%type,
                 p_deal_date          in skrynka_nd.docdate%type,
                 p_deal_start_date    in skrynka_nd.dat_begin%type,
                 p_deal_end_date      in skrynka_nd.dat_end%type,
                 p_custtype           in skrynka_nd.custtype%type,
                 p_fio                in skrynka_nd.fio%type,
                 p_okpo               in skrynka_nd.okpo1%type,
                 p_doc                in skrynka_nd.dokum%type,
                 p_issued             in skrynka_nd.issued%type,
                 p_address            in skrynka_nd.adres%type,
                 p_birthplace         in skrynka_nd.mr%type,
                 p_birthdate          in skrynka_nd.datr%type,
                 p_phone              in skrynka_nd.tel%type,
                 p_nmk                in skrynka_nd.nmk%type,
                 p_nlsk               in skrynka_nd.nlsk%type,
                 p_mfok               in skrynka_nd.mfok%type,
                 p_trustee_fio        in skrynka_nd.fio2%type,
                 p_trustee_okpo       in skrynka_nd.okpo2%type,
                 p_trustee_doc        in skrynka_nd.pasp2%type,
                 p_trustee_issued     in skrynka_nd.issued2%type,
                 p_trustee_address    in skrynka_nd.adres2%type,
                 p_trustee_birthplace in skrynka_nd.mr2%type,
                 p_trustee_birthdate  in skrynka_nd.datr2%type,
                 p_trustee_deal_num   in skrynka_nd.dover%type,
                 p_trustee_deal_start in skrynka_nd.dov_dat1%type,
                 p_trustee_deal_end   in skrynka_nd.dov_dat2%type,
                 p_is_import          in number default 0,
                 p_rnk                in skrynka_nd.rnk%type) is
    ob22_    accounts.ob22%type;
    l_nd     skrynka.n_sk%type;
    mainacc_ accounts%rowtype;
    nacc     accounts.acc%type;
    r011_    number(1);
    l_creat  int := 0; --  0 - вже відкритий 1 - відкриваєм
    err_phonecheck exception;
  begin
  
    if p_phone is null then
      raise err_phonecheck;
    end if;
  
    begin
      select nd
        into l_nd
        from skrynka_nd
       where n_sk = p_safe_id
         and sos = 0;
      -- договір вже існує
    exception
      when no_data_found then
        -- відкриваємо новий
        skrn.p_dep_skrn(bankdate, bankdate, p_safe_id, 0, 0, '');
        l_creat := 1;
      
        if p_deal_id is not null then
          l_nd := p_deal_id;
        else
          select bars_sqnc.get_nextval('S_CC_DEAL') into l_nd from dual;
        end if;
      
        select a.*
          into mainacc_
          from skrynka_acc s, accounts a
         where s.n_sk = p_safe_id
           and s.acc = a.acc
           and s.tip = 'M';
      
        insert into skrynka_nd
          (nd,
           n_sk,
           keycount,
           isp_dov,
           ndoc,
           sdoc,
           tariff,
           docdate,
           dat_begin,
           dat_end,
           custtype,
           fio,
           okpo1,
           dokum,
           issued,
           adres,
           mr,
           datr,
           tel,
           nmk,
           nlsk,
           mfok,
           fio2,
           okpo2,
           pasp2,
           issued2,
           adres2,
           mr2,
           datr2,
           dover,
           dov_dat1,
           dov_dat2,
           sos,
           nls,
           imported,
           rnk)
        values
          (l_nd,
           p_safe_id,
           p_key_count,
           p_bank_trustee_id,
           p_deal_num,
           p_bail_sum,
           p_tarif_id,
           p_deal_date,
           p_deal_start_date,
           p_deal_end_date,
           p_custtype,
           p_fio,
           p_okpo,
           p_doc,
           p_issued,
           p_address,
           p_birthplace,
           p_birthdate,
           p_phone,
           p_nmk,
           p_nlsk,
           p_mfok,
           p_trustee_fio,
           p_trustee_okpo,
           p_trustee_doc,
           p_trustee_issued,
           p_trustee_address,
           p_trustee_birthplace,
           p_trustee_birthdate,
           p_trustee_deal_num,
           p_trustee_deal_start,
           p_trustee_deal_end,
           0,
           mainacc_.nls,
           p_is_import,
           p_rnk);
      
        begin
          select a.acc
            into nacc
            from skrynka_nd_acc s, accounts a
           where s.nd = l_nd
             and s.acc = a.acc
             and s.tip = 'D';
        
          select (case
                   when p_custtype = 3 then
                    ob22
                   else
                    ob22_u
                 end)
            into ob22_
            from skrynka_acc_tip
           where tip = 'D';
        
          accreg.setaccountsparam(nacc, 'OB22', ob22_);
        
        exception
          when no_data_found then
            null;
        end;
      
    end;
  
    begin
      select nd
        into l_nd
        from skrynka_nd
       where n_sk = p_safe_id
         and sos = 0;
    exception
      when no_data_found then
        -- чомусь договір все ж не відкрився, причому не було викинуто ніякої помилки
        bars_error.raise_nerror(modcode,
                                'DEAL_NOT_CREATED',
                                to_char(p_safe_id));
    end;
    if p_deal_id is not null then
      l_nd := p_deal_id;
    end if;
  
    update skrynka_nd
       set keycount  = p_key_count,
           isp_dov   = p_bank_trustee_id,
           ndoc      = p_deal_num,
           sdoc      = p_bail_sum,
           tariff    = p_tarif_id,
           docdate   = p_deal_date,
           dat_begin = p_deal_start_date,
           dat_end   = p_deal_end_date,
           custtype  = p_custtype,
           fio       = p_fio,
           okpo1     = p_okpo,
           dokum     = p_doc,
           issued    = p_issued,
           adres     = p_address,
           mr        = p_birthplace,
           datr      = p_birthdate,
           tel       = p_phone,
           nmk       = p_nmk,
           nlsk      = p_nlsk,
           mfok      = p_mfok,
           fio2      = p_trustee_fio,
           okpo2     = p_trustee_okpo,
           pasp2     = p_trustee_doc,
           issued2   = p_trustee_issued,
           adres2    = p_trustee_address,
           mr2       = p_trustee_birthplace,
           datr2     = p_trustee_birthdate,
           dover     = p_trustee_deal_num,
           dov_dat1  = p_trustee_deal_start,
           dov_dat2  = p_trustee_deal_end,
           rnk       = p_rnk
     where nd = l_nd;
  
    update skrynka
       set keyused   = p_key_used,
           keynumber = p_key_number,
           isp_mo    = p_safe_man_id,
           o_sk      = p_safe_type_id
     where n_sk = p_safe_id;
  
    update accounts
       set mdate = p_deal_end_date
     where acc in (select acc
                     from skrynka_acc a, skrynka s
                    where a.n_sk = s.n_sk
                      and s.n_sk = p_safe_id
                      and a.tip = 'M');
  
    -- проставляємо r011
    set_r011(l_nd);
  
    if p_is_import != 1 and l_creat = 1 then
      skrn.p_calc_tariff(p_safe_id, l_nd);
    end if;
  
    -- не вказаний номер телефона кліента
  exception
    when err_phonecheck then
      bars_error.raise_nerror(modcode,
                              'NOT_PHONE_CLIENT',
                              to_char(p_safe_id));
    
  end deal;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура отримання інформації про клієнта            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/

  procedure getcustomer(p_rnk        in skrynka.n_sk%type,
                        p_nmk        out customer.nmk%type, --(FIO OR NMK)
                        p_custtype   out customer.custtype%type,
                        p_okpo       out customer.okpo%type,
                        p_docserial  out person.ser%type,
                        p_docnumber  out person.numdoc%type,
                        p_docdate    out varchar2,
                        p_issued     out person.organ%type,
                        p_address    out customer.adr%type,
                        p_birthplace out person.bplace%type,
                        p_birthday   out varchar2,
                        p_tel        out person.teld%type) is
  begin
    select c.nmk,
           c.custtype,
           c.okpo,
           nvl(p.ser, ' '),
           nvl(p.numdoc, ' '),
           nvl(to_char(p.pdate, 'DD/MM/YYYY'), '01/01/0001'),
           nvl(p.organ, ' '),
           nvl(c.adr, ' '),
           nvl(p.bplace, ' '),
           nvl(to_char(p.bday, 'DD/MM/YYYY'), '01/01/0001'),
           nvl(f_get_cust_tel(c.rnk), ' ')
      into p_nmk,
           p_custtype,
           p_okpo,
           p_docserial,
           p_docnumber,
           p_docdate,
           p_issued,
           p_address,
           p_birthplace,
           p_birthday,
           p_tel
      from customer c, person p
     where c.rnk = p_rnk
       and p.rnk(+) = c.rnk;
  end getcustomer;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура отримання інформації про клієнта            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure set_extra_field(p_nd  in nd_txt.nd%type,
                            p_tag in nd_txt.tag%type,
                            p_val in nd_txt.txt%type) is
  begin
    update nd_txt
       set txt = p_val
     where nd = p_nd
       and tag = p_tag;
  
    if sql%rowcount = 0 then
      insert into nd_txt (nd, tag, txt) values (p_nd, p_tag, p_val);
    end if;
  end set_extra_field;
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура привязки документа до скриньки            */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure bind_doc(p_nd          in skrynka_nd.nd%type,
                     p_ref         in oper.ref%type,
                     p_bind_unbind in number -- 0 - UNBIND, 1 - BIND
                     ) is
  begin
    if (p_bind_unbind = 0) then
      delete from skrynka_nd_ref
       where nd = p_nd
         and ref = p_ref;
    elsif (p_bind_unbind = 1) then
      insert into skrynka_nd_ref
        (nd, ref, bdate)
      values
        (p_nd, p_ref, bankdate);
    end if;
  end bind_doc;
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура вставки нового документа              */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure insert_doc(p_nd       in skrynka_nd.nd%type,
                       p_template in cc_docs.id%type,
                       p_text     in cc_docs.text%type) is
    p_state cc_docs.state%type;
    p_adds  cc_docs.adds%type;
  begin
  
    select nvl(max(adds), -1) + 1 into p_adds from cc_docs where nd = p_nd;
  
    /*
    UPDATE cc_docs
       SET text = p_text,
           version = sysdate,
       STATE = 1
    WHERE id = P_TEMPLATE
       AND nd = p_nd;
    
    IF SQL%ROWCOUNT = 0 THEN
    */
    insert into cc_docs
      (id, nd, adds, text, version, state)
    values
      (p_template, p_nd, p_adds, p_text, sysdate, 1);
    /*END IF;*/
  end insert_doc;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура відкриття 3600              */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure open_3600(p_nd  in skrynka_nd.nd%type,
                      p_nls in accounts.nls%type) is
    ob22_    specparam_int.ob22%type; -- ob22
    dep_isp  branch_parameters.val%type; --  виконавець
    dep_grp  branch_parameters.val%type; --  група рахунків
    our_rnk  branch_parameters.val%type; --  рнк банку
    macc     accounts.acc%type; --  код рахунку
    ntmp     integer; --  не використовується
    l_ourmfo varchar2(6) := '300205';
  begin
    begin
      select acc
        into macc
        from accounts
       where nls = p_nls
         and kv = 980;
    
      bars_error.raise_nerror(modcode,
                              'ACCOUNT_ALREADY_EXISTS',
                              to_char(p_nls));
    exception
      when no_data_found then
        null;
    end;
  
    select val
      into dep_isp
      from branch_parameters
     where tag = 'DEP_ISP'
       and branch = sys_context('bars_context', 'user_branch');
    select val
      into our_rnk
      from branch_parameters
     where tag = 'DEP_SKRN'
       and branch = sys_context('bars_context', 'user_branch');
    select val
      into dep_grp
      from branch_parameters
     where tag = 'DEP_GRP'
       and branch = sys_context('bars_context', 'user_branch');
  
    op_reg_ex(99,
              0,
              0,
              dep_grp,
              ntmp,
              our_rnk,
              p_nls,
              980,
              'Приб.майб.пер.від ор.пл.-реф. дог.' || to_char(p_nd),
              'ODB',
              dep_isp,
              macc,
              '1',
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              sys_context('bars_context', 'user_branch'),
              null);
  
    insert into skrynka_nd_acc (acc, nd, tip) values (macc, p_nd, 'D');
  
    -- вставка показника ОБ22
    --   select ob22 into ob22_ from SKRYNKA_ACC_TIP where tip = 'D';
    --   accreg.setAccountSParam (macc, 'OB22', ob22_);
  
  end open_3600;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*                Процедура перевірки дат при створенні/оновленні довіреності                                */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/

  procedure check_attorney_dates(p_nd          in skrynka_attorney.nd%type,
                                 p_date_from   in varchar2,
                                 p_date_to     in varchar2,
                                 p_cancel_date in varchar2) is
    l_date_from   date;
    l_date_to     date;
    l_cancel_date date;
  begin
    begin
      select trunc(dat_begin), trunc(dat_end)
        into l_date_from, l_date_to
        from skrynka_nd
       where nd = p_nd;
    exception
      when no_data_found then
        raise_application_error(-20101,
                                'Не знайдено договір!');
    end;
  
    if (l_date_from > to_date(p_date_from, 'DD/MM/YYYY')) then
      raise_application_error(-20102,
                              'Дата початку дії довіреності не може бути меншою за дату початку договору!');
    elsif ((l_date_to < to_date(p_date_to, 'DD/MM/YYYY')) or
          (l_date_to < to_date(p_cancel_date, 'DD/MM/YYYY'))) then
      raise_application_error(-20103,
                              'Дата завершення дії довіреності не може бути більшою за дату завершення договору!');
    elsif ((to_date(p_date_from, 'DD/MM/YYYY') < trunc(sysdate)) or
          (to_date(p_date_to, 'DD/MM/YYYY') < trunc(sysdate))) then
      raise_application_error(-20104,
                              'Дати дії довіреності не можуть бути меншими за поточну дату!');
    else
      null;
    end if;
  
  end check_attorney_dates;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура створення/оновлення довіреності               */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/

  procedure merge_skrynka_attorney(p_nd          in skrynka_attorney.nd%type,
                                   p_rnk         in skrynka_attorney.rnk%type,
                                   p_date_from   in varchar2,
                                   p_date_to     in varchar2,
                                   p_cancel_date in varchar2) is
  begin
    check_attorney_dates(p_nd, p_date_from, p_date_to, p_cancel_date);
  
    merge into skrynka_attorney t1
    using (select p_nd          as nd,
                  p_rnk         as rnk,
                  p_date_from   as date_from,
                  p_date_to     as date_to,
                  p_cancel_date as cancel_date
             from dual) t2
    on (t1.nd = t2.nd and t1.rnk = t2.rnk)
    when matched then
      update
         set t1.date_from   = to_date(t2.date_from, 'DD/MM/YYYY'),
             t1.date_to     = to_date(t2.date_to, 'DD/MM/YYYY'),
             t1.cancel_date = to_date(t2.cancel_date, 'DD/MM/YYYY')
    when not matched then
      insert
        (t1.nd, t1.rnk, t1.date_from, t1.date_to, t1.cancel_date)
      values
        (t2.nd,
         t2.rnk,
         to_date(t2.date_from, 'DD/MM/YYYY'),
         to_date(t2.date_to, 'DD/MM/YYYY'),
         to_date(t2.cancel_date, 'DD/MM/YYYY'));
  
  end merge_skrynka_attorney;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура заповнення спецпараметра r011           */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure set_r011(p_nd in skrynka_nd.nd%type) is
    l_okpo     skrynka_nd.okpo1%type;
    l_custtype skrynka_nd.custtype%type;
    l_acc      skrynka_acc.acc%type;
    l_r011     specparam.r011%type;
  begin
    select okpo1, custtype
      into l_okpo, l_custtype
      from skrynka_nd
     where nd = p_nd;
  
    select acc
      into l_acc
      from skrynka_acc
     where n_sk in (select n_sk from skrynka_nd where nd = p_nd)
       and tip = 'M';
  
    -- якщо customer.sed = '91'
    begin
      select 1
        into l_r011
        from customer
       where date_off is null
         and okpo = l_okpo
         and sed = '91'
         and l_okpo is not null
         and l_okpo != '55555'
         and l_okpo != '000000000'
         and rownum = 1;
    exception
      when no_data_found then
        -- r011 : 1 - юр, 2 - фіз
        l_r011 := l_custtype - 1;
    end;
  
    accreg.setaccountsparam(l_acc, 'R011', l_r011);
  
  end set_r011;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Процедура відправки SMS повідомлення по сейфам у яких дата закінчення настаєчерез 5 днів      */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  procedure skrn_send_sms is
  
    l_msgid  msg_submit_data.msg_id%type := null;
    l_crtime date := sysdate;
    l_encode varchar2(3);
    l_msg    msg_submit_data.msg_text%type;
    l_phone  msg_submit_data.msg_text%type;
    l_kf     varchar2(6);
    l_datend date;
    l_state  number(5);
    l_cnt    number(5);
    l_cnt_s  number(5);
    o_errmsg varchar2(254);
    l_title  varchar2(60) := 'dpt_web.skrn_send_sms: ';
  begin
  
    bars_audit.trace('%s started', l_title);
  
    -- пошук номеру договору та мобільного телефону
    for skrn in (select n.nd, f_get_cust_tel(n.rnk) tel, n.dat_end, n.kf
                   from skrynka_nd n, customer c
                  where n.sos <> 15
                    and c.rnk = n.rnk
                    and c.custtype = 3
                    and n.dat_end = trunc(sysdate) + 5)
    
     loop
    
      bars_audit.trace('%s loop nd = %s tel = %s ',
                       l_title,
                       to_char(skrn.nd),
                       to_char(skrn.tel));
    
      g_type_sms := 1; -- СМС за закрытие;
    
      begin
      
        savepoint sp1;
      
        select count(1)
          into l_cnt
          from skrn_msg sm
         where sm.branch = skrn.kf
           and sm.nd = skrn.nd
           and sm.type_sms = g_type_sms;
      
        if l_cnt = 0 then
        
          --  сохраняем информацию по отправке СМС в таблицу skrn_msg
          insert into skrn_msg
            (msg_id, change_time, branch, nd, type_sms, state, error)
          values
            (null, sysdate, skrn.kf, skrn.nd, g_type_sms, 0, null);
        
          bars_audit.trace('%s insert nd = %s state = 0',
                           l_title,
                           to_char(skrn.nd));
        
        end if;
      
      exception
        when others then
          rollback to sp1;
          bars_audit.error(l_title || ' insert: Error => ' ||
                           substr(skrn.nd || sqlerrm || chr(10) ||
                                  dbms_utility.format_error_backtrace ||
                                  dbms_utility.format_call_stack(),
                                  0,
                                  2000));
      end;
    
      begin
        savepoint sp3;
        -- проверяем есть ли запись в таблице skrn_msg
        select count(1)
          into l_cnt_s
          from skrn_msg sm
         where sm.branch = skrn.kf
           and sm.nd = skrn.nd
           and sm.type_sms = g_type_sms;
      
        -- если запись есть, идем дальше смотрим на состояние
        if l_cnt_s <> 0 then
        
          select sm.state
            into l_state
            from skrn_msg sm
           where sm.branch = skrn.kf
             and sm.nd = skrn.nd
             and sm.type_sms = g_type_sms;
        
          --если состояние <> 1, то пытаемся обработать запись
          if l_state <> 1 then
          
            l_msgid  := null;
            l_encode := 'lat'; --'cyr';
            l_phone  := skrn.tel;
            l_kf     := skrn.kf;
            l_datend := to_date(skrn.dat_end, 'dd.mm.yyyy');
            l_msg    := 'Termin orendy safe zakinchuetsya ';
          
            case length(l_phone)
              when 9 then
                l_phone := '+380' || l_phone;
              when 10 then
                l_phone := '+38' || l_phone;
              when 12 then
                l_phone := '+' || l_phone;
              else
                null;
            end case;
          
            -- отправляем данные на создание сообщения
            begin
              savepoint sp2;
            
              bars_sms.create_msg(p_msgid           => l_msgid,
                                  p_creation_time   => l_crtime,
                                  p_expiration_time => l_crtime + 1,
                                  p_phone           => l_phone,
                                  p_encode          => l_encode,
                                  p_msg_text        => substr(l_msg ||
                                                              l_datend,
                                                              1,
                                                              160),
                                  p_kf              => l_kf);
            
              o_errmsg := null;
            
              update bars.skrn_msg
                 set msg_id      = l_msgid,
                     change_time = sysdate,
                     state       = 1,
                     error       = o_errmsg
               where branch = skrn.kf
                 and nd = skrn.nd
                 and state <> 1
                 and type_sms = g_type_sms;
            
              bars_audit.trace('%s update: Processed nd = %s ',
                               l_title,
                               to_char(skrn.nd));
            
            exception
              when others then
                rollback to sp2;
              
                -- записіваем ошибку в таблицу skrn_msg
                o_errmsg := substr(skrn.nd || sqlerrm || chr(10) ||
                                   dbms_utility.format_error_backtrace ||
                                   dbms_utility.format_call_stack(),
                                   0,
                                   254);
              
                update bars.skrn_msg
                   set msg_id      = l_msgid,
                       change_time = sysdate,
                       state       = -1,
                       error       = o_errmsg
                 where branch = skrn.kf
                   and nd = skrn.nd
                   and state <> 1
                   and type_sms = g_type_sms;
              
                bars_audit.error(l_title || ' insert: Error => ' ||
                                 substr(skrn.nd || sqlerrm || chr(10) ||
                                        dbms_utility.format_error_backtrace ||
                                        dbms_utility.format_call_stack(),
                                        0,
                                        2000));
              
            end;
          end if;
        end if;
      
      exception
        when others then
          rollback to sp3;
          bars_audit.error(l_title || 'loop end: Error => ' ||
                           substr(skrn.nd || sqlerrm || chr(10) ||
                                  dbms_utility.format_error_backtrace ||
                                  dbms_utility.format_call_stack(),
                                  0,
                                  2000));
      end;
    
    end loop;
    bars_audit.trace('%s end_loop', l_title);
  
    bars_audit.trace('%s exit', l_title);
  
  exception
    when others then
      bars_audit.error(l_title || ' insert: Error => ' ||
                       substr(sqlerrm || chr(10) ||
                              dbms_utility.format_error_backtrace ||
                              dbms_utility.format_call_stack(),
                              0,
                              2000));
    
  end skrn_send_sms;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Функція визначення номера телефона для кліента                                                                               */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  function f_get_cust_tel(rnk_ number) return varchar2 is
    tel_ varchar2(20);
  begin
    select case c.custtype
             when 3 then
              (select nvl(w.value, p.cellphone)
                 from person p, customerw w
                where p.rnk = c.rnk
                  and p.rnk = w.rnk
                  and lower(w.tag) = 'mpno')
             when 2 then
              (select nvl(w.value, ' ')
                 from customerw w
                where w.rnk = c.rnk
                  and lower(w.tag) = 'mpno')
             else
              null
           end as tel
      into tel_
      from customer c
     where c.rnk = rnk_;
  
    return tel_;
  
  exception
    when no_data_found then
      tel_ := ' ';
      return tel_;
  end f_get_cust_tel;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Версія заголовку пакета           */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  function header_version return varchar2 is
  begin
    return 'Package header safe_deposit ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
  end header_version;

  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  /*        Версія пакета           */
  /*-------------------------------------------------------------------------------------------------------------------------------------*/
  function body_version return varchar2 is
  begin
    return 'Package body safe_deposit ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;

end safe_deposit;
/
 show err;
 
PROMPT *** Create  grants  SAFE_DEPOSIT ***
grant EXECUTE                                                                on SAFE_DEPOSIT    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SAFE_DEPOSIT    to DEP_SKRN;
grant EXECUTE                                                                on SAFE_DEPOSIT    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/safe_deposit.sql =========*** End **
 PROMPT ===================================================================================== 


