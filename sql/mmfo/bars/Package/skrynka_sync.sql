
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/skrynka_sync.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SKRYNKA_SYNC is

  -- Author  :a_yurchenko
  -- Created : 01/04/2015
  -- Purpose :

  g_header_version constant varchar2(64) := 'version 1.1 18/06/2015';

  g_awk_header_defs constant varchar2(512) := '';

  g_transfer_timeout constant number := 1000;

  /*
  * header_version - версія заголовку документа
  */
  function header_version return varchar2;

  /*
  * body_version - версія тілу пакета
  */
  function body_version return varchar2;

  /*
  * get_param_webconfig - Отримання параметрів із  web_config
  */
  function get_param_webconfig(par varchar2) return web_barsconfig.val%type;


--додає договір ячейки з регіона(заглушка)

PROCEDURE add_nd (p_o_sk          IN SKRYNKA_ND_BRANCH.O_SK%TYPE,
                  p_branch        IN SKRYNKA_ND_BRANCH.BRANCH%TYPE,
                  p_nd            IN SKRYNKA_ND_BRANCH.ND%TYPE,
                  p_open_date     IN varchar2,--SKRYNKA_ND_BRANCH.OPEN_DATE%TYPE,
                  p_close_date    IN varchar2,
                  p_renter_name   IN SKRYNKA_ND_BRANCH.renter_name%TYPE,
                  p_sos           IN SKRYNKA_ND_BRANCH.sos%TYPE);

 procedure add_type (p_o_sk in SKRYNKA_TIP_BRANCH.O_SK%type, p_branch in SKRYNKA_TIP_BRANCH.BRANCH%type, p_name in SKRYNKA_TIP_BRANCH.NAME%type
  , p_etalon_id in SKRYNKA_TIP_BRANCH.ETALON_ID%type, p_cell_count in SKRYNKA_TIP_BRANCH.CELL_COUNT%type );
 procedure send_msg (p_sync_id in SKRYNKA_sync_queue.id%type );

 procedure sync_queue ;
