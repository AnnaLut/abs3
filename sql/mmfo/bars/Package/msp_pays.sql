CREATE OR REPLACE package BARS.msp_pays is

  g_mfo  oper.mfoa%type  := '300465';
  -- g_nls  oper.nlsa%type := '290642012'; -- тест дев
  g_nls  oper.nlsa%type  := '29094003004651'; -- тестовий полігон
  g_okpo oper.id_a%type  := '00032129';  -- тест
  g_nms  oper.nam_a%type := 'Оплата пенсійних реєстрів'; -- в ГОУ
  g_kv   oper.kv%type    := 980;
  g_paypack_size pls_integer := 100;


  -- Версiя пакету
  g_header_version constant varchar2(64) := 'version 1.02 11/01/2018';
  -- header_version - возвращает версию заголовка пакета

  function header_version return varchar2;
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  procedure pay_social(p_id in integer, p_ref out number);

  -- получение буферов для подписи
  procedure get_doc_buffers(p_ref     in integer, p_key     in varchar2, p_int_buf out varchar2,
                            p_sep_buf out varchar2);

  -- установка подписей на документ
  procedure put_doc_sign(p_ref in integer, p_key in varchar2, p_int_sign in varchar2, p_sep_sign in varchar2);

   -- получение буферов для подписи
  procedure get_doc_buffers2(p_ref     in integer, p_key     in varchar2, p_buf_int out varchar2, p_buf_ext out varchar2);

  -- установка подписей на документ
  procedure put_doc_sign2(p_ref in integer, p_key in varchar2, p_int_sign in varchar2, p_sep_sign in varchar2);

 /* procedure pay_ready_rec;*/

end msp_pays;
/


