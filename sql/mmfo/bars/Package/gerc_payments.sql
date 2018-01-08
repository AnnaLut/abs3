
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/gerc_payments.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.GERC_PAYMENTS 
IS
   G_HEADER_VERSION   CONSTANT VARCHAR2 (64) := 'v.3.4 15.06.2017';

   TYPE tBranchData IS RECORD
   (
      BranchCode      branch.BRANCH%TYPE,
      BranchName      BRANCH.name%TYPE,
      BranchAddress   VARCHAR2 (500)
   );

   TYPE t_docrec IS RECORD
   (
      p_nd                    oper.nd%TYPE,
      p_externalDocId         number,
      p_date                  oper.vdat%TYPE DEFAULT TRUNC (SYSDATE),
      p_branch                oper.branch%TYPE,
      p_mfoa                  oper.mfoa%TYPE,
      p_mfob                  oper.mfob%TYPE,
      p_nlsa                  oper.nlsa%TYPE,
      p_nlsb                  oper.nlsb%TYPE,
      p_okpoa                 oper.id_a%TYPE,
      p_okpob                 oper.id_b%TYPE,
      p_kv                    tabval.lcv%TYPE,
      p_s                     oper.s%TYPE,
      p_nama                  oper.nam_a%TYPE,
      p_namb                  oper.nam_b%TYPE,
      p_nazn                  oper.nazn%TYPE,
      p_sk                    oper.sk%TYPE,
      p_dk                    oper.dk%TYPE DEFAULT 1,
      p_vob                   oper.vob%TYPE DEFAULT 6,
      p_drec                  VARCHAR2(4000) DEFAULT NULL,
      p_sign                  oper.SIGN%TYPE DEFAULT NULL,
      p_CreatedByUserName     staff.logname%TYPE,
      p_ConfirmedByUserName   staff.logname%TYPE,
      p_tt                    oper.tt%TYPE
   );

   TYPE tBranchDataSet IS TABLE OF tBranchData;

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;

   PROCEDURE CreateDoc (p_nd                    IN     oper.nd%TYPE,
                     p_externalDocId         IN     number,
                     p_date                  IN     oper.vdat%TYPE DEFAULT TRUNC (SYSDATE),
                     p_branch                IN     oper.branch%TYPE,
                     p_mfoa                  IN     oper.mfoa%TYPE,
                     p_mfob                  IN     oper.mfob%TYPE,
                     p_nlsa                  IN     oper.nlsa%TYPE,
                     p_nlsb                  IN     oper.nlsb%TYPE,
                     p_okpoa                 IN     oper.id_a%TYPE,
                     p_okpob                 IN     oper.id_b%TYPE,
                     p_kv                    IN     tabval.lcv%TYPE,
                     p_s                     IN     oper.s%TYPE,
                     p_nama                  IN     oper.nam_a%TYPE,
                     p_namb                  IN     oper.nam_b%TYPE,
                     p_nazn                  IN     oper.nazn%TYPE,
                     p_sk                    IN     oper.sk%TYPE,
                     p_dk                    IN     oper.dk%TYPE DEFAULT 1,
                     p_vob                   IN     oper.vob%TYPE DEFAULT 6,
                     p_drec                  IN     VARCHAR2 DEFAULT NULL,
                     p_sign                  IN     varchar2 DEFAULT NULL,
                     p_CreatedByUserName     IN     staff.logname%TYPE,
                     p_ConfirmedByUserName   IN     staff.logname%TYPE,
                     p_tt                    IN     oper.tt%TYPE,
                     p_our_buffer            IN     varchar2,
                     p_ref                      OUT oper.REF%TYPE,
                     p_errcode                  OUT NUMBER,
                     p_errmsg                   OUT VARCHAR2);

    procedure CancelDocument (p_ExternalDocumentId    IN  gerc_orders.externaldocumentid%type,
                              p_ref                  OUT oper.ref%type,
                              p_StateCode            OUT gerc_statecodes.id%type,
                              p_ErrorMessage         OUT varchar2);

    procedure GetDocumentState (p_ExternalDocumentID IN OUT varchar2,
                                p_ref                   OUT oper.ref%type,
                                p_StateCode             OUT oper.sos%type,
                                p_ErrorMessage          OUT varchar2);
 procedure GetBuffer(p_nd                    IN     varchar2,
                     p_date                  IN     date,
                     p_mfoa                  IN     oper.mfoa%TYPE,
                     p_mfob                  IN     oper.mfob%TYPE,
                     p_nlsa                  IN     oper.nlsa%TYPE,
                     p_nlsb                  IN     oper.nlsb%TYPE,
                     p_okpoa                 IN     oper.id_a%TYPE,
                     p_okpob                 IN     oper.id_b%TYPE,
                     p_kv                    IN     tabval.lcv%TYPE,
                     p_s                     IN     oper.s%TYPE,
                     p_nama                  IN     oper.nam_a%TYPE,
                     p_namb                  IN     oper.nam_b%TYPE,
                     p_nazn                  IN     oper.nazn%TYPE,
                     p_dk                    IN     oper.dk%TYPE DEFAULT 1,
                     p_buffer                   OUT varchar2);
 procedure PutValidationResult (p_externalDocId     IN  VARCHAR2,
                                p_buffer            IN  VARCHAR2,
                                p_sign              IN  VARCHAR2,
                                p_ValidationResult  IN VARCHAR2);
PROCEDURE doc_visa (p_ref      IN oper.REF%TYPE,
                    p_idoper   IN VARCHAR2,
                    p_sign     IN oper.SIGN%TYPE);

PROCEDURE SearchClient (p_in_RNK            IN     NUMBER DEFAULT NULL,
                        p_in_OKPO           IN     VARCHAR2 DEFAULT NULL,
                        p_in_NMK            IN     VARCHAR2 DEFAULT NULL,
                        p_in_CUSTTYPE       IN     NUMBER DEFAULT null,
                        p_in_passtype       IN     NUMBER DEFAULT NULL,
                        p_in_SER            IN     VARCHAR2 DEFAULT NULL,
                        p_in_NUMDOC         IN     VARCHAR2 DEFAULT NULL,
                        p_RNK                  OUT NUMBER,
                        p_OKPO                 OUT VARCHAR2,
                        p_NMK                  OUT VARCHAR2,
                        p_PCUSTTYPE            OUT NUMBER,
                        p_COUNTRY              OUT NUMBER,
                        p_NMKV                 OUT VARCHAR2,
                        p_NMKK                 OUT VARCHAR2,
                        p_CODCAGENT            OUT NUMBER,
                        p_PRINSIDER            OUT NUMBER,
                        p_ADR                  OUT VARCHAR2,
                        p_C_REG                OUT NUMBER,
                        p_C_DST                OUT NUMBER,
                        p_ADM                  OUT VARCHAR2,
                        p_DATE_ON              OUT VARCHAR2,
                        p_DATE_OFF             OUT VARCHAR2,
                        p_CRISK                OUT NUMBER,
                        p_ND                   OUT VARCHAR2,
                        p_ISE                  OUT VARCHAR2,
                        p_FS                   OUT VARCHAR2,
                        p_OE                   OUT VARCHAR2,
                        p_VED                  OUT VARCHAR2,
                        p_SED                  OUT VARCHAR2,
                        p_MB                   OUT VARCHAR2,
                        p_RGADM                OUT VARCHAR2,
                        p_BC                   OUT NUMBER,
                        p_BRANCH               OUT VARCHAR2,
                        p_TOBO                 OUT VARCHAR2,
                        p_K050                 OUT VARCHAR2,
                        p_NREZID_CODE          OUT VARCHAR2,
                        p_SER                  OUT VARCHAR2,
                        p_NUMDOC               OUT VARCHAR2,
                        p_OperationResult      OUT INTEGER,
                        p_ErrorMessage         OUT VARCHAR2);

