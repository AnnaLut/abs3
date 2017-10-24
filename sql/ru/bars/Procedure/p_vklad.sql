

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_VKLAD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_VKLAD ***

  CREATE OR REPLACE PROCEDURE BARS.P_VKLAD 
 (p_id    in  smallint,
  p_dat1  in  date,
  p_dat2  in  date,
  p_nls   in  accounts.nls%type,
  p_kv    in  accounts.kv%type    default null)
is
  l_nb    banks.nb%type;
  l_side  char(1);
  l_cnt   integer;
begin

  delete from tmp_lic where id = p_id;

  l_cnt := 0;

  for c0 in
     (select a.acc, a.nls, a.kv, a.isp, a.nms, s.fdat, s.pdat, s.ostf
        from saldoa s, accounts a
       where a.acc   = s.acc
         and s.fdat >= p_dat1
         and s.fdat <= p_dat2
         and a.nls like p_nls
         and a.kv    = nvl(p_kv, a.kv))
  loop

    l_cnt := l_cnt + 1;

    for c1 in
       (select ref, tt, s * decode(dk, 0, -1, 1) s, txt
          from opldok
         where acc  = c0.acc
           and fdat = c0.fdat
           and sos  = 5
         order by ref)
    loop

      for c2 in
         (select o.vdat, o.vob, o.nd, o.userid, o.sk, o.kv,
                 o.mfoa, o.nlsa, o.nam_a, o.id_a,
                 o.mfob, o.nlsb, o.nam_b, o.id_b,
                 decode(o.tt, c1.tt, o.nazn, t.name) nazn
            from oper o, tts t
           where o.ref = c1.ref
             and t.tt  = c1.tt)
      loop

        if c0.nls = c2.nlsa and c0.kv = c2.kv then
           l_side := 'a';
           select nb into l_nb from banks where mfo = c2.mfob;
        else
           l_side := 'b';
           select nb into l_nb from banks where mfo = c2.mfoa;
        end if;

        insert into tmp_lic
           (id, acc, nls, kv, nms, fdat, dapp, ostf, isp,
            ref, tt, nd, vob, s, vdat, sk, userid, nazn,
            nb, mfo, nlsk, namk, okpo)
        values
           (p_id, c0.acc, c0.nls, c0.kv, c0.nms, c0.fdat, c0.pdat, c0.ostf, c0.isp,
            c1.ref, c1.tt, c2.nd, c2.vob, c1.s, c2.vdat, c2.sk, c2.userid, c2.nazn,
            l_nb,
            (case when l_side = 'a' then c2.mfob  else c2.mfoa  end),
            (case when l_side = 'a' then c2.nlsb  else c2.nlsa  end),
            (case when l_side = 'a' then c2.nam_b else c2.nam_a end),
            (case when l_side = 'a' then c2.id_b  else c2.id_a  end));

      end loop; -- c2

    end loop; -- c1

  end loop;  -- c0

  if l_cnt = 0 then

    for c9 in
       (select a.acc, a.nls, a.kv, a.isp, a.nms, (s.ostf - s.dos + s.kos) ost
          from accounts a, saldoa s
         where a.acc = s.acc
           and a.nls like p_nls
           and a.kv = nvl(p_kv, a.kv)
           and s.fdat =
              (select max(s1.fdat)
                 from saldoa s1
                where s1.acc = s.acc
                  and s1.fdat >= a.daos
                  and s1.fdat <= p_dat1))
    loop

      insert into tmp_lic
        (id, acc, nls, kv, nms, ostf, isp)
      values
        (p_id, c9.acc, c9.nls, c9.kv, c9.nms, c9.ost, c9.isp);

    end loop; -- c9

  end if;

end p_vklad;
/
show err;

PROMPT *** Create  grants  P_VKLAD ***
grant EXECUTE                                                                on P_VKLAD         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_VKLAD         to DPT;
grant EXECUTE                                                                on P_VKLAD         to START1;
grant EXECUTE                                                                on P_VKLAD         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_VKLAD.sql =========*** End *** =
PROMPT ===================================================================================== 
