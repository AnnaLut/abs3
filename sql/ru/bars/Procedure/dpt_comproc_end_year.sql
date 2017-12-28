CREATE OR REPLACE PROCEDURE BARS.dpt_comproc_end_year (p_dat IN DATE)
is
  l_tt      oper.tt%type;
  l_dk      oper.dk%type;
  l_vob     oper.vob%type;
  l_vdat    oper.vdat%type;
  l_ref     oper.ref%type;
  l_mfo     banks.mfo%type;
  l_bdat    date;
  l_branch  branch.branch%type;
  l_user    staff.id%type;
  
-- �-� ������� ������� ������� ���� ���� ��������� � P_DATE
  FUNCTION last_work_day( P_DATE DATE )
  RETURN date 
  IS
    l_out date;
    L_DAT date;
  BEGIN
    l_dat := add_months(trunc(p_date,'YYYY'),12); -- 01/01/20NN ����
    
    loop
      begin
        l_dat := (l_dat - 1);  --31/12/20NN ����
      
        select HOLIDAY
          into l_out
          from HOLIDAY
         where HOLIDAY = l_dat
           and KV = 980;
      
      exception
        when NO_DATA_FOUND THEN 
          l_out := null;
      end;
    EXIT
      when l_out is null;
    end loop;

  RETURN l_dat;
    
  END;
--------------------------------------------------------------------------------
BEGIN
  tuda;

  l_bdat   := nvl(p_dat, gl.bd);
  l_mfo    := gl.amfo;
  l_dk     := 1;
  l_branch := sys_context('bars_context', 'user_branch');
  
  bars_audit.trace( 'DPT_COMPROC_END_YEAR: start with (bd = %s, user = %s, branch = %s)',
                    to_char(l_bdat,'dd/mm/yyyy'), to_char(gl.aUID), l_branch );
  
  if l_branch = '/' then
    raise_application_error(-20001, 'ERR: ���������� ��������� ��������� ������ ��������� �� ���� �������� '||l_branch, true);
  end if;
  
  If (l_bdat = Last_work_day(l_bdat)) then
    -- ���� ������� ������� ���� ���� -> ������� ��������
    l_vob  := 6;
    l_vdat := l_bdat;
  ElsIf (l_bdat > trunc(l_bdat,'YYYY') AND l_bdat < (trunc(l_bdat,'YYYY') + 10)) Then
    -- ���� ������ 10 ������.��� ���� -> ��������� ��������
    l_vob  := 96;
    l_vdat := Last_work_day(l_bdat - 30);
  Else
    -- ������� �������
    raise_application_error(-20002, 'ERR: '||to_char(l_bdat,'dd/mm/yyyy')||' �� �����Ͳ� ������� ���� ����!', true);
  End If;
    
  for k in ( select d.deposit_id, d.kv, d.branch, c.okpo,
                    ad.nls as nls_d, ad.nms as nms_d,
                    ap.nls as nls_p, ap.nms as nms_p, fost(ap.acc, l_vdat) as suma
               from dpt_deposit d,
                    accounts   ad,
                    int_accn    i,
                    accounts   ap,
                    customer     c
              where D.VIDD in ( 18, 37, 38, 39, 54, 55, 56, 106, 110, 159, 201, 324, 380, 382, 418, 438, 507, 946 )
                and d.acc  = ad.acc
                and d.acc  =  i.acc and i.id  = 1
                and i.acra = ap.acc 
                and fost(ap.acc, l_vdat) > 0 
                and d.rnk = c.rnk )
  loop

    if l_branch != k.branch then
       l_branch := k.branch;
       bars_context.subst_branch(l_branch);
    else
      null;
    end if;

    update dpt_deposit
       set mfo_p  = l_mfo,
           nls_p  = k.nls_d,
           name_p = k.nms_d,
           okpo_p = k.okpo
     where deposit_id = k.deposit_id;
  
    begin
      gl.ref (l_ref);
    
      if k.kv = gl.baseval then
        l_tt := 'DP5';
      else
        l_tt := 'DPL';
      end if;
      
      gl.in_doc3 (ref_    => l_ref,
                  tt_     => l_tt,
                  vob_    => l_vob,
                  nd_     => SubStr(to_char(l_ref),1,10),
                  pdat_   => sysdate,
                  vdat_   => l_vdat,
                  dk_     => l_dk,
                  kv_     => k.kv,
                  s_      => k.suma,
                  kv2_    => k.kv,
                  s2_     => k.suma,
                  sk_     => null,
                  data_   => l_bdat,
                  datp_   => l_bdat,
                  nam_a_  => SubStr(k.nms_p, 1, 38),
                  nlsa_   => k.nls_p,
                  mfoa_   => l_mfo,
                  nam_b_  => SubStr(k.nms_d, 1, 38),
                  nlsb_   => k.nls_d,
                  mfob_   => l_mfo,
                  nazn_   => SubStr('����������� ������� ����� �������� � '||dpt_web.f_nazn('U', k.deposit_id), 1, 160),
                  d_rec_  => null,
                  id_a_   => k.okpo,
                  id_b_   => k.okpo,
                  id_o_   => null,
                  sign_   => null,
                  sos_    => null,
                  prty_   => 0,
                  uid_    => null );
    end;              
                 
    gl.payv(0, l_ref, l_bdat, l_tt, l_dk, 
               k.kv, k.nls_p, k.suma,
               k.kv, k.nls_d, k.suma );

    bars_audit.trace('DPT_COMPROC_END_YEAR: �������� �������� (�������� = %s) ����������� % �� ���.�������� (dpt_id = %s)',
                     to_char(l_ref), to_char(k.deposit_id) );
    
  end loop;
    
  -- ����������� � ���� ������� �������� ��� ����������� ���������
  --bc.set_context();
  
EXCEPTION
  when others then
    -- ����������� � ���� ������� �������� ��� ��������� ���������
    bc.set_context();
    
    bars_audit.trace('DPT_COMPROC_END_YEAR: ERR => '||SQLERRM);
    
    -- ���������� ������� ������
    raise_application_error( -20000, SQLERRM||chr(10)||dbms_utility.format_error_backtrace(), true );
    
end DPT_COMPROC_END_YEAR;
/
grant execute on DPT_COMPROC_END_YEAR to bars_access_defrole;
/
show errors;
/
