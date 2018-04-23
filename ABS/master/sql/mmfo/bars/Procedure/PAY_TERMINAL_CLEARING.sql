PROMPT *** Create  procedure PAY_TERMINAL_CLEARING ***

CREATE OR REPLACE PROCEDURE BARS.PAY_TERMINAL_CLEARING
( p_sum              in     number
, p_kv               in     number
, p_operation_type   in     varchar2 -- 
, p_terminal_code    in     varchar2 -- код терміналу
, p_ref                 out oper.ref%type
) 
----------------------------------------
-- выполнение проводок по отработке POS терминалов
--
-- Департамент бек-офісу
-- Забезпечення за операціями, проведеними в установах Банку по карткових рахунках через POS-термінали інтеграцію даних до АБС, 
-- використовуючи інтеграцію РОС- терміналів, що була створена для ідентифікації клієнтів . 
-- По факту здійсненої через РОS- термінал операції поповнення або операції видачі коштів з рахунків 
-- по завершенню операційного дня імпортувати дані в АБС і формувати в АБС проведення в залежності від операції (
-- поповнення/зняття) для автоматичного здійснення відповідних бухгалтерських проведень в АБС.
----------------------------------------

is
  title        constant     varchar2(32)   := 'pay_terminal_clearing:';
  c_tag        constant     operw.tag%type := 'TRMNL';
  l_bnk_dt                  fdat.fdat%type;
  l_nd                      oper.nd%type;
  l_dk                      oper.dk%type;
  l_ref                     oper.ref%type;
  l_tt                      oper.tt%type;
  l_vob                     oper.vob%type;
  l_sk                      oper.sk%type;
  l_nlsa                    oper.nlsa%type;
  l_nam_a                   oper.nam_a%type;
  l_nlsb                    oper.nlsb%type;
  l_nam_b                   oper.nam_b%type;
  l_sum                     oper.s%type;
  l_nazn                    oper.nazn%type;
  
