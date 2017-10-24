
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/val_service.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.VAL_SERVICE is
----
--  Package BARS_SMS_SMPP - пакет процедур дл€ отправки SMS по SMPP протокол
--                              (транспортный уровень)
--
-- MOS, 31/07/2013
--

g_header_version  constant varchar2(64)  := 'version 1.06 06.02.2015';

g_awk_header_defs constant varchar2(512) := '';

g_transfer_timeout constant number := 30;

---
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

---
-- ¬озвращает параметр из web_config
--
function get_param_webconfig (par varchar2) return web_barsconfig.val%type;

----
-- вызов
--
function invoke (p_req in out nocopy soap_rpc.t_request) return soap_rpc.t_response;

function get_eq  (vidd  number  ,
                  ser   varchar2,
                  num   varchar2,
                  datb  date    ,
                  kv    number  ,
                  kurs  varchar2,
                  s     number,
				  fio   varchar2,
				  drday varchar2,
				  tt    varchar2) return varchar2;


procedure set_eq (vdat_     date    ,
                  datb_     date    ,
                  pdat_     date,
                  vidd_     number  ,
                  serd_     varchar2,
                  pasp_     varchar2,
                  fio_      varchar2,
                  sq_       number  ,
                  kv_       number  ,
                  s_        number  ,
                  ref_      varchar2,
                  branch_   varchar2,
                  kurs_     varchar2,
                  kuro_     varchar2,
                  tt_       varchar2,
				  drday_    varchar2,
                  ret_ out  varchar2);

procedure del_eq (ref_      number,
                  branch_   varchar2);
procedure set_val;

procedure ping (  service_id  varchar2,
                  abonent_id  varchar2,
                  ret_   out  varchar2);