PROCEDURE RegisterRefreshNonClient (p_isnew             IN     INTEGER DEFAULT 0,
                                    p_in_RNK            IN     NUMBER DEFAULT NULL,
                                    p_in_OKPO           IN     VARCHAR2 DEFAULT NULL,
                                    p_in_NMK            IN     VARCHAR2 DEFAULT NULL,
                                    p_in_CUSTTYPE       IN     NUMBER DEFAULT null,
                                    p_in_passtype       IN     NUMBER DEFAULT NULL,
                                    p_in_SER            IN     VARCHAR2 DEFAULT NULL,
                                    p_in_NUMDOC         IN     VARCHAR2 DEFAULT NULL,
                                    p_RNK               IN OUT NUMBER,
                                    p_OKPO              IN OUT VARCHAR2,
                                    p_NMK               IN OUT VARCHAR2,
                                    p_CUSTTYPE          IN OUT NUMBER,
                                    p_COUNTRY           IN OUT NUMBER,
                                    p_NMKV              IN OUT VARCHAR2,
                                    p_NMKK              IN OUT VARCHAR2,
                                    p_CODCAGENT         IN OUT NUMBER,
                                    p_PRINSIDER         IN OUT NUMBER,
                                    p_ADR               IN OUT VARCHAR2,
                                    p_C_REG             IN OUT NUMBER,
                                    p_C_DST             IN OUT NUMBER,
                                    p_ADM               IN OUT VARCHAR2,
                                    p_DATE_ON           IN OUT VARCHAR2,
                                    p_DATE_OFF          IN OUT VARCHAR2,
                                    p_CRISK             IN OUT NUMBER,
                                    p_ND                IN OUT VARCHAR2,
                                    p_ISE               IN OUT VARCHAR2,
                                    p_FS                IN OUT VARCHAR2,
                                    p_OE                IN OUT VARCHAR2,
                                    p_VED               IN OUT VARCHAR2,
                                    p_SED               IN OUT VARCHAR2,
                                    p_MB                IN OUT VARCHAR2,
                                    p_RGADM             IN OUT VARCHAR2,
                                    p_BC                IN OUT NUMBER,
                                    p_BRANCH            IN OUT VARCHAR2,
                                    p_TOBO              IN OUT VARCHAR2,
                                    p_K050              IN OUT VARCHAR2,
                                    p_NREZID_CODE       IN OUT VARCHAR2,
                                    p_SER               IN OUT VARCHAR2,
                                    p_NUMDOC            IN OUT VARCHAR2,
                                    p_OperationResult   IN OUT INTEGER,
                                    p_ErrorMessage      IN OUT VARCHAR2);

END GERC_PAYMENTS;
/
CREATE OR REPLACE PACKAGE BODY BARS.GERC_PAYMENTS IS

    G_BODY_VERSION      constant varchar2(64) := 'v.2.4 13.09.2017';
    TYPE t_cursor   IS REF CURSOR;
    function header_version return varchar2
    is
    begin
       return 'package header GERC_PAYMENTS: ' || G_HEADER_VERSION;
    end header_version;

    function body_version return varchar2
    is
    begin
       return 'package body GERC_PAYMENTS: ' || G_BODY_VERSION || chr(10);
    end body_version;

    procedure log_gerc_audit(externalDocument_id varchar2, rec_message varchar2)
    is
    pragma autonomous_transaction;
    begin
        begin
          insert into gerc_audit (date_run, externalDocument_id, rec_message)
               values (sysdate, externalDocument_id, rec_message);
               commit;
        exception when others then bars_audit.info('log_gerc_audit'||':'||sqlcode||'/'||sqlerrm);
        end;
     commit;
    end;


  PROCEDURE try_ins (p_nd                    IN     oper.nd%TYPE,
                     p_externalDocId         IN     number,
                     p_date                  IN     oper.vdat%TYPE DEFAULT TRUNC (SYSDATE),
                     p_branch                IN     oper.branch%TYPE,
                     p_mfoa                  IN     oper.mfoa%TYPE,
                     p_mfob                  IN     oper.mfob%TYPE,
                     p_nlsa                  IN     oper.nlsa%TYPE,
                     p_nlsb                  IN     oper.nlsb%TYPE,
                     p_okpoa                 IN     oper.id_a%TYPE,
                     p_okpob                 IN     oper.id_b%TYPE,
                     p_kv                    IN     tabval.lcv%TYPE,
                     p_s                     IN     oper.s%TYPE,
                     p_nama                  IN     oper.nam_a%TYPE,
                     p_namb                  IN     oper.nam_b%TYPE,
                     p_nazn                  IN     oper.nazn%TYPE,
                     p_sk                    IN     oper.sk%TYPE,
                     p_dk                    IN     oper.dk%TYPE DEFAULT 1,
                     p_vob                   IN     oper.vob%TYPE DEFAULT 6,
                     p_drec                  IN     VARCHAR2 DEFAULT NULL,
                     p_sign                  IN     varchar2 DEFAULT NULL,
                     p_CreatedByUserName     IN     staff.logname%TYPE,
                     p_tt                    IN     oper.tt%TYPE,
                     p_our_buffer            IN     varchar2)
    is
    pragma autonomous_transaction;
    begin
     begin
       merge into gerc_orders o using (select * from dual) on (o.externaldocumentid = p_externalDocId and o.ref is null)
       when matched then
         update set
           DOCUMENTNUMBER       = p_nd,
           OPERATIONTYPE        = p_tt,
           DOCUMENTTYPE         = p_vob,
           DOCUMENTDATE         = p_date,
           DEBITMFO             = p_mfoa,
           CREDITMFO            = p_mfob,
           DEBITACCOUNT         = p_nlsa,
           CREDITACCOUNT        = p_nlsb,
           DEBITNAME            = p_nama,
           CREDITNAME           = p_namb,
           DEBITEDRPOU          = p_okpoa,
           CREDITEDRPOU         = p_okpob,
           AMOUNT               = p_s,
           CURRENCY             = p_kv,
           PURPOSE              = p_nazn,
           CASHSYMBOL           = p_sk,
           DEBITFLAG            = p_dk,
           ADDITIONALREQUISITES = p_drec,
           DIGITALSIGNATURE     = p_sign,
           DOCUMENTAUTHOR       = p_CreatedByUserName,
           BRANCH               = p_branch,
           REQ_MESSAGE          = p_OUR_BUFFER,
           OUR_BUFFER           = p_SIGN,
           GERC_SIGN            = 'update'
       when not matched then
          insert                   (REF, DOCUMENTNUMBER, OPERATIONTYPE, DOCUMENTTYPE, DOCUMENTDATE,
                                   DEBITMFO, CREDITMFO, DEBITACCOUNT, CREDITACCOUNT, DEBITNAME,
                                   CREDITNAME, DEBITEDRPOU, CREDITEDRPOU, AMOUNT, CURRENCY, PURPOSE,
                                   CASHSYMBOL, DEBITFLAG, ADDITIONALREQUISITES, DIGITALSIGNATURE,
                                   DOCUMENTAUTHOR, BRANCH, EXTERNALDOCUMENTID, REQ_MESSAGE, OUR_BUFFER, GERC_SIGN)
          values (null,
                  p_nd,
                  p_tt,
                  p_vob,
                  p_date,
                  p_mfoa,
                  p_mfob,
                  p_nlsa,
                  p_nlsb,
                  p_nama,
                  p_namb,
                  p_okpoa,
                  p_okpob,
                  p_s,
                  p_kv,
                  p_nazn,
                  p_sk,
                  p_dk,
                  p_drec,
                  p_sign,
                  p_CreatedByUserName,
                  p_branch,
                  p_externalDocId,
                  p_OUR_BUFFER,
                  p_SIGN,
                  'insert');
     exception when others then bars_audit.info('GERC_PAYMENTS.try_ins'||':'||sqlcode||'/'||sqlerrm);
                                log_gerc_audit(p_externalDocId,'GERC_PAYMENTS.try_ins'||':'||sqlcode||'/'||sqlerrm);
                                raise;
     end;

    commit;
    end;

    FUNCTION get_kv (p_lcv tabval.lcv%TYPE)
       RETURN tabval.kv%TYPE
    IS
       l_kv   tabval.kv%TYPE;
    BEGIN
       BEGIN
          SELECT kv
            INTO l_kv
            FROM tabval
           WHERE UPPER (lcv) = UPPER (p_lcv);
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN raise_application_error (-20000,'������������ ��� ������ ' || p_lcv);
       END;

       RETURN l_kv;
    END;
    PROCEDURE parse_str (p_str VARCHAR2, p_name OUT VARCHAR2, p_val OUT VARCHAR2)
    IS
    BEGIN
       p_name := SUBSTR (p_str, 0, INSTR (p_str, '=') - 1);
       p_val := SUBSTR (p_str, INSTR (p_str, '=') + 1);
    END;

