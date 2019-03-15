
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/sbon_autopay.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.sbon_autopay is

  
  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.00 11/09/2018';
  G_ERRMOD         constant varchar2(50)  := 'DOC';
  G_TRACE          constant varchar2(50)  := 'sbon_autopay.';
  
  -----------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  -----------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;
  
  
  -----------------------------------
  -- GET_DOC_BUFFER
  --
  -- Получить буффера для подписи
  --
   
   procedure get_doc_buffer ( p_ref     in integer,
                              p_key     in varchar2,
                              p_int_buf out varchar2,
                              p_sep_buf out varchar2);
  
  

  ------------------------------------
  -- ASYNC_AUTO_VISA 
  -- 
  -- Процедура для автообработки докумнетов корп2 вертушкой
  -- Установка виз с подписями, оплата по-факту
  --
  procedure async_auto_visa (p_ref      in number,
                             p_key      in varchar2,
                             p_int_sign in varchar2,
                             p_sep_sign in varchar2);
    
  ------------------------------------
  --  POST_ERROR_PROC 
  --
  --  Набор операций для выполнения после неуспешной обработки докумнета 
  --
  procedure post_error_proc(p_ref number, p_sqlerr_code number, p_sqlerr_stack varchar2);

  ------------------------------------
  -- GET_BIS_COUNT 
  -- 
  -- Проверить наличие бис строк
  --
  function get_bis_count(p_ref      in number) return number;
  

end sbon_autopay;
/
show err


