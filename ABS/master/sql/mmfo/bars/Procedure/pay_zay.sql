

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_ZAY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_ZAY ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_ZAY 
is
  l_zay           zayavka_ru%rowtype;
  l_cur           tabval%rowtype;
  l_nlsa          accounts.nls%type;
  l_nlsb          accounts.nls%type;
  l_lcv           tabval.lcv%type;
  l_nam_a         banks.nb%type;
  l_nam_b         banks.nb%type;
  l_okpo_b        customer.okpo%type;
  l_kv            tabval.kv%type;
  l_nom_amount    number;
  l_need_amount    number;
  l_kv_base       zayavka_ru.kv2%type;
  l_ref           oper.ref%type;
  l_errcode       number;
  l_errmsg        varchar2(200);
  l_url           varchar2(256);

 procedure ipay_doc (
  p_tt     oper.tt%type,
  p_vob    in oper.vob%type,
  p_dk     in oper.dk%type,
  p_sk     in oper.sk%type,
  p_nam_a  in oper.nam_a%type,
  p_nlsa   in oper.nlsa%type,
  p_mfoa   in oper.mfoa%type,
  p_id_a   in oper.id_a%type,
  p_nam_b  in oper.nam_b%type,
  p_nlsb   in oper.nlsb%type,
  p_mfob   in oper.mfob%type,
  p_id_b   in oper.id_b%type,
  p_kv     in oper.kv%type,
  p_s      in oper.s%type,
  p_kv2    in oper.kv2%type,
  p_s2     in oper.s2%type,
  p_nazn   in oper.nazn%type,
  p_ref   out number )
 is
  l_bdate  date;
  l_mfo    varchar2(6);
  l_ref    number;
  l_flag   number;
  l_user   number;
 begin

  l_bdate := gl.bdate;
  l_mfo   := gl.amfo;

  select nvl(min(value),1) into l_flag from tts_flags where tt = p_tt and fcode = 37;

   -- код пользователя, которым будем платить
   begin
     select b.val into l_user from birja b, staff s where b.par = 'PAY_USER' and b.val = s.id;
   exception
   when no_data_found then
       -- не определен код пользователя для оплаты
       raise_application_error(-20000, 'В конфигурационных параметрах не определен/указан несуществующий код пользователя для оплаты!');
   end;

  gl.ref (l_ref);

  gl.in_doc3 (ref_    => l_ref,
              tt_     => p_tt,
              vob_    => p_vob,
              nd_     => to_char(l_ref),
              pdat_   => sysdate,
              vdat_   => l_bdate,
              dk_     => p_dk,
              kv_     => p_kv,
              s_      => p_s,
              kv2_    => p_kv2,
              s2_     => p_s2,
              sk_     => p_sk,
              data_   => l_bdate,
              datp_   => l_bdate,
              nam_a_  => p_nam_a,
              nlsa_   => p_nlsa,
              mfoa_   => nvl(p_mfoa,l_mfo),
              nam_b_  => p_nam_b,
              nlsb_   => p_nlsb,
              mfob_   => nvl(p_mfob,l_mfo),
              nazn_   => p_nazn,
              d_rec_  => null,
              id_a_   => p_id_a,
              id_b_   => p_id_b,
              id_o_   => null,
              sign_   => null,
              sos_    => null,
              prty_   => 0,
              uid_    => l_user);

  paytt ( flg_ => null,
          ref_ => l_ref,
         datv_ => l_bdate,
           tt_ => p_tt,
          dk0_ => p_dk,
          kva_ => p_kv,
         nls1_ => p_nlsa,
           sa_ => p_s,
          kvb_ => p_kv2,
         nls2_ => p_nlsb,
           sb_ => p_s2 );

  p_ref := l_ref;

 end ipay_doc;

