PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GEN_DPTRPT.sql =========*** Run **
PROMPT ===================================================================================== 


  CREATE OR REPLACE PROCEDURE BARS.GEN_DPTRPT 
 (p_code     in  tmp_dptrpt.code%type,
  p_dat1     in  tmp_dptrpt.fdat%type,
  p_dat2     in  tmp_dptrpt.fdat%type,
  p_dptid    in  tmp_dptrpt.dptid%type,
  p_planflg  in  number default 0)    -- флаг отображения незавизир.документов за дату p_dat2
is
  -- процедура формирования отчетов по деп.и соц.договорам физ.лиц
  -- Версия : № 2 от 02/07/2009
  -- Режим  :
  -- с модулем "Соц.договора физ.лиц"
  -- мульти-МФО схема с иерархическими отделениями
  title constant varchar2(60) := 'gendptrpt:';
  type t_dpt is record (dptid       tmp_dptrpt.dptid%type,
                        dptnum      tmp_dptrpt.dptnum%type,
                        dptdat      tmp_dptrpt.dptdat%type,
                        datbeg      tmp_dptrpt.datbeg%type,
                        datend      tmp_dptrpt.datend%type,
                        typeid      tmp_dptrpt.typeid%type,
                        typename    tmp_dptrpt.typename%type,
                        curid       tmp_dptrpt.curid%type,
                        curcode     tmp_dptrpt.curcode%type,
                        curname     tmp_dptrpt.curname%type,
                        custid      tmp_dptrpt.custid%type,
                        custname    tmp_dptrpt.custname%type,
                        depaccid    accounts.acc%type,
                        depaccnum   tmp_dptrpt.depaccnum%type,
                        depaltaccnum   tmp_dptrpt.depaltaccnum%type,
                        depaccname  tmp_dptrpt.depaccname%type,
                        intaccid    accounts.acc%type,
                        intaccnum   tmp_dptrpt.intaccnum%type,
                        intaccname  tmp_dptrpt.intaccname%type,
                        userid      tmp_dptrpt.userid%type,
                        username    tmp_dptrpt.username%type,
                        brn4id      tmp_dptrpt.brn4id%type,
                        brn4name    tmp_dptrpt.brn4name%type);
  l_dpt     t_dpt;
  l_recid   number(38);
  l_noturns number(1);
  l_idupd   number;
  l_genisal accounts.ostc%type;
  l_genosal accounts.ostc%type;
  l_accid   accounts.acc%type;
  l_type    char(3);
  l_side    char(1);
  l_lasturn date;
  l_prevturn date;
  l_lastinsal accounts.ostc%type;
  l_plansum number(38);