CREATE OR REPLACE PACKAGE BODY BARS.sbon_autopay is

  
  G_BODY_VERSION constant varchar2(64)  := 'version 1.00 11/09/2018';

  

  ------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header '||G_HEADER_VERSION;
  end header_version;

  ------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body '||G_BODY_VERSION;
  end body_version;

  
  
  ------------------------------------
  --  READ_BARS_DOC
  --
  --  Получить строку документа из oper
  --
  function read_bars_doc(p_ref number, p_silent number default 1) return bars.oper%rowtype
  is
     l_doc bars.oper%rowtype;
  begin
     select * into l_doc from bars.oper where ref = p_ref;
     return l_doc;
  exception when no_data_found then
     if p_silent = 1 then 
        return null;  
     else 
       raise_application_error(-20000, 'Документ не найден REF='||p_ref, TRUE);
     end if;
  end;


  -----------------------------------
  -- extract_app_error  
  --
  -- возвращает код прикладной ошибки
  --
  function extract_app_error(p_err_msg in varchar2) return integer is
    l_str   varchar2(40) := '';
    i       integer;
  begin
    if substr(p_err_msg, 12, 1)='\' then
        l_str := ''; 
        i := 1;
        while substr(p_err_msg, 12+i, 1) in ('0','1','2','3','4','5','6','7','8','9') loop
            l_str := l_str || substr(p_err_msg, 12+i, 1);
            i := i + 1;
        end loop;
        return to_number(l_str);
    else
        return null;
    end if;
  end extract_app_error;


  -----------------------------------
  -- GET_DOC_BUFFER
  --
  -- Получить буффера для подписи
  --

   procedure get_doc_buffer ( p_ref     in integer,
                              p_key     in varchar2,
                              p_int_buf out varchar2,
                              p_sep_buf out varchar2) is
    l_buffer varchar2(4000);
  begin
    -- отримання СЕП буферу
    bars.docsign.retrievesepbuffer(p_ref, p_key, l_buffer);
    p_sep_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
    bars.chk.make_int_docbuf(p_ref, l_buffer);
    p_int_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
  end;


  
  
  ------------------------------------
  --  POST_ERROR_PROC
  --
  --  Набор операций для выполнения после неуспешной обработки докумнета
  --
  procedure post_error_proc( p_ref number, p_sqlerr_code number, p_sqlerr_stack varchar2) is     
     l_app_err       varchar2(4000);
     l_err_code      number;
     l_err_msg       varchar2(4000);
     l_doc           bars.oper%rowtype;
     l_doc_vdat      date;
     l_trace         varchar2(1000) := g_trace||'post_error_proc: ';
  begin

     bars.bars_audit.error(l_trace||'обработка ошибки оплаты: errcode='||p_sqlerr_code||', errmsg='||substr(p_sqlerr_stack, 1, 3900));
	 l_doc := read_bars_doc(p_ref);
     -- сохраняем информацию об ошибке
     l_err_code := p_sqlerr_code;
     l_err_msg  := substr(p_sqlerr_stack, 1, 3900);

     -- прикладные ошибки трактуются как неустраняемые для данного док-та и передаются породившей док-т стороне
     -- По заказу от банка:    
     -- Если платеж при автооплате вылетает с ошибкой нелдостачи денег  ORA-20203: \9301 broken limit on accounts
     -- Тогда его не сторнировать (т.е. не устанавливать booking_flag = N), а оставлять на повторную оплату в этот день, 
     -- и только в следующий банковский день - браковать его (т.е. не устанавливать booking_flag = N) 
     
     if   l_err_code > -21000 and l_err_code <= -20000 then
         -- нет средств на счете и банк дата = валютировнаию  - документ отправить на повторную оплату
         l_doc_vdat := nvl(l_doc.vdat, bars.gl.bdate);
        
         bars.bars_audit.info(l_trace||'vdat='|| to_date(l_doc_vdat,'dd/mm/yyyy') ||' bars.gl.bdate='||to_date(bars.gl.bdate,'dd/mm/yyyy')||', instr ='||instr(l_err_msg, '\9301') );

        -- Обработка прикладных ошибок, которые должны дать повторную оплату 
        
        -- Если платеж при автооплате вылетает с ошибкой нелдостачи денег  ORA-20203: \9301 broken limit on accounts
        -- Тогда его не сторнировать , а оставлять на повторную оплату в этот день
        if ( (l_err_code = -20203 and instr(l_err_msg, '\9301') > 0 and  l_doc_vdat = bars.gl.bdate) 
             or
            (l_err_code = -20060)   -- Будущая дата валютирования (описана в ошибках модуля DOC)
           )   
        then 
           bars.bars_audit.info(l_trace||'нехватка денег на счете - документ ожидает оплаты в следующем цикле обработки' );     
        else 
            -- обработка специальных случаев, типа "счет залочен" и пр.
            l_app_err  := extract_app_error(l_err_msg);
            bars.bars_audit.info(l_trace||'ошибка прикладная - документ остановлен для дальнейшей оплаты' );
        end if;
     else
          bars.bars_audit.info(l_trace||'ошибка системная - документ ожидает оплаты в следующем цикле обработки' );
     end if;
  end;



  ------------------------------------
  --  SUBST_NEDDED_BRANCH
  --
  --  Установить нужный бранч для создания документа в нем
  --
  procedure subst_nedded_branch(p_ref number) is
     l_branch_isp    varchar2(30);
     l_branch        varchar2(30);
     l_doc           oper%rowtype;
	 l_trace         varchar2(4000) := g_trace ||'subst_nedded_branch:';
  begin
     l_doc := read_bars_doc(p_ref);
     bars.bars_context.subst_mfo(l_doc.branch);
     bars.bars_audit.trace(l_trace ||'представление бранчем - '|| sys_context('bars_context','user_branch'));
  end;



  ------------------------------------
  -- GET_BIS_COUNT
  --
  -- Проверить наличие бис строк
  --
  function get_bis_count(p_ref      in number) return number
  is
     l_cnt number;
  begin
     select count(*) into l_cnt
                 from bars.operw w, bars.op_field v
                where w.ref = p_ref
                  and w.tag = v.tag
                  and v.vspo_char in ('F','П','C')
                order by v.vspo_char,w.tag; 
     return l_cnt;
  end;



  ------------------------------------
  -- POST_SEP_ROWS
  --
  -- Вставить строки в arc_rrp
  --
  --
  procedure post_sep_rows (p_doc bars.oper%rowtype)
  is
     l_arc        bars.arc_rrp%rowtype;    
     l_doc        bars.oper%rowtype;
     l_err        number;
     l_bis_count  number;
     l_bis_curr   number;
     l_sep_err    number;
     l_seperr_text varchar2(1024);
     l_sep_rec    number;
     l_arc_count  number;
     l_arc_curr   number;
     l_nazn_list  bars.tt_str_array;
     l_req_value  varchar2(1024);
     l_trace      varchar2(2000) := G_TRACE||'post_sep_rows: ';
  begin
     l_nazn_list :=  bars.tt_str_array(null);
     l_doc := p_doc;
     l_bis_curr  := 0;
     
     bars.bars_audit.info(l_trace||'старт вставки строк в arc_rrp REF='||p_doc.ref);
     -- если ест ьбис строки - сформируем массив назанчений платежа
     for c in (select w.tag, w.value, v.vspo_char
                 from bars.operw w, bars.op_field v
                where w.ref = l_doc.ref
                  and w.tag = v.tag
                  and v.vspo_char in ('F','П','C')
                order by v.vspo_char,w.tag
               ) loop

          -- в некоторых случаях бис строки могут быть в однос строке через перевод каретки (из пакета CHK)
          for v in (select regexp_substr(c.value ,'[^'|| chr(13)||chr(10) ||']+', 1, level) value
                      from dual
                   connect by regexp_substr(c.value , '[^'|| chr(13)||chr(10) ||']+', 1, level) is not null)
                  loop
                    l_bis_curr := l_bis_curr + 1;
                    if c.vspo_char = 'F' then
                       l_req_value := '#F' || trim(c.tag) || ':' || rpad(trim(v.value) || '#', 158);
                    else
                       l_req_value := '#' || c.vspo_char || rpad(trim(v.value) || '#', 218);
                    end if;
                    l_nazn_list(l_nazn_list.last) := l_req_value;
                  end loop;
     end loop;
     l_bis_count := l_bis_curr;    
     bars.bars_audit.info(l_trace||'кол-во бис строк: '||l_bis_count);

     l_bis_curr := 0;  -- номер текущей строки в arc_rrp, начинаем с 0
     l_arc.rec  := 0;
     -- начинаем формировать строки для arc_rrp
     -- пройтись по всем нужным строкам в arc_rrp
     while l_bis_curr <= l_bis_count loop
           if l_bis_curr = 0 then -- первая строка в arc_rr
              l_arc.d_rec := case when l_bis_count > 0 then '#B' || lpad(l_bis_count + 1, 2, '0') || nvl(l_doc.d_rec, '#') else l_doc.d_rec end; 
              l_arc.nazns := case when l_bis_count > 0 then '11' else  '10' end;
              l_arc.bis   := case when l_bis_count = 0 then 0 else 1 end;
              l_arc.sign  := l_doc.sign;
           else              -- остальные строки
              l_arc.nazns := '33';
              l_doc.s     := 0;
              l_arc.bis   := l_bis_curr + 1; 
              l_doc.dk := case l_doc.dk when 0 then 2 when 1 then 3 else l_doc.dk end;
              l_arc.sign  := null;
              l_req_value := l_nazn_list(l_bis_curr);

              if length(l_req_value) > 160 then
                 l_arc.d_rec := substr(l_req_value, 161, 60);
                 l_doc.nazn := substr(l_req_value, 1, 160);
              else
                 l_arc.d_rec := '';
                 l_doc.nazn := substr(l_req_value, 1, 160);
              end if;
           end if;

            bars.sep.in_sep(
                  err_   => l_sep_err,
                  rec_   => l_sep_rec,
                  mfoa_  => l_doc.mfoa,
                  nlsa_  => l_doc.nlsa,
                  mfob_  => l_doc.mfob,
                  nlsb_  => l_doc.nlsb,
                  dk_    => l_doc.dk,
                  s_     => l_doc.s,
                  vob_   => l_doc.vob,
                  nd_    => l_doc.nd,
                  kv_    => l_doc.kv,
                  data_  => l_doc.datd,
                  datp_  => l_doc.datp,
                  nam_a_ => l_doc.nam_a,
                  nam_b_ => l_doc.nam_b,
                  nazn_  => l_doc.nazn,
                  naznk_ => null,
                  nazns_ => l_arc.nazns,
                  id_a_  => l_doc.id_a,
                  id_b_  => l_doc.id_b,
                  id_o_  => l_doc.id_o,
                  ref_a_ => l_doc.ref_a,
                  bis_   => l_arc.bis,
                  sign_  => l_arc.sign,
                  fn_a_  => null,
                  rec_a_ => null,
                  dat_a_ => null,
                  d_rec_ => l_arc.d_rec,
                  otm_i  => 0,
                  ref_i  => l_doc.ref,
                  blk_i  => 0,
                  ref_swt_ => null);
           
                  l_bis_curr := l_bis_curr + 1;
                  
                  if (l_sep_err <> '0') then
                      begin
                          select  l_sep_err||': '||n_er into l_seperr_text from bars.s_er where k_er = l_sep_err;
                      exception when no_data_found then
                          l_seperr_text := l_sep_err;
                      end;
                      bars.bars_error.raise_nerror( G_ERRMOD, 'SDO_AUTO_PAY_INSEP_ERROR', l_seperr_text, l_doc.ref, l_doc.ref);
                  end if; 
                  
     end loop;
     bars.bars_audit.info(l_trace||' документ REF = '||l_doc.ref||' вставлен в arc_rrp, l_sep_err=<'||l_sep_err||'>, кол-во бис строк = '||l_bis_count);
  end;

  
  
  ------------------------------------
  -- ASYNC_AUTO_VISA
  --
  -- Процедура для автообработки докумнетов корп2 вертушкой
  -- Установка виз с подписями, оплата по-факту
  --
  procedure async_auto_visa (p_ref      in number,
                             p_key      in varchar2,
                             p_int_sign in varchar2,
                             p_sep_sign in varchar2)
  is
     l_doc           bars.oper%rowtype;
     l_chk_group     number;
     l_errtxt        varchar2(4000);
     l_bis_count     number;
     l_curr_bis      number;
     l_arc_row       bars.arc_rrp%rowtype;
     l_trace         varchar2(4000) := g_trace ||'async_auto_visa:';
  begin
     
	 bars.bars_audit.info(l_trace||'старт формирования подписей и оплаты по-факту для документа REF = '||p_ref);
     l_doc     := read_bars_doc(p_ref);
     
     -- на входе имеем документ вставленный в OPER, вставленные проводки в OPLDOK.
	 -- докумнет ожидает автовизы

	 
	 bc.go(l_doc.branch);
	 dbms_output.put_line('branch from pack='||l_doc.branch);
	 
     -- найдем код группы визирования для сбон платежей
     select idchk into l_chk_group
         from bars.chklist_tts
        where priority = (select max(priority) from chklist_tts where tt = l_doc.tt)
          and tt = l_doc.tt;
 
     -- документ внешний, требующий СЕП или ВПС
     if ( l_doc.mfoa <> l_doc.mfob ) then
		 -- наложить вторую и последнюю визу но уже с подписью вертушки авто-СДО
		   bars.chk.put_visa(ref_     => p_ref ,
							  tt_     => l_doc.tt,
							  grp_    => l_chk_group,
							  status_ => 2,
							  keyid_  => p_key,
							  sign1_  => p_int_sign,
							  sign2_  => p_sep_sign);

		   bars.bars_audit.info(l_trace||'для внешнего докумнета виза с внешней подписью сформирована с группой визировнаия '||l_chk_group);

		   -- оплачиваем документ принудительно до состяения "оплачен"
		   bars.bars_audit.info(l_trace||'старт оплаты документа по-факту с датой валютировнаия '||to_char(l_doc.vdat,'dd/mm/yyyy'));
		   bars.gl.pay( p_flag => 2,
						p_ref  => p_ref,
						p_vdat => l_doc.vdat);
		   
		   l_doc     := read_bars_doc(p_ref);

		   bars.bars_audit.info(l_trace||'документ REF = '||p_ref||' успешно оплачен по-факту в oper, sos='||l_doc.sos );
		   
		   -- что - то пошлоне так (например, дата валютирования больше чем текущая - тогда документ останется ждать даты валютировнаия. В этом случае вообще приостанавливаем оплату.)
		   if (l_doc.sos <> 5 ) then
				-- по какойто причине документ не смог оплатиться по-факту. При этом ошибки(exception) могло не быть.
				-- Например, будущая дата валютировнаия. По-этому выкидываем прикладную ошибку
				if l_doc.vdat > bars.gl.bDATE then
				   bars.bars_error.raise_nerror( G_ERRMOD, 'FUTURE_VALUE_DATE', p_ref, p_ref, to_char(l_doc.vdat,'dd/mm/yyyy')); 
				end if;
				
				bars.bars_error.raise_nerror( G_ERRMOD, 'FAILED_TO_PAY_BY_FACT', p_ref, p_ref);
				 
		   end if;
		   
		   bars.bars_audit.info(l_trace||'документ REF = '||p_ref||' успешно оплачен по-факту в oper, sos='||l_doc.sos );
		   -- если удалось оплатить
		   if (l_doc.sos = 5 ) then
			   -- внести записи в arc_rrp (тут же бисы)
			   post_sep_rows (p_doc => l_doc);
		   else
			   bars.bars_audit.info(l_trace||'при попытке автооплаты СЕП/ВПС документа, документ  REF = '||p_ref||' не был оплачен по-факту, sos='||l_doc.sos);
		   end if;

     
    else
       
         -- наложить вторую и последнюю визу для внутреннего документа 
         bars.chk.put_visa(ref_    => p_ref         ,
                          tt_     => l_doc.tt      ,
                          grp_    => l_chk_group   ,
                          status_ => 2             ,
                          keyid_  => l_doc.id_o,
                          sign1_  => l_doc.sign,
                          sign2_  => null);
         -- оплачиваем документ принудительно до состяения "оплачен"
         bars.gl.pay( p_flag => 2,
                      p_ref  => p_ref,
                      p_vdat => l_doc.datp);
    end if;
    bars.bars_audit.info(l_trace||'документ REF = '||p_ref||' успешно оплачен по-факту');
    
  end;


  
end sbon_autopay;
/
 show err;
 

grant execute on bars.sbon_autopay to bars_access_defrole; 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/sbon_autopay.sql =========*** End 
 PROMPT ===================================================================================== 
 