begin

   for k in (select id from zayavka_ru where ref_sps is not null and nvl(ref_sps_check,0) = 0)
     loop
       bars_audit.info('pay_zay - enter: id=>'||k.id);
       -- базовые параметры заявки РУ
       begin
         select * into l_zay from zayavka_ru where id = k.id;
       exception
       when no_data_found then
           -- не найдена заявка № %s
           raise_application_error(-20000, 'Не знайдена заявка №'||to_char(k.id));
       end;

       select * into l_cur from tabval where kv = l_zay.kv2;

       -- счет 2900 РУ (должен быть заполнен в справочнике)
       begin
         select nls29 into l_nlsb from zay_mfo_nls29 where mfo = l_zay.mfo;
       exception when no_data_found then
               raise_application_error(-20000, 'Для МФО заявки '||k.id||' не заполнен счет 2900 РУ!');
       end;

       -- счет 2900 РУ (должен быть заполнен в справочнике)
       begin
         select nls29 into l_nlsa from zay_mfo_nls29 where mfo = f_ourmfo;
       exception when no_data_found then
               raise_application_error(-20000, 'Не заполнен счет 2900 ЦА!');
       end;

       -- наименования - из справочника банков. можно если что - внести в справочник счетов 2900 наименования для РУ-шек
       select nb into l_nam_a from banks where mfo = '300465';
       select nb into l_nam_b from banks where mfo = l_zay.mfo;

       -- поскольку все РУ-шки зарегистрированы как банки - оттуда найдем и ОКПО
       begin
         select c.okpo  into l_okpo_b
           from customer c, custbank b
          where b.mfo = l_zay.mfo
            and b.rnk = c.rnk and rownum=1;
       exception when no_data_found then
            raise_application_error(-20000, 'Не знайдено ОКПО отримувача!');
       end;

       --  другие необходимые параметры для оплаты на базе базовых параметров заявки
       -- валюта ЗА
       /*select decode(l_zay.dk, 1, l_zay.kv2, 2, 980, l_zay.kv_conv ) into l_kv from dual;*/
       select decode(l_zay.dk, 2, 980, l_zay.kv2 ) into l_kv from dual;

       -- cумма заявленной валюты в номинале
       l_nom_amount := l_zay.s2;

       -- cумма заявленной валюты в эквиваленте по курсу дилера
 /*      if l_zay.dk = 3 then
        -- покупка за валюту (конверсия)
          begin
            select kv_base into l_kv_base from zay_conv_kv where (kv1 = l_zay.kv2 and kv2 = l_zay.kv_conv) or (kv2 = l_zay.kv2 and kv1 = l_zay.kv_conv);
          exception when no_data_found then
             bars_error.raise_error ('Не описана базовая валюта для данной пары валют в конверсии!');
          end;
          -- обигрываем конверсию согласно курсам (валюта по отношению к валюте - пришлось определять понятие базовой валюты в паре)
          if l_zay.kv_conv = l_kv_base then
           l_need_amount := round(l_nom_amount / l_zay.kurs_f / power(10, 2) * 100);
          else
           l_need_amount := round(l_nom_amount * l_zay.kurs_f / power(10, 2) * 100);
          end if;
       elsif  l_zay.dk = 1 then
         -- покупка за грн
         l_need_amount := round(l_nom_amount * l_zay.kurs_f / power(10, l_cur.dig) * 100);
       else
         -- продажа
         l_need_amount := l_nom_amount;
       end if;   */

       if l_zay.dk = 2 then
         l_need_amount := round(l_nom_amount * l_zay.kurs_f / power(10, l_cur.dig) * 100);
       else
         l_need_amount := l_nom_amount;
       end if;


       ipay_doc (p_tt => 'GOR',
                 p_vob => 6,
                 p_dk => 1,
                 p_sk => null,
                 p_nam_a => l_nam_a,
                 p_nlsa =>  l_nlsa,  --'29003',
                 p_mfoa => f_ourmfo,
                 p_id_a => f_ourokpo,
                 p_nam_b => l_nam_b,
                 p_nlsb => l_nlsb,
                 p_mfob => l_zay.mfo,
                 p_id_b => l_okpo_b,
                 p_kv => l_kv,
                 p_s => l_need_amount,
                 p_kv2 => l_kv,
                 p_s2 => l_need_amount,
                 p_nazn => substr('Зарахування коштів згідно заявки №'||l_zay.req_id||'('||l_zay.id||') від '||l_zay.fdat||' (РНК='||l_zay.rnk||').',1,160),
                 p_ref => l_ref);

    bars_audit.info('pay_zay - exit: l_ref=>'||l_ref);
    dbms_output.put_line('pay_zay - exit: l_ref=>'||l_ref);


      if l_ref is not null then
        update zayavka_ru set ref_sps_check = l_ref where id = l_zay.id;
        bars_zay.p_reqest_set_refsps ( l_zay.id, l_ref);
      end if;

   end loop;

exception when others then
            l_errmsg := substr(sqlerrm, 1, 200);
            bars_audit.error('set_ref_sps ERROR: ' || l_errmsg);
			select r.url into l_url from zay_recipients r where r.mfo = l_zay.mfo;
            insert into ZAY_DATA_TRANSFER(id, req_id, url,mfo, transfer_type, transfer_date, transfer_result, comm)
             Values
             (bars_sqnc.get_nextval('s_zay_data_transfer'),  l_zay.id, l_url, l_zay.mfo, 6, sysdate,
               0, 'exception - ' || l_errmsg);

end pay_zay;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_ZAY.sql =========*** End *** =
PROMPT ===================================================================================== 