CREATE OR REPLACE package body BARS.msp_pays is

  -- Версiя пакету
  g_body_version constant varchar2(64) := 'version 1.02 11/01/2018';

  g_errmsg varchar2(4000);

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header pfu_pays ' || g_header_version || '.';
  end header_version;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body pfu_pays ' || g_body_version || '.';
  end body_version;

   --Процедура зміни статуса платежу
  procedure set_paym_state_cancel(p_id in integer,
                                  p_state in integer) is
  begin
     update pfu.pfu_file_records p
        set p.state = p_state
      where p.id = p_id;
     commit;
  end;

  -- Процедура виплати пенсії
  procedure pay_social(p_id in integer, p_ref out number) is
    l_rec_row        msp.msp_file_records%rowtype;
    --l_rec_file      pfu.pfu_file%rowtype;
    --l_rec_req       pfu.pfu_envelope_request%rowtype;
    g_grc_nls_trans  accounts.nls%type;
    g_grc_nls_t00    accounts.nls%type;

    l_ref           oper.ref%type;
    l_tt            tts.tt%type := 'PFR';
    l_vob           oper.vob%type := 6;
    l_dk            oper.dk%type := 1;
    l_bankdate      date;
    l_okpo          oper.id_b%type;
    l_nls_a         oper.nlsa%type;
    l_nls_b         oper.nlsa%type;
    l_nam_b         oper.nam_b%type;
    l_mfo_b         varchar2(9);
    l_mfo           varchar2(9);
    l_nazn          varchar2(160);
    l_err           varchar2(4000);
    l_doc           varchar2(30);
    l_date_off      date;
    --l_rec_resources exchange_of_resources%rowtype;
    l_branch        branch.branch%type;

    l_sos number;
    l_rec number;

  begin
    bc.go(300465);
    --Вичитаєм рядок з таблиці реєстру
    select d.*
      into l_rec_row
      from msp.msp_file_records d
     where d.id = p_id
       for update;

    select to_char(f.receiver_mfo)
      into l_mfo
      from msp.msp_files f
     where f.id = l_rec_row.file_id;

    select p.okpo into l_okpo
      from pfu.pfu_pensioner p
     where (p.rnk,p.kf) in (select pa.rnk,pa.kf
                              from pfu.pfu_pensacc pa
                             where pa.kf = l_mfo
                               and pa.nls = to_char(l_rec_row.deposit_acc)
                               and pa.dazs is null);

    if not regexp_like(l_okpo, '^\d{8,10}$', 'i') then
      l_okpo := '0000000000';
    end if;

    begin
          select p.ser||p.numdoc, date_off into l_doc, l_date_off
            from pfu.pfu_pensioner p
           where p.rnk = (select pa.rnk
                            from pfu.pfu_pensacc pa
                           where pa.nls = to_char(l_rec_row.deposit_acc)
                             and pa.kf = l_mfo)
             and p.kf = l_mfo;
          if (l_date_off is not null) then
            raise_application_error(-20000, 'Клієнт закритий!!!');
          end if;
        exception when no_data_found
                       then raise_application_error(-20000, 'Клієнта не знайдено!!!');
    end;


     if (l_mfo = '300465') and substr(l_rec_row.deposit_acc, 1, 4) = '2620' then
       l_tt := '024';
     elsif (l_mfo = '300465') and substr(l_rec_row.deposit_acc, 1, 4) = '2625' then
       l_tt := 'PKX';
     end if;


 --    bars_audit.info(l_rec_row.full_rec);

    --Вичитаєм рядок з таблиці файлу
    /*
    select f.*
      into l_rec_file
      from pfu.pfu_file f
     where f.id = l_rec_fd.file_id;
     */
    --Вичитаєм рядок з таблиці конверту
    /*
    select r.*
      into l_rec_req
      from pfu.pfu_envelope_request r
     where r.id = l_rec_file.ENVELOPE_REQUEST_id;
   */
   --  получаем номер транзитного счета
    begin
      select a.acc_num
        into g_grc_nls_trans
        from msp.msp_acc_trans_2909 a
       where a.kf = l_mfo;
    exception
      when others then
        raise_application_error(-20000,
                                'Невозможно получить счет T00 ГРЦ',
                                true);
    end;

    if (l_mfo = '300465') then
      g_grc_nls_t00 := '2924311'; -- транзитный для ГРЦ, необходимо поправить в случае его смены
    else
      select get_proc_nls('T00',980) into g_grc_nls_t00 from dual;
    end if;



    bars_audit.info(g_grc_nls_t00);

    --Блок ініціалізації
    begin
      l_bankdate  := gl.bd;
      l_nls_a     := null;

      l_nam_b := substr(translate(l_rec_row.full_name,'Ў°Ї','ІЇЄ'), 1, 38);

      if length(l_mfo)> 6 then
        l_mfo_b := substr(l_mfo, 4, 6);
      else
        l_mfo_b := l_mfo;
      end if;
      l_nazn  := substr('Оплата реестров УПСЗН;'||l_rec_row.full_name||';'||l_rec_row.numident||';'||to_char(sysdate,'DD.MM.YYYY'), 1, 160);
    end;

      begin
        savepoint sp_before;

        gl.ref(l_ref);

        bars_audit.info ('Pens:'||l_ref);

        gl.in_doc3(l_ref,
                   l_tt,
                   l_vob,
                   l_ref,
                   sysdate,
                   l_bankdate,
                   l_dk,
                   g_kv,
                   l_rec_row.pay_sum,
                   g_kv,
                   l_rec_row.pay_sum,
                   null,
                   l_bankdate,
                   l_bankdate,
                   g_nms,
                   g_grc_nls_trans,
                   g_mfo,
                   l_nam_b,
                   ltrim(l_rec_row.deposit_acc,'0'),
                   l_mfo_b,
                   l_nazn,
                   '#ф'||l_doc||'#',
                   g_okpo,
                   l_okpo,--l_rec_row.numident, ОКПО з ЄБП
                   null,
                   null,
                   0,
                   0,
                   null);

          -- оплата платежа в ГРЦ
          if (l_mfo != '300465') then
              gl.payv(0,
                      l_ref,
                      l_bankdate,
                      l_tt,
                      1,
                      g_kv,
                      g_grc_nls_trans,
                      l_rec_row.pay_sum,
                      g_kv,
                      g_grc_nls_t00,
                      l_rec_row.pay_sum);
          else paytt(0,
                        l_ref,
                        l_bankdate,
                        l_tt,
                        1,
                        g_kv,
                        g_grc_nls_trans,
                        l_rec_row.pay_sum,
                        g_kv,
                        ltrim(l_rec_row.deposit_acc,'0'),
                        l_rec_row.pay_sum);
          end if;
        /*
          -- формируем платеж в ГРЦ
          insert into oper
            (ref,
             tt,
             vob,
             nd,
             pdat,
             vdat,
             dk,
             kv,
             s,
             kv2,
             s2,
             sk,
             datd,
             datp,
             nam_a,
             nlsa,
             mfoa,
             nam_b,
             nlsb,
             mfob,
             nazn,
             d_rec,
             id_a,
             id_b,
             id_o,
             sign,
             sos,
             prty,
             sq,
             ref_a,
             nextvisagrp)
          values
            (l_ref,
             l_tt,
             l_vob,
             l_ref,
             sysdate,
             l_rec_row.payment_date,
             l_dk,
             g_kv,
             l_rec_row.sum_pay,
             g_kv,
             l_rec_row.sum_pay,
             null,
             l_bankdate,
             l_bankdate,
             g_nms,
             g_nls,
             g_mfo,
             l_nam_b,
             ltrim(l_rec_row.num_acc,'0'),
             l_mfo_b,
             l_nazn,
             null,
             g_okpo,
             l_rec_row.numident,
             null,
             null,
             0,
             0,
             l_rec_row.sum_pay,
             l_ref,
             '!!');

            -- оплата платежа в ГРЦ
              gl.payv(0,
                          l_ref,
                          l_bankdate,
                          l_tt,
                          1,
                          g_kv,
                          g_nls,
                          l_rec_row.sum_pay,
                          g_kv,
                          g_grc_nls_t00,
                          l_rec_row.sum_pay);

            gl.pay2(2, l_ref, l_bankdate);

            -- Отправка в СЄП
            select o.sos
              into l_sos
              from oper o
             where o.ref = l_ref;

            if (l_sos = 5) then
              sep.in_sep(l_err,
                             l_rec,
                             g_mfo,
                             g_nls,
                             l_mfo_b,
                             ltrim(l_rec_row.num_acc,'0'),
                             l_dk,
                             l_rec_row.sum_pay,
                             l_vob,
                             l_ref,
                             g_kv,
                             l_bankdate,
                             l_bankdate,
                             g_nms,
                             l_nam_b,
                             l_nazn,
                             null,
                             '10',
                             g_okpo,
                             l_rec_row.numident,
                             null,
                             null,
                             0,
                             null,
                             null,
                       a      null,
                             sysdate,
                             null,
                             0,
                             l_ref);
            end if;*/

            update msp.msp_file_records r
              set r.ref=l_ref,
				  r.state_id=20
            where id = p_id;
            p_ref := l_ref;

      exception
        when others then
          rollback to sp_before;
          l_err := sqlerrm;
          bars_audit.error(l_err);

         if (l_err not like '%Locked account%') then
             if l_rec_row.state_id = 19 then
               update msp.msp_file_records r
                 set r.state_id=17,  ---якщо помилка блокування рахунку то перезапуск
                     r.comm = l_err
                where r.id = p_id;
             end if;
         end if;

      end;


  end pay_social;

  procedure get_doc_buffers2(p_ref     in integer,
                            p_key     in varchar2,
                            p_buf_int out varchar2,
                            p_buf_ext out varchar2) is
    l_buffer varchar2(4000);
  begin
    -- отримання СЕП буферу
    chk.make_int_docbuf(p_ref, p_buf_int);
    docsign.retrievesepbuffer(p_ref, p_key, p_buf_ext);

    p_buf_int  := rawtohex(utl_raw.cast_to_raw(p_buf_int));
    p_buf_ext  := rawtohex(utl_raw.cast_to_raw(p_buf_ext));

  end;

  -- установка подписей на документ
    procedure put_doc_sign2(p_ref      in integer,
                         p_key      in varchar2,
                         p_int_sign in varchar2,
                         p_sep_sign in varchar2) is
    l_tt oper.tt%type;

    g_grc_nls_trans accounts.nls%type;
    g_grc_nls_t00 accounts.nls%type;


    fli_   NUMBER;
    flg_   NUMBER;
    refL_  NUMBER;
    refA_  VARCHAR2(9);
    prty_  NUMBER;
    sos_   NUMBER;

    err_   NUMBER;    -- Return code
    rec_   NUMBER;    -- Record number
    mfoa_  VARCHAR2(12);   -- Sender's MFOs
    nlsa_  VARCHAR2(15);   -- Sender's account number
    mfob_  VARCHAR2(12);   -- Destination MFO
    nlsb_  VARCHAR2(15);   -- Target account number
    dk_    NUMBER;         -- Debet/Credit code
    s_     DECIMAL(24);    -- Amount
    vob_   NUMBER;         -- Document type
    nd_    VARCHAR2(10);   -- Document number
    kv_    NUMBER;         -- Currency code
    datD_  DATE;           -- Document date
    datP_  DATE;           -- Posting date
    nam_a_  VARCHAR2(38);  -- Sender's customer name
    nam_b_  VARCHAR2(38);  -- Target customer name
    nazn_   VARCHAR(160);  -- Narrative
    nazns_ CHAR(2);        -- Narrative contens type
    id_a_  VARCHAR2(14);   -- Sender's customer identifier
    id_b_  VARCHAR2(14);   -- Target's customer identifier
    id_o_  VARCHAR2(6);    -- Teller identifier
    sign_  OPER.SIGN%TYPE; -- Signature
    datA_  DATE;           -- Input file date/time
    d_rec_ VARCHAR2(80);   -- Additional parameters

     l_rec_id    number;

  begin

    select o.tt, o.mfob into l_tt, mfob_ from oper o where o.ref = p_ref;
    if (mfob_ != 300465 and l_tt not in ('PKX','024')) then
       chk.put_visa_out(p_ref, l_tt, null, 0, null/*p_key*/,null /*p_int_sign*/, null/*p_sep_sign*/, l_rec_id);

       SELECT datp
         INTO datp_
         FROM oper WHERE ref=p_ref;

       p_fm_intdoccheck(p_ref);

       sgn_mgr.store_sep_sign(p_ref       => p_ref,
                              p_sign_type => 'VG2',
                              p_key_id    => p_key,
                              p_sign_hex  => p_sep_sign);
       --chk.put_visa_out(p_ref, l_tt, 5, 2, null/*p_key*/,null /*p_int_sign*/, null/*p_sep_sign*/, l_rec_id);
       sgn_mgr.store_int_sign(p_ref       => p_ref,
                              p_rec_id    => l_rec_id,
                              p_sign_type => 'VG2',
                              p_key_id    => p_key,
                              p_sign_hex  => p_int_sign);

       gl.pay( 2,p_ref,datp_);

       SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
              datd, datp, nam_a, nam_b, nazn, id_a, id_b,
              id_o, sign, d_rec, sos, ref_a, prty
         INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
              datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
              id_o_,sign_,d_rec_, sos_, refA_, prty_
         FROM oper WHERE ref=p_ref;

       if (sos_ = 5 ) then
          IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
             nazns_ := '11';
          ELSE
             nazns_ := '10';
          END IF;

          sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                     vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                     NULL,nazns_,id_a_,id_b_,id_o_,refA_,0,sign_,
                     NULL,NULL,datA_,d_rec_,0,p_ref,0);

       end if;

       p_fm_extdoccheck(rec_);
    else
