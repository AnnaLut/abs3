

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SP15.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SP15 ***

  CREATE OR REPLACE PROCEDURE BARS.SP15 (p_dat in date, p_dpt_id in number, p_shtraf_int in number, p_mode in number, p_tax out number)
is

l_tax_acc number;
l_tax_nls varchar2(14);
l_tax_nls_back varchar2(14);
l_tax number;
l_tax_date_begin date;
l_tax_date_end date;

l_kv number;
l_kv2 number := 980;
l_tax_back number :=0;
l_tax_backv number :=0;
l_intost number := 0;

l_tax_payed number :=0;
l_tax_payedv number :=0;

l_ref number; -- DPS
l_nlsa varchar2(14);
l_acc number;
l_branch varchar2(50);
l_id_a varchar2(50);

 l_bdate date;
 l_mfo   varchar2(50);
 l_mfoa varchar2(50);
 l_nmsa varchar2(100);
 l_tax_nms varchar2(100);
 l_tax_mfo varchar2(100);


begin


   select kv , branch
   into l_kv, l_branch
   from dpt_deposit
   where deposit_id = p_dpt_id;

   bars_audit.trace('%s TAX: START  p_tax %s', 'SP15', to_char(p_shtraf_int));
   bars_audit.trace('%s TAX: START  p_tax %s'||to_char(p_dat)||','||to_char(p_dpt_id)||','|| to_char(p_shtraf_int)||','||to_char(p_mode), 'SP15', to_char(p_dat)||','||to_char(p_dpt_id)||','|| to_char(p_shtraf_int)||','||to_char(p_mode));

   l_tax:= GetGlobalOption('TAX_INT');
   l_tax_date_begin := to_date(GetGlobalOption('TAX_DON'), 'dd.mm.yyyy');
   l_tax_date_end := to_date(nvl(GetGlobalOption('TAX_DOFF'),add_months(p_dat,1)), 'dd.mm.yyyy');
   l_tax_nls := nbs_ob22_null(3622,37, l_branch);
   l_tax_nls_back := nbs_ob22_null(3522,29,l_branch);


  select acc, substr(nms,1,38)
   into l_tax_acc, l_tax_nms
   from accounts
   where nls = l_tax_nls_back;

              if p_mode = 1 then  --вернуть налог от штрафа
               -- пересчитіваем сколько было уплачено ранее штрафа
                if l_kv = 980 then
                    begin
                          select sum(s)
                          into l_tax_payed
                          from opldok
                          where acc in (select accid from dpt_accounts where dptid = p_dpt_id)
                          and tt = '%15'
                          and sos = 5
                          and dk = 0
                          and fdat >=l_tax_date_begin;
                    exception
                      when no_data_found then
                      l_tax_payed := 0;
                   end;
                else
                 begin
                         select sum(s)
                          into l_tax_payed
                          from opldok
                          where ref in
                          (select ref from opldok
                          where  acc in (select accid from dpt_accounts where dptid = p_dpt_id)
                          and tt = '%15' and sos = 5 and dk = 0)
                          and tt = '%15'
                          and dk = 0
                          and sos = 5
                          and fdat >=l_tax_date_begin
                          and s <> sq;
                     exception
                      when no_data_found then
                      l_tax_payed := 0;
                   end;

                end if;

                  l_tax_back  := l_tax_payed - p_shtraf_int*nvl(l_tax,0.15); -- отнимаем от того, что уплачено ранее новый (честный) налог от начисленных процентов. Разницу надо вернуть
                  l_tax_backv := p_icurval(l_kv, round(l_tax_back), p_dat);
                  p_tax := nvl(l_tax_back,0);

               if to_date(p_dat,'dd/mm/yyyy') between to_date(l_tax_date_begin,'dd/mm/yyyy') and to_date(l_tax_date_end,'dd/mm/yyyy')
                  and nvl(l_tax_backv,0) > 0
                then

                 select da.accid, a.nls, a.kv, c.okpo, A.KF, substr(a.nms,1,38)
                 into l_acc, l_nlsa, l_kv, l_id_a, l_mfoa, l_nmsa
                 from accounts a, dpt_deposit d, dpt_accounts da, customer c
                 where a.acc= da.accid
                 and a.rnk = c.rnk
                 and D.DEPOSIT_ID = DA.DPTID
                 and d.deposit_id = p_dpt_id
                 and d.acc <> da.accid;

                    if  nvl(l_nlsa,'') <>0
                    then
                           l_bdate := gl.bdate;
                           l_mfo   := gl.amfo;

                          l_intost := fost(l_acc,p_dat);
                          if l_intost > 0 then

                           gl.ref(l_ref);

                            gl.in_doc3 (ref_    => l_ref,
                                      tt_     => '%15',
                                      vob_    => 6,
                                      nd_     => to_char(l_ref),
                                      pdat_   => sysdate,
                                      vdat_   => bankdate,
                                      dk_     => 1,
                                      kv_     => l_kv,
                                      s_      => l_tax_back,
                                      kv2_    => 980,
                                      s2_     => l_tax_backv,
                                      sk_     => null,
                                      data_   => bankdate,
                                      datp_   => bankdate,
                                      nam_a_  => l_nmsa,
                                      nlsa_   => l_nlsa,
                                      mfoa_   => nvl(l_mfoa,l_mfo),
                                      nam_b_  => l_tax_nms,
                                      nlsb_   => l_tax_nls_back,
                                      mfob_   => nvl(l_tax_mfo,l_mfo),
                                      nazn_   => 'Повернення  податку з процентних доходів фізичних осіб за при достроковому розірванні',
                                      d_rec_  => null,
                                      id_a_   => l_id_a,
                                      id_b_   => l_id_a,
                                      id_o_   => null,
                                      sign_   => null,
                                      sos_    => null,
                                      prty_   => 0,
                                      uid_    => user_id);

                           gl.payv(1, l_ref, bankdate,'%15', 1, 980,  l_tax_nls_back , l_tax_backv, l_kv,l_nlsa, l_tax_back);
                          end if;

                            insert into int15_log
                            select l_ref, p_dat, p_shtraf_int, l_kv, l_tax_back, to_char(l_tax_backv) from dual;

                         else
                          return;
                         end if;
                  end if;
             end if;

 if p_mode = 0 then -- просто посчитать сумму возвращаемого налога

    if l_kv = 980 then
         begin
              select sum(s)
              into l_tax_payed
              from opldok
              where  acc in (select accid from dpt_accounts where dptid = p_dpt_id)
              and tt = '%15'
              and sos = 5
              and dk = 0
              and fdat >=l_tax_date_begin;
        exception
          when no_data_found then
          l_tax_payed := 0;
       end;
    else
     begin
             select sum(s)
              into l_tax_payed
              from opldok
              where ref in
              (select ref from opldok
              where  acc in (select accid from dpt_accounts where dptid = p_dpt_id)
              and tt = '%15' and sos = 5 and dk = 0)
              and tt = '%15'
              and dk = 1
              and sos = 5
              and fdat >=l_tax_date_begin
              and s <> sq;
         exception
          when no_data_found then
          l_tax_payed := 0;
       end;
     end if;

      l_tax_back  := l_tax_payed - p_shtraf_int*nvl(l_tax,0.15);
      l_tax_backv := p_icurval(l_kv, round(l_tax_back), p_dat);

   p_tax := nvl(l_tax_back,0);
   end if;

end sp15;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SP15.sql =========*** End *** ====
PROMPT ===================================================================================== 