PROCEDURE CreateDoc (p_nd                    IN     oper.nd%TYPE,
                     p_externalDocId         IN     number,
                     p_date                  IN     oper.vdat%TYPE DEFAULT TRUNC (SYSDATE),
                     p_branch                IN     oper.branch%TYPE,
                     p_mfoa                  IN     oper.mfoa%TYPE,
                     p_mfob                  IN     oper.mfob%TYPE,
                     p_nlsa                  IN     oper.nlsa%TYPE,
                     p_nlsb                  IN     oper.nlsb%TYPE,
                     p_okpoa                 IN     oper.id_a%TYPE,
                     p_okpob                 IN     oper.id_b%TYPE,
                     p_kv                    IN     tabval.lcv%TYPE,
                     p_s                     IN     oper.s%TYPE,
                     p_nama                  IN     oper.nam_a%TYPE,
                     p_namb                  IN     oper.nam_b%TYPE,
                     p_nazn                  IN     oper.nazn%TYPE,
                     p_sk                    IN     oper.sk%TYPE,
                     p_dk                    IN     oper.dk%TYPE DEFAULT 1,
                     p_vob                   IN     oper.vob%TYPE DEFAULT 6,
                     p_drec                  IN     VARCHAR2 DEFAULT NULL,
                     p_sign                  IN     varchar2 DEFAULT NULL,
                     p_CreatedByUserName     IN     staff.logname%TYPE,
                     p_ConfirmedByUserName   IN     staff.logname%TYPE,
                     p_tt                    IN     oper.tt%TYPE,
                     p_our_buffer            IN     varchar2,
                     p_ref                      OUT oper.REF%TYPE,
                     p_errcode                  OUT NUMBER,
                     p_errmsg                   OUT VARCHAR2)
