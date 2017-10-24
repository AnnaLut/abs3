

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_PAY_FINDEB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_PAY_FINDEB ***

  CREATE OR REPLACE PROCEDURE BARS.P_CP_PAY_FINDEB (p_ref    IN NUMBER,
                                             p_nlsN   IN accounts.nls%TYPE,
                                             p_sN     IN NUMBER,
                                             p_mode1  IN NUMBER DEFAULT 0,
                                             p_nlsR   IN accounts.nls%TYPE,
                                             p_sR     IN NUMBER,
                                             p_mode2  IN NUMBER DEFAULT 0)
IS
    -- для погашения ФДЗ
    title          constant varchar2(14)    := 'p_cp_takeout:';
    nlsT0          constant varchar2(8)     := '37392555';
    o_row                   oper%rowtype;
    p_resulttxt             varchar2(250)   := title;
    p_resultcode            int := 0;
    l_nazn                  oper.nazn%type  := 'Погашення ФД заборгованості по обліг. ';
    l_cp_id                 cp_kod.cp_id%type;
    l_nd                    oper.nd%type;
    l_kol                   number;
    l_nmk                   customer.nmk%type;
BEGIN

 o_row.tt   := 'FX7';
 o_row.vob  := 6;
 o_row.dk   := 1;
 o_row.kv   := 980;
 o_row.kv2  := 980;

  -- для назначения ищем ИСИН код бумаги
 begin
  select cv.cp_id, cv.nd, abs(fost(cv.acc, gl.bd)/100/(select cena from cp_kod where id= cv.id)), c.nmk
    into l_cp_id, l_nd, l_kol, l_nmk
    from cp_v cv, customer c
   where ref = p_ref
     and cv.rnk = c.rnk;
 exception when no_data_found then raise;
 end;
 l_nazn := l_nazn ||' '||l_nmk || ', '|| l_cp_id || ', уг.' || l_nd || ' пакет ' ||to_char(l_kol) || ' шт.';

 begin
   select nls, substr(nms,1,38), c.okpo
    into o_row.nlsa, o_row.nam_a, o_row.id_a
    from accounts a, customer c
   where a.rnk = c.rnk
     and a.kv = 980
     and a.nls = nlsT0;
 exception when no_data_found
           then p_resulttxt := p_resulttxt || 'Не найден T0 '|| nlsT0;
                p_resultcode := 2;
                raise_application_error(-20000, P_RESULTTXT);
                RETURN;
 end;
 if p_mode1 = 1 and  nvl(p_sN,0) != 0
 then
     begin
       select nls, substr(nms,1,38), c.okpo
        into o_row.nlsb, o_row.nam_b, o_row.id_b
        from accounts a, customer c
       where a.rnk = c.rnk
         and a.kv = 980
         and a.nls = p_nlsN;
     exception when no_data_found
               then p_resulttxt := p_resulttxt || 'Не найден p_nlsN '|| p_nlsN;
                    p_resultcode := 2;
                    raise_application_error(-20000, P_RESULTTXT);
                    RETURN;
     end;

   gl.ref(o_row.ref);
   gl.in_doc3 (ref_    => o_row.ref,
               tt_     => o_row.tt,
               vob_    => o_row.vob,
               nd_     => o_row.ref,
               pdat_   => gl.bdate,
               vdat_   => gl.bdate,
               dk_     => 1,
               kv_     => o_row.kv,
               s_      => abs((nvl(p_mode1*p_sN,0) + nvl(p_mode2*p_sR,0))), -- на полную сумму выноса на ФДЗ с купоном
               kv2_    => o_row.kv,
               s2_     => abs((nvl(p_mode1*p_sN,0) + nvl(p_mode2*p_sR,0))),
               sk_     => null,
               data_   => SYSDATE,
               datp_   => SYSDATE,
               nam_a_  => substr(o_row.nam_a,1,38),
               nlsa_   => o_row.nlsa,
               mfoa_   => gl.amfo,
               nam_b_  => substr(o_row.nam_b,1,38),
               nlsb_   => o_row.nlsb,
               mfob_   => gl.amfo,
               nazn_   => l_nazn,
               d_rec_  => null,
               id_a_   => o_row.id_a,
               id_b_   => o_row.id_b,
               id_o_   => null,
               sign_   => null,
               sos_    => 1,
               prty_   => null,
               uid_    => NULL);
     gl.payv(0, o_row.ref,    gl.bdate,     o_row.tt, 1,
                o_row.kv,     o_row.nlsa,   abs(p_sN),
                o_row.kv,     o_row.nlsb,   abs(p_sN));
 end if;

 if p_mode2 = 1 and nvl(p_sR,0) != 0
 then
     begin
       select nls, substr(nms,1,38), c.okpo
        into o_row.nlsb, o_row.nam_b, o_row.id_b
        from accounts a, customer c
       where a.rnk = c.rnk
         and a.kv = 980
         and a.nls = p_nlsR;
     exception when no_data_found
               then p_resulttxt := p_resulttxt || 'Не найден p_nlsR '|| p_nlsR;
                    p_resultcode := 2;
                    raise_application_error(-20000, P_RESULTTXT);
                    RETURN;
     end;

     if o_row.ref is not null
     then
          gl.payv(0, o_row.ref,    gl.bdate,     o_row.tt, 1,
            o_row.kv,     o_row.nlsa,   abs(p_sR),
            o_row.kv,     o_row.nlsb,   abs(p_sR));
     else
       gl.ref(o_row.ref);
       gl.in_doc3 (ref_    => o_row.ref,
                   tt_     => o_row.tt,
                   vob_    => o_row.vob,
                   nd_     => o_row.ref,
                   pdat_   => gl.bdate,
                   vdat_   => gl.bdate,
                   dk_     => 1,
                   kv_     => o_row.kv,
                   s_      => abs((nvl(p_mode1*p_sN,0) + nvl(p_mode2*p_sR,0))), -- на полную сумму выноса на ФДЗ с купоном
                   kv2_    => o_row.kv,
                   s2_     => abs((nvl(p_mode1*p_sN,0) + nvl(p_mode2*p_sR,0))),
                   sk_     => null,
                   data_   => SYSDATE,
                   datp_   => SYSDATE,
                   nam_a_  => substr(o_row.nam_a,1,38),
                   nlsa_   => o_row.nlsa,
                   mfoa_   => gl.amfo,
                   nam_b_  => substr(o_row.nam_b,1,38),
                   nlsb_   => o_row.nlsb,
                   mfob_   => gl.amfo,
                   nazn_   => l_nazn,
                   d_rec_  => null,
                   id_a_   => o_row.id_a,
                   id_b_   => o_row.id_b,
                   id_o_   => null,
                   sign_   => null,
                   sos_    => 1,
                   prty_   => null,
                   uid_    => NULL);
         gl.payv(0, o_row.ref,    gl.bdate,     o_row.tt, 1,
                    o_row.kv,     o_row.nlsa,   abs(p_sR),
                    o_row.kv,     o_row.nlsb,   abs(p_sR));
     end if;
 end if;
END p_cp_pay_findeb;
/
show err;

PROMPT *** Create  grants  P_CP_PAY_FINDEB ***
grant EXECUTE                                                                on P_CP_PAY_FINDEB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_PAY_FINDEB.sql =========*** E
PROMPT ===================================================================================== 