--     chk.put_visa(p_ref, l_tt, 5, 2, p_key, p_int_sign, p_sep_sign);
       gl.pay( 2,p_ref,datp_);
    end if;

    update msp.msp_file_records r
       set r.state_id=20
     where r.ref = p_ref;

    /*exception
        when others then
          commit;*/
  end;

  procedure get_doc_buffers(p_ref     in integer,
                            p_key     in varchar2,
                            p_int_buf out varchar2,
                            p_sep_buf out varchar2) is
    l_buffer varchar2(4000);
  begin
    -- отримання СЕП буферу
    docsign.retrievesepbuffer(p_ref, p_key, l_buffer);
    p_sep_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
    chk.make_int_docbuf(p_ref, l_buffer);
    p_int_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
  end;

  -- установка подписей на документ
    procedure put_doc_sign(p_ref      in integer,
                         p_key      in varchar2,
                         p_int_sign in varchar2,
                         p_sep_sign in varchar2) is
    l_tt oper.tt%type;

    g_grc_nls_trans accounts.nls%type;
    g_grc_nls_t00 accounts.nls%type;


    fli_   NUMBER;
    flg_   NUMBER;
    refL_  NUMBER;
    refA_  VARCHAR2(9);
    prty_  NUMBER;
    sos_   NUMBER;

    err_   NUMBER;    -- Return code
    rec_   NUMBER;    -- Record number
    mfoa_  VARCHAR2(12);   -- Sender's MFOs
    nlsa_  VARCHAR2(15);   -- Sender's account number
    mfob_  VARCHAR2(12);   -- Destination MFO
    nlsb_  VARCHAR2(15);   -- Target account number
    dk_    NUMBER;         -- Debet/Credit code
    s_     DECIMAL(24);    -- Amount
    vob_   NUMBER;         -- Document type
    nd_    VARCHAR2(10);   -- Document number
    kv_    NUMBER;         -- Currency code
    datD_  DATE;           -- Document date
    datP_  DATE;           -- Posting date
    nam_a_  VARCHAR2(38);  -- Sender's customer name
    nam_b_  VARCHAR2(38);  -- Target customer name
    nazn_   VARCHAR(160);  -- Narrative
    nazns_ CHAR(2);        -- Narrative contens type
    id_a_  VARCHAR2(14);   -- Sender's customer identifier
    id_b_  VARCHAR2(14);   -- Target's customer identifier
    id_o_  VARCHAR2(6);    -- Teller identifier
    sign_  OPER.SIGN%TYPE; -- Signature
    datA_  DATE;           -- Input file date/time
    d_rec_ VARCHAR2(80);   -- Additional parameters


  begin

    select o.tt, o.mfob into l_tt, mfob_ from oper o where o.ref = p_ref;

    if (mfob_ != 300465 and l_tt not in ('PKX','024')) then
       chk.put_visa(p_ref, l_tt, null, 0, p_key, p_int_sign, p_sep_sign);

       SELECT datp
         INTO datp_
         FROM oper WHERE ref=p_ref;

       p_fm_intdoccheck(p_ref);

       chk.put_visa(p_ref, l_tt, 5, 2, p_key, p_int_sign, p_sep_sign);

       gl.pay( 2,p_ref,datp_);

       SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
              datd, datp, nam_a, nam_b, nazn, id_a, id_b,
              id_o, sign, d_rec, sos, ref_a, prty
         INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
              datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
              id_o_,sign_,d_rec_, sos_, refA_, prty_
         FROM oper WHERE ref=p_ref;

       if (sos_ = 5 ) then
          IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
             nazns_ := '11';
          ELSE
             nazns_ := '10';
          END IF;

          sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                     vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                     NULL,nazns_,id_a_,id_b_,id_o_,refA_,0,sign_,
                     NULL,NULL,datA_,d_rec_,0,p_ref,0);

       end if;

       p_fm_extdoccheck(rec_);
    else
--     chk.put_visa(p_ref, l_tt, 5, 2, p_key, p_int_sign, p_sep_sign);
       gl.pay( 2,p_ref,datp_);
    end if;

   -- update msp.msp_file_records r
   --    set r.state_id=20
   --  where r.ref = p_ref;

    exception
        when others then
        commit;
		bars_audit.error(sqlerrm);
		raise_application_error (-20000, dbms_utility.format_error_backtrace);   

       --   commit;
  end;




  /*procedure pay_ready_rec is
   l_ref number;
  begin
      for c0 in (select * from msp.msp_file_records r
                  where r.state_id = 19
                    and r.ref is null
                   -- and rownum < 101
                    for update skip locked
                      ) loop
           pay_social(c0.id);
      end loop;
  end;*/



begin
  null;
end msp_pays;
/
