
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/check_pkg.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CHECK_PKG is

  g_header_version constant varchar2(64) := 'version 1.00';
  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  -- Видалення вибраного чека
  procedure delete_check(p_id ch_1.id%type);

  -- Додавання нового чека
  procedure add_check(p_nd    ch_1.nd%type,
                      p_nls   ch_1.nls%type,
                      p_okpo  ch_1.okpo%type,
                      p_bic_e ch_1.bic_e%type,
                      p_fio   ch_1.fio%type,
                      p_kol   ch_1.kol%type,
                      p_nom   ch_1.nom%type,
                      p_tobo  ch_1.tobo%type,
                      p_mfoa  ch_1.mfoa%type);

  -- Зміна даних вибраного чека
  procedure upd_check(p_id    ch_1.id%type,
                      p_nd    ch_1.nd%type,
                      p_nls   ch_1.nls%type,
                      p_okpo  ch_1.okpo%type,
                      p_bic_e ch_1.bic_e%type,
                      p_fio   ch_1.fio%type,
                      p_kol   ch_1.kol%type,
                      p_nom   ch_1.nom%type,
                      p_tobo  ch_1.tobo%type,
                      p_mfoa  ch_1.mfoa%type);

  -- Взяти чек на облік
  procedure get_check(p_id ch_1.id%type);

  -- Сфорсувати посилку
  procedure send_check(p_id      ch_1.id%type,
                       p_nostro  varchar2,
                       p_REF_POS integer);

  -- Запис даних в контекст
  procedure start_check(p_pap ch_1.ids%type, p_kvc ch_1.kv%type);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.CHECK_PKG as

  -- версія пакету
  g_body_version constant varchar2(64) := 'version 1.00';
  g_dbgcode      constant varchar2(20) := 'check_pkg';

  -- header_version
  function header_version return varchar2 is
  begin
    return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.';
  end header_version;

  -- body_version
  function body_version return varchar2 is
  begin
    return 'Package body ' || g_dbgcode || ' ' || g_body_version || '.';
  end body_version;

  procedure start_check(p_pap ch_1.ids%type, p_kvc ch_1.kv%type) is
  begin
    pul.put(tag_ => 'CHPAP', val_ => p_pap);
    pul.put(tag_ => 'CHKVC', val_ => p_kvc);
  end start_check;

  procedure delete_check(p_id ch_1.id%type) is
  begin
    delete from ch_1 t
     where t.id = p_id
       and t.ref1 is null;
  end delete_check;

  procedure add_check(p_nd    ch_1.nd%type,
                      p_nls   ch_1.nls%type,
                      p_okpo  ch_1.okpo%type,
                      p_bic_e ch_1.bic_e%type,
                      p_fio   ch_1.fio%type,
                      p_kol   ch_1.kol%type,
                      p_nom   ch_1.nom%type,
                      p_tobo  ch_1.tobo%type,
                      p_mfoa  ch_1.mfoa%type) is
    l_rec ch_1%rowtype;
  begin
    l_rec.s   := (p_kol * p_nom) * 100;
    l_rec.mfo := f_ourmfo;
    if p_okpo is null then
      select zkpo into l_rec.okpo from alegro where num = p_tobo;
    else
      l_rec.okpo := p_okpo;
    end if;
    l_rec.ids := to_number(pul.get('CHPAP'));
    if p_nls is null then
      select decode(l_rec.ids, 0, nls_chk0, 1, nls_chk1, nls_chk)
        into l_rec.nls
        from alegro
       where num = p_tobo;
    else
      l_rec.nls := p_nls;
    end if;
    l_rec.kv := to_number(pul.get('CHKVC'));

    insert into ch_1
      (nd, s, kv, mfo, nls, okpo, ids, fio, bic_e, kol, nom, tobo, mfoa)
    values
      (p_nd,
       l_rec.s,
       l_rec.kv,
       l_rec.mfo,
       l_rec.nls,
       l_rec.okpo,
       l_rec.ids,
       p_fio,
       p_bic_e,
       p_kol,
       p_nom,
       p_tobo,
       p_mfoa);
  end add_check;

  procedure upd_check(p_id    ch_1.id%type,
                      p_nd    ch_1.nd%type,
                      p_nls   ch_1.nls%type,
                      p_okpo  ch_1.okpo%type,
                      p_bic_e ch_1.bic_e%type,
                      p_fio   ch_1.fio%type,
                      p_kol   ch_1.kol%type,
                      p_nom   ch_1.nom%type,
                      p_tobo  ch_1.tobo%type,
                      p_mfoa  ch_1.mfoa%type) is
    l_s   ch_1.s%type;
    l_mfo ch_1.mfo%type;
  begin
    l_s   := (p_kol * p_nom) * 100;
    l_mfo := f_ourmfo;

    update ch_1
       set nd    = p_nd,
           s     = l_s,
           mfo   = l_mfo,
           nls   = p_nls,
           okpo  = p_okpo,
           fio   = p_fio,
           bic_e = p_bic_e,
           kol   = p_kol,
           nom   = p_nom,
           tobo  = p_tobo,
           mfoa  = p_mfoa
     where id = p_id;
  end upd_check;

  procedure get_check(p_id ch_1.id%type) is
    l_rec    ch_1%rowtype;
    oo       oper%rowtype;
    nls_9910 accounts.nls%type;
    nms_9910 accounts.nms%type;
    nls_9830 accounts.nls%type;
    nms_9830 accounts.nms%type;
    l_nb     banks.nb%type;
  begin
    select t1.* into l_rec from ch_1 t1 where t1.id = p_id;
    if l_rec.ref1 is null and l_rec.s > 0 and l_rec.kol > 0 then
      select c.s9910 as nls_9910,
             substr(a9910.nms, 1, 38) as nms_9910,
             c.s9830 as nls_9830,
             substr(a9830.nms, 1, 38) as nms_9830
        into nls_9910, nms_9910, nls_9830, nms_9830
        from ch_1s c, accounts a9910, accounts a9830
       where c.ids = l_rec.ids
         and a9830.kv = l_rec.kv
         and a9830.nls = c.s9830
         and a9910.kv = l_rec.kv
         and a9910.nls = c.s9910;

      gl.ref(oo.ref);
      oo.tt := 'CH1';
      oo.nd := case
                 when length(oo.ref) > 10 then
                  substr(oo.ref, -10)
                 else
                  to_char(oo.ref)
               end;

      select b.nb
        into l_nb
        from banks b
       where nvl(l_rec.mfoa, l_rec.mfo) = b.mfo(+);
      oo.nazn := 'Чеки, що отримані від ' || l_nb;

      select vob
        into oo.VOB
        from tts_vob
       where tt = 'CH1'
         and ord = 1;

      gl.in_doc3(ref_   => oo.ref,
                 tt_    => oo.tt,
                 vob_   => OO.VOB,
                 nd_    => oo.nd,
                 pdat_  => SYSDATE,
                 vdat_  => gl.bdate,
                 dk_    => 1,
                 kv_    => l_rec.kv,
                 s_     => l_rec.S,
                 kv2_   => l_rec.kv,
                 s2_    => l_rec.s,
                 sk_    => null,
                 data_  => gl.bdate,
                 datp_  => gl.bdate,
                 nam_a_ => NMS_9830,
                 nlsa_  => NLS_9830,
                 mfoa_  => gl.aMfo,
                 nam_b_ => NMS_9910,
                 nlsb_  => NLS_9910,
                 mfob_  => gl.aMfo,
                 nazn_  => oo.nazn,
                 d_rec_ => null,
                 id_a_  => gl.aokpo,
                 id_b_  => gl.aokpo,
                 id_o_  => null,
                 sign_  => null,
                 sos_   => 1,
                 prty_  => null,
                 uid_   => null);

      set_operw(oo.ref, 'GOLD', 'Чеки');
      set_operw(oo.ref, 'SUMGD', l_rec.kol);
      set_operw(oo.ref, 'VLASN', l_nb);

      gl.payv(0,
              oo.ref,
              gl.bdate,
              'CH1',
              1,
              l_rec.kv,
              nls_9830,
              l_rec.s,
              l_rec.kv,
              nls_9910,
              l_rec.s);

      update ch_1 set ref1 = oo.ref where id = l_rec.id;

    end if;
  end get_check;

  procedure send_check(p_id      ch_1.id%type,
                       p_nostro  varchar2,
                       p_ref_pos integer) is
    l_rec    ch_1%rowtype;
    oo       oper%rowtype;
    l_name   sw_banks.name%type;
    nls_9831 accounts.nls%type;
    nms_9831 accounts.nms%type;
    nls_9830 accounts.nls%type;
    nms_9830 accounts.nms%type;
    l_bic    bic_acc.bic%type;
    l_acc    bic_acc.acc%type;
  begin
    select t1.* into l_rec from ch_1 t1 where t1.id = p_id;
    if l_rec.ref1 is not null and l_rec.ref2 is null and l_rec.s > 0 and
       l_rec.kol > 0 then

      select c.s9831 as nls_9831,
             substr(a9831.nms, 1, 38) as nms_9831,
             c.s9830 as nls_9830,
             substr(a9830.nms, 1, 38) as nms_9830
        into nls_9831, nms_9831, nls_9830, nms_9830
        from ch_1s c, accounts a9831, accounts a9830
       where c.ids = l_rec.ids
         and a9830.kv = l_rec.kv
         and a9830.nls = c.s9830
         and a9831.kv = l_rec.kv
         and a9831.nls = c.s9831;

      gl.REF(oo.ref);

      select t2.acc, t2.bic
        into l_acc, l_bic
        from bic_acc t2
       where t2.acc || '_' || t2.bic = p_nostro;
      select name into l_name from sw_banks where bic = l_bic;

      oo.nazn := substr('Вiдправка чекiв в ' || l_name ||
                        ' на загальну суму ' || l_rec.s || ' ' || l_rec.kv || ' ' ||
                        l_rec.kol || ' шт, № ' || p_ref_pos,
                        1,
                        160);
      oo.tt   := 'CH1';
      select vob
        into oo.vob
        from tts_vob
       where tt = 'CH1'
         and ord = 2;
      oo.nd := case
                 when length(oo.ref) > 10 then
                  substr(oo.ref, -10)
                 else
                  to_char(oo.ref)
               end;

      gl.in_doc3(ref_   => oo.ref,
                 tt_    => oo.tt,
                 vob_   => OO.VOB,
                 nd_    => oo.nd,
                 pdat_  => SYSDATE,
                 vdat_  => gl.bdate,
                 dk_    => 1,
                 kv_    => l_rec.kv,
                 s_     => l_rec.S,
                 kv2_   => l_rec.kv,
                 s2_    => l_rec.s,
                 sk_    => null,
                 data_  => gl.bdate,
                 datp_  => gl.bdate,
                 nam_a_ => NMS_9831,
                 nlsa_  => NLS_9831,
                 mfoa_  => gl.aMfo,
                 nam_b_ => NMS_9830,
                 nlsb_  => NLS_9830,
                 mfob_  => gl.aMfo,
                 nazn_  => oo.nazn,
                 d_rec_ => null,
                 id_a_  => gl.aokpo,
                 id_b_  => gl.aokpo,
                 id_o_  => null,
                 sign_  => null,
                 sos_   => 1,
                 prty_  => null,
                 uid_   => null);

      set_operw(oo.ref, 'NOS_A', l_acc);
      set_operw(oo.ref, '72', p_REF_POS);
      set_operw(oo.ref, 'GOLD', 'Чеки');
      set_operw(oo.ref, 'SUMGD', l_rec.Kol);
      set_operw(oo.ref,
                'VLASN',
                'Відправка чеків в інобанк');

      gl.payv(0,
              oo.ref,
              gl.bdate,
              'CH1',
              1,
              l_rec.kv,
              NLS_9831,
              l_rec.s,
              l_rec.kv,
              NLS_9830,
              l_rec.s);

      update ch_1 set ref2 = oo.ref where id = l_rec.id;

    end if;
  end send_check;

begin
  -- Initialization
  null;
end;
/
 show err;
 
PROMPT *** Create  grants  CHECK_PKG ***
grant EXECUTE                                                                on CHECK_PKG       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/check_pkg.sql =========*** End *** =
 PROMPT ===================================================================================== 
 