begin

  bars_audit.trace('%s entry, (%s, %s, %s, %s)', title, to_char(p_code), to_char(p_dptid),
                   to_char(p_dat1, 'dd.mm.yyyy'), to_char(p_dat2, 'dd.mm.yyyy') );

  delete from tmp_dptrpt;

  l_recid := 1;

  if p_code in (35, 37) then

    if p_code = 35 then  --  поиск деп.договора

       select max(idupd)
         into l_idupd
         from dpt_deposit_clos
        where deposit_id = p_dptid
          and bdate     <= p_dat1;

       if l_idupd is null then
          select min(idupd)
            into l_idupd
            from dpt_deposit_clos
           where deposit_id = p_dptid
             and bdate     >= p_dat1;
       end if;

       begin
         select d.deposit_id, d.nd, d.datz, d.dat_begin, d.dat_end,
                v.vidd, v.type_name, t.kv, t.lcv, t.name, c.rnk, c.nmk,
                a1.acc, a1.nls, a1.nlsalt, a1.nms, a2.acc, a2.nls, a2.nms,
                s.id, s.fio, b.branch, b.name
           into l_dpt
           from dpt_deposit_clos d,
                int_accn         i,
                dpt_vidd         v,
                customer         c,
                tabval           t,
                staff$base       s,
                branch           b,
                saldo            a1,
                saldo            a2
          where d.idupd  = l_idupd
            and d.acc    = a1.acc
            and d.acc    = i.acc
            and i.id     = 1
            and i.acra   = a2.acc
            and d.kv     = t.kv
            and d.rnk    = c.rnk
            and d.vidd   = v.vidd
            and a1.isp   = s.id
            and d.branch = b.branch
            and a1.daos <= p_dat2
            and nvl(a1.dazs, p_dat2) >= p_dat2
            and l_idupd  is not null;
       exception
         when no_data_found then
           return;
       end;

    else  -- поиск соц.договора

       begin
         select s.contract_id, s.contract_num, s.contract_date, s.contract_date, s.closed_date,
                v.type_id, substr(v.name, 1, 50), t.kv, t.lcv, t.name, c.rnk, c.nmk,
                a1.acc, a1.nls, a1.nlsalt, a1.nms, a2.acc, a2.nls, a2.nms,
                f.id, f.fio, b.branch, b.name
           into l_dpt
           from social_contracts s,
                int_accn         i,
                social_dpt_types v,
                customer         c,
                tabval           t,
                staff$base       f,
                branch           b,
                saldo            a1,
                saldo            a2
          where s.contract_id = p_dptid
            and s.acc         = a1.acc
            and s.acc         = i.acc
            and i.id          = 1
            and i.acra        = a2.acc
            and a1.kv         = t.kv
            and s.rnk         = c.rnk
            and v.type_id     = s.type_id
            and a1.isp        = f.id
            and s.branch      = b.branch
            and a1.daos      <= p_dat2
            and nvl(a1.dazs, p_dat2) >= p_dat2;
       exception
         when no_data_found then
           return;
       end;
    end if;
    bars_audit.trace('%s l_dptid = %s', title, to_char(l_dpt.dptid));

    -- 1 = выписка по депозитному счету / 2 = по счету начисленных процентов
    for i in 1..2 loop

      l_noturns := 1;

      if  i = 1 then
          l_accid := l_dpt.depaccid;
          l_type  := 'DEP';
      else
          l_accid := l_dpt.intaccid;
          l_type  := 'INT';
      end if;
      bars_audit.trace('%s l_type = %s, l_accid = %s', title, l_type, to_char(l_accid));

      l_genisal := null;
      l_genosal := null;

      -- даты с оборотами по счету
      for trn in
         (select acc, fdat, pdat, ostf, (ostf - dos + kos) ostp
            from saldoa
           where acc   = l_accid
             and fdat >= p_dat1
             and fdat <= p_dat2
             and dos + kos > 0
           order by acc, fdat)
      loop
        bars_audit.trace('%s trn.dat = %s', title, to_char(trn.fdat, 'dd.mm.yyyy'));

        if trn.fdat = p_dat1 then
           l_genisal := trn.ostf;
        end if;
        if trn.fdat = p_dat2 then
           l_genosal := trn.ostp;
        end if;

        for doc in
           (select p.ref, p.tt, p.s, p.dk, o.nd, o.kv,
                   o.mfoa, o.nlsa, o.nam_a, o.id_a,
                   o.mfob, o.nlsb, o.nam_b, o.id_b,
                   o.userid, o.sk, nvl(o.nazn,t.name) nazn  --decode(o.tt, p.tt, o.nazn, t.name) nazn  --- COBUMMFO-9624
              from opldok p, oper o, tts t
             where p.acc  = trn.acc
               and p.fdat = trn.fdat
               and p.sos  = 5
               and p.ref  = o.ref
               and p.tt   = t.tt
             order by p.ref)
        loop
          bars_audit.trace('%s doc.ref = %s', title, to_char(doc.ref));

          if (i = 1 and l_dpt.depaccnum = doc.nlsa and l_dpt.curid = doc.kv) or
             (i = 2 and l_dpt.intaccnum = doc.nlsa and l_dpt.curid = doc.kv) then
              l_side := 'a';
          else
              l_side := 'b';
          end if;

          insert into tmp_dptrpt
             (recid, code, dptid, dptnum, dptdat,
              datbeg, datend, custid, custname,
              depaccnum, depaltaccnum, depaccname, intaccnum, intaccname,
              curid, curcode, curname, typeid, typename,
              doctype, fdat, pdat, isal_dat, osal_dat,
              docref, docnum, doctt, docdk, docsum, docsk, docuser, docdtl,
              corrmfo, corracc, corrname, corrcode,
              userid, username, brn4id, brn4name)
          values
             (l_recid, p_code, l_dpt.dptid, l_dpt.dptnum, l_dpt.dptdat,
              l_dpt.datbeg, l_dpt.datend, l_dpt.custid, l_dpt.custname,
              l_dpt.depaccnum, l_dpt.depaltaccnum, l_dpt.depaccname, l_dpt.intaccnum, l_dpt.intaccname,
              l_dpt.curid, l_dpt.curcode, l_dpt.curname, l_dpt.typeid, l_dpt.typename,
              l_type, trn.fdat, trn.pdat, trn.ostf, trn.ostp,
              doc.ref, doc.nd, doc.tt, doc.dk, doc.s, doc.sk, doc.userid, doc.nazn,
              (case when l_side = 'a' then doc.mfob  else doc.mfoa  end),
              (case when l_side = 'a' then doc.nlsb  else doc.nlsa  end),
              (case when l_side = 'a' then doc.nam_b else doc.nam_a end),
              (case when l_side = 'a' then doc.id_b  else doc.id_a  end),
              l_dpt.userid, l_dpt.username, l_dpt.brn4id, l_dpt.brn4name);

          l_recid   := l_recid + 1;
          l_noturns := 0;
        end loop;  -- doc

      end loop; -- trn

      bars_audit.trace('%s l_genisal = %s, l_genosal = %s', title, to_char(l_genisal), to_char(l_genosal));

      -- входящий остаток на начало периода
      if l_genisal is null then
         begin
           select (s.ostf - s.dos + s.kos)
             into l_genisal
             from saldoa s
            where s.acc  = l_accid
              and s.fdat = (select max(s1.fdat)
                              from saldoa s1
                             where s1.acc   = l_accid
                               and s1.fdat <= p_dat1);
         exception
           when no_data_found then l_genisal := 0;
         end;
      end if;

      -- исходящий остаток на конец периода
      if l_genosal is null then
         begin
           select s.fdat, s.pdat, s.ostf,  (s.ostf - s.dos + s.kos)
             into l_lasturn, l_prevturn, l_lastinsal, l_genosal
             from saldoa s
            where s.acc  = l_accid
              and s.fdat = (select max(s1.fdat)
                              from saldoa s1
                             where s1.acc   = l_accid
                               and s1.fdat <= p_dat2);
         exception
           when no_data_found then l_genosal := 0;
         end;
      end if;
      bars_audit.trace('%s l_genisal* = %s, l_genosal* = %s', title,
                       to_char(l_genisal), to_char(l_genosal));
      bars_audit.trace('%s l_lasturn = %s, l_prevturn = %s, l_lastinsal = %s', title,
                       to_char(l_lasturn,  'dd.mm.yyyy'),
                       to_char(l_prevturn, 'dd.mm.yyyy'),
                       to_char(l_lastinsal));

      update tmp_dptrpt
         set isal_gen = l_genisal,
             osal_gen = l_genosal
       where dptid    = l_dpt.dptid
         and doctype  = l_type;

      -- если не было движений, зафиксим исходящий остаток на конечную дату
      if l_noturns = 1 then
         bars_audit.trace('%s no movements', title);
         insert into tmp_dptrpt
                (recid, code, dptid, dptnum, dptdat,
                 datbeg, datend, custid, custname,
                 depaccnum, depaltaccnum, depaccname, intaccnum, intaccname,
                 curid, curcode, curname, typeid, typename,
                 doctype, fdat, isal_gen, osal_gen,
                 userid, username, brn4id, brn4name)
         values (l_recid, p_code, l_dpt.dptid, l_dpt.dptnum, l_dpt.dptdat,
                 l_dpt.datbeg, l_dpt.datend, l_dpt.custid, l_dpt.custname,
                 l_dpt.depaccnum, l_dpt.depaltaccnum, l_dpt.depaccname, l_dpt.intaccnum, l_dpt.intaccname,
                 l_dpt.curid, l_dpt.curcode, l_dpt.curname, l_dpt.typeid, l_dpt.typename,
                 l_type, p_dat2, l_genisal, l_genosal,
                 l_dpt.userid, l_dpt.username, l_dpt.brn4id, l_dpt.brn4name);
         l_recid    := l_recid + 1;
      end if;

      -- отбор незавизированных документов за конечную дату
      if p_planflg = 1 then

         l_plansum := 0;

         for plan_doc in
           (select p.ref, p.tt, p.s, p.dk, o.nd, o.kv,
                   o.mfoa, o.nlsa, o.nam_a, o.id_a,
                   o.mfob, o.nlsb, o.nam_b, o.id_b,
                   o.userid, o.sk, nvl(o.nazn,t.name) nazn  --decode(o.tt, p.tt, o.nazn, t.name) nazn  --- COBUMMFO-9624
              from opldok p, oper o, tts t
             where p.ref  = o.ref
               and p.tt   = t.tt
               and p.acc  = l_accid
               and p.fdat = p_dat2
               and p.sos  = 1
             order by p.ref)
         loop

           bars_audit.trace('%s plandoc.ref = %s', title, to_char(plan_doc.ref));

           if (i = 1 and l_dpt.depaccnum = plan_doc.nlsa and l_dpt.curid = plan_doc.kv) or
              (i = 2 and l_dpt.intaccnum = plan_doc.nlsa and l_dpt.curid = plan_doc.kv) then
               l_side := 'a';
           else
               l_side := 'b';
           end if;

           insert into tmp_dptrpt
              (recid, code, dptid, dptnum, dptdat,
               datbeg, datend, custid, custname,
               depaccnum, depaltaccnum, depaccname, intaccnum, intaccname,
               curid, curcode, curname, typeid, typename,
               doctype, fdat, pdat, isal_dat, osal_dat, isal_gen, osal_gen,
               docref, docnum, doctt, docdk,
               docsum, docsk, docuser, docdtl,
               corrmfo, corracc, corrname, corrcode,
               userid, username, brn4id, brn4name)
           values
              (l_recid, p_code, l_dpt.dptid, l_dpt.dptnum, l_dpt.dptdat,
               l_dpt.datbeg, l_dpt.datend, l_dpt.custid, l_dpt.custname,
               l_dpt.depaccnum, l_dpt.depaltaccnum, l_dpt.depaccname, l_dpt.intaccnum, l_dpt.intaccname,
               l_dpt.curid, l_dpt.curcode, l_dpt.curname, l_dpt.typeid, l_dpt.typename,
               l_type,
               p_dat2,
               (case when p_dat2 = l_lasturn then l_prevturn  else l_lasturn end),
               (case when p_dat2 = l_lasturn then l_lastinsal else l_genosal end),
               l_genosal, l_genisal, l_genosal,
               plan_doc.ref, plan_doc.nd, plan_doc.tt, plan_doc.dk,
               plan_doc.s, plan_doc.sk, plan_doc.userid, plan_doc.nazn,
               (case when l_side = 'a' then plan_doc.mfob  else plan_doc.mfoa  end),
               (case when l_side = 'a' then plan_doc.nlsb  else plan_doc.nlsa  end),
               (case when l_side = 'a' then plan_doc.nam_b else plan_doc.nam_a end),
               (case when l_side = 'a' then plan_doc.id_b  else plan_doc.id_a  end),
               l_dpt.userid, l_dpt.username, l_dpt.brn4id, l_dpt.brn4name);

           if plan_doc.dk = 1 then
              l_plansum := l_plansum + plan_doc.s;
           else
              l_plansum := l_plansum - plan_doc.s;
           end if;
           bars_audit.trace('%s l_plansum = %s', title, to_char(l_plansum));

           l_recid   := l_recid + 1;

         end loop;  -- plan_doc

         bars_audit.trace('%s l_plansum(total) = %s', title, to_char(l_plansum));

         update tmp_dptrpt
            set osal_gen = osal_gen + l_plansum
          where dptid   = l_dpt.dptid
            and doctype = l_type;

         update tmp_dptrpt
            set osal_dat = osal_dat + l_plansum
          where dptid   = l_dpt.dptid
            and doctype = l_type
            and fdat    = p_dat2;

      end if;

    end loop; -- dep / int

  else

    return;

  end if;

end gen_dptrpt;
 
/
show err;

PROMPT *** Create  grants  GEN_DPTRPT ***
grant EXECUTE                                                                on GEN_DPTRPT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GEN_DPTRPT      to RPBN001;
grant EXECUTE                                                                on GEN_DPTRPT      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GEN_DPTRPT      to WR_CREPORTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GEN_DPTRPT.sql =========*** End **
PROMPT ===================================================================================== 
