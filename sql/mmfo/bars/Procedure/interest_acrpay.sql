

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INTEREST_ACRPAY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INTEREST_ACRPAY ***

  CREATE OR REPLACE PROCEDURE BARS.INTEREST_ACRPAY (P_FILTER_STRING varchar2/*, P_MESSAGE out varchar2*/) is
  -- ������ Sel010(hWndMDI,1,1,'','1') tblAcrPay		!! 02 ������� %% (����� ������)
  -- ver 1.0  17.03.2017
  -- author Diver
  l_sql         varchar2(4000) := 'select * from v_pay_interest_depos ';
  l_cur         sys_refcursor;
  l_vpid        v_pay_interest_depos%rowtype;
  l_seq         number;
  l_user_login  staff$base.logname%type;
  l_bad         pls_integer := 0;
  l_ok          pls_integer := 0;
  l_info        pay_int_acrpay_batch.info%type;
  l_err         varchar2(4000);
  l_err_summary varchar2(32000);

  ref_          oper.ref%type    ;
  l_purpose     varchar2(32767 byte);
  l_mfo_b       varchar2(32767 byte);
  l_receiver_account_row accounts%rowtype;
begin
--  raise_application_error(-20001,'P_FILTER_STRING='||P_FILTER_STRING );
  --P_MESSAGE := '��������� ������: '/*||P_FILTER_STRING*/;
  bars_audit.info('START Interest_AcrPay with filter: '||P_FILTER_STRING);
  l_sql := l_sql || case when P_FILTER_STRING is null then '' else ' where '||P_FILTER_STRING end;
--  raise_application_error(-20001,'l_sql='||l_sql );

  select s.logname into l_user_login from staff$base s where s.id = user_id();
  l_seq := s_pay_int_acrpay_batch.nextval;
  insert into pay_int_acrpay_batch(batch_id, user_login, filter) values(l_seq, l_user_login, P_FILTER_STRING);
  open l_cur for l_sql;
  loop
   fetch l_cur into l_vpid;
   exit when l_cur%notfound;

   gl.ref (ref_);
   -----------------
   SAVEPOINT DO_OPL;  -- ����� ������-1. ������ �� �����
   -----------------
   l_mfo_b := l_vpid.mfob;
   if (l_mfo_b is null) then
       if (l_vpid.ttb = 'PS1') then
           l_receiver_account_row := account_utl.read_account(l_vpid.nlsb, l_vpid.kvb, p_raise_ndf => false);
           if (l_receiver_account_row.acc is not null) then
               l_mfo_b := l_receiver_account_row.kf;
           end if;
       end if;
   end if;

   if (l_mfo_b is null) then
       raise_application_error(-20000, '�� ������� ��������� ���������� �������');
   end if;

   l_purpose := case when l_vpid.nazn is null and l_vpid.ttb = 'PS1' then
                          '������� ������� �� ������� ' || account_utl.get_account_number(l_vpid.acc)
                     else l_vpid.nazn
                end;

   if (l_purpose is null) then
       raise_application_error(-20000, '�� ������� ����������� ������� ��� ������� �������');
   end if;

   update int_accN set apl_dat = gl.bdate where acc=l_vpid.acc and id=1;
   begin
      gl.in_doc3(ref_   => REF_,
                 tt_    => l_vpid.ttb ,
                 vob_   => l_vpid.vob ,
                 nd_    => substr(to_char(REF_),1,10),
                 pdat_  => SYSDATE ,
                 vdat_  => gl.bdate,
                 dk_    => l_vpid.dk,
                 kv_    => l_vpid.kv,
                 s_     => l_vpid.original_amount,
                 kv2_   => l_vpid.kvb,
                 s2_    => null,--l_vpid.original_amount,
                 sk_    => null,
                 data_  => gl.bdate,
                 datp_  => gl.bdate,
                 nam_a_ => substr(trim(l_vpid.nms), 1, 38),
                 nlsa_  => l_vpid.nls,
                 mfoa_  => gl.aMfo,
                 nam_b_ => substr(trim(l_vpid.namb), 1, 38),
                 nlsb_  => l_vpid.nlsb,
                 mfob_  => l_mfo_b,
                 nazn_  => l_purpose,
                 d_rec_ => null,
                 id_a_  => f_ourokpo(),
                 id_b_  => l_vpid.okpo,
                 id_o_  => null, --Trace from Centura insert: CQKOBC
                 sign_  => null,
                 sos_   => 1,    --Trace from Centura insert: 0
                 prty_  => null,
                 uid_   => null);

      --CENTURA TRACE: BEGIN chk.make_int_docbuf(:a0,:a1); END;
      --CENTURA TRACE: BEGIN chk.put_visa(:a0,:a1,:a2,:a3,:a4,:a5,:a6); END;
      --CENTURA TRACE: BEGIN chk.PUT_BIG(:a0,:a1,:a2,:a3,:a4,:a5,:a6); END;

      paytt(flg_  => 0,
            ref_  => REF_ ,
            datv_ => gl.bDATE ,
            tt_   => l_vpid.ttb   ,
            dk0_  => l_vpid.dk     ,
            kva_  => l_vpid.kv  ,
            nls1_ => l_vpid.nls,
            sa_   => l_vpid.original_amount   ,
            kvb_  => l_vpid.kvb ,
            nls2_ => l_vpid.nlsb,
            sb_   => null  );


      l_ok :=  l_ok + 1;
   exception
     when others then
       ROLLBACK TO DO_OPL;
       l_err := sqlerrm;
       insert into pay_int_acrpay_log(batch_id,
                                      acc,
                                      id,
                                      nls,
                                      sumr,
                                      tts,
                                      info)
              values(l_seq,
                     l_vpid.acc,
                     1,
                     l_vpid.nls,
                     l_vpid.original_amount,
                     l_vpid.ttb,
                     l_err);
      l_bad := l_bad + 1;
      if l_err_summary is null or length(l_err_summary) < 4000 then
        l_err_summary := l_err_summary ||chr(10)||'ERR'||l_bad||' '||l_err;
      end if;
    end;
  end loop;
  close l_cur;
  l_info := substr('�������� ������: '||l_ok||' �������: '||l_bad||' ... '||l_err_summary, 1, 4000);
  update pay_int_acrpay_batch set info =  l_info where batch_id = l_seq;
  if l_bad > 0 then
    bars_audit.error('END Interest_AcrPay with filter: '||P_FILTER_STRING||' ������ �������, ��������� � �������� pay_int_acrpay_batch, pay_int_acrpay_log');
  end if;

end;
/
show err;

PROMPT *** Create  grants  INTEREST_ACRPAY ***
grant EXECUTE                                                                on INTEREST_ACRPAY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INTEREST_ACRPAY.sql =========*** E
PROMPT ===================================================================================== 