IS
    title       constant   varchar2(25) := 'GERC_PAYMENTS.CreateDoc:';
    l_tt                   oper.tt%type;
    l_rec_id               sec_audit.rec_id%type;
    l_impdoc               xml_impdocs%rowtype;
    l_doc                  bars_xmlklb_imp.t_doc;
    --l_dreclist             bars_xmlklb.array_drec;
    l_userid               staff.id%type;
    l_branch               staff.branch%type;
    l_length               number;
    l_name                 operw.tag%type;
    l_val                  operw.value%type;
    l_tmp                  varchar2(32767);
    l_str                  varchar2(32767);

  begin
    bars_audit.INFO(title||': entry point');

    begin
      try_ins(p_nd, p_externalDocId, p_date
      ,p_branch, p_mfoa, p_mfob
      ,p_nlsa, p_nlsb, p_okpoa, p_okpob, p_kv, p_s
      ,p_nama ,p_namb, p_nazn, p_sk, p_dk, p_vob, p_drec, p_sign
      ,p_CreatedByUserName, p_tt, p_our_buffer);
      exception
        when others then
          if sqlcode = -1 then
              p_ref := null;
              p_errcode:=sqlcode;
              p_errmsg:=substr('���� ��� ExternalDocId='||p_externalDocId||' '||sqlcode||'/'||sqlerrm,1,4000);
              --raise_application_error(-20000,p_errmsg);
              return;
            else
              raise;
          end if;
    end;

    log_gerc_audit(p_externalDocId,'insert: p_externalDocId=>'||p_externalDocId||', p_branch=>'||p_branch||', p_s=>'||to_char(p_s)||', p_tt=>'||p_tt);

    bars_audit.info(title||'(input parameters): p_nd=>'||p_nd||chr(13)||chr(10)||
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


      -- ����� ������
      savepoint sp_paystart;

      begin
         -- �������������� ����������
        bc.subst_branch(p_branch);
        bars_audit.trace(title||':  bc.subst_branch(p_branch)'|| p_branch);
       -- ���������� �������� ��� ������ ���������
          /* l_tt := bars_xmlklb_imp.get_import_operation(
                    p_nlsa => p_nlsa,
                    p_mfoa => p_mfoa,
                    p_nlsb => p_nlsb,
                    p_mfob => p_mfob,
                    p_dk   => p_dk,
                    p_kv   =>get_kv(p_kv));*/

        l_tt:=p_tt;
        bars_audit.trace('%s: l_tt = %s', title, l_tt);

        p_errcode := null;
        p_errmsg := null;
        p_ref := null;

         begin
           select id, branch into l_userid, l_branch from staff$base
                  where upper(logname)=upper(p_CreatedByUserName);
         exception when no_data_found then
                   raise_application_error(-20001, '������������ �� ������ ��� ��������������� � ������ ���������!');
         end;

        if l_tt not like 'G0%' then
          raise_application_error(-20000, '�������� ('||l_tt||') ���������� ��� ������������!!!');
        end if;

        if l_branch != '/' then --COBUMMFO-4499
          if l_branch<>p_branch then
              raise_application_error(-20000, '������� ���������('||p_branch||') �� ������������� ���������('||l_branch||') ������������ '||p_CreatedByUserName);
          end if;
        end if;

        l_impdoc.ref_a  := null;
        l_impdoc.impref := null;
        l_impdoc.nd     := nvl(p_nd, substr(p_externalDocId,greatest(-length(p_externalDocId),-10)));--����� 10 ������� ������� ��� p_nd = null
        l_impdoc.datd   := p_date;
        l_impdoc.vdat   := gl.bdate;
        l_impdoc.nam_a  := p_nama;
        l_impdoc.mfoa   := p_mfoa;
        l_impdoc.nlsa   := p_nlsa;
        l_impdoc.id_a   := p_okpoa;
        l_impdoc.nam_b  := p_namb;
        l_impdoc.mfob   := p_mfob;
        l_impdoc.nlsb   := p_nlsb;
        l_impdoc.id_b   := p_okpob;
        l_impdoc.s      := p_s;
        l_impdoc.kv     := p_kv;
        l_impdoc.s2     := p_s;
        l_impdoc.kv2    := p_kv;
        l_impdoc.sk     := p_sk;
        l_impdoc.dk     := p_dk;
        l_impdoc.tt     := l_tt;
        l_impdoc.vob    := p_vob;
        l_impdoc.nazn   := p_nazn;
        l_impdoc.datp   := gl.bdate;
        l_impdoc.userid := l_userid;

        bars_audit.INFO(title||':  l_impdoc. DONE');
        l_doc.doc  := l_impdoc;
        bars_audit.INFO(title||':  l_doc.doc  := l_impdoc. DONE');
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
        exception when others then raise_application_error(-20000, '�� �������� ���������� �������� D_REC!');
        end;
        bars_audit.INFO(title||':  p_drec. DONE');
        bars_audit.INFO(title||':  bars_xmlklb_imp.pay_extern_doc. start');
        bars_xmlklb_imp.pay_extern_doc( p_doc     => l_doc,
                                        p_errcode => p_errcode,
                                        p_errmsg  => p_errmsg ) ;
        bars_audit.INFO(title||':  bars_xmlklb_imp.pay_extern_doc. end');
        log_gerc_audit(p_externalDocId,p_errmsg);
        p_ref := to_char(l_doc.doc.ref);

        bars_audit.trace('%s: pay_extern_doc done, l_errcode=%s, l_errmsg=%s',
           title, to_char(p_errcode), p_errmsg);

       -- ������� ���������
       bc.set_context;

     exception when others then
       bars_audit.trace('%s: exception block entry point', title);
       bars_audit.trace('%s: error detected sqlerrcode=%s, sqlerrm=%s', title, to_char(sqlcode), sqlerrm);
       --e��� exception ������� ������ � ���. ��������
       p_errcode:=sqlcode;
       p_errmsg:=substr(sqlerrm,1,4000);
       -- ������ ������� ��������� �� ������ � ������
       bars_audit.error(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), null, null, l_rec_id);
       -- ����� � ����� ������ ������
       rollback to savepoint sp_paystart;
       -- ������� ���������
       bc.set_context;
     end;

     begin
      update gerc_orders
         set REF = p_ref,
             REQ_MESSAGE = case when p_errcode = 0 then 'Ok' else p_errmsg end
       where ExternalDocumentId = p_externalDocId
         and ref is null;
      exception when others then bars_audit.info(title||':'||sqlcode||'/'||sqlerrm);
     end;

     bars_audit.info('GERC_PAYMENTS.CreateDoc(output parameters):'||chr(13)||chr(10)||
                        ' p_ref=>'||to_char(p_ref)||chr(13)||chr(10)||
                        ',p_errcode=>'||to_char(p_errcode)||chr(13)||chr(10)||
                        ',p_errmsg=>'||p_errmsg);

     log_gerc_audit(p_externalDocId,' CreateDoc- Success. p_ref=>'||to_char(p_ref));

  end CreateDoc;

    procedure CancelDocument (p_ExternalDocumentId    IN  gerc_orders.externaldocumentid%type  ,
                              p_ref                  OUT oper.ref%type,
                              p_StateCode            OUT gerc_statecodes.id%type,
                              p_ErrorMessage         OUT varchar2)
    is
     title  constant    varchar2(30) := 'GERC_PAYMENTS.CancelDocument:';
     l_ref  oper.ref%type;
     l_n    number;
     l_s    varchar2(250);
     l_branch branch.branch%type;
    begin
     bars_audit.trace(title||' started.');
     begin
          update gerc_orders
             set REQ_MESSAGE = 'try to storno'
           where ExternalDocumentId = p_ExternalDocumentId;
     exception when others then bars_audit.info(title||':'||sqlcode||'/'||sqlerrm);
     end;

     log_gerc_audit(p_ExternalDocumentId,'Request to storno p_ExternalDocumentId='||p_ExternalDocumentId);


     begin
         select o.ref, o.sos, o.branch
           into l_ref, p_statecode, l_branch
           from gerc_orders t, oper o
          where ExternalDocumentId = p_ExternalDocumentId
            and trunc(DocumentDate) >= bankdate
            and o.ref = t.ref;
     exception when no_data_found then p_errorMessage := '�������� '||to_char(p_ExternalDocumentId) ||' �� ���� >= '||to_char(bankdate,'yyyy.mm.dd') ||' �� ��������'; p_statecode := null;
               when too_many_rows then p_errorMessage := '��������� �� ������� '||to_char(p_ExternalDocumentId) ||' �� ���� '||to_char(bankdate,'yyyy.mm.dd') ||' �������� �����, �� ����'; p_statecode := null;
     end;

     if p_errorMessage is not null then
       log_gerc_audit(p_ExternalDocumentId,p_errorMessage);
       bars_audit.error(title||' '||p_errorMessage);
       return;
     end if;

     -- �������������� ����������
     begin
       bc.subst_branch(l_branch);
       exception
         when others then
           p_errorMessage :=substr(sqlerrm,1,1070); p_statecode := null;
           bars_audit.error(title||' '||p_errorMessage);
           return;
     end;


     if l_ref is not null
     then
      if p_statecode != -1
      then
           begin
           p_ref := l_ref;
           end;
           begin
           p_back_dok (p_ref,
                      lev_      => 5,
                      reasonid_ => 3, -- ��������.������
                      par2_     => l_n,
                      par3_     => l_s,
                      fullback_ => 1);
           p_StateCode    := -1;
           p_errorMessage := '�������� �� ������� '||to_char(p_ExternalDocumentId) ||'�� ���� '||to_char(bankdate,'yyyy.mm.dd') || ' ������ �����������';
            begin
              update gerc_orders
                 set REQ_MESSAGE = 'Canceled'
               where ExternalDocumentId = p_ExternalDocumentId and ref = p_ref;
            exception when others then bars_audit.info(title||':'||sqlcode||'/'||sqlerrm);
            end;
           exception when others then
             p_errorMessage :=substr(sqlerrm,1,1070); p_statecode := null;
             bars_audit.error(title||' '||p_errorMessage);
           end;
       else
           p_StateCode    := null;
           p_errorMessage := '�������� �� ������� '||to_char(p_ExternalDocumentId) ||' �� ���� '||to_char(bankdate,'yyyy.mm.dd') || ' ����������� ����� (ref='||l_ref||')';
           bars_audit.error(title||' '||p_errorMessage);
       end if;
     end if;

     bars_audit.trace(title||' finised.');
    end CancelDocument;
   procedure GetDocumentState ( p_ExternalDocumentID IN OUT varchar2,
                                p_ref                   OUT oper.ref%type,
                                p_StateCode             OUT oper.sos%type,
                                p_ErrorMessage          OUT varchar2)
   is
    l_ErrorMessage varchar2(500);
   begin
   bars_audit.info('GetDocumentState '||' started p_ExternalDocumentID = ' || p_ExternalDocumentID);
    l_ErrorMessage := 'Ok';
    begin
        select o.sos, o.ref
          into p_StateCode, p_ref
          from oper o, gerc_orders g
         where g.ExternalDocumentID = p_ExternalDocumentID
           and o.sos>0
           and o.ref = G.REF;
    exception when no_data_found
              then l_ErrorMessage := '�� �������� ��������� �� �������' || to_char(p_ExternalDocumentID); p_ref := -1;
              when too_many_rows
              then l_ErrorMessage := '�������� ���� ������ ��������� �� �������' || to_char(p_ExternalDocumentID); p_ref := -1;
    end;
    p_ErrorMessage := substr(l_ErrorMessage,1,160);
    bars_audit.info('GetDocumentState '||'finished p_ExternalDocumentID = ' || p_ExternalDocumentID || ', p_StateCode = ' || to_char(p_StateCode) || ', p_ErrorMessage='|| l_ErrorMessage || ',p_ref=' || to_char(p_ref));
   end GetDocumentState;

 procedure GetBuffer(p_nd                    IN     varchar2,
                     p_date                  IN     date,
                     p_mfoa                  IN     oper.mfoa%TYPE,
                     p_mfob                  IN     oper.mfob%TYPE,
                     p_nlsa                  IN     oper.nlsa%TYPE,
                     p_nlsb                  IN     oper.nlsb%TYPE,
                     p_okpoa                 IN     oper.id_a%TYPE,
                     p_okpob                 IN     oper.id_b%TYPE,
                     p_kv                    IN     tabval.lcv%TYPE,
                     p_s                     IN     oper.s%TYPE,
                     p_nama                  IN     oper.nam_a%TYPE,
                     p_namb                  IN     oper.nam_b%TYPE,
                     p_nazn                  IN     oper.nazn%TYPE,
                     p_dk                    IN     oper.dk%TYPE DEFAULT 1,
                     p_buffer                   OUT varchar2 )
 is
 title constant varchar2(11)    := 'GetBuffer: ';
 l_buffer       varchar2(4000)  := '';
 l_kv           number          := 980;
 begin
 p_buffer := '';
 bars_audit.info(title||'(input parameters): p_nd=>'||p_nd||chr(13)||chr(10)||
                    ', p_date=>'||to_char(p_date, 'YYMMDD') ||chr(13)||chr(10)||
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
                    ', p_dk=>'||to_char(p_dk));
    begin
     select kv
       into l_kv
       from tabval
      where KV = p_kv;
    exception when no_data_found then bars_audit.error(title||'�� �������� ���� ������ ��� lcv = '|| p_kv);
              when too_many_rows then bars_audit.error(title||'��������� ���������� ��������� ��� ������ �� lcv = '|| p_kv);
    end;

    l_buffer := NVL (RPAD (to_char(p_nd), 10), RPAD (' ', 10))
         || NVL (TO_CHAR (p_date, 'YYMMDD'), RPAD (' ', 6))
         || NVL (LPAD (TO_CHAR (p_dk), 1), ' ')
         || NVL (LPAD (p_mfoa, 9), RPAD (' ', 9))
         || NVL (LPAD (p_nlsa, 14), RPAD (' ', 14))
         || NVL (LPAD (TO_CHAR (l_kv), 3), RPAD (' ', 3))
         || NVL (LPAD (TO_CHAR (p_s), 16), RPAD (' ', 16))
         || NVL (RPAD (p_nama, 38), RPAD (' ', 38))
         || LPAD (NVL (p_okpoa, ' '), 14)
         || NVL (LPAD (p_mfob, 9), RPAD (' ', 9))
         || NVL (LPAD (p_nlsb, 14), RPAD (' ', 14))
         || NVL (LPAD (TO_CHAR (l_kv), 3), RPAD (' ', 3))
         || NVL (LPAD (TO_CHAR (p_s), 16), RPAD (' ', 16))
         || NVL (RPAD (p_namb, 38), RPAD (' ', 38))
         || LPAD (NVL (p_okpob, ' '), 14)
         || NVL (RPAD (p_nazn, 160), RPAD (' ', 160));

         --l_buffer := substr(l_buffer,1,359);
    bars_audit.info(title||' (output buffer = )'|| l_buffer || 'length = ' ||length(l_buffer));
    begin
     p_buffer := l_buffer;
    exception when others then bars_audit.info(title||  dbms_utility.format_error_backtrace || sqlcode|| sqlerrm );
    end;



 end GetBuffer;
 procedure PutValidationResult (p_externalDocId     IN  VARCHAR2,
                                p_buffer            IN  VARCHAR2,
                                p_sign              IN  VARCHAR2,
                                p_ValidationResult  IN VARCHAR2)
 is

 begin
    begin
     insert into gerc_signs (ExternalDocumentId, Buffer, DigitalSignature, ValidationStatus)
     values (p_externalDocId, p_buffer, p_sign, p_ValidationResult);
    end;
 end PutValidationResult;

