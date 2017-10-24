

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAYPAY_DM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAYPAY_DM ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAYPAY_DM (p_date date)
is
  -- version 11/08/2008
  l_done   integer;
  l_tt     oper.tt%type     := 'GO6';
  l_tt1    oper.tt%type     := 'GO1';
  l_tt2    oper.tt%type     := 'GO2';
  l_userid oper.userid%type := gl.auid;
  l_mfo    oper.mfoa%type   := gl.amfo;
  l_bdate  oper.vdat%type   := gl.bdate;
  l_baseval oper.kv%type    := gl.baseval;
  l_txt    oper.nazn%type   := '���������� �� ������-������ ������';
  l_param  params.par%type;
  l_okpo   oper.id_a%type;
  l_vobNC  oper.vob%type;
  l_vobFC  oper.vob%type;
  l_nls29g accounts.nls%type; l_nms29g accounts.nms%type;
  l_nls18g accounts.nls%type; l_nms18g accounts.nms%type;
  l_nls29v accounts.nls%type; l_nms29v accounts.nms%type;
  l_nls18v accounts.nls%type; l_nms18v accounts.nms%type;
  l_nazn   oper.nazn%type;
  l_ref    oper.ref%type;
  l_dk     oper.dk%type;
  l_sq     oper.s%type;
begin

  select count(*) into l_done from oper where vdat = p_date and sos > 0 and tt = l_tt;
  if l_done > 0 then
     return;
  end if;

  l_param := 'OKPO';
  select val into l_okpo from params where par = l_param;

  -- ��� ��������� ������������� ������
  l_param := 'MBK_VZAL';
  begin
   select to_number(val) into l_vobFC from params where par = l_param;
  exception
   when no_data_found then
     l_vobFC := 6;
  end;
  -- ��� ���������� ������������� ������
  begin
   select vob into l_vobNC from tts_vob where tt = l_tt;
  exception
   when no_data_found or too_many_rows then
     l_vobNC := 6;
  end;

  -- ����� �����
  for c in
   (select kv2 kv, lcv iso, dig,
           sum(decode(dk, 1,  s2, -s2)) s,
           round(sum(decode(dk, 1, s2 * kurs_f, -s2 * kurs_f))) sq
      from v_zay
     where vdate = p_date
       and sos   = 2
     group by kv2, lcv, dig
    having sum(decode(dk, 1, s2, -s2)) != 0)
  loop

    l_sq := abs(c.sq) * power(10, 2) / power(10, c.dig);

    begin
      select a1.nls, substr(a1.nms,1,38),
             a2.nls, substr(a2.nms,1,38),
             a3.nls, substr(a3.nms,1,38),
             a4.nls, substr(a4.nms,1,38)
        into l_nls29g, l_nms29g,
             l_nls18g, l_nms18g,
             l_nls29v, l_nms29v,
             l_nls18v, l_nms18v
        from tts t1, tts t2, accounts a1, accounts a2, accounts a3, accounts a4
       where t1.tt   = l_tt1
         and t2.tt   = l_tt2
         and t1.nlsk = a1.nls
         and t1.nlsk = a3.nls
         and t2.nlsa = a2.nls
         and t2.nlsa = a4.nls
         and a1.kv   = l_baseval
         and a2.kv   = l_baseval
         and a3.kv   = c.kv
         and a4.kv   = c.kv;
    exception
      when no_data_found then
        bars_error.raise_nerror ('ZAY', 'TRANSIT_ACC_NOT_FOUND');
    end;

    l_nazn := l_txt
            ||' ('
            ||case
              when c.dig = 3 then ltrim(to_char(abs(c.s/power(10, c.dig)),'999999999.999'))
              else                ltrim(to_char(abs(c.s/power(10, c.dig)),'999999999.99'))
              end
            ||' '
            ||c.iso
            ||')';
    l_dk   := case when c.s > 0 then 1 else 0 end;

    gl.ref (l_ref);
    gl.in_doc3 (ref_   => l_ref,
                tt_    => l_tt,
                vob_   => l_vobfc,
                nd_    => to_char(l_ref),
                pdat_  => sysdate,
                vdat_  => l_bdate,
                dk_    => 1,
                kv_    => c.kv,
                s_     => abs(c.s),
                kv2_   => c.kv,
                s2_    => abs(c.s),
                sk_    => null,
                data_  => sysdate,
                datp_  => sysdate,
                nam_a_ => (case when l_dk = 1 then l_nms18v else l_nms29v end),
                nlsa_  => (case when l_dk = 1 then l_nls18v else l_nls29v end),
                mfoa_  => l_mfo,
                nam_b_ => (case when l_dk = 1 then l_nms29v else l_nms18v end),
                nlsb_  => (case when l_dk = 1 then l_nls29v else l_nls18v end),
                mfob_  => l_mfo,
                nazn_  => l_nazn,
                d_rec_ => null,
                id_a_  => l_okpo,
                id_b_  => l_okpo,
                id_o_  => null,
                sign_  => null,
                sos_   => null,
                prty_  => null,
                uid_   => l_userid);

    gl.payv (null, l_ref, l_bdate, l_tt, 1,
             c.kv, (case when l_dk = 1 then l_nls18v else l_nls29v end), abs(c.s),
             c.kv, (case when l_dk = 1 then l_nls29v else l_nls18v end), abs(c.s));

    gl.ref (l_ref);
    gl.in_doc3 (ref_   => l_ref,
                tt_    => l_tt,
                vob_   => l_vobNC,
                nd_    => to_char(l_ref),
                pdat_  => sysdate,
                vdat_  => l_bdate,
                dk_    => 1,
                kv_    => l_baseval,
                s_     => l_sq,
                kv2_   => l_baseval,
                s2_    => l_sq,
                sk_    => null,
                data_  => sysdate,
                datp_  => sysdate,
                nam_a_ => (case when l_dk = 1 then l_nms29g else l_nms18g end),
                nlsa_  => (case when l_dk = 1 then l_nls29g else l_nls18g end),
                mfoa_  => l_mfo,
                nam_b_ => (case when l_dk = 1 then l_nms18g else l_nms29g end),
                nlsb_  => (case when l_dk = 1 then l_nls18g else l_nls29g end),
                mfob_  => l_mfo,
                nazn_  => l_nazn,
                d_rec_ => null,
                id_a_  => l_okpo,
                id_b_  => l_okpo,
                id_o_  => null,
                sign_  => null,
                sos_   => null,
                prty_  => null,
                uid_   => l_userid);

    gl.payv (null, l_ref, l_bdate, l_tt, 1,
             l_baseval, (case when l_dk = 1 then l_nls29g else l_nls18g end), l_sq,
             l_baseval, (case when l_dk = 1 then l_nls18g else l_nls29g end), l_sq);

  end loop;
end;
/
show err;

PROMPT *** Create  grants  P_ZAYPAY_DM ***
grant EXECUTE                                                                on P_ZAYPAY_DM     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAYPAY_DM     to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_ZAYPAY_DM     to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAYPAY_DM.sql =========*** End *
PROMPT ===================================================================================== 