end val_service;
/
CREATE OR REPLACE PACKAGE BODY BARS.VAL_SERVICE 
IS
 --
 -- MOS 02/10/2013
 --

 g_body_version CONSTANT VARCHAR2 (64) := 'version 1.19 07.10.2016';
 g_awk_body_defs CONSTANT VARCHAR2 (512) := '';
 g_cur_rep_id NUMBER := -1;
 g_cur_block_id NUMBER := -1;
 G_ERRMOD CONSTANT VARCHAR2 (3) := 'BCK';
 g_is_error BOOLEAN := FALSE;
 G_XMLHEAD CONSTANT VARCHAR2 (100)
 := '<?xml version="1.0" encoding="utf-8"?>' ;


 --
 -- header_version - возвращает версию заголовка пакета
 --
 FUNCTION header_version
 RETURN VARCHAR2
 IS
 BEGIN
 RETURN 'Package header val_service '
 || g_header_version
 || '.'
 || CHR (10)
 || 'AWK definition: '
 || CHR (10)
 || g_awk_header_defs;
 END header_version;


 --
 -- body_version - возвращает версию тела пакета
 --
 FUNCTION body_version
 RETURN VARCHAR2
 IS
 BEGIN
 RETURN 'Package body BARS.val_service '
 || g_body_version
 || '.'
 || CHR (10)
 || 'AWK definition: '
 || CHR (10)
 || g_awk_body_defs;
 END body_version;


 --
 FUNCTION EXTRACT (p_xml IN XMLTYPE,
 p_xpath IN VARCHAR2,
 p_mandatory IN NUMBER)
 RETURN VARCHAR2
 IS
   BEGIN
      BEGIN
         RETURN p_xml.EXTRACT (p_xpath).getStringVal ();
      EXCEPTION
         WHEN OTHERS
         THEN
            IF p_mandatory IS NULL OR g_is_error
            THEN
               RETURN NULL;
            ELSE
               IF SQLCODE = -30625
               THEN
                  bars_error.raise_nerror (g_errmod,
                                           'XMLTAG_NOT_FOUND',
                                           p_xpath,
                                           g_cur_block_id,
                                           g_cur_rep_id);
               ELSE
                  RAISE;
               END IF;
            END IF;
      END;
   END;


   --
   -- ¬озвращает параметр из web_config
   --
   FUNCTION get_param_webconfig (par VARCHAR2)
      RETURN web_barsconfig.val%TYPE
   IS
      l_res   web_barsconfig.val%TYPE;
   BEGIN
      SELECT val
        INTO l_res
        FROM web_barsconfig
       WHERE key = par;

      RETURN TRIM (l_res);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error (
            -20000,
               'Ќе найден KEY='
            || par




            || ' в таблице web_barsconfig!');
   END;


   --
   PROCEDURE generate_envelope (p_req   IN OUT NOCOPY soap_rpc.t_request,
                                p_env   IN OUT NOCOPY VARCHAR2)
   AS
   BEGIN
      p_env :=
            G_XMLHEAD
         || '<soap:Envelope '
         || 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '
         || 'xmlns:xsd="http://www.w3.org/2001/XMLSchema" '
         || 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
         || '<soap:Body>'
         || '<'
         || p_req.method
         || ' xmlns="'
         || p_req.namespace
         || '">'
         || p_req.body
         || '</'
         || p_req.method
         || '>'
         || '</soap:Body>'
         || '</soap:Envelope>';
   END;


   --
   -- получает строку с ошибкой и генерирует исключение
   --
   PROCEDURE check_fault (p_resp IN OUT NOCOPY soap_rpc.t_response)
   AS
      l_fault_node     XMLTYPE;
      l_fault_code     VARCHAR2 (256);
      l_fault_string   VARCHAR2 (32767);
   BEGIN
      l_fault_node :=
         p_resp.doc.EXTRACT (
            '/soap:Fault',
            'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/');

      IF (l_fault_node IS NOT NULL)
      THEN
         l_fault_code :=
            l_fault_node.EXTRACT (
               '/soap:Fault/faultcode/child::text()',
               'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/').getstringval ();
         l_fault_string :=
            l_fault_node.EXTRACT (
               '/soap:Fault/faultstring/child::text()',
               'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/').getstringval ();
         raise_application_error (-20000,
                                  l_fault_code || ' - ' || l_fault_string);
      END IF;
   END;


   --
   FUNCTION invoke (p_req IN OUT NOCOPY soap_rpc.t_request)
      RETURN soap_rpc.t_response
   AS
      l_env         VARCHAR2 (32767);
      l_line        VARCHAR2 (32767);
      l_res         CLOB;
      l_http_req    UTL_HTTP.req;
      l_http_resp   UTL_HTTP.resp;
      l_resp        soap_rpc.t_response;
   BEGIN
      generate_envelope (p_req, l_env);

      --bars_audit.info('val_service1');

      --SSL соединение выполн€ем через wallet
      IF INSTR (LOWER (p_req.url), 'https://') > 0
      THEN
         UTL_HTTP.set_wallet (p_req.wallet_dir, p_req.wallet_pass);
      END IF;

      --bars_audit.info('val_service2');

      BEGIN
         l_http_req := UTL_HTTP.begin_request (p_req.url, 'POST', 'HTTP/1.0');
      EXCEPTION
         WHEN OTHERS
         THEN
            IF SQLCODE = -29273 OR SQLCODE = -20097 OR SQLCODE = -20000
            THEN
               IF SQLCODE = -29273
               THEN
                  bars_error.raise_nerror ('BRS', 'TRANSFER_TIMEOUT');
               ELSIF    SQLCODE = -20097
                     OR (    SQLCODE = -20000
                         AND   INSTR (SQLERRM, 'ORA-1034')
                             + INSTR (SQLERRM, 'ORA-12518') > 0)
               THEN
                  bars_error.raise_nerror ('BRS', 'MISSING_CONNECTION');
               ELSIF SQLCODE = -20000
               THEN
                  bars_error.raise_nerror ('ORA', 'MISSING_CONNECTION_W');
               END IF;
            ELSE
               RAISE;
            END IF;
      END;

      --bars_audit.info('val_service3');
      UTL_HTTP.set_transfer_timeout (l_http_req,
                                     timeout   => g_transfer_timeout);
      --bars_audit.info('val_service4');
      UTL_HTTP.set_body_charset (l_http_req, 'UTF-8');
      --bars_audit.info('val_service5');
      --utl_http.set_header(l_http_req, 'Content-Type',   'application/x-www-form-urlencoded;');
      UTL_HTTP.set_header (l_http_req,
                           'Content-Type',
                           'text/xml; charset=UTF-8');
      --bars_audit.info('val_service6');
      UTL_HTTP.set_header (l_http_req,
                           'Content-Length',
                           LENGTHB (CONVERT (l_env, 'utf8')));
      --bars_audit.info('val_service7');
      UTL_HTTP.set_header (l_http_req,
                           'SOAPAction',
                           p_req.namespace || p_req.method);
      --bars_audit.info('val_service8');
      UTL_HTTP.write_text (l_http_req, l_env);

      --bars_audit.info('val_service9');
      BEGIN
         l_http_resp := UTL_HTTP.get_response (l_http_req);
      --bars_audit.info('val_serviceA');
      EXCEPTION
         WHEN OTHERS
         THEN
            --  bars_audit.error('val_service0: sqlcode='||to_char(sqlcode)||', sqlerrm='||sqlerrm);
            IF SQLCODE = -29273 OR SQLCODE = -20097 OR SQLCODE = -20000
            THEN
               --  if sqlcode=-29273 then
               IF SQLCODE = -29273
               THEN
                  bars_error.raise_nerror ('BRS', 'TRANSFER_TIMEOUT');
               ELSIF    SQLCODE = -20097
                     OR (    SQLCODE = -20000
                         AND   INSTR (SQLERRM, 'ORA-1034')
                             + INSTR (SQLERRM, 'ORA-12518') > 0)
               THEN
                  bars_error.raise_nerror ('BRS', 'MISSING_CONNECTION');
               ELSIF SQLCODE = -20000
               THEN
                  bars_error.raise_nerror ('ORA', 'MISSING_CONNECTION_W');
               END IF;
            ELSE
               RAISE;
            END IF;
      END;

      l_res := NULL;

      BEGIN
         LOOP
            UTL_HTTP.read_text (l_http_resp, l_line);
            l_res := l_res || l_line;
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      UTL_HTTP.end_response (l_http_resp);

      --bars_audit.info('val_serviceB');
      BEGIN
         l_resp.doc := xmltype.createxml (l_res);
      EXCEPTION
         WHEN OTHERS
         THEN
            --  bars_audit.error('val_service1: sqlcode='||to_char(sqlcode)||', sqlerrm='||sqlerrm);
            IF    SQLCODE = -31011
               OR SQLCODE = -20097
               OR (    SQLCODE = -20000
                   AND   INSTR (SQLERRM, 'ORA-1034')
                       + INSTR (SQLERRM, 'ORA-12518') > 0)
            THEN
               bars_error.raise_nerror ('BRS', 'MISSING_CONNECTION');
            ELSIF SQLCODE = -20000
            THEN
               bars_error.raise_nerror ('ORA', 'MISSING_CONNECTION_W');
            ELSE
               RAISE;
            END IF;
      END;

      --bars_audit.info('val_serviceC');
      l_resp.doc :=
         l_resp.doc.EXTRACT (
            '/soap:Envelope/soap:Body/child::node()',
            'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');

      --bars_audit.info('val_serviceD');
      BEGIN
         check_fault (l_resp);
      EXCEPTION
         WHEN OTHERS
         THEN
            --  bars_audit.error('val_service2: sqlcode='||to_char(sqlcode)||', sqlerrm='||sqlerrm);
            IF     SQLCODE = -20000
               AND INSTR (SQLERRM, 'ORA-1034') + INSTR (SQLERRM, 'ORA-12518') >
                      0
            THEN
               bars_error.raise_nerror ('BRS', 'MISSING_CONNECTION');
            --    raise;
            ELSIF SQLCODE = -20000
            THEN
               bars_error.raise_nerror ('ORA', 'MISSING_CONNECTION_W');
            ELSE
               RAISE;
            END IF;
      END;

      --bars_audit.info('val_serviceE');
      RETURN l_resp;
   END;


   --
   FUNCTION get_eq (vidd     NUMBER,
                    ser      VARCHAR2,
                    num      VARCHAR2,
                    datb     DATE,
                    kv       NUMBER,
                    kurs     VARCHAR2,
                    s        NUMBER,
                    fio      VARCHAR2,
                    drday    VARCHAR2,
                    tt       VARCHAR2)
      RETURN VARCHAR2
   IS
      l_request    soap_rpc.t_request;
      l_response   soap_rpc.t_response;
      l_tmp        XMLTYPE;
      l_message    VARCHAR2 (4000);
      l_clob       CLOB;
      l_ret_ping   VARCHAR2 (4000);
   BEGIN
      BEGIN
         --  подготовить реквест
         l_request :=
            soap_rpc.new_request (
               p_url           => get_param_webconfig ('VAL.Url'),
               p_namespace     => 'http://tempuri.org/',
               p_method        => 'Get_eq',
               p_wallet_dir    => get_param_webconfig ('VAL.Wallet_dir'),
               p_wallet_pass   => get_param_webconfig ('VAL.Wallet_pass'));

         --  добавить параметры
         soap_rpc.ADD_PARAMETER (l_request, 'vidd', TO_CHAR (vidd));
         soap_rpc.ADD_PARAMETER (l_request, 'ser', TO_CHAR (ser));
         soap_rpc.ADD_PARAMETER (l_request, 'num', TO_CHAR (num));
         soap_rpc.ADD_PARAMETER (l_request,
                                 'datb',
                                 TO_CHAR (datb, 'dd/mm/yyyy'));
         soap_rpc.ADD_PARAMETER (l_request, 'kv', TO_CHAR (kv));
         soap_rpc.ADD_PARAMETER (l_request, 'kurs', TO_CHAR (kurs));
         soap_rpc.ADD_PARAMETER (l_request, 's', TO_CHAR (s));
         soap_rpc.ADD_PARAMETER (l_request, 'fio', TO_CHAR (fio));
         soap_rpc.ADD_PARAMETER (l_request, 'drday', TO_CHAR (drday));
         soap_rpc.ADD_PARAMETER (l_request, 'tt', TO_CHAR (tt));


         --  позвать метод веб-сервиса
         l_response := invoke (l_request);

         --  ‘икс непри€тности в работе xpath при указанных xmlns
         l_clob := REPLACE (l_response.doc.getClobVal (), 'xmlns', 'mlns');
         l_tmp := xmltype (l_clob);

         l_message :=
            EXTRACT (l_tmp, '/Get_eqResponse/Get_eqResult/text()', NULL);
         ping (service_id   => 'GET_EQ',
               abonent_id   => gl.aMFO,
               ret_         => l_ret_ping);
         bars_audit.trace ('GET_EQ(Ping):' || l_ret_ping);
      END;

      RETURN l_message;
   END get_eq;


   --
   PROCEDURE set_eq (vdat_         DATE,
                     datb_         DATE,
                     pdat_         DATE,
                     vidd_         NUMBER,
                     serd_         VARCHAR2,
                     pasp_         VARCHAR2,
                     fio_          VARCHAR2,
                     sq_           NUMBER,
                     kv_           NUMBER,
                     s_            NUMBER,
                     ref_          VARCHAR2,
                     branch_       VARCHAR2,
                     kurs_         VARCHAR2,
                     kuro_         VARCHAR2,
                     tt_           VARCHAR2,
                     drday_        VARCHAR2,
                     ret_      OUT VARCHAR2)
   IS
      l_request    soap_rpc.t_request;
      l_response   soap_rpc.t_response;
      l_tmp        XMLTYPE;
      l_message    VARCHAR2 (4000);
      l_clob       CLOB;
   BEGIN
      --подготовить реквест
      l_request :=
         soap_rpc.new_request (
            p_url           => get_param_webconfig ('VAL.Url'),
            p_namespace     => 'http://tempuri.org/',
            p_method        => 'Set_eq',
            p_wallet_dir    => get_param_webconfig ('VAL.Wallet_dir'),
            p_wallet_pass   => get_param_webconfig ('VAL.Wallet_pass'));

      --добавить параметры
      soap_rpc.ADD_PARAMETER (l_request,
                              'vdat_',
                              TO_CHAR (vdat_, 'dd/mm/yyyy HH24:MI:SS'));
      soap_rpc.ADD_PARAMETER (l_request,
                              'datb_',
                              TO_CHAR (datb_, 'dd/mm/yyyy'));
      soap_rpc.ADD_PARAMETER (l_request,
                              'pdat_',
                              TO_CHAR (pdat_, 'dd/mm/yyyy HH24:MI:SS'));
      soap_rpc.ADD_PARAMETER (l_request, 'vidd_', TO_CHAR (vidd_));
      soap_rpc.ADD_PARAMETER (l_request, 'serd_', TO_CHAR (serd_));
      soap_rpc.ADD_PARAMETER (l_request, 'pasp_', TO_CHAR (pasp_));
      soap_rpc.ADD_PARAMETER (l_request, 'fio_', TO_CHAR (fio_));
      soap_rpc.ADD_PARAMETER (l_request, 'sq_', TO_CHAR (replace(sq_,',','.')));
      soap_rpc.ADD_PARAMETER (l_request, 'kv_', TO_CHAR (kv_));
      soap_rpc.ADD_PARAMETER (l_request, 's_', TO_CHAR (s_));
      soap_rpc.ADD_PARAMETER (l_request, 'ref_', TO_CHAR (ref_));
      soap_rpc.ADD_PARAMETER (l_request, 'branch_', TO_CHAR (branch_));
      soap_rpc.ADD_PARAMETER (l_request, 'kurs_', TO_CHAR (kurs_));
      soap_rpc.ADD_PARAMETER (l_request, 'kuro_', TO_CHAR (kuro_));
      soap_rpc.ADD_PARAMETER (l_request, 'tt_', TO_CHAR (tt_));
      soap_rpc.ADD_PARAMETER (l_request, 'drday_', TO_CHAR (drday_));

      --позвать метод веб-сервиса
      l_response := invoke (l_request);

      --‘икс непри€тности в работе xpath при указанных xmlns
      l_clob := REPLACE (l_response.doc.getClobVal (), 'xmlns', 'mlns');
      l_tmp := xmltype (l_clob);

      ret_ := EXTRACT (l_tmp, '/Set_eqResponse/Set_eqResult/text()', NULL);
   END;


   --
   PROCEDURE del_eq (ref_ NUMBER, branch_ VARCHAR2)
   IS
      l_request    soap_rpc.t_request;
      l_response   soap_rpc.t_response;
      l_tmp        XMLTYPE;
      l_message    VARCHAR2 (4000);
      l_clob       CLOB;
   BEGIN
      --подготовить реквест
      l_request :=
         soap_rpc.new_request (
            p_url           => get_param_webconfig ('VAL.Url'),
            p_namespace     => 'http://tempuri.org/',
            p_method        => 'Del_eq',
            p_wallet_dir    => get_param_webconfig ('VAL.Wallet_dir'),
            p_wallet_pass   => get_param_webconfig ('VAL.Wallet_pass'));

      --добавить параметры
      soap_rpc.ADD_PARAMETER (l_request, 'ref_', TO_CHAR (ref_));
      soap_rpc.ADD_PARAMETER (l_request, 'branch_', TO_CHAR (branch_));

      --позвать метод веб-сервиса
      l_response := invoke (l_request);

      --‘икс непри€тности в работе xpath при указанных xmlns
      l_clob := REPLACE (l_response.doc.getClobVal (), 'xmlns', 'mlns');
      l_tmp := xmltype (l_clob);

      l_message :=
         EXTRACT (l_tmp,
                  '/Del_eqResponse/Del_eqResult/ErrorMessage/text()',
                  NULL);
   END;

   procedure set_val
   is
      l_sq      number;
      l_vidd    number;
      l_serd    varchar2 (32);
      l_pasp    varchar2 (64);
      l_fio     varchar2 (254);
      l_ret     varchar2 (4000);
      l_limeq   varchar2 (254);
      l_kurs    number (20, 8);
      l_kuro    number (20, 8);
      l_kurb    number (20, 8);
      l_drday   varchar2 (14);
   begin
      for c in (select kf from mv_kf)
      loop
         bc.subst_mfo (c.kf);
         for k
            in (select op.*, (select ov.dat
                                from oper_visa ov
                               where ov.ref = v.ref
                                 and ov.status = 2) datvisa,
                       v.tt vtt,
                       nvl(p.passp,1) vidd,
                       case when nvl(p.passp,1) = 7
                              then ' '
                              else nvl ((select trim (replace(
                                                       replace(
                                                        replace(
                                                         replace(
                                                          replace(
                                                           replace(
                                                            replace(
                                                             replace(
                                                              replace(
                                                               replace(
                                                                        value
                                                                        ,'1'
                                                                      ),'2'
                                                                     ),'3'
                                                                    ),'4'
                                                                   ),'5'
                                                                  ),'6'
                                                                 ),'7'
                                                                ),'8'
                                                               ),'9'
                                                              ),'0'
                                                             ))
                                           from operw
                                          where ref = op.ref and tag = 'PASPN'),'NN')
                       end serial_doc,
                       case when nvl(p.passp,1) = 7
                            then
                              nvl((select trim (translate(value,'1234567890'||value,'1234567890'))
                                     from operw
                                    where ref = op.ref and tag = 'PASPN'),'000000000')
                            else
                              nvl((select trim (translate(value,'1234567890'||value,'1234567890'))
                                     from operw
                                    where ref = op.ref and tag = 'PASPN'),'000000')
                       end number_doc,
                       nvl ( (select value
                                from operw
                               where ref = op.ref and tag = 'FIO  '),
                            'Ќе заповнено')
                          pib,
                       (select to_number (replace (value, ',', '.'),'9999999.9999999')
                          from operw
                         where     ref = op.ref
                               and tag =
                                      case
                                         when op.tt in ('TMP', 'TTI', 'TM8')
                                         then
                                            'MKURS'
                                         else
                                            'KURS '
                                      end)
                          kurs,
                       case when (select sum(s)
                                    from opldok
                                   where ref = v.ref
                                     and tt = v.tt
                                     and dk = 1
                                     and s != sq) is null
                              then (select sum(s)
                                      from opl
                                     where ref = v.ref
                                       and tt = v.tt
                                       and kv = op.kv
                                       and dk = 1)
                              else (select sum (s)
                                      from opldok
                                     where ref = v.ref
                                       and tt = v.tt
                                       and dk = 1
                                       and s != sq)
                       end s_nom,
                       case when (select max(kv)
                                    from opl
                                   where ref = v.ref
                                     and tt = v.tt
                                     and dk = 1
                                     and s != sq) is null
                              then (select max(kv)
                                      from opl
                                     where ref = v.ref
                                       and tt = v.tt
                                       and kv = op.kv
                                       and dk = 1)
                              else (select max(kv) from opl
                                     where     ref = v.ref
                                       and tt = v.tt
                                       and dk = 1
                                       and s != sq)
                       end s_kv,
                       case when (select sum(sq)
                               from opldok
                              where ref = v.ref
                                and tt = v.tt
                                and dk = 1
                                and s != sq) is null
                              then (select sum(sq)
                                      from opl
                                     where ref = v.ref
                                       and tt = v.tt
                                       and kv = op.kv
                                       and dk = 1)
                              else (select sum(sq)
                                      from opldok
                                     where ref = v.ref
                                       and tt = v.tt
                                       and dk = 1
                                       and s != sq)
                       end s_eqv
                  from oper op, val_queue v, operw w, passpv p
                 where v.ref = op.ref
                   and op.kf = c.kf
                   and op.sos=5
                   and op.ref = w.ref(+)
                   and w.tag(+) in ('PASPV', 'PASNR', 'PASP')
                   and w.value = p.name(+))
         loop
            begin
               select value
                 into l_limeq
                 from operw
                where ref = k.ref and tag = 'LIMEQ';
            exception
               when no_data_found
               then
                  l_limeq := null;
            end;

            if l_limeq is null
            then
               begin
                  begin
                     select rate_b / bsum, rate_o / bsum
                       into l_kurb, l_kuro
                       from cur_rates$base
                      where     vdate = trunc(sysdate)
                            and kv = k.s_kv
                            and branch = '/' || f_ourmfo_g || '/';
                  exception
                     when no_data_found
                     then
                        l_kurb := 1;
                        l_kuro := 1;
                  end;

                 if l_kurb is null then
                     l_kurb :=k.s_nom;
                 end if;

                  l_vidd := k.vidd;
                  l_serd := k.serial_doc;
                  l_pasp := k.number_doc;
                  l_fio := k.pib;
                  if k.vtt in  ('TTI') then
                    begin
                        SELECT VALUE
                          INTO l_kurs
                          FROM operw
                         WHERE REF = k.REF AND tag = 'BM__R';
                    exception
                     when no_data_found
                     then
                        l_kurs :=  l_kurb;
                    end;
                  else
                    l_kurs :=  l_kurb;
                  end if;

                  if k.vtt in  ('TMP', 'TTI', 'TM8') then
                    l_sq := k.s2;
                  else
                    l_sq := k.s_nom*l_kurb;
                  end if;
                  l_drday := '01/01/0001';
               end;

               begin

               bars_audit.info('VAL_SERVICE l_vidd = '||l_vidd||
                ' l_serd = '||l_serd||
                ' l_pasp = '||l_pasp||
                ' l_fio = '||l_fio||
                ' l_drday = '||l_drday||
                ' ref = '||to_char (k.ref)||
                ' l_sq = '||l_sq||
                ' l_kurs = '||l_kurs||
                ' l_kuro = '||l_kuro||
                ' l_kurb = '||l_kurb||
                ' s_nom = '||k.s_nom||
                ' l_limeq = '||l_limeq);
                  val_service.set_eq (k.datvisa,            --vdat_    varchar2,
                                      k.bdat,           --datb_    varchar2,
                                      k.pdat,                          --pdat_
                                      nvl(l_vidd,1),             --vidd_    number  ,
                                      nvl(l_serd,'00'),             --serd_    varchar2,
                                      nvl(l_pasp,'000000'),             --pasp_    varchar2,
                                      nvl(l_fio,' '),              --fio_     varchar2,
                                      l_sq,               --sq_      number  ,
                                      k.s_kv,             --kv_      number  ,
                                      k.s_nom,            --s_       number  ,
                                      to_char (k.ref),    --ref_     varchar2,
                                      k.branch,           --branch_  varchar2,
                                      to_char (l_kurs),   --kurs_    number  ,
                                      to_char (l_kuro),   --kuro_    number  ,
                                      to_char (k.vtt),
                                      nvl(l_drday,'01/01/0001'),
                                      l_ret);             --ret_ out varchar2)

                  if l_ret is not null
                  then
                     bars_error.raise_nerror ('BRS', 'NOT_PAY_150', l_ret);
                  else
                     begin
                        insert into operw (ref, tag, value)
                             values (k.ref, 'LIMEQ', to_char (l_sq));
                     exception
                        when dup_val_on_index
                        then
                           null;
                     end;
                  end if;
               exception
                  when others
                  then
                     if instr (
                           sqlerrm,
                           'ORA-00001: unique constraint (BARS.PK_LIMDAT) violated') >
                           0
                     then
                        null;
                     else
                        raise;
                     end if;
               end;
            end if;

            delete from val_queue
                  where ref = k.ref and tt = k.vtt;
            commit;
         end loop;
      end loop;
   end set_val;

   PROCEDURE ping (service_id       VARCHAR2,
                   abonent_id       VARCHAR2,
                   ret_         OUT VARCHAR2)
   IS
      l_request    soap_rpc.t_request;
      l_response   soap_rpc.t_response;
      l_tmp        XMLTYPE;
      l_message    VARCHAR2 (4000);
      l_clob       CLOB;
   BEGIN
      --подготовить реквест
      l_request :=
         soap_rpc.new_request (
            p_url           => get_param_webconfig ('VAL.Url'),
            p_namespace     => 'http://tempuri.org/',
            p_method        => 'Ping',
            p_wallet_dir    => get_param_webconfig ('VAL.Wallet_dir'),
            p_wallet_pass   => get_param_webconfig ('VAL.Wallet_pass'));

      --добавить параметры
      soap_rpc.ADD_PARAMETER (l_request, 'service_id', TO_CHAR (service_id));
      soap_rpc.ADD_PARAMETER (l_request, 'abonent_id', TO_CHAR (abonent_id));

      --позвать метод веб-сервиса
      l_response := invoke (l_request);

      --‘икс непри€тности в работе xpath при указанных xmlns
      l_clob := REPLACE (l_response.doc.getClobVal (), 'xmlns', 'mlns');
      l_tmp := xmltype (l_clob);

      ret_ := EXTRACT (l_tmp, '/PingResponse/PingResult/text()', NULL);
   END;
END val_service;
/
 show err;
 
PROMPT *** Create  grants  VAL_SERVICE ***
grant EXECUTE                                                                on VAL_SERVICE     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/val_service.sql =========*** End ***
 PROMPT ===================================================================================== 
 