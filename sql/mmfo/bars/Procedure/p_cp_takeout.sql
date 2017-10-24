

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_TAKEOUT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_TAKEOUT ***

  CREATE OR REPLACE PROCEDURE BARS.P_CP_TAKEOUT (p_ref     IN cp_deal.ref%type,
                                               p_nlsfd   IN accounts.nls%type,
                                               p_rnk     IN customer.rnk%type default null,
                                               p_SN      IN number default null,-- ����� �������� �� �����
                                               p_SR      IN number default null,-- ����� R �� �����
                                               p_SR2     IN number default null,-- ����� R2 �� �����
                                               p_SR3     IN number default null,
                                               p_SREXP   IN number default null)-- ����� R3 �� �����     
is
 /*21.03.2017*/
 title          constant    varchar2(14)        := 'p_cp_takeout:';
 l_vidd         constant    accounts.nbs%type   := '3541';
 l_pf_id        constant    cp_pf.pf%type       := -3;         -- �� ���������
 l_op_id        constant    cp_arch.op%type     := 3;          -- ����������� cp_arch.op
 l_quality      constant    cp_ryn.quality%type := -1;
 l_tt           constant    tts.tt%type         := 'FX7';
 l_vob          constant    vob.vob%type        := 6;
 l_nazn         oper.nazn%type                  := '����������� �� �� ������������� �� ����. ';
                                                 -- ����������� �� ��� ������������� �� ����. �����������, UA4000150841, ��. 5931, ����� 250 ��
 l_cp_id                cp_kod.cp_id%type;
 l_nd                   oper.nd%type;
 l_kol                  number;

 p_resulttxt            varchar2(250) := title;
 p_resultcode           int := 0;
 l_nmk                  customer.nmk%type;

 ref_                   number;
 l_cust_row             customer%rowtype;
 l_cpdeal_row_init      cp_deal%rowtype;    -- �� �������� ������
 l_accounts_row         accounts%rowtype;   -- ������ ����� ������������ 3541 ��� ��������
 l_accountsR_row        accounts%rowtype;   -- ������ ����� ������������ 3541 ��� ������
 l_accountNLS_FXP       accounts%rowtype;   -- ���� 5102 ����������

 l_cpdeal_row           cp_deal%rowtype;    -- ����� ������ � ���
 l_cpryn_row            cp_ryn%rowtype;
 l_cpaccc_row           cp_accc%rowtype;
 l_rnk_emi              cp_kod.emi%type;
 -- ��������� ��� �������� ������
 GRP_                   int;
 r1_                    int;
 acc_                   int;
 accR_                  int;
 l_nlsN                 accounts.nls%type;
 l_nmsN                 accounts.nms%type;
 l_s                    number;             -- ����� ��� ���������
 l_sN                   number;             -- ����� ��� �� �� ��������
 l_sR                   number;             -- ����� ��� �� �� ������� ���������
 l_sS                   number;             -- ����� ��� �� �������� ������/��������
   