PROCEDURE doc_visa (p_ref      IN oper.REF%TYPE,
                    p_idoper   IN VARCHAR2,
                    p_sign     IN oper.SIGN%TYPE)
IS
 grp_   number :=18;
 chk_   VARCHAR2(80);
 hex_   VARCHAR2(6);
 msg_   varchar2(4000);
 pos_   int := 0;
 begin
  bars_audit.info('gerc_payments.doc_visa: start with params  p_ref => '||p_ref ||', p_idoper = ' || p_idoper || ', p_sign => '|| p_sign);
     BEGIN  -- Clear document

         SAVEPOINT chk_pay_before;
         hex_:=chk.put_stmp(grp_);

         bars_audit.info('gerc_payments.doc_visa:hex_ '|| hex_);

         UPDATE oper SET chk=RTRIM(NVL(chk,''))||hex_ WHERE ref = p_ref
             RETURNING chk INTO chk_;
         bars_audit.info('gerc_payments.doc_visa:chk_ '|| chk_);
         INSERT INTO oper_visa (ref, dat, userid, groupid, status, sign)
               VALUES (p_ref, sysdate, gl.aUID, grp_,    1, p_sign);
         update oper set id_o = substr(p_idoper,3,6),
                         sign = p_sign,
                         ref_a = p_ref
          where ref = p_ref
            and ( id_o is null or
                  sign is null or
                  ref_a is null);

     EXCEPTION
         WHEN OTHERS THEN ROLLBACK TO chk_pay_before;

         msg_ := SUBSTR(SQLERRM,13,100);
         pos_ := INSTR(msg_,CHR(10));

         IF pos_ > 0 THEN
            msg_ := SUBSTR(msg_,1,pos_-1);
         END IF;

         bars_audit.info('gerc_payments.doc_visa:msg_ '|| msg_ || ', pos_ = ' || pos_ );
     END;
 end doc_visa;

