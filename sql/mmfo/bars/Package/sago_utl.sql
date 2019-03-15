create or replace package sago_utl is

  -- Author  : YAROSLAV.KURTOV
  -- Created : 21.03.2018 17:24:57
  -- Purpose : Пакет утилит для обмена ПО с САГО


  procedure ins_request(P_CREATE_DATE  sago_requests.create_date%type,
                        P_DATA         sago_requests.data%type,
                        P_STATE        sago_requests.state%type,
                        P_COMM         sago_requests.comm%type,
                        P_USER_ID      sago_requests.user_id%type,
                        P_DOC_COUNT    sago_requests.doc_count%type,
                        P_REQ_ID   out sago_requests.id%type,
                        P_ERR_MESS out varchar2);
                        
  procedure ins_document(p_ref_sago     sago_documents.ref_sago%type,
                         p_act          sago_documents.act%type,
                         p_act_type     sago_documents.act_type%type,
                         p_act_date     sago_documents.act_date%type,
                         p_total_amount sago_documents.total_amount%type,
                         p_reg_id       sago_documents.reg_id%type,
                         p_f_state      sago_documents.f_state%type,
                         p_n_doc        sago_documents.n_doc%type,
                         p_d_doc        sago_documents.d_doc%type,
                         p_user_id      sago_documents.user_id%type,
                         p_fio_reg      sago_documents.fio_reg%type,
                         p_sign         sago_documents.sign%type,
                         p_request_id   sago_documents.request_id%type,
                         p_is_ins   out number,
                         P_ERR_MESS out varchar2);
  
  procedure set_request_state(p_req_id    sago_requests.id%type,
                              p_state     sago_requests.state%type,
                              p_comm      sago_requests.comm%type);
                              
  procedure create_payment(p_req_id sago_requests.id%type);
  
  procedure pay_req_paym;
  
  function get_count_doc(p_req_id sago_requests.id%type) return integer;