end skrynka_sync;
/
CREATE OR REPLACE PACKAGE BODY BARS.SKRYNKA_SYNC 
IS
   g_body_version    CONSTANT VARCHAR2 (64) := 'version 1.0.1 18/06/2015';
   g_awk_body_defs   CONSTANT VARCHAR2 (512) := '';
   g_cur_rep_id               NUMBER := -1;
   g_cur_block_id             NUMBER := -1;
   G_ERRMOD          CONSTANT VARCHAR2 (3) := 'SKR';
   g_is_error                 BOOLEAN := FALSE;
   G_XMLHEAD         CONSTANT VARCHAR2 (100)
                                 := '<?xml version="1.0" encoding="utf-8"?>' ;

   /*
    * header_version - возвращает версию заголовка пакета
    */
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package header lcs_pack__service '
             || g_header_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_header_defs;
   END header_version;

   /*
    * body_version - возвращает версию тела пакета
    */
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package body lcs_pack_service '
             || g_body_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_body_defs;
   END body_version;

   FUNCTION EXTRACT (p_xml         IN XMLTYPE,
                     p_xpath       IN VARCHAR2,
                     p_mandatory   IN NUMBER)
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


   FUNCTION g_wsproxy_url
      RETURN VARCHAR2
   IS
      l_wsproxy_url   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_url
        FROM web_barsconfig b
       WHERE b.key = 'Skrynka.Url';

      RETURN l_wsproxy_url;
   END g_wsproxy_url;

   FUNCTION g_wsproxy_walletdir
      RETURN VARCHAR2
   IS
      l_wsproxy_walletdir   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_walletdir
        FROM web_barsconfig b
       WHERE b.key = 'Skrynka.WalletDir';

      RETURN l_wsproxy_walletdir;
   END g_wsproxy_walletdir;

   FUNCTION g_wsproxy_walletpass
      RETURN VARCHAR2
   IS
      l_wsproxy_walletpass   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_walletpass
        FROM web_barsconfig b
       WHERE b.key = 'Skrynka.WalletPass';

      RETURN l_wsproxy_walletpass;
   END g_wsproxy_walletpass;

   FUNCTION g_wsproxy_ns
      RETURN VARCHAR2
   IS
      l_wsproxy_ns   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_ns
        FROM web_barsconfig b
       WHERE b.key = 'Skrynka.NS';

      RETURN l_wsproxy_ns;
   END g_wsproxy_ns;

   FUNCTION g_wsproxy_username
      RETURN VARCHAR2
   IS
      l_wsproxy_username   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_username
        FROM web_barsconfig b
       WHERE b.key = 'Skrynka.UserName';

      RETURN l_wsproxy_username;
   END g_wsproxy_username;

   FUNCTION g_wsproxy_password
      RETURN VARCHAR2
   IS
      l_wsproxy_password   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_password
        FROM web_barsconfig b
       WHERE b.key = 'Skrynka.Password';

      RETURN l_wsproxy_password;
   END g_wsproxy_password;


   /*
    * Возвращает параметр из web_config
    */
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
               'Не найден KEY='
            || par

            || ' в таблице web_barsconfig!');
   END;


   FUNCTION encode_to_base (par VARCHAR2)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN UTL_ENCODE.text_encode (par, encoding => UTL_ENCODE.base64);
   END;

  FUNCTION encode_from_base (par VARCHAR2)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN  UTL_ENCODE.TEXT_DECODE(par, encoding => UTL_ENCODE.base64);
   END;

   -- Отправить сообщение на веб-сервис (тип ячейки)
   PROCEDURE send_type (p_sync_id IN SKRYNKA_sync_queue.id%TYPE)
   IS
      l_o_sk         SKRYNKA_TIP.O_SK%TYPE;
      l_branch       SKRYNKA_TIP.BRANCH%TYPE;
      l_name         SKRYNKA_TIP.NAME%TYPE;
      l_etalon_id    SKRYNKA_TIP.ETALON_ID%TYPE;
      l_cell_count   SKRYNKA_TIP.CELL_COUNT%TYPE;
   BEGIN
      -- ставим статус "Обробка"
      UPDATE SKRYNKA_sync_queue sq
         SET sq.msg_status = 'PROC', SQ.ERR_TEXT = NULL
       WHERE sq.id = p_sync_id;

      COMMIT;

      SELECT t2.o_sk,
             t2.branch,
             t2.name,
             t2.etalon_id,
             t2.cell_count
        INTO l_o_sk,
             l_branch,
             l_name,
             l_etalon_id,
             l_cell_count
        FROM SKRYNKA_sync_queue t1, skrynka_tip t2
       WHERE T1.OBJ_ID = T2.O_SK AND T1.ID = p_sync_id;

      -- вызов метода прокси-сервиса
      DECLARE
         l_err_text   VARCHAR2 (4000);

         l_request    soap_rpc.t_request;
         l_response   soap_rpc.t_response;
      BEGIN
         -- подготовить реквест
         l_request :=
            soap_rpc.new_request (p_url           => g_wsproxy_url,
                                  p_namespace     => g_wsproxy_ns,
                                  p_method        => 'AddType',
                                  p_wallet_dir    => g_wsproxy_walletdir,
                                  p_wallet_pass   => g_wsproxy_walletpass);
         -- добавить параметры
         soap_rpc.ADD_PARAMETER (l_request, 'UserName', g_wsproxy_username);
         soap_rpc.ADD_PARAMETER (l_request, 'Password', g_wsproxy_password);
         soap_rpc.ADD_PARAMETER (l_request, 'O_SK', TO_CHAR (l_o_sk));
         soap_rpc.ADD_PARAMETER (l_request, 'Branch', TO_CHAR (l_branch));
         soap_rpc.ADD_PARAMETER (l_request, 'Name', encode_to_base(l_name));
         soap_rpc.ADD_PARAMETER (l_request,
                                 'EtalonId',
                                 TO_CHAR (l_etalon_id));
         soap_rpc.ADD_PARAMETER (l_request,
                                 'CellCount',
                                 TO_CHAR (l_cell_count));
         DBMS_OUTPUT.PUT_LINE ('g_wsproxy_url = ' || g_wsproxy_url);


         -- выполнить метод веб-сервиса
         l_response := soap_rpc.invoke (l_request);


         UPDATE SKRYNKA_sync_queue sq
            SET sq.msg_status = 'DONE', SQ.MSG_TIME = SYSDATE
          WHERE sq.id = p_sync_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            l_err_text :=
                  'Помилка на статусі PROC: '
               || SQLCODE
               || ' - '
               || SQLERRM;

            -- ставим статус "Помилка"
            UPDATE SKRYNKA_sync_queue sq
               SET sq.msg_status = 'ERROR', sq.err_text = l_err_text
             WHERE sq.id = p_sync_id;

            COMMIT;
      END;
   END send_type;

   -- Отправить сообщение на веб-сервис (договор ячейки)
   PROCEDURE send_nd (p_sync_id IN SKRYNKA_sync_queue.id%TYPE)
   IS
      l_o_sk         SKRYNKA_ND.O_SK%TYPE;
      l_branch       SKRYNKA_ND.BRANCH%TYPE;
      l_nd           SKRYNKA_ND.ND%TYPE;
      l_open_date    SKRYNKA_ND.DAT_BEGIN%TYPE;
      l_close_date   SKRYNKA_ND.DAT_END%TYPE;
      l_renter_name  SKRYNKA_ND.FIO%TYPE;
      l_sos          SKRYNKA_ND.SOS%TYPE;

   BEGIN
      -- ставим статус "Обробка"
      UPDATE SKRYNKA_sync_queue sq
         SET sq.msg_status = 'PROC', SQ.ERR_TEXT = NULL
       WHERE sq.id = p_sync_id;

      COMMIT;

      select T3.O_SK, T1.BRANCH, T1.ND, T1.DAT_BEGIN, nvl(T1.DAT_CLOSE,to_date('01/01/4000','DD/MM/YYYY')) , NVL(T1.FIO,' '), T1.SOS
      into l_o_sk, l_branch, l_nd, l_open_date, l_close_date, l_renter_name, l_sos
      from SKRYNKA_ND t1, SKRYNKA_sync_queue t2, skrynka t3
      where T1.ND = T2.OBJ_ID
      and T3.N_SK = T1.N_SK
      and T3.BRANCH = T1.BRANCH
      and T2.ID = p_sync_id;