PROCEDURE SearchClient (p_in_RNK            IN     NUMBER DEFAULT NULL,
                        p_in_OKPO           IN     VARCHAR2 DEFAULT NULL,
                        p_in_NMK            IN     VARCHAR2 DEFAULT NULL,
                        p_in_CUSTTYPE       IN     NUMBER DEFAULT null,
                        p_in_passtype       IN     NUMBER DEFAULT NULL,
                        p_in_SER            IN     VARCHAR2 DEFAULT NULL,
                        p_in_NUMDOC         IN     VARCHAR2 DEFAULT NULL,
                        p_RNK                  OUT NUMBER,
                        p_OKPO                 OUT VARCHAR2,
                        p_NMK                  OUT VARCHAR2,
                        p_PCUSTTYPE            OUT NUMBER,
                        p_COUNTRY              OUT NUMBER,
                        p_NMKV                 OUT VARCHAR2,
                        p_NMKK                 OUT VARCHAR2,
                        p_CODCAGENT            OUT NUMBER,
                        p_PRINSIDER            OUT NUMBER,
                        p_ADR                  OUT VARCHAR2,
                        p_C_REG                OUT NUMBER,
                        p_C_DST                OUT NUMBER,
                        p_ADM                  OUT VARCHAR2,
                        p_DATE_ON              OUT VARCHAR2,
                        p_DATE_OFF             OUT VARCHAR2,
                        p_CRISK                OUT NUMBER,
                        p_ND                   OUT VARCHAR2,
                        p_ISE                  OUT VARCHAR2,
                        p_FS                   OUT VARCHAR2,
                        p_OE                   OUT VARCHAR2,
                        p_VED                  OUT VARCHAR2,
                        p_SED                  OUT VARCHAR2,
                        p_MB                   OUT VARCHAR2,
                        p_RGADM                OUT VARCHAR2,
                        p_BC                   OUT NUMBER,
                        p_BRANCH               OUT VARCHAR2,
                        p_TOBO                 OUT VARCHAR2,
                        p_K050                 OUT VARCHAR2,
                        p_NREZID_CODE          OUT VARCHAR2,
                        p_SER                  OUT VARCHAR2,
                        p_NUMDOC               OUT VARCHAR2,
                        p_OperationResult      OUT INTEGER,
                        p_ErrorMessage         OUT VARCHAR2)
is
 title          constant varchar2(27) := 'GERC_PAYMENTS.SearchClient:';
 nlchr          constant char(2) := chr(13)||chr(10);
 l_stmt_kl      varchar2(4000)   := '';
 l_stmt_nkl     varchar2(4000)   := '';
 l_clause_kl    varchar2(4000)   := '';
 l_clause_nkl   varchar2(4000)   := '';
 t_cust         t_cursor;
