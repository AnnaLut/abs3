

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RECONSILATION_RUN.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RECONSILATION_RUN ***

  CREATE OR REPLACE PROCEDURE BARS.P_RECONSILATION_RUN (p_stmt_ref    in v_sw950_header.stmt_ref%type,
                                                p_coln        in v_sw950_detail.numrow%type,
                                                p_tt          in tts.tt%type,
                                                p_nlsa        out accounts.nls%type,
                                                p_nlsb        out accounts.nls%type,
                                                p_MsgSender   out sw_journal.sender%type,
                                                p_MsgReceiver out sw_journal.receiver%type,
                                                p_RelMsgRef   out sw_journal.swref%type,
                                                p_RelMsgMt    out sw_journal.mt%type,
                                                p_kv out number,
                                                p_s out number,
                                                p_nazn out oper.nazn%type) is
  l_nlsa           accounts.nls%type;
  l_nlsb           accounts.nls%type;
  l_MsgSender      sw_journal.sender%type;
  l_MsgReceiver    sw_journal.receiver%type;
  l_RelMsgRef      sw_journal.swref%type;
  l_RelMsgMt       sw_journal.mt%type;
  l_v_sw950_detail v_sw950_detail%rowtype;
  l_v_sw950_header v_sw950_header%rowtype;
  l_nazn varchar2(160);
  l_NameBank varchar2(150);
begin
  --Вичитуємо рядок з деталями виписки
  select v.*
    into l_v_sw950_detail
    from v_sw950_detail v
   where v.sw950ref = p_stmt_ref
     and v.numrow = p_coln;
  --Вичитуємо заголовок виписки
  select v.*
    into l_v_sw950_header
    from v_sw950_header v
   where v.stmt_ref = p_stmt_ref;
  --src_ref заповнений  (прикріплене повідомлення)
  if (l_v_sw950_detail.src_swref is not null) then

    if (nvl(l_v_sw950_detail.debit_sum, 0) != 0) then
      l_nlsa := l_v_sw950_header.nostro_accnum;
     begin
      SELECT nls
        INTO l_nlsb
        FROM accounts
       WHERE acc =
             bars_swift.impmsg_message_getaccb(l_v_sw950_detail.src_swref);
      exception when no_data_found then l_nlsb:='';
      end;
    else
      begin
      SELECT nls
        INTO l_nlsa
        FROM accounts
       WHERE acc =
             bars_swift.impmsg_message_getaccb(l_v_sw950_detail.src_swref);
           exception when no_data_found then l_nlsa:='';
      end;
      l_nlsb := l_v_sw950_header.nostro_accnum;
    end if;

    -- Получаем реф. связанного сообщения, т.е. если разбираем 202 и есть сообщение 103
    -- по которому было создано 202, то будем показывать именно 103
    bars_swift.impmsg_message_getrelmsg(l_v_sw950_detail.src_swref,
                                        l_RelMsgRef,
                                        l_RelMsgMt);
    --Получаем отправителя и получателя сообщения
  begin
   SELECT sender, receiver
      INTO l_MsgSender, l_MsgReceiver
      FROM sw_journal
     WHERE swref = l_RelMsgRef;
    exception when no_data_found then
      l_MsgSender:='';
      l_MsgReceiver:='';
   end;

    --src_ref пустий (без прикріпленого повідомлення)
  else
    if (nvl(l_v_sw950_detail.debit_sum, 0) != 0) then
      l_nlsa := l_v_sw950_header.nostro_accnum;
      l_nlsb := '';
    else
      l_nlsa := '';
      l_nlsb := l_v_sw950_header.nostro_accnum;
    end if;
    l_MsgSender   := l_v_sw950_header.sender_bic;
    l_MsgReceiver := '';
  end if;

  if (getglobaloption('SW_D07')='1' and p_tt='D07')
    then
      SELECT substr(bars_swift.get_name_bank(p_stmt_ref),1,150) INTO l_NameBank  FROM dual;
      l_nlsb:='';
      l_MsgReceiver:='';
      l_nazn :=substr('Комісія за п/д на суму '||to_char(case when nvl(l_v_sw950_detail.debit_sum,0)!=0 then l_v_sw950_detail.debit_sum else l_v_sw950_detail.credit_sum end, '999999999.99')||' від '||to_char(l_v_sw950_header.stmt_value_date, 'dd.mm.yyyy')||' - '||l_NameBank,1,160);
      end if;

   if (getglobaloption('SW_D07')='1' and p_tt='830' and l_RelMsgMt in('490','456'))
    then
      l_nlsb:=l_nlsa;
      l_nlsa:='';
      end if;


  p_nazn:=l_nazn;
  p_nlsa        := l_nlsa;
  p_nlsb        := l_nlsb;
  p_MsgSender   := l_MsgSender;
  p_MsgReceiver := l_MsgReceiver;
  p_RelMsgRef   := l_RelMsgRef;
  p_RelMsgMt    := l_RelMsgMt;
  p_kv :=l_v_sw950_header.stmt_currcode;
  p_s:= case when nvl(l_v_sw950_detail.debit_sum,0)!=0 then l_v_sw950_detail.debit_sum else l_v_sw950_detail.credit_sum end*100;

end p_reconsilation_run;
/
show err;

PROMPT *** Create  grants  P_RECONSILATION_RUN ***
grant EXECUTE                                                                on P_RECONSILATION_RUN to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RECONSILATION_RUN.sql =========*
PROMPT ===================================================================================== 