begin

 l_sum   := p_sum;

  
  bars_audit.trace( '%s: Entry with ( p_sum=%s, p_kv=%s, p_operation_type=%s, p_terminal_code=%s ).'
                    , title, to_char(l_sum ), to_char(p_kv), p_operation_type, p_terminal_code );
  
  case
    when ( l_sum  Is Null )
    then raise_application_error( -20666, 'Не вкзано суму операції', TRUE );
    when ( l_sum  <> trunc(l_sum ) )
    then raise_application_error( -20666, 'Сума операції повинна бути в копійках', TRUE );
    when ( p_kv Is Null )
    then raise_application_error( -20666, 'Не вкзано код валюти операції', TRUE );
    when ( p_operation_type Is Null )
    then raise_application_error( -20666, 'Не вкзано тип операції', TRUE );
    when ( p_terminal_code Is Null )
    then raise_application_error( -20666, 'Не вкзано код терміналу', TRUE );
    else null;
  end case;
  
  l_bnk_dt := gl.BDATE;
  
  case
   when ( p_operation_type = 'INCOME' )
   then 
     l_tt  := 'IP2';
     l_dk  := 0;
     l_vob := 56;
     l_sk  := 29;
     l_nazn :='Поповнення готівки по терміналу ';
   when ( p_operation_type = 'OUTCOME' )
   then
     l_tt  :='IP1';
     l_dk  := 1;
     l_vob := 222;
     l_sk  := 58;
     l_nazn :='Видача готівки по терміналу ';
  end case;
  
  bars_audit.trace( '%s: continue with ( l_tt=%s, l_dk=%s, l_vob=%s, l_sk=%s ).'
                    , title, l_tt, to_char(l_dk), to_char(l_vob), to_char(l_sk) );
 /*  решили выгружать когда хотят
  begin
    select w.REF
      into l_ref
      from BARS.OPER d
      join BARS.OPERW w
        on ( w.REF = d.REF ) 
     where d.VDAT  = l_bnk_dt  
       and d.TT    = l_tt
       and d.KV    = p_kv
       and w.TAG   = c_tag
       and w.VALUE = p_terminal_code;
    raise_application_error( -20666, 'Опреацію '||l_tt||' по коду терміналу '||p_terminal_code||
                                     ' вже було проведено в #'||to_char(l_ref), TRUE );
  exception
    when NO_DATA_FOUND then
      null;
  end;
  */
  if     p_terminal_code != '-1' then  
   begin
     select a.NLS, substr(a.NMS,1,37)
      into l_nlsa, l_nam_a
      from BARS.ACCOUNTS a
     where a.NLS like '2924_'||substr(p_terminal_code, -6)||'015'  --2924 К  FFF FFF ННН COBUMMFO-7560
       and a.KV  = p_kv
       and a.DAZS is Null;
       
   exception
    when NO_DATA_FOUND then
      raise_application_error( -20666, 'Не знайдено дійчий рахунок 2924/15('||to_char(p_kv)||
                                       ') для відділення '||sys_context('bars_context','user_branch'), TRUE );
    end;
  else 
   begin
     select a.NLS, substr(a.NMS,1,37)
      into l_nlsa, l_nam_a
      from BARS.ACCOUNTS a
     where a.NLS = BARS.NBS_OB22('2924','15')
       and a.KV  = p_kv
       and a.DAZS is Null;
       
   exception
    when NO_DATA_FOUND then
      raise_application_error( -20666, 'Не знайдено дійчий рахунок 2924/15('||to_char(p_kv)||
                                       ') для відділення '||sys_context('bars_context','user_branch'), TRUE );
   end;
  end if;
  
  begin
    select a.NLS, substr(a.NMS,1,37)
      into l_nlsb, l_nam_b
      from BARS.ACCOUNTS a
     where a.NLS = BRANCH_USR.GET_BRANCH_PARAM2('CASH',0)
       and a.KV  = p_kv
       and a.DAZS is Null;
  exception
    when NO_DATA_FOUND then
      raise_application_error( -20666, 'Не знайдено дійчий рахунок каси ('||to_char(p_kv)||
                                       ') для відділення '||sys_context('bars_context','user_branch'), TRUE );
  end;
  
  gl.ref(l_ref);
  
  l_nd := substr( to_char(l_ref), -10 );
  
  gl.in_doc3( ref_   => l_ref,
              tt_    => l_tt,
              vob_   => l_vob,
              nd_    => l_nd,
              pdat_  => sysdate,
              vdat_  => l_bnk_dt,
              dk_    => l_dk,
              kv_    => p_kv,
              s_     => l_sum ,
              kv2_   => p_kv,
              s2_    => l_sum ,
              sk_    => l_sk,
              data_  => l_bnk_dt, -- datd
              datp_  => l_bnk_dt,
              nam_a_ => l_nam_a,
              nlsa_  => l_nlsa,
              mfoa_  => gl.aMfo,
              nam_b_ => l_nam_b,
              nlsb_  => l_nlsb,
              mfob_  => gl.aMfo,
              nazn_  => l_nazn||p_terminal_code,
              id_a_  => gl.aOkpo,
              id_b_  => gl.aOkpo,
              sos_   => 1,
              uid_   => gl.aUID,
              id_o_  => null,
              d_rec_ => null,
              sign_  => null,
              prty_  => null
            );
 
  paytt( flg_  => 0
       , ref_  => l_ref
       , datv_ => l_bnk_dt
       , tt_   => l_tt
       , dk0_  => l_dk
       , kva_  => p_kv
       , nls1_ => l_nlsa
       , sa_   => l_sum 
       , kvb_  => p_kv
       , nls2_ => l_nlsb
       , sb_   => l_sum 
       );
  
  insert
    into BARS.OPERW
      ( REF, TAG, VALUE )
  values
      ( l_ref, c_tag, p_terminal_code );
  
  p_ref := l_ref;
  
  bars_audit.trace( '%s: Exit with ( p_ref=%s ).', title, to_char(p_ref) );
  
end PAY_TERMINAL_CLEARING;
/
show err;

grant EXECUTE on PAY_TERMINAL_CLEARING to BARS_ACCESS_DEFROLE;