DECLARE
         l_err_text   VARCHAR2 (4000);

         l_request    soap_rpc.t_request;
         l_response   soap_rpc.t_response;
      BEGIN
         -- подготовить реквест
         l_request :=
            soap_rpc.new_request (p_url           => g_wsproxy_url,
                                  p_namespace     => g_wsproxy_ns,
                                  p_method        => 'AddND',
                                  p_wallet_dir    => g_wsproxy_walletdir,
                                  p_wallet_pass   => g_wsproxy_walletpass);
         -- добавить параметры
         soap_rpc.ADD_PARAMETER (l_request, 'UserName', g_wsproxy_username);
         soap_rpc.ADD_PARAMETER (l_request, 'Password', g_wsproxy_password);
         soap_rpc.ADD_PARAMETER (l_request, 'O_SK', TO_CHAR (l_o_sk));
         soap_rpc.ADD_PARAMETER (l_request, 'Branch', TO_CHAR (l_branch));
         soap_rpc.ADD_PARAMETER (l_request, 'ND', TO_CHAR (l_nd) );
         soap_rpc.ADD_PARAMETER (l_request,
                                 'OpenDate',
                                 TO_CHAR (l_open_date, 'DD.MM.YYYY')
                                 );
         soap_rpc.ADD_PARAMETER (l_request,
                                 'CloseDate',
                                 TO_CHAR (l_close_date,'DD.MM.YYYY')
                                 );

         soap_rpc.ADD_PARAMETER (l_request,
                                 'RenterName',
                                 encode_to_base (l_renter_name)
                                 );
         soap_rpc.ADD_PARAMETER (l_request, 'SOS', TO_CHAR (l_sos) );

         DBMS_OUTPUT.PUT_LINE ('g_wsproxy_url = ' || g_wsproxy_url);


         -- выполнить метод веб-сервиса
         l_response := soap_rpc.invoke (l_request);

      UPDATE SKRYNKA_sync_queue sq
            SET sq.msg_status = 'DONE', SQ.MSG_TIME = SYSDATE
          WHERE sq.id = p_sync_id;


   EXCEPTION
      WHEN OTHERS
      THEN
         l_err_text :=
               'Помилка на статусі PROC: '
            || SQLCODE
            || ' - '
            || SQLERRM;
         -- ставим статус "Помилка"
         UPDATE SKRYNKA_sync_queue sq
          SET sq.msg_status = 'ERROR', sq.err_text = l_err_text
          WHERE sq.id = p_sync_id;
         COMMIT;
         return;

    END;
   UPDATE SKRYNKA_sync_queue sq
   SET sq.msg_status = 'DONE', SQ.MSG_TIME = SYSDATE
   WHERE sq.id = p_sync_id
   and sq.msg_status <> 'ERROR';
   COMMIT;

exception when no_data_found then
null;
END send_nd;

--відправляє повідомлення (заглушка)

PROCEDURE send_msg (p_sync_id IN SKRYNKA_sync_queue.id%TYPE)
IS
   l_sync_type   SKRYNKA_SYNC_QUEUE.SYNC_TYPE%TYPE;
BEGIN
   SELECT SYNC_TYPE
     INTO l_sync_type
     FROM SKRYNKA_SYNC_QUEUE
    WHERE id = p_sync_id;

   CASE (l_sync_type)
      WHEN 'TIP'
      THEN
         send_type (p_sync_id);
      WHEN 'ND'
      THEN
         send_nd (p_sync_id);
   END CASE;

   DBMS_OUTPUT.PUT_LINE ('send_msg(' || TO_CHAR (p_sync_id) || ')');

END send_msg;


--відправляє всі повідомлення повідомлення (заглушка)