begin
 bars_audit.info(title || ' started.');
 bars_audit.info('gerc_payments.SearchClient(' ||
                ' p_in_RNK      => '    || p_in_RNK         ||
                ',p_in_okpo     => '    || p_in_OKPO        ||
                ',p_in_NMK      => '    || p_in_NMK         ||
                ',p_in_CUSTTYPE => '    || p_in_CUSTTYPE    ||
                ',p_in_passtype => '    || p_in_passtype    ||
                ',p_in_SER      => '    || p_in_SER         ||
                ',p_in_NUMDOC   => '    || p_in_NUMDOC      || ')');

   if p_in_RNK is not null
   then l_clause_kl := nlchr||' AND c.rnk = :p_in_RNK '||nlchr;
   else l_clause_kl := nlchr||' AND (:p_in_RNK is null or 1=1)'||nlchr;
   end if;

   l_clause_kl := l_clause_kl || ' AND CUSTTYPE = :p_in_CUSTTYPE' || nlchr;

   if p_in_okpo is not null
   then l_clause_kl := l_clause_kl || ' AND NVL(c.okpo, ''0000000000'') = :p_in_okpo '||nlchr;
   else l_clause_kl := l_clause_kl || ' AND (:p_in_okpo is null or 1=1)'||nlchr;
   end if;
  ------------------------------
   if p_in_RNK is not null
   then l_clause_nkl := nlchr||' AND c.rnk = :p_in_RNK '||nlchr;
   else l_clause_nkl := nlchr||' AND (:p_in_RNK is null or 1=1)'||nlchr;
   end if;

   l_clause_nkl := l_clause_nkl || ' AND CUSTTYPE = :p_in_CUSTTYPE' || nlchr;

   if p_in_okpo is not null
   then l_clause_nkl := l_clause_nkl || ' AND NVL(okpo, ''0000000000'') = :p_in_okpo '||nlchr;
   else l_clause_nkl := l_clause_nkl || ' AND :p_in_okpo is null'||nlchr;
   end if;

   case
    when p_in_CUSTTYPE = 2
    then
       begin

           l_clause_kl := l_clause_kl || ' AND :p_in_passtype is null '   ||nlchr;
           l_clause_kl := l_clause_kl || ' AND :p_in_ser is null'||nlchr;
           l_clause_kl := l_clause_kl || ' AND :p_in_numdoc is null' ||nlchr;

           l_clause_nkl := l_clause_nkl || ' AND :p_in_passtype is null '   ||nlchr;
           l_clause_nkl := l_clause_nkl || ' AND :p_in_ser is null'||nlchr;
           l_clause_nkl := l_clause_nkl || ' AND :p_in_numdoc is null' ||nlchr;
         l_stmt_kl:=
        'SELECT /*+ FIRST_ROWS(10) */
               c.RNK,c.OKPO,c.NMK,c.CUSTTYPE,c.COUNTRY,c.NMKV,c.NMKK,c.CODCAGENT,c.PRINSIDER,c.ADR,c.C_REG,c.C_DST,c.ADM,
               c.DATE_ON,c.DATE_OFF,c.CRISK,c.ND,c.ISE,c.FS,c.OE,c.VED,c.SED,c.MB,c.RGADM,c.BC,c.BRANCH,c.TOBO,c.K050,c.NREZID_CODE, NULL, NULL
          FROM customer c
         WHERE c.date_off IS NULL ';

        l_stmt_nkl :=
        ' SELECT /*+FIRST_ROWS(10) */
                ID RNK,
                OKPO,
                name NMK,
                CUSTTYPE,
                COUNTRY,
                null NMKV,
                null NMKK,
                null CODCAGENT,
                null PRINSIDER,
                ADR,
                null C_REG,
                null C_DST,
                null ADM,
                null DATE_ON,
                null DATE_OFF,
                null CRISK,
                null ND,
                ISE,
                FS,
                null OE,
                VED,
                SED,
                null MB,
                null RGADM,
                null BC,
                null BRANCH,
                null TOBO,
                null K050,
                null NREZID_CODE,
                DOC_SERIAL,DOC_NUMBER
           FROM CUSTOMER_EXTERN
          WHERE 1=1 ';
        p_OperationResult := 20;
       end;
    when p_in_CUSTTYPE = 3
    then
       begin
           if p_in_passtype is not null
           then l_clause_kl := l_clause_kl || ' AND s.passp = :p_in_passtype '   ||nlchr;
           else l_clause_kl := l_clause_kl || ' AND :p_in_passtype is null'||nlchr;
           end if;
           if p_in_ser is not null
           then l_clause_kl := l_clause_kl || ' AND p.ser= :p_in_ser '||nlchr;
           else l_clause_kl := l_clause_kl || ' AND :p_in_ser is null'||nlchr;
           end if;
           if p_in_numdoc is not null
           then l_clause_kl := l_clause_kl || ' AND p.numdoc = :p_in_numdoc '||nlchr;
           else l_clause_kl := l_clause_kl || ' AND :p_in_numdoc is null'||nlchr;
           end if;

           if p_in_passtype is not null
           then l_clause_nkl := l_clause_nkl || ' AND DOC_TYPE = :p_in_passtype '   ||nlchr;
           else l_clause_nkl := l_clause_nkl || ' AND :p_in_passtype is null '||nlchr;
           end if;

           if p_in_ser is not null
           then l_clause_nkl := l_clause_nkl || ' AND DOC_SERIAL = :p_in_ser '||nlchr;
           else l_clause_nkl := l_clause_nkl || ' AND :p_in_ser is null'||nlchr;
           end if;

           if p_in_numdoc is not null
           then l_clause_nkl := l_clause_nkl || ' AND DOC_NUMBER= :p_in_numdoc '||nlchr;
           else l_clause_nkl := l_clause_nkl || ' AND :p_in_numdoc is null  '||nlchr;
           end if;

         l_stmt_kl:=
        'SELECT /*+ FIRST_ROWS(10) */
               c.RNK,c.OKPO,c.NMK,c.CUSTTYPE,c.COUNTRY,c.NMKV,c.NMKK,c.CODCAGENT,c.PRINSIDER,c.ADR,c.C_REG,c.C_DST,c.ADM,
               c.DATE_ON,c.DATE_OFF,c.CRISK,c.ND,c.ISE,c.FS,c.OE,c.VED,c.SED,c.MB,c.RGADM,c.BC,c.BRANCH,c.TOBO,c.K050,c.NREZID_CODE, P.SER, P.NUMDOC
          FROM customer c, person p, passp s
         WHERE c.rnk   = p.rnk
           AND p.passp = s.passp
           AND c.date_off IS NULL ';

        l_stmt_nkl :=
        'SELECT /*+FIRST_ROWS(10) */
                ID RNK,
                OKPO,
                name NMK,
                CUSTTYPE,
                COUNTRY,
                null NMKV,
                null NMKK,
                null CODCAGENT,
                null PRINSIDER,
                ADR,
                null C_REG,
                null C_DST,
                null ADM,
                null DATE_ON,
                null DATE_OFF,
                null CRISK,
                null ND,
                ISE,
                FS,
                null OE,
                VED,
                SED,
                null MB,
                null RGADM,
                null BC,
                null BRANCH,
                null TOBO,
                null K050,
                null NREZID_CODE,
                DOC_SERIAL,DOC_NUMBER
           FROM CUSTOMER_EXTERN
          WHERE 1=1 ';
        p_OperationResult := 30;
       end;

    else p_OperationResult := -1;
         p_ErrorMessage    := '��� �볺��� '|| to_char(p_in_CUSTTYPE) || ' �� ������� ������� ��� ������ (2 ��, 3 ��)';
         bars_audit.error(title || p_ErrorMessage);
         return;
   end case;
   --bars_audit.info(p_in_NMK||','|| p_in_CUSTTYPE||','|| p_in_passtype||','|| p_in_okpo||','|| p_in_ser||','||p_in_numdoc);
   l_stmt_kl  := l_stmt_kl  || l_clause_kl;
   l_stmt_nkl := l_stmt_nkl || l_clause_nkl;
   bars_audit.info(l_stmt_kl);
   bars_audit.info(l_stmt_nkl);
   OPEN t_cust FOR l_stmt_kl using p_in_rnk, p_in_CUSTTYPE, p_in_okpo,p_in_passtype,p_in_ser,p_in_numdoc;

   begin

    fetch t_cust into p_rnk,p_okpo,p_nmk,p_PCUSTTYPE,p_COUNTRY,p_NMKV,p_NMKK,p_CODCAGENT,p_PRINSIDER,
                      p_ADR,p_C_REG,p_C_DST,p_ADM,p_DATE_ON,p_DATE_OFF,p_CRISK,p_ND,p_ISE,p_FS,p_OE,
                      p_VED,p_SED,p_MB,p_RGADM,p_BC,p_BRANCH,p_TOBO,p_K050,p_NREZID_CODE,p_SER,p_NUMDOC;
    if p_rnk is null
    then
      bars_audit.info(title || ' �� ������ ����� �������� �����');
      close t_cust;
        OPEN t_cust FOR l_stmt_nkl using p_in_rnk, p_in_CUSTTYPE, p_in_okpo,p_in_passtype,p_in_ser,p_in_numdoc;

          fetch t_cust into p_rnk,p_okpo,p_nmk,p_PCUSTTYPE,p_COUNTRY,p_NMKV,p_NMKK,p_CODCAGENT,p_PRINSIDER,
                            p_ADR,p_C_REG,p_C_DST,p_ADM,p_DATE_ON,p_DATE_OFF,p_CRISK,p_ND,p_ISE,p_FS,p_OE,
                            p_VED,p_SED,p_MB,p_RGADM,p_BC,p_BRANCH,p_TOBO,p_K050,p_NREZID_CODE,p_SER,p_NUMDOC;

        if p_rnk is null -- �� ������ ����� ����������
        then
            bars_audit.info(title || ' �� ������ ����� ���������� �����');
            p_OperationResult := -1;
            p_ErrorMessage    := '�볺��� � ��������� ���������� �� ��������';
        else                    -- ������ ����� ����������
            bars_audit.info(title || ' ������ ����� ����������');
        end if;
    else p_OperationResult := p_OperationResult + 1;
    end if;
   end;

   if p_rnk is null
   then
    p_OperationResult := -1;
    p_ErrorMessage    := '�볺��� � ��������� ���������� �� ��������';
   end if;

   close t_cust;

   bars_audit.info('gerc_payments.SearchClient('        ||
                   ' p_RNK =>'          || p_rnk        ||
                   ',p_OKPO => '        || p_OKPO       ||
                   ',p_NMK => '         || p_NMK        ||
                   ',p_PCUSTTYPE => '   || p_PCUSTTYPE  ||
                   ',p_COUNTRY => '     || p_COUNTRY    ||
                   ',p_NMKV => '        || p_NMKV       ||
                   ',p_NMKK => '        || p_NMKK       ||
                   ',p_CODCAGENT => '   || p_CODCAGENT  ||
                   ',p_PRINSIDER => '   || p_PRINSIDER  ||
                   ',p_ADDR => '        || p_ADR        ||
                   ',p_C_REG => '       || p_C_REG      ||
                   ',p_C_DST => '       || p_C_DST      ||
                   ',p_ADM => '         || p_ADM        ||
                   ',p_DATE_ON => '     || p_DATE_ON    ||
                   ',p_DATE_OFF => '    || p_DATE_OFF   ||
                   ',p_CRISK => '       || p_CRISK      ||
                   ',p_ND => '          || p_ND         ||
                   ',p_ISE => '         || p_ISE        ||
                   ',p_FS => '          || p_FS         ||
                   ',p_OE => '          || p_OE         ||
                   ',p_VED => '         || p_VED        ||
                   ',p_SED => '         || p_SED        ||
                   ',p_MB => '          || p_MB         ||
                   ',p_RGADM => '       || p_RGADM      ||
                   ',p_BC => '          || p_BC         ||
                   ',p_BRANCH => '      || p_BRANCH     ||
                   ',p_TOBO => '        || p_TOBO       ||
                   ',p_K050 => '        || p_K050       ||
                   ',p_NREZID_CODE => ' || p_NREZID_CODE||
                   ',p_SER => '         || p_SER        ||
                   ',p_NUMDOC => '      || p_NUMDOC     ||
                   ',p_OperationResult=>'||p_OperationResult||
                   ',p_ErrorMessage => ' || p_ErrorMessage);
 bars_audit.info(title || ' finished');