begin
  bars_audit.info(title||' start with params: p_ref =>' || p_ref||', p_nlsfd => '|| p_nlsfd || ', p_SN => ' || p_SN|| ', p_SR => ' || p_SR|| ', p_SR2 => ' || p_SR2|| ', p_SR3 => ' || p_SR3);

  -- �������� ������
  begin
    SELECT *
      INTO l_cpdeal_row_init
      FROM cp_deal
     WHERE ref = p_ref;
  exception when no_data_found
            then p_resulttxt := p_resulttxt || '�� ������� ������ � ���������� '|| to_char(p_ref);
                 p_resultcode := 1;
                 raise_application_error(-20000, P_RESULTTXT);
                 RETURN;
  end;

  -- ������� ����� ������ ��� ��
  l_cpdeal_row := l_cpdeal_row_init;
   -- �������� �������� ���� �� ��� ��������
  begin
   select *
     into l_accounts_row
     from accounts
    where nls = p_nlsfd
      and kv = (select kv from accounts where acc = l_cpdeal_row.acc)
      and dazs is null;
   l_accountsR_row := l_accounts_row;
  exception when no_data_found
            then p_resulttxt := p_resulttxt || '�� ������ (��� ������) ���� �����.������������� '|| p_nlsfd || ', � ������ ������';
                 p_resultcode := 3;
                 raise_application_error(-20000, P_RESULTTXT);
                 RETURN;
  end;
  
 
   -- �������� ������ �� ��� ��������
  begin
   select *
     into l_cust_row
     from customer
    where rnk = (select rnk from accounts where acc = l_cpdeal_row.acc);
  exception when no_data_found then raise;
  end;
   -- �������� ��� �������� �� ���
  begin
   select min(emi)
     into l_rnk_emi
     from cp_kod
    where rnk = l_accounts_row.rnk;
  exception when no_data_found then raise;
  end;  
 
  -- ��� ���������� ���� ���� ��� ������
  begin
   select cp_id, nd, abs(coalesce(p_SN,fost(c.acc, gl.bd)/100)/(select cena from cp_kod where id= c.id))
     into l_cp_id, l_nd, l_kol
     from cp_v c
    where ref = p_ref;
  exception when no_data_found then raise;
  end;
  l_nazn := l_nazn ||' '||l_cust_row.nmk || ', '|| l_cp_id || ', ��.' || l_nd || ' ����� ' ||to_char(l_kol) || ' ��.';

  l_cpryn_row.name := to_char(l_accounts_row.rnk)||'/�������� ��';
   -- ����� ���������� ��� ������ ����� �������� cp_ryn
  begin
      select *
        into l_cpryn_row
        from cp_ryn
       where name = l_cpryn_row.name
         and quality = l_quality;
  exception when no_data_found
            then
                begin
                 select max(ryn)+1
                   into l_cpryn_row.ryn
                   from cp_ryn;

                 l_cpryn_row.tipd       := 1;
                 l_cpryn_row.kv         := null;
                 l_cpryn_row.quality    := l_quality;
                 insert into cp_ryn values l_cpryn_row;
                end;
  end;

  -- ����� ��� ������� ������ �������� � ����������� ����������������� ������
  begin
   select *
     into l_cpaccc_row
     from cp_accc
    where ryn = l_cpryn_row.ryn;
  exception when no_data_found
            then begin
                  l_cpaccc_row.VIDD := l_vidd;
                  l_cpaccc_row.RYN  := l_cpryn_row.ryn;
                  l_cpaccc_row.NLSA := p_nlsfd;
                  l_cpaccc_row.EMI  := l_rnk_emi;
                  l_cpaccc_row.PF   := l_pf_id; -- �� ���������
                  insert into cp_accc values l_cpaccc_row;
                 end;
  end;

  begin
    select *
      into l_accountNLS_FXP
      from accounts
     where nls = (select NLS_FXP from cp_accc where ryn = l_cpdeal_row_init.ryn and rownum = 1) 
       and kv = (select kv from accounts where acc = l_cpdeal_row.acc) 
       and rownum = 1;
  exception when no_data_found then null;
  end;

   begin
   select nmk
     into l_nmk 
     from customer 
    where rnk = p_rnk;
   exception when no_data_found then l_nmk := l_cust_row.nmk;
   end;
  -- ������� ���� ��� �������� �� ��� ������
   l_accounts_row.nls := substr(l_vidd||p_rnk,1,14);
   l_accounts_row.nms := substr('���(������)'||l_nmk || ','|| l_cp_id || ',��.' || l_nd || '���.' ||to_char(l_kol) || '��.',1,39);
   
     
   cp.CP_REG_EX(99,0,0,GRP_,r1_,
                coalesce(p_rnk,l_accounts_row.rnk), -- ��������� ����� ��� ���� �� �������� (�� ���������), ���� �� ��������� ��� � ��������� 
                l_accounts_row.nls,l_accounts_row.kv,l_accounts_row.nms,'ODB',gl.aUid,acc_);

   update accounts
      set accc = l_accounts_row.acc,
          dapp = l_accounts_row.dapp
    where acc = acc_;

  -- ������� ���� ��� ������ �������� �� ��� ������
  l_accountsR_row.nls := substr(l_vidd||'2'||p_rnk,1,14);
  l_accountsR_row.nms := substr('���(�����)'||l_nmk || ','|| l_cp_id || ',��.' || l_nd || '�����' ||to_char(l_kol) || '��.',1,39);

  cp.CP_REG_EX(99,0,0,GRP_,r1_,coalesce(p_rnk,l_accountsR_row.rnk),l_accountsR_row.nls,l_accountsR_row.kv,l_accountsR_row.nms,'ODB',gl.aUid,accR_);

   update accounts
      set accc = l_accountsR_row.acc,
          dapp = l_accountsR_row.dapp
    where acc = accR_;

  -- ����������� ��� ������� ������ ������, ��������������� �� ���������
  begin
    SELECT l_cpdeal_row.id,
           l_cpryn_row.ryn,
           p_ref,--COALESCE (l_cpdeal_row.initial_ref, p_ref),
           acc_, accR_,
           1, l_op_id, l_pf_id, erat
      INTO l_cpdeal_row.id,
           l_cpdeal_row.ryn,
           l_cpdeal_row.INITIAL_REF,
           l_cpdeal_row.ACC,
           l_cpdeal_row.ACCR,
           l_cpdeal_row.active,
           l_cpdeal_row.op,
           l_cpdeal_row.pf,
           l_cpdeal_row.erat
      FROM cp_deal
     WHERE ref = p_ref;
  exception when no_data_found then return;
  end;
  l_cpdeal_row.acc := acc_;
  l_cpdeal_row.accr  := accR_;
  l_cpdeal_row.accr2 := null;
  l_cpdeal_row.accr3 := null;
  l_cpdeal_row.accp  := null;
  l_cpdeal_row.accd  := null;
  l_cpdeal_row.accs  := null;
  
      begin
        select max(nls), max(nms), case when (p_SN is null and p_SR is null and p_SR2 is null and p_SR3 is null and p_SREXP is null) then ABS(sum(s)) else abs(nvl(p_SN,0) + nvl(p_SR,0) + nvl(p_SR2 ,0) + nvl(p_SR3,0)+ nvl(p_SREXP,0)) end
          into l_nlsN, l_nmsN, l_s
          from (select case when ca.CP_ACCTYPE = 'N' then min(a.nls) else null end nls,
                           case when ca.CP_ACCTYPE = 'N' then min(a.nms) else null end nms,
                           sum(a.ostc) s
                      from cp_accounts ca, accounts a
                     where ca.CP_ACCTYPE in ('N', 'R', 'R2', 'R3', 'EXPR')
                       and a.acc = ca.cp_acc
                       and ca.cp_ref = l_cpdeal_row.initial_ref
                     group by ca.CP_ACCTYPE);
      exception when no_data_found
                then
                 begin
                  select a.nls, a.nms, fost(cd.acc, gl.bd) + fost(cd.accR, gl.bd) + fost(cd.accR2, gl.bd) + fost(cd.accR3, gl.bd) + fost(cd.accexpr, gl.bd)
                    into l_nlsN, l_nmsN, l_s
                    from cp_deal cd, accounts a
                   where cd.ref = l_cpdeal_row.initial_ref;
                 end;
      end;
     
      begin
       /* select ref
          into l_cpdeal_row.ref
          from cp_deal
         where id = l_cpdeal_row.id
           and ryn = l_cpdeal_row.ryn
           and initial_ref = l_cpdeal_row.INITIAL_REF
           and acc = l_cpdeal_row.ACC
           and op = l_cpdeal_row.op;
      exception when no_data_found
                then*/
                begin
                 gl.ref(ref_);
                 gl.in_doc3 (  ref_    => ref_,
                               tt_     => l_tt,
                               vob_    => l_vob,
                               nd_     => ref_,
                               pdat_   => gl.bd,
                               vdat_   => gl.bd,
                               dk_     => 1,
                               kv_     => l_accounts_row.kv,
                               s_      => l_s*100, -- �� ������ ����� ������ �� ��� � �������
                               kv2_    => l_accounts_row.kv,
                               s2_     => l_s*100,
                               sk_     => null,
                               data_   => gl.bd,
                               datp_   => gl.bd,
                               nam_a_  => substr(l_nmsN,1,38),
                               nlsa_   => l_nlsN,
                               mfoa_   => gl.amfo,
                               nam_b_  => substr(l_accounts_row.nms,1,38),
                               nlsb_   => l_accounts_row.nls,
                               mfob_   => gl.amfo,
                               nazn_   => l_nazn,
                               d_rec_  => null,
                               id_a_   => l_cust_row.okpo,
                               id_b_   => l_cust_row.okpo,
                               id_o_   => null,
                               sign_   => null,
                               sos_    => 1,
                               prty_   => null,
                               uid_    => NULL);
        
                 for k in ( select acc, cp_acctype, nls, abs(s*100) s from (                           
                                    select a.acc, ca.cp_acctype, a.nls, 
                                           case when ca.cp_acctype = 'N' then p_SN
                                                when ca.cp_acctype = 'R' then p_SR
                                                when ca.cp_acctype = 'R2' then p_SR2
                                                when ca.cp_acctype = 'R3' then p_SR3    
                                                when ca.cp_acctype = 'EXPR' then p_SREXP       
                                           end s
                                      from cp_accounts ca, accounts a
                                     where ca.cp_acctype in ('N', 'R', 'R2', 'R3', 'EXPR', 'S')
                                       and a.acc = ca.cp_acc
                                       and ca.cp_ref = l_cpdeal_row.initial_ref) 
                             /*where nvl(s,0)>0*/)
                 loop 
                  bars_audit.info('p_cp_takeout:C_CURSOR=' || k.s || ', '||k.nls);
                     if (k.s != 0 and k.cp_acctype = 'N')
                     then -- ������� ��������
                       l_sN := k.s;
                       bars_audit.info(title || 'l_accounts_row.nls = ' || l_accounts_row.nls);
                         gl.payv(0, ref_, gl.bdate, l_tt, 1,
                                l_accounts_row.kv,      l_accounts_row.nls,  k.s,
                                l_accounts_row.kv,      k.nls,   k.s);
                     elsif (k.s != 0 and k.cp_acctype in ( 'R', 'R2', 'R3', 'EXPR'))
                     then -- ������� ���� ���������� ������������ ������
                       l_sR := nvl(l_sR,0) + k.s;
                       bars_audit.info(title || 'l_accountsR_row.nls = ' || l_accountsR_row.nls);
                         gl.payv(0, ref_, gl.bdate, l_tt, 1,
                                l_accountsR_row.kv,     l_accountsR_row.nls, k.s,
                                l_accountsR_row.kv,     k.nls,   k.s);
                     elsif (k.s != 0 and k.cp_acctype = 'S' )
                     then -- ������������ ���������� cp_accc.NLS_FXP;\
                      l_sS := k.s;
                         gl.payv(0, ref_, gl.bdate, l_tt, 1,
                                l_accountsR_row.kv,     l_accountNLS_FXP.nls, k.s,
                                l_accountsR_row.kv,     k.nls,   k.s);
                     end if;
                 end loop;
                 bars_audit.info(title||'FD! => ��������');
                 l_cpdeal_row.ref := ref_;
                end;
      end;
  bars_audit.info(title||'FD! => '||to_char(l_cpdeal_row.INITIAL_REF)||'/'||to_char(l_cpdeal_row.ACC)||'/'||to_char(l_cpdeal_row.ref));

  if ref_ is not null
  then
      begin
       insert into cp_deal values l_cpdeal_row;
      exception when dup_val_on_index then null;
      end;

      begin
       insert into cp_arch (REF, REF_MAIN, ID, DAT_UG, ACC, op, N, R)
       values (l_cpdeal_row.ref, l_cpdeal_row.INITIAL_REF, l_cpdeal_row.id, gl.bdate, l_cpdeal_row.acc, l_op_id, -l_sN, -l_sR);
      exception when dup_val_on_index then null;
      end;

      begin
       insert into cp_acctypes(type, name)
       values ('s3541','��');
      exception when dup_val_on_index then null;
      end;

      begin
       insert into cp_accounts (cp_ref, cp_acctype, cp_acc, ostc, ostcr)
       values (ref_, 'N',acc_, -l_sN, 0);
      exception when dup_val_on_index then null;
      end;

      begin
       insert into cp_accounts (cp_ref, cp_acctype, cp_acc, ostc, ostcr)
       values (ref_, 'R',accR_, 0, -l_sR);
      exception when dup_val_on_index then null;
      end;
      begin
       insert into cp_payments (cp_ref, op_ref)
       values (ref_, ref_);
      exception when dup_val_on_index then null;
      end;

      begin
       insert into cp_refw (ref, tag, value)
       select ref_, tag, value
         from cp_refw
        where ref = l_cpdeal_row.INITIAL_REF;
      end;
  end if;
 bars_audit.info(title||' finished for p_ref =>' || p_ref);
end;
/
show err;

PROMPT *** Create  grants  P_CP_TAKEOUT ***
grant EXECUTE                                                                on P_CP_TAKEOUT    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_TAKEOUT.sql =========*** End 
PROMPT ===================================================================================== 