PROCEDURE sync_queue
IS
l_sync_id SKRYNKA_SYNC_QUEUE.id%type;
BEGIN
for cur in (select id from SKRYNKA_SYNC_QUEUE
where MSG_STATUS in ('NEW', 'ERROR') order by id )
loop
send_msg(cur.id);
commit;
end loop;

END sync_queue;




--додає тип ячейки з регіона(заглушка)

PROCEDURE add_type (p_o_sk         IN SKRYNKA_TIP_BRANCH.O_SK%TYPE,
                    p_branch       IN SKRYNKA_TIP_BRANCH.BRANCH%TYPE,
                    p_name         IN SKRYNKA_TIP_BRANCH.NAME%TYPE,
                    p_etalon_id    IN SKRYNKA_TIP_BRANCH.ETALON_ID%TYPE,
                    p_cell_count   IN SKRYNKA_TIP_BRANCH.CELL_COUNT%TYPE)
IS
l_decode_name varchar2(1000);
BEGIN
   l_decode_name := encode_from_base(p_name);
   MERGE INTO SKRYNKA_TIP_BRANCH t1
        USING (SELECT p_o_sk AS o_sk,
                      p_branch AS branch,
                      l_decode_name AS name,
                      p_etalon_id AS etalon_id,
                      p_cell_count AS cell_count
                 FROM DUAL) t2
           ON (T1.BRANCH = t2.branch AND t1.o_sk = t2.o_sk)
   WHEN MATCHED
   THEN
      UPDATE SET
         T1.CELL_COUNT = t2.cell_count,
         T1.NAME = t2.name,
         T1.ETALON_ID = t2.ETALON_ID
   WHEN NOT MATCHED
   THEN
      INSERT     (T1.O_SK,
                  T1.BRANCH,
                  T1.NAME,
                  T1.ETALON_ID,
                  T1.CELL_COUNT)
          VALUES (T2.O_SK,
                  T2.BRANCH,
                  T2.NAME,
                  T2.ETALON_ID,
                  T2.CELL_COUNT);
END add_type;


--додає договір ячейки з регіона(заглушка)

PROCEDURE add_nd (p_o_sk          IN SKRYNKA_ND_BRANCH.O_SK%TYPE,
                  p_branch        IN SKRYNKA_ND_BRANCH.BRANCH%TYPE,
                  p_nd            IN SKRYNKA_ND_BRANCH.ND%TYPE,
                  p_open_date     IN varchar2,--SKRYNKA_ND_BRANCH.OPEN_DATE%TYPE,
                  p_close_date    IN varchar2,
                  p_renter_name   IN SKRYNKA_ND_BRANCH.renter_name%TYPE,
                  p_sos           IN SKRYNKA_ND_BRANCH.SOS%TYPE )
IS
l_decode_renter_name varchar2(1000);
BEGIN
 l_decode_renter_name := encode_from_base(p_renter_name);
   DBMS_OUTPUT.PUT_LINE ('add_nd(' || TO_CHAR (p_o_sk) || TO_CHAR (p_branch)|| TO_CHAR (p_open_date)|| TO_CHAR (p_close_date)|| TO_CHAR (p_nd)|| ')');
MERGE INTO SKRYNKA_ND_BRANCH t1
        USING (SELECT p_o_sk AS o_sk,
                      p_branch AS branch,
                      p_nd AS nd,
                      p_open_date AS open_date,
                      p_close_date AS close_date,
                      l_decode_renter_name AS renter_name,
                      p_sos  AS sos
                 FROM DUAL) t2
           ON (T1.BRANCH = t2.branch AND t1.nd = t2.nd)
   WHEN MATCHED
   THEN
      UPDATE SET
         T1.open_date = to_date(t2.open_date, 'DD.MM.YYYY') ,
         T1.close_date = to_date(t2.close_date, 'DD.MM.YYYY'),
         T1.renter_name = t2.renter_name,
         t1.o_sk = t2.o_sk,
         t1.sos = t2.sos

   WHEN NOT MATCHED
   THEN
      INSERT     (T1.O_SK,
                  T1.BRANCH,
                  T1.ND,
                  T1.open_date,
                  T1.close_date,
                  t1.renter_name,
                  t1.SOS)
          VALUES (T2.O_SK,
                  T2.BRANCH,
                  T2.ND,
                  to_date(t2.open_date, 'DD.MM.YYYY') ,
                  to_date(t2.close_date, 'DD.MM.YYYY'),
                  t2.renter_name,
                  t2.SOS);

END add_nd;



END skrynka_sync;
/
 show err;
 
PROMPT *** Create  grants  SKRYNKA_SYNC ***
grant DEBUG,EXECUTE                                                          on SKRYNKA_SYNC    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/skrynka_sync.sql =========*** End **
 PROMPT ===================================================================================== 
 