end;

PROCEDURE RegisterRefreshNonClient (p_isnew             IN     INTEGER DEFAULT 0,
                                    p_in_RNK            IN     NUMBER DEFAULT NULL,
                                    p_in_OKPO           IN     VARCHAR2 DEFAULT NULL,
                                    p_in_NMK            IN     VARCHAR2 DEFAULT NULL,
                                    p_in_CUSTTYPE       IN     NUMBER DEFAULT null,
                                    p_in_passtype       IN     NUMBER DEFAULT NULL,
                                    p_in_SER            IN     VARCHAR2 DEFAULT NULL,
                                    p_in_NUMDOC         IN     VARCHAR2 DEFAULT NULL,
                                    p_RNK               IN OUT NUMBER,
                                    p_OKPO              IN OUT VARCHAR2,
                                    p_NMK               IN OUT VARCHAR2,
                                    p_CUSTTYPE          IN OUT NUMBER,
                                    p_COUNTRY           IN OUT NUMBER,
                                    p_NMKV              IN OUT VARCHAR2,
                                    p_NMKK              IN OUT VARCHAR2,
                                    p_CODCAGENT         IN OUT NUMBER,
                                    p_PRINSIDER         IN OUT NUMBER,
                                    p_ADR               IN OUT VARCHAR2,
                                    p_C_REG             IN OUT NUMBER,
                                    p_C_DST             IN OUT NUMBER,
                                    p_ADM               IN OUT VARCHAR2,
                                    p_DATE_ON           IN OUT VARCHAR2,
                                    p_DATE_OFF          IN OUT VARCHAR2,
                                    p_CRISK             IN OUT NUMBER,
                                    p_ND                IN OUT VARCHAR2,
                                    p_ISE               IN OUT VARCHAR2,
                                    p_FS                IN OUT VARCHAR2,
                                    p_OE                IN OUT VARCHAR2,
                                    p_VED               IN OUT VARCHAR2,
                                    p_SED               IN OUT VARCHAR2,
                                    p_MB                IN OUT VARCHAR2,
                                    p_RGADM             IN OUT VARCHAR2,
                                    p_BC                IN OUT NUMBER,
                                    p_BRANCH            IN OUT VARCHAR2,
                                    p_TOBO              IN OUT VARCHAR2,
                                    p_K050              IN OUT VARCHAR2,
                                    p_NREZID_CODE       IN OUT VARCHAR2,
                                    p_SER               IN OUT VARCHAR2,
                                    p_NUMDOC            IN OUT VARCHAR2,
                                    p_OperationResult   IN OUT INTEGER,
                                    p_ErrorMessage      IN OUT VARCHAR2)
is
 title constant varchar2(40) := 'GERC_PAYMENTS.RegisterRefreshNonClient:';
 l_CUSTTYPE    number;
 l_COUNTRY      number;
 l_OperationResult number;
 l_ErrorMessage varchar2(4000);
 l_ADR          varchar2(300);
 l_NMK          varchar2(300);
 l_DATE_ON      varchar2(10);
 l_ISE          varchar2(10);
 l_FS           varchar2(10);
 l_VED          varchar2(10);
 L_sed          VARCHAR2(10);
begin
 bars_audit.info(title || ' started');
 SearchClient (p_in_RNK,
               p_in_OKPO,
               p_in_NMK,
               p_in_CUSTTYPE,
               p_in_passtype,
               p_in_SER,
               p_in_NUMDOC,
               p_RNK,
               p_OKPO,
               l_NMK,
               l_CUSTTYPE,
               l_COUNTRY,
               p_NMKV,
               p_NMKK,
               p_CODCAGENT,
               p_PRINSIDER,
               l_ADR,
               p_C_REG,
               p_C_DST,
               p_ADM,
               l_DATE_ON,
               p_DATE_OFF,
               p_CRISK,
               p_ND ,
               l_ISE,
               l_FS,
               p_OE ,
               l_VED,
               l_SED ,
               p_MB,
               p_RGADM,
               p_BC ,
               p_BRANCH,
               p_TOBO,
               p_K050,
               p_NREZID_CODE,
               p_SER,
               p_NUMDOC,
               p_OperationResult,
               p_ErrorMessage);
  bars_audit.info(title || ' finished.');
  p_ErrorMessage := '';
  if p_OperationResult in (21,31)
  then
   bars_audit.info(title|| '�볺�� �������� � ������ �������� ����� RNK ='|| p_rnk);
  elsif p_OperationResult in (20,30,-1)
  then
    if p_RNK is not null
    then p_OperationResult := to_number(p_OperationResult || '1'); -- �������� �� ������
         bars_audit.info(title|| '��������� ��-������� RNK ='|| p_rnk);
    else p_OperationResult := to_number(p_in_CUSTTYPE || '02'); -- ������ �� ������ ;
         bars_audit.info(title|| '������������ ��-������� RNK ='|| p_rnk);
    end if;

    begin
       kl.setCustomerExtern(  p_id        => p_RNK,
                              p_name      => p_in_NMK,
                              p_doctype   => p_in_passtype,
                              p_docserial => p_in_SER,
                              p_docnumber => p_in_NUMDOC,
                              p_docdate   => null,
                              p_docissuer => null,
                              p_birthday  => null,
                              p_birthplace=> null,
                              p_sex       => '0',
                              p_adr       => p_ADR,
                              p_tel       => null,
                              p_email     => null,
                              p_custtype  => p_IN_CUSTTYPE,
                              p_okpo      => p_IN_OKPO,
                              p_country   => p_COUNTRY,
                              p_region    => null,
                              p_fs        => p_FS,
                              p_ved       => p_VED,
                              p_sed       => p_SED,
                              p_ise       => p_ISE,
                              p_notes     => 'GERC');
                              bars_audit.info(title|| '��������/��������������� ��-������ RNK ='|| p_rnk);
    exception when others then p_OperationResult := -1* p_OperationResult; p_ErrorMessage := sqlerrm;
    bars_audit.info(title || p_ErrorMessage);
    end;

    SearchClient (p_in_RNK,
               p_in_OKPO,
               p_in_NMK,
               p_in_CUSTTYPE,
               p_in_passtype,
               p_in_SER,
               p_in_NUMDOC,
               p_RNK,
               p_OKPO,
               p_NMK,
               p_CUSTTYPE,
               p_COUNTRY,
               p_NMKV,
               p_NMKK,
               p_CODCAGENT,
               p_PRINSIDER,
               p_ADR,
               p_C_REG,
               p_C_DST,
               p_ADM,
               p_DATE_ON,
               p_DATE_OFF,
               p_CRISK,
               p_ND ,
               p_ISE,
               p_FS,
               p_OE ,
               p_VED,
               p_SED ,
               p_MB,
               p_RGADM,
               p_BC ,
               p_BRANCH,
               p_TOBO,
               p_K050,
               p_NREZID_CODE,
               p_SER,
               p_NUMDOC,
               l_OperationResult,
               l_ErrorMessage);
  end if;
  exception when others then  p_ErrorMessage := sqlerrm;
end;

END GERC_PAYMENTS;
/
 show err;
 
PROMPT *** Create  grants  GERC_PAYMENTS ***
grant EXECUTE                                                                on GERC_PAYMENTS   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/gerc_payments.sql =========*** End *
 PROMPT ===================================================================================== 
 