end sago_utl;
/
create or replace package body sago_utl is

  procedure ins_request(P_CREATE_DATE  sago_requests.create_date%type,
                        P_DATA         sago_requests.data%type,
                        P_STATE        sago_requests.state%type,
                        P_COMM         sago_requests.comm%type,
                        P_USER_ID      sago_requests.user_id%type,
                        P_DOC_COUNT    sago_requests.doc_count%type,
                        P_REQ_ID   out sago_requests.id%type,
                        P_ERR_MESS out varchar2) is
  begin
    insert into sago_requests(id, create_date, data, state, comm, user_id, doc_count)
    values(sago_requests_seq.nextval, p_create_date, p_data, p_state, p_comm, p_user_id, p_doc_count)
    returning id into P_REQ_ID;
  exception 
    when others then
      p_err_mess := SUBSTR(SQLERRM,1,4000);
      null;
  end;
  
  procedure ins_document(p_ref_sago     sago_documents.ref_sago%type,
                         p_act          sago_documents.act%type,
                         p_act_type     sago_documents.act_type%type,
                         p_act_date     sago_documents.act_date%type,
                         p_total_amount sago_documents.total_amount%type,
                         p_reg_id       sago_documents.reg_id%type,
                         p_f_state      sago_documents.f_state%type,
                         p_n_doc        sago_documents.n_doc%type,
                         p_d_doc        sago_documents.d_doc%type,
                         p_user_id      sago_documents.user_id%type,
                         p_fio_reg      sago_documents.fio_reg%type,
                         p_sign         sago_documents.sign%type,
                         p_request_id   sago_documents.request_id%type,
                         p_is_ins   out number,
                         P_ERR_MESS out varchar2) is
  begin
    insert into sago_documents(id, ref_sago, act, act_type, act_date, total_amount, reg_id, f_state, n_doc, d_doc, user_id, fio_reg, sign, request_id)
    values(sago_documents_seq.nextval, p_ref_sago, p_act, p_act_type, p_act_date, p_total_amount, p_reg_id, p_f_state, p_n_doc, p_d_doc, p_user_id, p_fio_reg, p_sign, 
           p_request_id);
   p_is_ins := 1;
  exception 
    when others then
       p_err_mess := SUBSTR(SQLERRM,1,4000);
       p_is_ins := 0;
  end;
  
  function get_acc_for_sago(p_nbs varchar2, p_kf varchar2) return varchar2 is
   l_nls accounts.nls%type;
  begin
    select sa.nls
      into l_nls 
      from sago_accounts sa
     where sa.nbs = p_nbs
       and sa.kf = p_kf;
    return l_nls;
  end;
  
  procedure create_payment(p_req_id sago_requests.id%type) is 
    l_ref oper.ref%type;
    l_nlsa     accounts.nls%type;
    l_nlsb     accounts.nls%type;
    l_nmsa     accounts.nms%type;
    l_nmsb     accounts.nms%type;
    l_mfob     accounts.kf%type;
    l_ida      oper.id_a%type;
    l_idb      oper.id_b%type;
    l_vob      oper.vob%type;
    l_kf       accounts.kf%type;
    l_bankdate date;
    l_cashsymb oper.sk%type;
    l_nazn     oper.nazn%type;
  begin
    for c0 in (select sd.*, sot.tts, row_number() over (partition by sd.request_id, sd.act order by sd.request_id, sd.act) RN
                 from sago_documents sd,
                      sago_operation_tts sot
                where sot.id_sago_oper = sd.act
                  and sd.request_id = p_req_id
                  and sd.f_state = 9999) loop
      begin 
        
         ---  ????????доделать подсчет количества оплаченных в запросе
          gl.ref(l_ref);
          l_bankdate :=  gl.bd;
          l_kf := gl.aMFO;
          if c0.tts = '090' then
            l_vob := 56;
            l_cashsymb := 33;
            l_nlsa := get_acc_for_sago('1001', l_kf);
            l_nlsb := get_acc_for_sago('1811', l_kf);
            l_ida  := f_ourokpo; 
            l_idb  := f_ourokpo;
            l_nazn := 'Зменшення запасів готівки для підкріплення операційної каси';
            select substr(acc.nms,1,38)
              into l_nmsa
              from accounts acc
             where acc.nls = l_nlsa
               and acc.kv = '980'
               and acc.dazs is null;
            select substr(acc.nms,1,38)
              into l_nmsb
              from accounts acc
             where acc.nls = l_nlsb
               and acc.kv = '980'
               and acc.dazs is null;
          elsif c0.tts = '092' then
            l_vob := 56;
            l_cashsymb := 67;
            l_nlsa := get_acc_for_sago('1811', l_kf);
            l_nlsb := get_acc_for_sago('1001', l_kf);
            l_ida  := f_ourokpo; 
            l_idb  := f_ourokpo;
            l_nazn := 'Збільшення запасів готівки за рахунок операційної каси';
            select substr(acc.nms,1,38)
              into l_nmsa
              from accounts acc
             where acc.nls = l_nlsa
               and acc.kv = '980'
               and acc.dazs is null;
            select substr(acc.nms,1,38)
              into l_nmsb
              from accounts acc
             where acc.nls = l_nlsb
               and acc.kv = '980'
               and acc.dazs is null;
          elsif c0.tts = 'VZA' then
            l_vob := 9;
          --  l_cashsymb := 33;
            l_nlsa := get_acc_for_sago('9817', l_kf);
            l_nlsb := get_acc_for_sago('9910', l_kf);
            l_ida  := f_ourokpo; 
            l_idb  := f_ourokpo;
            l_nazn := 'Підкріплення запасів готівки НБУ в уповноваженому банку';
            select substr(acc.nms,1,38)
              into l_nmsa
              from accounts acc
             where acc.nls = l_nlsa
               and acc.kv = '980'
               and acc.dazs is null;
            select substr(acc.nms,1,38)
              into l_nmsb
              from accounts acc
             where acc.nls = l_nlsb
               and acc.kv = '980'
               and acc.dazs is null;
          elsif c0.tts = 'VZB' then
            l_vob := 4;
         --   l_cashsymb := 33;
            l_nlsa := get_acc_for_sago('9910', l_kf);
            l_nlsb := get_acc_for_sago('9817', l_kf);
            l_ida  := f_ourokpo; 
            l_idb  := f_ourokpo;
            l_nazn := 'Вивезення запасів готівки в уповноваженому банку до НБУ';
            select substr(acc.nms,1,38)
              into l_nmsa
              from accounts acc
             where acc.nls = l_nlsa
               and acc.kv = '980'
               and acc.dazs is null;
            select substr(acc.nms,1,38)
              into l_nmsb
              from accounts acc
             where acc.nls = l_nlsb
               and acc.kv = '980'
               and acc.dazs is null;
          elsif c0.tts = '225' then
            l_vob := 4;
         --   l_cashsymb := 33;
            l_nlsa := get_acc_for_sago('1811', l_kf);
            l_nlsb := '46284100901026';
            select substr(acc.nms,1,38)
              into l_nmsa
              from accounts acc
             where acc.nls = l_nlsa
               and acc.kv = '980'
               and acc.dazs is null;
            l_nmsb := 'Національний банк України';
            l_mfob := '300001';
            l_ida  := f_ourokpo;
            l_idb  := '00032106';

          end if;

          gl.in_doc3(l_ref,
                     c0.tts,
                     l_vob,
                     l_ref,
                     sysdate,
                     l_bankdate,
                     1,
                     980,
                     c0.total_amount,
                     980,
                     c0.total_amount,
                     l_cashsymb,
                     l_bankdate,
                     l_bankdate,
                     l_nmsa,
                     l_nlsa,
                     l_kf,
                     l_nmsb,
                     l_nlsb,
                     nvl(l_mfob, l_kf),
                     l_nazn,
                     null,
                     l_ida,
                     l_idb,--l_rec_row.numident, ОКПО з ЄБП
                     null,
                     null,
                     0,
                     0,
                     null);
           if (c0.tts = '225') then
              gl.payv(0,
                      l_ref,
                      l_bankdate,
                      c0.tts,
                      1,
                      980,
                      l_nlsa,
                      c0.total_amount,
                      980,
                      get_proc_nls('T00',980) ,
                      c0.total_amount);
           else 
                  paytt(0,
                        l_ref,
                        l_bankdate,
                        c0.tts,
                        1,
                        980,
                        l_nlsa,
                        c0.total_amount,
                        980,
                        l_nlsb,
                        c0.total_amount);
          end if;
                     
           update sago_documents sd
              set sd.ref_our = case c0.rn when 1 then to_char(l_ref)
                                          when 2 then to_char(sd.ref_our)||','||to_char(l_ref) end,
                  sd.f_state = 2
            where sd.id = c0.id;
        
       exception 
         when others then
           dbms_output.put_line(sqlerrm);
           logger.error('SAGO ERORR:'||sqlerrm);
           update sago_documents sd
              set sd.f_state = 12
            where sd.id = c0.id;
       end;
    end loop;
    update sago_requests sr 
       set sr.state = 4
     where sr.id = p_req_id;
  end;
  
  procedure pay_req_paym is
  begin
    for c0 in (select *
                 from sago_requests sr
                where sr.state = 0) loop
       create_payment(c0.id);
    end loop;
  end;
  
  procedure set_request_state(p_req_id    sago_requests.id%type,
                              p_state     sago_requests.state%type,
                              p_comm      sago_requests.comm%type) is
  begin
    update sago_requests sr
       set sr.state = p_state,
           sr.comm = p_comm
     where sr.id = p_req_id;
  end;
  
  function get_count_doc(p_req_id sago_requests.id%type) return integer is
    l_cnt integer := 0;
  begin
    for c0 in (select sd.ref_our ref
                 from sago_documents sd
                where sd.request_id = p_req_id) loop
        if (c0.ref is not null) then
          l_cnt := l_cnt + 1;
          if INSTR(c0.ref,',') > 0 then
            l_cnt := l_cnt + 1;
          end if;
        end if;
    end loop;
    return l_cnt;
  end;

end sago_utl;
/

grant execute on sago_utl to bars_access_defrole;
