

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_FILE_A.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_FILE_A ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_FILE_A (p_nd oper.nd%type,
                                       p_date oper.vdat%type default trunc(sysdate),
                                       p_branch oper.branch%type,
                                       p_mfoa oper.mfoa%type,
                                       p_mfob oper.mfob%type,
                                       p_nlsa oper.nlsa%type,
                                       p_nlsb oper.nlsb%type,
                                       p_okpoa oper.id_a%type,
                                       p_okpob oper.id_b%type,
                                       p_kv tabval.lcv%type,
                                       p_s oper.s%type,
                                       p_nama oper.nam_a%type,
                                       p_namb oper.nam_b%type,
                                       p_nazn oper.nazn%type,
                                       p_sk oper.sk%type,
                                       p_dk oper.dk%type default 1,
                                       p_vob oper.vob%type default 6,
                                       p_drec varchar2 default null,
                                       p_sign oper.sign%type default null,
                                       p_CreatedByUserName staff.logname%type,
                                       p_ConfirmedByUserName staff.logname%type,
                     p_tt oper.tt%type,
                                       p_ref out oper.ref%type,
                                       p_errcode out number,
                                       p_errmsg out varchar2
                                       )
  is
    l_th constant varchar2(100) := 'pay_file_a';
    l_errcode number;
    l_errmsg varchar2(4000);
    l_ref number;
    l_tt oper.tt%type;
    l_rec_id sec_audit.rec_id%type;
    l_impdoc    xml_impdocs%rowtype;
    l_doc       bars_xmlklb_imp.t_doc;
    l_dreclist  bars_xmlklb.array_drec;
    l_userid staff.id%type;
    l_branch staff.branch%type;
  l_length number;
  l_name operw.tag%type;
  l_val operw.value%type;
  l_tmp varchar2(32767);
  l_str varchar2(32767);

    function get_kv(p_lcv tabval.lcv%type) return tabval.kv%type
        is
        l_kv tabval.kv%type;
      begin
        begin
             select kv into l_kv
                    from tabval where upper(lcv)=upper(p_lcv);
                   exception when no_data_found then
                      raise_application_error(-20000, 'Недопустимый код валюты '||p_lcv);
             end;

        return l_kv;
      end;
      procedure parse_str(p_str varchar2, p_name out varchar2, p_val out varchar2)
    is
    begin
      p_name := substr(p_str,0,instr(p_str,'=')-1);
      p_val := substr(p_str,instr(p_str,'=')+1);
    end;

  begin
    bars_audit.trace('%s: entry point', l_th);
  bars_audit.info('pay_file_a(input parameters): p_nd=>'||p_nd||chr(13)||chr(10)||
                  ', p_date=>'||to_char(p_date, 'dd.mm.yyyy') ||chr(13)||chr(10)||
          ', p_branch=>'||p_branch||chr(13)||chr(10)||
          ', p_mfoa=>'||p_mfoa||chr(13)||chr(10)||
          ', p_mfob=>'||p_mfob||chr(13)||chr(10)||
          ', p_nlsa=>'||p_nlsa||chr(13)||chr(10)||
          ', p_nlsb=>'||p_nlsb||chr(13)||chr(10)||
          ', p_okpoa=>'||p_okpoa||chr(13)||chr(10)||
          ', p_okpob=>'||p_okpob||chr(13)||chr(10)||
          ', p_kv=>'||p_kv||chr(13)||chr(10)||
          ', p_s=>'||to_char(p_s)||chr(13)||chr(10)||
          ', p_nama=>'||p_nama||chr(13)||chr(10)||
          ', p_namb=>'||p_namb||chr(13)||chr(10)||
          ', p_nazn=>'||p_nazn||chr(13)||chr(10)||
          ', p_sk=>'||to_char(p_sk)||chr(13)||chr(10)||
          ', p_dk=>'||to_char(p_dk)||chr(13)||chr(10)||
          ', p_vob=>'||to_char(p_vob)||chr(13)||chr(10)||
          ', p_drec=>'||p_drec||chr(13)||chr(10)||
          ', p_sign=>'||p_sign||chr(13)||chr(10)||
          ', p_CreatedByUserName=>'||p_CreatedByUserName||chr(13)||chr(10)||
          ', p_ConfirmedByUserName=>'||p_ConfirmedByUserName||chr(13)||chr(10)||
          ', p_tt=>'||p_tt);
      -- точка отката
      savepoint sp_paystart;

      begin
         -- представляемся отделением
        bc.subst_branch(p_branch);


       -- вычисление операции для оплаты документа
      /* l_tt := bars_xmlklb_imp.get_import_operation(
                p_nlsa => p_nlsa,
                p_mfoa => p_mfoa,
                p_nlsb => p_nlsb,
                p_mfob => p_mfob,
                p_dk   => p_dk,
                p_kv   =>get_kv(p_kv));*/
        l_tt:=p_tt;
        bars_audit.trace('%s: l_tt = %s', l_th, l_tt);

        l_errcode := null;
        l_errmsg := null;
        l_ref := null;

         begin
           select id, branch into l_userid, l_branch from staff
                  where upper(logname)=upper(p_CreatedByUserName);
             exception when no_data_found then
                   raise_application_error(-20000, 'Пользователь не найден или зарегестрирован в другом отделении!');
           end;

            if l_branch<>p_branch then
                  raise_application_error(-20000, 'Заданое отделение('||p_branch||') не соответствует отделению('||l_branch||') пользователя '||p_CreatedByUserName);
                end if;


        l_impdoc.ref_a  := null ;
        l_impdoc.impref := null ;
        l_impdoc.nd     := p_nd;
        l_impdoc.datd   := p_date;
        l_impdoc.vdat   := gl.bdate       ;
        l_impdoc.nam_a  := p_nama         ;
        l_impdoc.mfoa   := p_mfoa         ;
        l_impdoc.nlsa   := p_nlsa         ;
        l_impdoc.id_a   := p_okpoa        ;
        l_impdoc.nam_b  := p_namb         ;
        l_impdoc.mfob   := p_mfob         ;
        l_impdoc.nlsb   := p_nlsb         ;
        l_impdoc.id_b   := p_okpob        ;
        l_impdoc.s      := p_s            ;
        l_impdoc.kv     := get_kv(p_kv)   ;
        l_impdoc.s2     := p_s            ;
        l_impdoc.kv2    := get_kv(p_kv)   ;
        l_impdoc.sk     := p_sk           ;
        l_impdoc.dk     := p_dk           ;
        l_impdoc.tt     := l_tt           ;
        l_impdoc.vob    := p_vob          ;
        l_impdoc.nazn   := p_nazn         ;
        l_impdoc.datp   := gl.bdate       ;
        l_impdoc.userid := l_userid       ;

        l_doc.doc  := l_impdoc;
  begin
    if p_drec is not null then
          l_length := length(p_drec) - length(replace(p_drec,';'));
          l_str :=p_drec;
          for i in 0..l_length - 1 loop
          l_tmp := substr(l_str, 0, instr(l_str,';')-1);
          l_str := substr(l_str, instr(l_str,';')+1);
          parse_str(l_tmp,l_name,l_val);
          l_doc.drec(i).tag := l_name;
          l_doc.drec(i).val := l_val;
          end loop;
     end if;
    exception when others then
    raise_application_error(-20000, 'Не коректно сформовано параметр D_REC!');
     end;
        bars_xmlklb_imp.pay_extern_doc( p_doc  => l_doc,
                        p_errcode => l_errcode,
                        p_errmsg  => l_errmsg ) ;

        l_ref := l_doc.doc.ref;

        p_ref:=to_char(l_ref);
        p_errcode:=to_char(l_errcode);
        p_errmsg:=l_errmsg;

        bars_audit.trace('%s: pay_extern_doc done, l_errcode=%s, l_errmsg=%s',
           l_th, to_char(l_errcode), l_errmsg);

        if p_errcode = 0 and p_errmsg is null then
          begin
            insert into CHECK_PAY_FILE_A(ND,S, NLSA, NLSB, MFOA, MFOB, LCV, PDAT, VDAT, KF)
            values(p_nd, p_s, p_nlsa, p_nlsb, p_mfoa, p_mfob, p_kv, p_date, gl.bdate, sys_context('bars_context','user_mfo'));
          exception when dup_val_on_index then
            raise_application_error(-20000, 'Документ з номером '||p_nd||' вже створено!');
            rollback to savepoint sp_paystart; 
          end;
        end if; 
       -- возврат контекста
       bc.set_context;

     exception when others then
       bars_audit.trace('%s: exception block entry point', l_th);
       bars_audit.trace('%s: error detected sqlerrcode=%s, sqlerrm=%s', l_th, to_char(sqlcode), sqlerrm);
       --eсли exception запишем ошыбку в исх. параметр
       p_errcode:=sqlcode;
       p_errmsg:=substr(sqlerrm,1,4000);
       -- запись полного сообщения об ошибке в журнал
       bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
          dbms_utility.format_error_backtrace(), null, null, l_rec_id);
       -- откат к точке начала оплаты
       rollback to savepoint sp_paystart;
       -- возврат контекста
       bc.set_context;
     end;
   bars_audit.info('pay_file_a(output parameters):
              p_ref=>'||to_char(p_ref)||chr(13)||chr(10)||
            ',p_errcode=>'||to_char(p_errcode)||chr(13)||chr(10)||
            ',p_errmsg=>'||p_errmsg);
    bars_audit.trace('%s: done', l_th);
end pay_file_a;
/
show err;

PROMPT *** Create  grants  PAY_FILE_A ***
grant EXECUTE                                                                on PAY_FILE_A      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_FILE_A.sql =========*** End **
PROMPT ===================================================================================== 
