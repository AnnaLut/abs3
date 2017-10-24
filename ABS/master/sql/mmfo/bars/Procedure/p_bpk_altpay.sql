

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BPK_ALTPAY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BPK_ALTPAY ***

  CREATE OR REPLACE PROCEDURE BARS.P_BPK_ALTPAY (p_userid number)
is
  l_bankdate  date;
  l_mfo       varchar2(6);

  l_err       varchar2(250);

  l_ref       number;
  l_s         number;
  l_kv        number;
  l_dk        number;
  l_vob       number;
  l_tt        varchar2(3);
  l_nazn      varchar2(160);

  l_nls_a     varchar2(14);
  l_nam_a     varchar2(38);
  l_okpo_a    varchar2(14);
  l_nls_b     varchar2(14);
  l_nam_b     varchar2(38);
  l_okpo_b    varchar2(14);

  -- функция получения ошибки
  function get_err (p_err varchar2, p_str varchar2) return varchar2
  is
     l_ret varchar2(250);
  begin
     if p_err is null then
        l_ret := null;
     else
        l_ret := p_err || ', ';
     end if;
     l_ret := substr(l_ret || p_str, 1, 250);
     return l_ret;
  end;
  ---------------------------------------------------------------------------------------
  --Процедура проверки длины назначения платежа и сумы документа
  ---------------------------------------------------------------------------------------
  procedure get_nazn_s (p_nazn in varchar2, p_s number)
  is
   begin
     if length(p_nazn)>160
	 then
        l_err := get_err(l_err, 'Призначення платежу більше 160 знаків');
     elsif
	    length(p_nazn)<3 then
   	    l_err := get_err(l_err, 'Призначення платежу менше 3 знаків');
	 else
        null;
     end if;
	 if p_s<=0 then
     	l_err := get_err(l_err, 'Сума документа повинна бути більше нуля');
	 end if;
  end;

  ---------------------------------------------------------------------------------------
  -- процедура для получения параметров счета
  procedure get_acc (
     p_nls_in   in varchar2,
     p_nls     out varchar2,
     p_nms     out varchar2,
     p_okpo    out varchar2 )
  is
     l_nls   varchar2(14);
     l_nms   varchar2(38);
     l_dazs  date;
     l_okpo  varchar2(14);
  begin
     begin
        select a.nls, substr(a.nms, 1, 38), a.dazs, c.okpo
          into l_nls, l_nms, l_dazs, l_okpo
          from accounts a, customer c
         where a.nls = p_nls_in and a.kv = 980
           and a.rnk = c.rnk;
     exception when no_data_found then
        l_err  := get_err(l_err, 'Рахунок ' || p_nls_in || ' не знайдено');
        l_nls  := null;
        l_nms  := null;
        l_okpo := null;
     end;

     if l_dazs is not null then
        l_err := get_err(l_err, 'Рахунок ' || p_nls_in || ' закрито');
     end if;

     p_nls  := l_nls;
     p_nms  := l_nms;
     p_okpo := l_okpo;

  end;

  -- процедура поиска операции для оплаты
  procedure get_tt (
     p_skzb in number,
     p_tt  out varchar2 )
  is
    l_tt_ret varchar2(3);
  begin
     if p_skzb is null then
        l_err := get_err(l_err, 'Не вказано Позабалансовий символ');
        l_tt_ret := null;
     else
        begin
           select tt into l_tt_ret from social_file_types where sk_zb = p_skzb and rownum = 1;
        exception when no_data_found then
           l_err := get_err(l_err, 'Не описано операц?ю для Позабалансового символу (' || to_char(p_skzb) || ')');
           l_tt_ret := null;
        end;
     end if;

     p_tt := l_tt_ret;

  end;

begin

  l_bankdate := gl.bdate;
  l_mfo      := f_ourmfo;

  l_kv  := 980;
  l_dk  := 1;
  l_vob := 6;

  for z in ( select id, nlsa, nlsb, s, nazn, sk_zb
               from alt_bpk
              where userid = p_userid
                and ref is null )
  loop

     l_ref  := null;
     l_err  := null;
     l_s    := z.s * 100;
     l_nazn := substr(z.nazn,1,160);

     -- парамтры счетов
     get_acc(z.nlsa, l_nls_a, l_nam_a, l_okpo_a);
     get_acc(z.nlsb, l_nls_b, l_nam_b, l_okpo_b);

     -- операция
     get_tt(z.sk_zb, l_tt);

	 --проверка назначения и сумы
	 get_nazn_s(z.nazn, z.s);

     -- оплата
     if l_err is null then

        begin
           savepoint sp_before;

           gl.ref (l_ref);

           insert into oper (ref, tt, vob, nd, dk, pdat, vdat, datd,
              nam_a, nlsa, mfoa, id_a,
              nam_b, nlsb, mfob, id_b, kv, s, kv2, s2, nazn, userid)
           values (l_ref, l_tt, l_vob, l_ref, l_dk, sysdate, l_bankdate, l_bankdate,
              l_nam_a, l_nls_a, l_mfo, l_okpo_a,
              l_nam_b, l_nls_b, l_mfo, l_okpo_b,
              l_kv, l_s, l_kv, l_s, l_nazn, user_id);

           paytt(null, l_ref, l_bankdate, l_tt, l_dk,
              l_kv, l_nls_a, l_s,
              l_kv, l_nls_b, l_s);

           insert into operw (ref, tag, value)
           values (l_ref, 'SK_ZB', to_char(z.sk_zb));

        exception when others then
           if ( sqlcode <= -20000 ) then
              rollback to sp_before;
           else raise;
           end if;
        end;

     end if;

     -- результат пишем в таблицу
     update alt_bpk set ref = l_ref, error = l_err where id = z.id;

  end loop;

end p_bpk_altpay;
/
show err;

PROMPT *** Create  grants  P_BPK_ALTPAY ***
grant EXECUTE                                                                on P_BPK_ALTPAY    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BPK_ALTPAY.sql =========*** End 
PROMPT ===================================================================================== 
