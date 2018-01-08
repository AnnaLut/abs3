create or replace procedure DPT_COMPROC_END_YEAR
( p_dat IN DATE
) is
  /**
  <b>DPT_COMPROC_END_YEAR</b> - Капіталізація відсотків в кінці року
  %param   p_dat - банківська дата
  
  %version 1.2 (28/12/2017)
  %usage   Капіталізація відсотків по депозитах ФО в кінці року
  */
  l_tt      oper.tt%type;
  l_dk      oper.dk%type;
  l_vob     oper.vob%type;
  l_vdat    oper.vdat%type;
  l_ref     oper.ref%type;
  l_mfo     banks.mfo%type;
  l_bdat    date;
  l_branch  branch.branch%type;
  l_user    staff.id%type;
  
  -- ф-я повертає останній робочий день року вказаного в P_DATE
  function LAST_WORK_DAY( P_DATE DATE )
  return date 
  IS
    l_out date;
    L_DAT date;
  BEGIN
    l_dat := add_months(trunc(p_date,'YYYY'),12); -- 01/01/20NN року
    
    loop
      begin
        
        l_dat := (l_dat - 1);  -- 31/12/20NN року
      
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
    
  end LAST_WORK_DAY;
  ---
BEGIN

  l_branch := sys_context('bars_context','user_branch');

  bars_audit.trace( 'DPT_COMPROC_END_YEAR: start with (bd = %s, user = %s, branch = %s)',
                    to_char(p_dat,'dd/mm/yyyy'), to_char(gl.aUID), l_branch );

  if ( l_branch = '/' )
  then
    for i in ( select KF
                 from MV_KF )
    loop
      BARS_CONTEXT.SUBST_MFO( i.KF );
      DPT_COMPROC_END_YEAR( p_dat );
    end loop;
  else
    l_bdat := nvl( p_dat, GL.GBD() );
    l_mfo  := GL.KF();
    l_dk   := 1;
  end if;
  
  If (l_bdat = LAST_WORK_DAY(l_bdat))
  then -- якщо останній робочий день року -> звичайні проводки
    l_vob  := 6;
    l_vdat := l_bdat;
  ElsIf (l_bdat > trunc(l_bdat,'YYYY') AND l_bdat < (trunc(l_bdat,'YYYY') + 10))
  Then -- якщо перших 10 календ.днів року -> коригуючі проводки
    l_vob  := 96;
    l_vdat := LAST_WORK_DAY(l_bdat - 30);
  Else -- викидаєм помилку
    raise_application_error( -20002, 'ERR: '||to_char(l_bdat,'dd/mm/yyyy')||' НЕ ОСТАННІЙ РОБОЧИЙ ДЕНЬ РОКУ!', true );
  End If;

  for k in ( select d.deposit_id, d.kv, d.branch, c.okpo,
                    ad.nls as nls_d, ad.nms as nms_d,
                    ap.nls as nls_p, ap.nms as nms_p, fost(ap.acc, l_vdat) as suma
               from DPT_DEPOSIT d,
                    ACCOUNTS   ad,
                    INT_ACCN    i,
                    ACCOUNTS   ap,
                    CUSTOMER    c
              where D.VIDD in ( 18, 37, 38, 39, 54, 55, 56, 106, 110, 159, 201, 324, 380, 382, 418, 438, 507, 946 )
                and d.acc  = ad.acc
                and d.acc  =  i.acc and i.id  = 1
                and i.acra = ap.acc 
                and fost(ap.acc, l_vdat) > 0
                and d.rnk = c.rnk )
  loop

    if ( l_branch = k.branch )
    then
      null;
    else
      l_branch := k.branch;
      bars_context.subst_branch(l_branch);
    end if;

    update DPT_DEPOSIT
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
      
      GL.IN_DOC3( ref_    => l_ref,
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
                  nazn_   => SubStr('Капіталізація відсотків згідно договору № '||dpt_web.f_nazn('U', k.deposit_id), 1, 160),
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

    bars_audit.trace('DPT_COMPROC_END_YEAR: створено операцію (референс = %s) капіталізації % по деп.договору (dpt_id = %s)',
                     to_char(l_ref), to_char(k.deposit_id) );
    
  end loop;
    
  -- повернутися в свою область видимості при нормальному завершенні
--bars_context.set_context();
  
EXCEPTION
  when others then
    -- повернутися в свою область видимості при аварійному завершенні
    bars_context.set_context();
    
    bars_audit.trace('DPT_COMPROC_END_YEAR: ERR => '||SQLERRM);
    
    -- исключение бросаем дальше
    raise_application_error( -20000, SQLERRM||chr(10)||dbms_utility.format_error_backtrace(), true );
    
end DPT_COMPROC_END_YEAR;
/

show errors;

grant execute on DPT_COMPROC_END_YEAR to BARS_ACCESS_DEFROLE;
