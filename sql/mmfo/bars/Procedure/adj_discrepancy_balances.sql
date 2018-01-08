create or replace procedure BARS.ADJ_DISCREPANCY_BALANCES
( p_dpu_id         in     dpu_deal.dpu_id%type -- ідентифікатор депозитного траншу
, p_ref            in     oper.ref%type
)
is
  /**
  <b>ADJ_DISCREPANCY_BALANCES</b> - Врегулювання невідповідностей
  %param p_dpu_id   - ідентифікатор депозитного траншу (дод.дог.)
  %param p_ref      - ідентифікатор документу
  
  %version 1.4
  %usage   вставка проводки в дебетову операцію по рахунку ген. дог.
  */
  title    constant  varchar2(60) := 'dpu.adj_discrepancy_balances';
  
  type t_doc_rec is record ( ref   oper.ref%type,
                             sos   oper.sos%type,
                             scht  oper.sos_change_time%type,
                             odat  oper.odat%type,
                             tt    opldok.tt%type,
                             kv    accounts.kv%type,
                             nlsd  accounts.nls%type,
                             nlsk  accounts.nls%type,
                             s     opldok.s%type,
                             fdat  opldok.fdat%type );
  
  l_doc_list  t_doc_rec;
  l_txn_qt    pls_integer;
  l_du8_qt    pls_integer;
  
begin
  
  bars_audit.info( title||': Entry with ( dpu_id='||to_char(p_dpu_id)||', ref='|| to_char(p_ref)||' ).' );
  
  --
  -- перевірки
  --
  
  if ( sys_context('bars_context','user_branch') = '/' )
  then
    bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Заборонено виконання даної операції (недопустимий рівень користувача)!' );
  end if;
  
  select count(unique TT), sum(decode(TT,'DU8',1,0))
    into l_txn_qt, l_du8_qt
    from OPLDOK
   where REF = p_ref
     and TT not like 'PO%'; -- без опер. податкового обліку
  
  case
    when l_du8_qt > 0
    then bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Документ уже містить транзакцію DU8!' );
    when l_txn_qt > 1
    then bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE',  'Документ містить більше однієї транзакції!' );
    else null;
  end case;
  
  begin
    select 1
      into l_txn_qt
      from V_DPU_RELATION_ACC r
     where GEN_ACC in ( select a.ACC 
                          from OPLDOK   t
                          join ACCOUNTS a
                            on ( a.ACC = t.ACC )
                         where t.REF = p_ref
                           and a.NBS in ( select NBS_DEP
                                            from DPU_NBS4CUST
                                           union all
                                          select NBS_INT
                                            from DPU_NBS4CUST
                                        )
                      )
       and DEP_ID = p_dpu_id;
  exception
    when NO_DATA_FOUND then
      bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Документ #' || to_char(p_ref) || ' не містить рахунка ген.дог. для вказаного траншу деп.лінії!' );
  end;
  
  select o.ref, o.sos, o.sos_change_time, o.odat,
         od.tt, ad.kv, ad.nls nlsd, ak.nls nlsk, od.s, od.fdat
    into l_doc_list
    from bars.oper o
    join bars.opldok od
      on ( od.REF = o.REF and od.DK  = 0 )
    join bars.opldok ok
      on ( ok.REF = o.REF and ok.DK  = 1 )
    join bars.accounts ad
      on ( ad.acc = od.acc )
    join bars.accounts ak
      on ( ak.acc = ok.acc ) 
   where o.REF = p_ref
     and od.TT not like 'PO%' -- без опер. податкового обліку
     and od.STMT = ok.STMT;
  
  l_doc_list.tt   := 'DU8';
  
  -- Запис номера деп. договору в додаткові реквізити операції
  insert into OPERW ( REF, TAG, VALUE ) values ( p_ref, 'ND', to_char(p_dpu_id) );
  
  l_doc_list.nlsd := DPU.get_nls4pay( l_doc_list.ref, l_doc_list.nlsd, l_doc_list.kv );
  l_doc_list.nlsk := DPU.get_nls4pay( l_doc_list.ref, l_doc_list.nlsk, l_doc_list.kv ); 
  
  if ( l_doc_list.nlsd = l_doc_list.nlsk )
  then
    bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Error: nlsd = nlsk' );
  end if;
  
  GL.PL_DAT( l_doc_list.fdat );
  
  GL.PAYV( 0, l_doc_list.ref, l_doc_list.fdat, l_doc_list.tt, 1,
              l_doc_list.kv,  l_doc_list.nlsd, l_doc_list.s,
              l_doc_list.kv,  l_doc_list.nlsk, l_doc_list.s );
  
  if ( l_doc_list.sos = 5 )
  then -- якщо документ вже оплачений то платим проводку по 8-му класу
       -- та вертаємо оригінальні занчення полів SOS_CHANGE_TIME та ODAT
    
    GL.PAY( 2, l_doc_list.ref, l_doc_list.fdat);
    
    bars_audit.info( title||': paid transaction DU8 ( nlsd = '||l_doc_list.nlsd
                          ||', nlsk = '||l_doc_list.nlsk  ||', s = '||to_char(l_doc_list.s)||' ).' );
    
    update OPER
       set SOS_CHANGE_TIME = l_doc_list.scht,
           ODAT            = l_doc_list.odat
     where REF             = l_doc_list.ref;
    
  end if;
  
  GL.PL_DAT( GL.GBD() );
  
  bars_audit.trace( '%s: Exit.', title );
  
end ADJ_DISCREPANCY_BALANCES;
/

show errors;
