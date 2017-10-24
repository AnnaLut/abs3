
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ead_pack.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.EAD_PACK is

  -- Author  : TVSUKHOV
  -- Created : 12.06.2013 16:56:08
  -- Changed : 08.02.2016 A.Yurchenko
  -- Purpose : Взаємодія з ЕА

  -- Public type declarations
  -- type <TypeName> is <Datatype>;
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 2.2 18.01.2017 MMFO';

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;
  -- Public constant declarations
  g_transfer_timeout constant number := 180;
  function g_process_actual_time return number;

  -- Public variable declarations
  -- <VariableName> <Datatype>;

  -- Public function and procedure declarations
  -- ==== Надруковані документи ====
  -- Створити надрукований документ
  function doc_create(p_type_id      in ead_docs.type_id%type,
                      p_template_id  in ead_docs.template_id%type,
                      p_scan_data    in ead_docs.scan_data%type,
                      p_ea_struct_id in ead_docs.ea_struct_id%type,
                      p_rnk          in ead_docs.rnk%type,
                      p_agr_id       in ead_docs.agr_id%type default null)
    return ead_docs.id%type;

  -- Надрукований документ підписано
  procedure doc_sign(p_doc_id in ead_docs.id%type);

  -- Кількість сторінок надрукованого документу
  procedure doc_page_count(p_doc_id     in ead_docs.id%type,
                           p_page_count in ead_docs.page_count%type);

  -- ==== Черга повідомлень для передачі в ЕА ====
  -- Установить статус сообщению "Повідомлення відправлено"
  procedure msg_set_status_send(p_sync_id      in ead_sync_queue.id%type,
                                p_message_id   in ead_sync_queue.message_id%type,
                                p_message_date in ead_sync_queue.message_date%type,
                                p_message      in ead_sync_queue.message%type,
                                p_kf           in ead_sync_queue.KF%TYPE);

  -- Установить статус сообщению "Відповідь отримано"
  procedure msg_set_status_received(p_sync_id  in ead_sync_queue.id%type,
                                    p_responce in ead_sync_queue.responce%type,
                                    p_kf       in ead_sync_queue.KF%TYPE);

  -- Установить статус сообщению "Відповідь оброблено"
  procedure msg_set_status_parsed(p_sync_id       in ead_sync_queue.id%type,
                                  p_responce_id   in ead_sync_queue.responce_id%type,
                                  p_responce_date in ead_sync_queue.responce_date%type,
                                  p_kf            in ead_sync_queue.KF%TYPE);

  -- Установить статус сообщению "Виконано"
  procedure msg_set_status_done(p_sync_id in ead_sync_queue.id%type,
                                p_kf      in ead_sync_queue.KF%TYPE);

  -- Установить статус сообщению "Помилка"
  procedure msg_set_status_error(p_sync_id  in ead_sync_queue.id%type,
                                 p_err_text in ead_sync_queue.err_text%type,
                                 p_kf       in ead_sync_queue.KF%TYPE);

  -- Створити повідомлення
  function msg_create(p_type_id in ead_sync_queue.type_id%type,
                      p_obj_id  in ead_sync_queue.obj_id%type,
                      p_kf      in ead_sync_queue.KF%TYPE)
    return ead_sync_queue.id%type;

  -- Отправить сообщение на прокси веб-сервис
  procedure msg_process(p_sync_id in ead_sync_queue.id%type, p_kf IN ead_sync_queue.KF%TYPE);

  -- Удалить сообщение
  procedure msg_delete(p_sync_id in ead_sync_queue.id%type, p_kf IN ead_sync_queue.KF%TYPE);

  -- Удалить сообщения старше даты
  function msg_delete_older(p_date in date, p_kf IN ead_sync_queue.KF%TYPE) return number;

  -- Захват изменений - Клієнт
  procedure cdc_client;

  -- Захват изменений - Актуалізація ідент. документів
  procedure cdc_act;

  -- Захват изменений - Угода
  procedure cdc_agr;

  -- Захват изменений - Клієнт Юр.лицо
  procedure cdc_client_u;

  -- Захват изменений - Угода Юр.лиц
  procedure cdc_agr_u;

  -- Захват изменений - Счета Юр.лиц
  procedure cdc_acc;

  -- Захват изменений - Надрукований документ
  procedure cdc_doc;

  -- !!! Пока в ручном режиме DICT  Довідник  SetDictionaryData

  -- Передача в ЭА сообщение типа
  procedure type_process(p_type_id in ead_types.id%type);
  -- функция возвращает 0 если счет не в рамках ДБО, 1 если счет в рамках ДБО
  function get_acc_info(p_acc in accounts.acc%type) return int;
  -- функция возвращает 1 если это первый акцептированный счет в рамках ДБО, 0 - если не первый
  function is_first_accepted_acc(p_acc in accounts.acc%type) return int;

end ead_pack;
/
show errors


CREATE OR REPLACE PACKAGE BODY BARS.EAD_PACK 
IS
   g_body_version   CONSTANT VARCHAR2 (64) := 'version 2.10  02.08.2017 MMFO';

   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body ead_pack ' || g_body_version;
   END body_version;


   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body ead_pack ' || g_body_version;
   END header_version;

   FUNCTION g_process_actual_time
      RETURN NUMBER
   IS
      l_wsproxy_url   VARCHAR2 (100);
   BEGIN
      RETURN 2;
   END g_process_actual_time;

   FUNCTION g_wsproxy_url
      RETURN VARCHAR2
   IS
      l_wsproxy_url   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_url
        FROM web_barsconfig b
       WHERE b.key = 'ead.WSProxy.Url';

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
       WHERE b.key = 'ead.WSProxy.WalletDir';

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
       WHERE b.key = 'ead.WSProxy.WalletPass';

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
       WHERE b.key = 'ead.WSProxy.NS';

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
       WHERE b.key = 'ead.WSProxy.UserName';

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
       WHERE b.key = 'ead.WSProxy.Password';

      RETURN l_wsproxy_password;
   END g_wsproxy_password;

   -- Private variable declarations
   -- < VariableName > < Datatype >;

   -- Function and procedure implementations

   -- ==== Надруковані документи ====
   -- Створити надрукований документ
   FUNCTION doc_create (
      p_type_id        IN ead_docs.type_id%TYPE,
      p_template_id    IN ead_docs.template_id%TYPE,
      p_scan_data      IN ead_docs.scan_data%TYPE,
      p_ea_struct_id   IN ead_docs.ea_struct_id%TYPE,
      p_rnk            IN ead_docs.rnk%TYPE,
      p_agr_id         IN ead_docs.agr_id%TYPE DEFAULT NULL)
      RETURN ead_docs.id%TYPE
   IS
      l_id   ead_docs.id%TYPE;
      l_kf   ead_docs.kf%TYPE;
   BEGIN
      --sec_aud_temp_write ('EAD: doc_create:p_rnk=' || TO_CHAR (p_rnk));
      BEGIN
         SELECT kf
           INTO l_kf
           FROM customer
          WHERE rnk = p_rnk;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_kf := SYS_CONTEXT ('bars_context', 'user_mfo');
      END;

      -- последовательный номер 10... - АБС
      SELECT TO_NUMBER (
                '10' || TO_CHAR (bars_sqnc.get_nextval ('S_EADDOCS')))
        INTO l_id
        FROM DUAL;

      -- создаем запись
      INSERT INTO ead_docs (id,
                            crt_date,
                            crt_staff_id,
                            crt_branch,
                            type_id,
                            template_id,
                            scan_data,
                            ea_struct_id,
                            rnk,
                            agr_id,
                            kf)
           VALUES (l_id,
                   SYSDATE,
                   user_id,
                   SYS_CONTEXT ('bars_context', 'user_branch'),
                   p_type_id,
                   p_template_id,
                   p_scan_data,
                   p_ea_struct_id,
                   p_rnk,
                   p_agr_id,
                   l_kf);

      RETURN l_id;
   END doc_create;

   -- Видалити надрукований документ
   PROCEDURE doc_del (p_doc_id IN ead_docs.id%TYPE)
   IS
   BEGIN
      DELETE FROM ead_docs d
            WHERE d.id = p_doc_id;
   END doc_del;

   -- Надрукований документ підписано
   PROCEDURE doc_sign (p_doc_id IN ead_docs.id%TYPE)
   IS
   BEGIN
      UPDATE ead_docs d
         SET d.sign_date = SYSDATE
       WHERE d.id = p_doc_id;
   END doc_sign;

   -- Кількість сторінок надрукованого документу
   PROCEDURE doc_page_count (p_doc_id       IN ead_docs.id%TYPE,
                             p_page_count   IN ead_docs.page_count%TYPE)
   IS
   BEGIN
      bars_audit.trace (
            'tvSukhov: p_doc_id = '
         || p_doc_id
         || ' p_page_count = '
         || p_page_count);

      --sec_aud_temp_write ('EAD: doc_page_count:p_page_count=' || TO_CHAR (p_page_count));
      UPDATE ead_docs d
         SET d.page_count = p_page_count
       WHERE d.id = p_doc_id;
   END doc_page_count;

   -- ==== Черга повідомлень для передачі в ЕА ====
   -- Установить статус сообщению "Повідомлення відправлено"
   PROCEDURE msg_set_status_send (
      p_sync_id        IN ead_sync_queue.id%TYPE,
      p_message_id     IN ead_sync_queue.message_id%TYPE,
      p_message_date   IN ead_sync_queue.message_date%TYPE,
      p_message        IN ead_sync_queue.MESSAGE%TYPE,
      p_kf             IN ead_sync_queue.KF%TYPE)
   IS
   BEGIN
      --sec_aud_temp_write ('EAD: msg_set_status_send:p_message=' || TO_CHAR (p_message));

      -- ставим статус "Повідомлення відправлено"
      UPDATE ead_sync_queue sq
         SET sq.status_id = 'MSG_SEND',
             sq.message_id = p_message_id,
             sq.message_date = p_message_date,
             sq.MESSAGE = p_message,
             sq.err_text = NULL
       WHERE sq.id = p_sync_id AND sq.kf = p_kf;

      COMMIT;
   END msg_set_status_send;

   -- Установить статус сообщению "Відповідь отримано"
   PROCEDURE msg_set_status_received (
      p_sync_id    IN ead_sync_queue.id%TYPE,
      p_responce   IN ead_sync_queue.responce%TYPE,
      p_kf         IN ead_sync_queue.kf%TYPE)
   IS
   BEGIN
      -- bars_audit.info('EAD: msg_set_status_received:p_sync_id=' || to_char(p_sync_id));
      --sec_aud_temp_write ('EAD: msg_set_status_received:p_sync_id=' || TO_CHAR (p_sync_id)||', p_kf=' || p_kf);

      -- ставим статус "Відповідь отримано"
      UPDATE ead_sync_queue sq
         SET sq.status_id = 'RSP_RECEIVED',
             sq.responce = p_responce,
             sq.err_text = NULL
       WHERE sq.id = p_sync_id AND sq.kf = p_kf;

      COMMIT;
   END msg_set_status_received;

   -- Установить статус сообщению "Відповідь оброблено"
   PROCEDURE msg_set_status_parsed (
      p_sync_id         IN ead_sync_queue.id%TYPE,
      p_responce_id     IN ead_sync_queue.responce_id%TYPE,
      p_responce_date   IN ead_sync_queue.responce_date%TYPE,
      p_kf              IN ead_sync_queue.kf%TYPE)
   IS
   BEGIN
      -- ставим статус "Відповідь оброблено"
      --   bars_audit.info('EAD: msg_set_status_parsed:p_sync_id=' || to_char(p_sync_id));
      --sec_aud_temp_write ('EAD: msg_set_status_parsed:p_sync_id=' || TO_CHAR (p_sync_id));

      UPDATE ead_sync_queue sq
         SET sq.status_id = 'RSP_PARSED',
             sq.responce_id = p_responce_id,
             sq.responce_date = p_responce_date,
             sq.err_text = NULL
       WHERE sq.id = p_sync_id AND sq.kf = p_kf;

      COMMIT;
   END msg_set_status_parsed;

   -- Установить статус сообщению "Виконано"
   PROCEDURE msg_set_status_done (p_sync_id   IN ead_sync_queue.id%TYPE,
                                  p_kf        IN ead_sync_queue.kf%TYPE)
   IS
   BEGIN
      --bars_audit.info('EAD: msg_set_status_done:p_sync_id=' || to_char(p_sync_id));
      -- ставим статус "Виконано"
      UPDATE ead_sync_queue sq
         SET sq.status_id = 'DONE', sq.err_text = NULL
       WHERE sq.id = p_sync_id AND sq.kf = p_kf;

      COMMIT;
   END msg_set_status_done;

   -- Установить статус сообщению "Помилка"
   PROCEDURE msg_set_status_error (
      p_sync_id    IN ead_sync_queue.id%TYPE,
      p_err_text   IN ead_sync_queue.err_text%TYPE,
      p_kf         IN ead_sync_queue.kf%TYPE)
   IS
   BEGIN
      --sec_aud_temp_write ('EAD: msg_set_status_error:p_sync_id=' || TO_CHAR (p_sync_id));

      -- ставим статус "Помилка"
      UPDATE ead_sync_queue sq
         SET sq.status_id = 'ERROR', sq.err_text = p_err_text
       WHERE sq.id = p_sync_id AND sq.kf = p_kf;

      COMMIT;
   END msg_set_status_error;

   -- Установить статус сообщению "Вичерпано час актуальності"
   PROCEDURE msg_set_status_outdated (p_sync_id   IN ead_sync_queue.id%TYPE,
                                      p_kf        IN ead_sync_queue.kf%TYPE)
   IS
   BEGIN
      --sec_aud_temp_write('EAD: msg_set_status_outdated:p_sync_id=' || to_char(p_sync_id));
      -- ставим статус "Помилка"
      UPDATE ead_sync_queue sq
         SET sq.status_id = 'OUTDATED'
       WHERE sq.id = p_sync_id AND sq.kf = p_kf;

      COMMIT;
   END msg_set_status_outdated;

   -- Створити повідомлення
   FUNCTION msg_create (p_type_id   IN ead_sync_queue.type_id%TYPE,
                        p_obj_id    IN ead_sync_queue.obj_id%TYPE,
                        p_kf        IN ead_sync_queue.kf%TYPE)
      RETURN ead_sync_queue.id%TYPE
   IS
      l_id   ead_sync_queue.id%TYPE;
      l_kf   VARCHAR2 (6);
   BEGIN
      IF p_kf IS NULL
      THEN
         l_kf := SYS_CONTEXT ('bars_context', 'user_mfo');
      ELSE
         l_kf := p_kf;
      END IF;

      --sec_aud_temp_write('EAD: msg_create:p_obj_id=' || to_char(p_obj_id));
      -- создаем запись
      INSERT INTO ead_sync_queue (id,
                                  crt_date,
                                  type_id,
                                  obj_id,
                                  status_id,
                                  kf)
           VALUES (S_EADSYNCQUEUE.nextval,
                   SYSDATE,
                   p_type_id,
                   p_obj_id,
                   'NEW',
                   l_kf)
        RETURNING id
             INTO l_id;

      -- все предидущие записи по даному обїекту помечаем как устаревшие
      FOR cur
         IN (SELECT *
               FROM ead_sync_queue sq
              WHERE     sq.crt_date >
                           ADD_MONTHS (SYSDATE, -1 * g_process_actual_time)
                    AND sq.type_id = p_type_id
                    AND sq.obj_id = p_obj_id
                    AND sq.id < l_id
                    AND sq.status_id <> 'DONE'
                    AND sq.kf = l_kf)
      LOOP
         msg_set_status_outdated (cur.id, l_kf);
      END LOOP;

      RETURN l_id;
      bars_audit.info ('EAD: msg_create:l_id=' || TO_CHAR (l_id));
   END msg_create;

   -- Отправить сообщение на прокси веб-сервис
   PROCEDURE msg_process (p_sync_id   IN ead_sync_queue.id%TYPE,
                          p_kf        IN ead_sync_queue.KF%TYPE)
   IS
   BEGIN
      -- ставим статус "Обробка"
      --sec_aud_temp_write('EAD: msg_process:p_sync_id=' || to_char(p_sync_id));
      UPDATE ead_sync_queue sq
         SET sq.status_id = 'PROC',
             sq.err_count =
                DECODE (sq.status_id, 'ERROR', NVL (sq.err_count, 0) + 1, 0)
       WHERE sq.id = p_sync_id AND sq.kf = p_kf;

      COMMIT;

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
                                  p_method        => 'MsgProcess',
                                  p_wallet_dir    => g_wsproxy_walletdir,
                                  p_wallet_pass   => g_wsproxy_walletpass);
         -- добавить параметры
         soap_rpc.ADD_PARAMETER (l_request, 'ID', TO_CHAR (p_sync_id));
         soap_rpc.ADD_PARAMETER (l_request,
                                 'WSProxyUserName',
                                 g_wsproxy_username);
         soap_rpc.ADD_PARAMETER (l_request,
                                 'WSProxyPassword',
                                 g_wsproxy_password);
         soap_rpc.ADD_PARAMETER (l_request, 'kf', p_kf);

         -- выполнить метод веб-сервиса
         --bars_audit.info('l_request.wallet_dir= ' || l_request.wallet_dir||', l_request.body=' || to_char(l_request.body));

         l_response := soap_rpc.invoke (l_request);
      EXCEPTION
         WHEN OTHERS
         THEN
            l_err_text :=
                  'Помилка на статусі PROC: '
               || SQLCODE
               || ' - '
               || dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace();

            -- ставим статус "Помилка"
            UPDATE ead_sync_queue sq
               SET sq.status_id = 'ERROR', sq.err_text = l_err_text
             WHERE sq.id = p_sync_id AND sq.kf = p_kf;

            COMMIT;
      END;
   END msg_process;

   -- Удалить сообщение
   PROCEDURE msg_delete (p_sync_id   IN ead_sync_queue.id%TYPE,
                         p_kf        IN ead_sync_queue.KF%TYPE)
   IS
   BEGIN
      -- удаляем записи
      DELETE FROM ead_sync_queue sq
            WHERE sq.id = p_sync_id AND sq.kf = p_kf;

      COMMIT;
   END msg_delete;

   -- Удалить сообщения старше даты
   FUNCTION msg_delete_older (p_date IN DATE, p_kf IN ead_sync_queue.KF%TYPE)
      RETURN NUMBER
   IS
      l_cnt   NUMBER := 0;
   BEGIN
      --bars_audit.info('EAD: msg_delete_older:p_date=' || to_char(p_date));
      -- удаляем записи
      DELETE FROM ead_sync_queue sq
            WHERE sq.crt_date < p_date AND sq.kf = p_kf;

      l_cnt := SQL%ROWCOUNT;
      COMMIT;

      -- сжимаем пространство
      BEGIN
         EXECUTE IMMEDIATE 'alter table ead_sync_queue shrink space';
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;

      -- возвращаем кол-во удаленных зап.
      RETURN l_cnt;
   END msg_delete_older;

   -- Захват изменений - Клієнт
   PROCEDURE cdc_client
   IS
      l_type_id       ead_types.id%TYPE := 'CLIENT';
      l_cdc_newkey    ead_sync_sessions.cdc_lastkey%TYPE;

      l_sync_id       ead_sync_queue.id%TYPE;
      l_cdc_lastkey   customer_update.idupd%TYPE;
   BEGIN
      --sec_aud_temp_write ('EAD: cdc_client');
      --bc.go('/');
      -- находим ключ захвата изменений
      BEGIN
         SELECT TO_NUMBER (ss.cdc_lastkey)
           INTO l_cdc_lastkey
           FROM ead_sync_sessions ss
          WHERE ss.type_id = l_type_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT MAX (cu.idupd)
              INTO l_cdc_lastkey
              FROM customer_update cu;
      END;

      -- берем всех клиентов у которых есть депозит или трейтих лиц по депозитам,або є рахунки way4
      -- у которых было изменение в реквизитах
      FOR cur
         IN (  SELECT cu.idupd, cu.rnk, cu.kf
                 FROM customer_update cu,
                      (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                         FROM web_barsconfig
                        WHERE     key LIKE 'ead.ServiceUrl%'
                              AND val IS NOT NULL
                              AND val NOT LIKE '-%') kflist
                WHERE     cu.idupd > l_cdc_lastkey
                      AND CU.CUSTTYPE = 3
                      AND cu.kf = kflist.kf
                      AND CU.SED <> '91'
                      AND (   (   EXISTS
                                     (SELECT 1
                                        FROM dpt_deposit_clos d
                                       WHERE     d.rnk = cu.rnk
                                             AND NVL (d.archdoc_id, 0) > 0)
                               OR EXISTS
                                     (SELECT 1
                                        FROM dpt_trustee t
                                       WHERE     t.rnk_tr = cu.rnk
                                             AND EXISTS
                                                    (SELECT 1
                                                       FROM dpt_deposit_clos d
                                                      WHERE     d.deposit_id =
                                                                   t.dpt_id
                                                            AND NVL (
                                                                   d.archdoc_id,
                                                                   0) > 0))
                               OR TRIM (f_custw (cu.rnk, 'CRSRC')) = 'DPT') --є депозити
                           OR (EXISTS
                                  (SELECT 1
                                     FROM w4_acc wacc, accounts acc
                                    WHERE     WACC.ACC_PK = acc.acc
                                          AND ACC.RNK = cu.rnk)) --є карткові рахунки way4
                           OR (EXISTS
                                  (SELECT 1
                                     FROM accounts acc
                                    WHERE     ACC.RNK = cu.rnk
                                          AND ACC.nbs = '2620'
                                          AND (   ACC.dazs IS NULL
                                               OR ACC.DAZS > TRUNC (SYSDATE)))) --є рахунки 2620
                                                                               )
             ORDER BY cu.idupd)
      LOOP
         l_sync_id :=
            ead_pack.msg_create (l_type_id, TO_CHAR (cur.rnk), cur.kf);
         l_cdc_lastkey := cur.idupd;
      END LOOP;

      -- сохраняем ключ захвата
      l_cdc_newkey := TO_CHAR (l_cdc_lastkey);

      UPDATE ead_sync_sessions ss
         SET ss.cdc_lastkey = l_cdc_newkey
       WHERE ss.type_id = l_type_id;

      IF (SQL%ROWCOUNT = 0)
      THEN
         INSERT INTO ead_sync_sessions (type_id, cdc_lastkey)
              VALUES (l_type_id, l_cdc_newkey);
      END IF;

      COMMIT;
   END cdc_client;

   -- Захват изменений - Актуалізація ідент. документів
   PROCEDURE cdc_act
   IS
      l_type_id       ead_types.id%TYPE := 'ACT';
      l_cdc_newkey    ead_sync_sessions.cdc_lastkey%TYPE;
      l_date_fmt      VARCHAR2 (100) := 'dd.mm.yyyy hh24:mi:ss';

      l_sync_id       ead_sync_queue.id%TYPE;
      l_cdc_lastkey   person_valid_document_update.chgdate%TYPE;
   BEGIN
      --bc.go('/');
      --bars_audit.info('EAD: cdc_act');
      -- находим ключ захвата изменений
      BEGIN
         SELECT TO_DATE (ss.cdc_lastkey, l_date_fmt)
           INTO l_cdc_lastkey
           FROM ead_sync_sessions ss
          WHERE ss.type_id = l_type_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT NVL (MAX (pvd.chgdate), SYSDATE)
              INTO l_cdc_lastkey
              FROM person_valid_document_update pvd;
      END;

      -- берем все актуализации
      FOR cur
         IN (  SELECT pvd.chgdate, pvd.rnk, c.kf
                 FROM person_valid_document_update pvd,
                      customer c,
                      (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                         FROM web_barsconfig
                        WHERE     key LIKE 'ead.ServiceUrl%'
                              AND val IS NOT NULL
                              AND val NOT LIKE '-%') kflist
                WHERE     pvd.rnk = c.rnk
                      AND c.custtype = 3 --COBUSUPABS-4496 11.05.2016 предохранитель на случай смены с ФО на ФОП, кода идент.документы уже существуют
                      AND c.sed != '91  '
                      AND c.kf = kflist.kf
                      AND pvd.chgdate > l_cdc_lastkey
             ORDER BY pvd.chgdate)
      LOOP
         -- клиент на всякий случай
         l_sync_id :=
            ead_pack.msg_create ('CLIENT', TO_CHAR (cur.rnk), cur.kf);

         l_sync_id :=
            ead_pack.msg_create (l_type_id, TO_CHAR (cur.rnk), cur.kf);
         l_cdc_lastkey := cur.chgdate;
      END LOOP;

      -- сохраняем ключ захвата
      l_cdc_newkey := TO_CHAR (l_cdc_lastkey, l_date_fmt);

      UPDATE ead_sync_sessions ss
         SET ss.cdc_lastkey = l_cdc_newkey
       WHERE ss.type_id = l_type_id;

      IF (SQL%ROWCOUNT = 0)
      THEN
         INSERT INTO ead_sync_sessions (type_id, cdc_lastkey)
              VALUES (l_type_id, l_cdc_newkey);
      END IF;

      COMMIT;
   END cdc_act;

   -- Захват изменений - Угода
   PROCEDURE cdc_agr
   IS
      l_type_id            ead_types.id%TYPE := 'AGR';
      l_cdc_newkey         ead_sync_sessions.cdc_lastkey%TYPE;

      l_sync_id            ead_sync_queue.id%TYPE;

      l_cdc_lastkey_dpt    dpt_deposit_clos.idupd%TYPE;
      l_cdc_lastkey_agr    dpt_agreements.agrmnt_id%TYPE;
      l_cdc_lastkey_way4   W4_ACC_UPDATE.IDUPD%TYPE;
      l_cdc_lastkey_2620   ACCOUNTS_UPDATE.IDUPD%TYPE;
   BEGIN
      -- bc.go('/');
      --bars_audit.info('EAD: cdc_act');
      -- находим ключ захвата изменений
      BEGIN
         SELECT NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               1)),
                     0),
                NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               2)),
                     0),
                NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               3)),
                     0),
                NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               4)),
                     0)
           INTO l_cdc_lastkey_dpt,
                l_cdc_lastkey_agr,
                l_cdc_lastkey_way4,
                l_cdc_lastkey_2620
           FROM ead_sync_sessions ss
          WHERE ss.type_id = l_type_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            SELECT MAX (dc.idupd)
              INTO l_cdc_lastkey_dpt
              FROM dpt_deposit_clos dc;

            SELECT MAX (a.agrmnt_id)
              INTO l_cdc_lastkey_agr
              FROM dpt_agreements a;

            SELECT MAX (W4.IDUPD)
              INTO l_cdc_lastkey_way4
              FROM w4_acc_update w4;

            SELECT MAX (ACC.IDUPD)
              INTO l_cdc_lastkey_2620
              FROM ACCOUNTS_UPDATE ACC;
      END;


      -- депезиты по которым были изменения
      FOR cur
         IN (  SELECT dc.idupd,
                      dc.deposit_id,
                      dc.rnk,
                      dc.kf
                 FROM dpt_deposit_clos dc,
                      (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                         FROM web_barsconfig
                        WHERE     key LIKE 'ead.ServiceUrl%'
                              AND val IS NOT NULL
                              AND val NOT LIKE '-%') kflist
                WHERE     dc.idupd > l_cdc_lastkey_dpt
                      AND NVL (dc.archdoc_id, 0) > 0
                      AND dc.kf = kflist.kf and dc.wb = 'N'
             ORDER BY dc.idupd)
      LOOP
         -- клиент
         l_sync_id :=
            ead_pack.msg_create ('CLIENT', TO_CHAR (cur.rnk), cur.kf);

         -- связанные РНК
         FOR cur1 IN (SELECT DISTINCT t.rnk_tr AS rnk
                        FROM dpt_trustee t
                       WHERE t.dpt_id = cur.deposit_id)
         LOOP
            l_sync_id :=
               ead_pack.msg_create ('CLIENT', TO_CHAR (cur1.rnk), cur.kf);
         END LOOP;

         l_sync_id :=
            ead_pack.msg_create (l_type_id,
                                 'DPT;' || TO_CHAR (cur.deposit_id),
                                 cur.kf);

         l_cdc_lastkey_dpt := cur.idupd;
      END LOOP;

      -- депезиты по которым были допсоглашения
      FOR cur
         IN (  SELECT a.agrmnt_id,
                      a.dpt_id,
                      a.kf,
                      (SELECT d.rnk
                         FROM dpt_deposit_clos d,
                              (SELECT TRIM (
                                         REPLACE (key, 'ead.ServiceUrl', ''))
                                         KF
                                 FROM web_barsconfig
                                WHERE     key LIKE 'ead.ServiceUrl%'
                                      AND val IS NOT NULL
                                      AND val NOT LIKE '-%') kflist
                        WHERE     d.deposit_id = a.dpt_id
                              AND d.kf = kflist.kf
                              AND D.IDUPD =
                                     (SELECT MAX (dc.idupd)
                                        FROM dpt_deposit_clos dc
                                       WHERE     dc.deposit_id = d.deposit_id
                                             AND NVL (d.archdoc_id, 0) > 0)
                              AND NVL (d.archdoc_id, 0) > 0)
                         AS rnk                    -- последний владелец счета
                 FROM dpt_agreements a,
                      (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                         FROM web_barsconfig
                        WHERE     key LIKE 'ead.ServiceUrl%'
                              AND val IS NOT NULL
                              AND val NOT LIKE '-%') kflist
                WHERE     a.agrmnt_id > l_cdc_lastkey_agr
                      AND a.kf = kflist.kf
                      AND EXISTS
                             (SELECT 1
                                FROM dpt_deposit_clos d
                               WHERE     d.deposit_id = a.dpt_id
                                     AND NVL (d.archdoc_id, 0) > 0
                                     and d.wb = 'N')
             ORDER BY a.agrmnt_id)
      LOOP
         -- клиент
         l_sync_id :=
            ead_pack.msg_create ('CLIENT', TO_CHAR (cur.rnk), cur.kf);

         -- связанные РНК
         FOR cur1 IN (SELECT DISTINCT t.rnk_tr AS rnk
                        FROM dpt_trustee t
                       WHERE t.dpt_id = cur.dpt_id)
         LOOP
            l_sync_id :=
               ead_pack.msg_create ('CLIENT', TO_CHAR (cur1.rnk), cur.kf);
         END LOOP;

         l_sync_id :=
            ead_pack.msg_create (l_type_id,
                                 'DPT;' || TO_CHAR (cur.dpt_id),
                                 cur.kf);
         l_cdc_lastkey_agr := cur.agrmnt_id;
      END LOOP;

      -- рахунок(обробка не знаходження значення і заборона на передачу всіх змін в чергу)
      IF (l_cdc_lastkey_way4 < 1)
      THEN
         SELECT MAX (W4.IDUPD)
           INTO l_cdc_lastkey_way4
           FROM w4_acc_update w4;
      END IF;


      -- рахунки way4 по которым были изменения
      FOR cur
         IN (  SELECT w4.idupd,
                      acc.rnk,
                      w4.nd AS nd,
                      acc.kf
                 FROM w4_acc_update w4,
                      accounts acc,
                      (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                         FROM web_barsconfig
                        WHERE     key LIKE 'ead.ServiceUrl%'
                              AND val IS NOT NULL
                              AND val NOT LIKE '-%') kflist
                WHERE     w4.idupd > l_cdc_lastkey_way4
                      AND acc.kf = kflist.kf
                      AND acc.nbs != '2605' --/COBUSUPABS-4497 11.05.2016 pavlenko inga
                      and w4.chgaction = 'I'
                      AND W4.ACC_PK = acc.acc
             ORDER BY w4.idupd)
      LOOP
         -- клиент
         --  l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur.rnk));
         l_sync_id :=
            ead_pack.msg_create (l_type_id,
                                 'WAY;' || TO_CHAR (cur.nd),
                                 cur.kf);

         l_cdc_lastkey_way4 := cur.idupd;
      END LOOP;


      --рахунки 2620 ФО
      -- рахунок(обробка не знаходження значення і заборона на передачу всіх змін в чергу)
      IF (l_cdc_lastkey_2620 < 1)
      THEN
         SELECT MAX (ACC.IDUPD)
           INTO l_cdc_lastkey_2620
           FROM ACCOUNTS_UPDATE ACC;
      END IF;

      -- рахунки 2620, заведені за останній період
      FOR cur
         IN (  SELECT T1.IDUPD AS idupd,
                      T1.RNK AS rnk,
                      t1.nbs AS nbs,
                      t1.kf
                 FROM accounts_update t1,
                      customer t2,
                      (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                         FROM web_barsconfig
                        WHERE     key LIKE 'ead.ServiceUrl%'
                              AND val IS NOT NULL
                              AND val NOT LIKE '-%') kflist
                WHERE     t1.idupd > l_cdc_lastkey_2620
                      AND T1.CHGACTION = 1
                      AND t2.rnk = t1.rnk
                      AND t2.kf = kflist.kf
                      AND T2.CUSTTYPE = 3
                      AND T2.SED <> '91'
             --and t1.nbs = '2620'
             ORDER BY t1.idupd)
      LOOP
         -- надсилати лише клієнта ФО при заведенні рахунку. В подальшому всі зміни передавати лише при зміні атрибутів клієнта/*COBUSUPABS-4045*/
         IF (cur.nbs = '2620')
         THEN
            l_sync_id :=
               ead_pack.msg_create ('CLIENT', TO_CHAR (cur.rnk), cur.kf);
         END IF;

         l_cdc_lastkey_2620 := cur.idupd;
      END LOOP;



      -- сохраняем ключ захвата
      l_cdc_newkey :=
            TO_CHAR (l_cdc_lastkey_dpt)
         || ';'
         || TO_CHAR (l_cdc_lastkey_agr)
         || ';'
         || TO_CHAR (l_cdc_lastkey_way4)
         || ';'
         || TO_CHAR (l_cdc_lastkey_2620);


      UPDATE ead_sync_sessions ss
         SET ss.cdc_lastkey = l_cdc_newkey
       WHERE ss.type_id = l_type_id;

      IF (SQL%ROWCOUNT = 0)
      THEN
         INSERT INTO ead_sync_sessions (type_id, cdc_lastkey)
              VALUES (l_type_id, l_cdc_newkey);
      END IF;

      COMMIT;
   END cdc_agr;

   -- Захват изменений - Надрукований документ
   PROCEDURE cdc_doc
   IS
      l_type_id       ead_types.id%TYPE := 'DOC';
      l_cdc_newkey    ead_sync_sessions.cdc_lastkey%TYPE;

      l_sync_id       ead_sync_queue.id%TYPE;
      l_cdc_lastkey   ead_docs.id%TYPE;
   BEGIN
      --bc.go('/');
      --sec_aud_temp_write ('EAD: cdc_doc');

      -- находим ключ захвата изменений
      BEGIN
         SELECT TO_NUMBER (ss.cdc_lastkey)
           INTO l_cdc_lastkey
           FROM ead_sync_sessions ss
          WHERE ss.type_id = l_type_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT NVL (MAX (d.id), 0)
              INTO l_cdc_lastkey
              FROM ead_docs d;
      END;

      -- берем все документы
      FOR cur
         IN (  SELECT d.id, d.rnk, d.kf
                 FROM ead_docs d,
                      (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                         FROM web_barsconfig
                        WHERE     key LIKE 'ead.ServiceUrl%'
                              AND val IS NOT NULL
                              AND val NOT LIKE '-%') kflist
                WHERE     d.id > l_cdc_lastkey
                      AND (d.sign_date IS NOT NULL OR d.type_id = 'SCAN') --отбираем только подписанные документы или сканкопии.
                      and lnnvl(d.template_id = 'WB_CREATE_DEPOSIT')  -- все кроме онлайн-депозитов
                      AND d.kf = kflist.kf
             ORDER BY d.id)
      LOOP
         --насильно отправляем клиента
         l_sync_id :=
            ead_pack.msg_create ('CLIENT', TO_CHAR (cur.rnk), cur.kf);
         --и теперь документы
         l_sync_id :=
            ead_pack.msg_create (l_type_id, TO_CHAR (cur.id), cur.kf);
         l_cdc_lastkey := cur.id;
      END LOOP;

      -- сохраняем ключ захвата
      l_cdc_newkey := TO_CHAR (l_cdc_lastkey);

      UPDATE ead_sync_sessions ss
         SET ss.cdc_lastkey = l_cdc_newkey
       WHERE ss.type_id = l_type_id;

      IF (SQL%ROWCOUNT = 0)
      THEN
         INSERT INTO ead_sync_sessions (type_id, cdc_lastkey)
              VALUES (l_type_id, l_cdc_newkey);
      END IF;

      COMMIT;
   END cdc_doc;

   -- Захват изменений - Клієнт Юр.Лицо
   PROCEDURE cdc_client_u
   IS
      l_sync_id                ead_sync_queue.id%TYPE;

      l_cdc_lastkey_cu_corp    customer_update.idupd%TYPE;
      l_cdc_newkey_cu_corp     customer_update.idupd%TYPE;
      l_cdc_lastkey_cpu_corp   corps_update.idupd%TYPE;
      l_cdc_newkey_cpu_corp    corps_update.idupd%TYPE;
      l_cdc_lastkey_cu_rel     customer_update.idupd%TYPE;
      l_cdc_newkey_cu_rel      customer_update.idupd%TYPE;
      l_cdc_lastkey_pu_rel     person_update.idupd%TYPE;
      l_cdc_newkey_pu_rel      person_update.idupd%TYPE;
      l_cdc_lastkey_cru_rel    customer_rel_update.idupd%TYPE;
      l_cdc_newkey_cru_rel     customer_rel_update.idupd%TYPE;

      -- получение ключей захвата изменений
      PROCEDURE get_cdc_lastkeys (
         p_cu_corp    OUT customer_update.idupd%TYPE,
         p_cpu_corp   OUT corps_update.idupd%TYPE,
         p_cu_rel     OUT customer_update.idupd%TYPE,
         p_pu_rel     OUT person_update.idupd%TYPE,
         p_cru_rel    OUT customer_rel_update.idupd%TYPE)
      IS
         l_cdc_lastkey   ead_sync_sessions.cdc_lastkey%TYPE;
      BEGIN
         --sec_aud_temp_write ('EAD: get_cdc_lastkeys');
         --bc.go('/');
         SELECT ss.cdc_lastkey
           INTO l_cdc_lastkey
           FROM ead_sync_sessions ss
          WHERE ss.type_id = 'UCLIENT';

         p_cu_corp :=
            TO_NUMBER (SUBSTR (l_cdc_lastkey,
                               1,
                                 INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        1)
                               - 1));
         p_cpu_corp :=
            TO_NUMBER (SUBSTR (l_cdc_lastkey,
                                 INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        1)
                               + 1,
                                 INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        2)
                               - INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        1)
                               - 1));
         p_cu_rel :=
            TO_NUMBER (SUBSTR (l_cdc_lastkey,
                                 INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        2)
                               + 1,
                                 INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        3)
                               - INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        2)
                               - 1));
         p_pu_rel :=
            TO_NUMBER (SUBSTR (l_cdc_lastkey,
                                 INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        3)
                               + 1,
                                 INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        4)
                               - INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        3)
                               - 1));
         p_cru_rel :=
            TO_NUMBER (SUBSTR (l_cdc_lastkey,
                                 INSTR (l_cdc_lastkey,
                                        ';',
                                        1,
                                        4)
                               + 1));
      EXCEPTION
         WHEN OTHERS
         THEN
            SELECT MAX (cu.idupd), MAX (cu.idupd)
              INTO p_cu_corp, p_cu_rel
              FROM customer_update cu;

            SELECT MAX (cpu.idupd)
              INTO p_cpu_corp
              FROM corps_update cpu;

            SELECT MAX (pu.idupd)
              INTO p_pu_rel
              FROM person_update pu;

            SELECT MAX (cru.idupd)
              INTO p_cru_rel
              FROM customer_rel_update cru;
      END get_cdc_lastkeys;

      -- сохранение ключей захвата изменений
      PROCEDURE set_cdc_newkeys (
         p_cu_corp    IN customer_update.idupd%TYPE,
         p_cpu_corp   IN corps_update.idupd%TYPE,
         p_cu_rel     IN customer_update.idupd%TYPE,
         p_pu_rel     IN person_update.idupd%TYPE,
         p_cru_rel    IN customer_rel_update.idupd%TYPE)
      IS
         l_cdc_newkey   ead_sync_sessions.cdc_lastkey%TYPE;
      BEGIN
         -- делаем составной ключ путем конкатенации
         l_cdc_newkey :=
               TO_CHAR (p_cu_corp)
            || ';'
            || TO_CHAR (p_cpu_corp)
            || ';'
            || TO_CHAR (p_cu_rel)
            || ';'
            || TO_CHAR (p_pu_rel)
            || ';'
            || TO_CHAR (p_cru_rel);

         UPDATE ead_sync_sessions ss
            SET ss.cdc_lastkey = l_cdc_newkey
          WHERE ss.type_id = 'UCLIENT';

         IF (SQL%ROWCOUNT = 0)
         THEN
            INSERT INTO ead_sync_sessions (type_id, cdc_lastkey)
                 VALUES ('UCLIENT', l_cdc_newkey);
         END IF;
      END set_cdc_newkeys;
   BEGIN
      --bc.go('/');
      --sec_aud_temp_write ('EAD: cdc_client_u');
      -- получаем ключи захвата изменений
      get_cdc_lastkeys (l_cdc_lastkey_cu_corp,
                        l_cdc_lastkey_cpu_corp,
                        l_cdc_lastkey_cu_rel,
                        l_cdc_lastkey_pu_rel,
                        l_cdc_lastkey_cru_rel);

      -- берем всех клиентов ЮЛ, у которых было изменение в реквизитах
      SELECT MAX (cu.idupd)
        INTO l_cdc_newkey_cu_corp
        FROM customer_update cu;

      SELECT MAX (cpu.idupd)
        INTO l_cdc_newkey_cpu_corp
        FROM corps_update cpu;

      FOR cur
         IN (SELECT cu.rnk, cu.kf
               FROM customer_update cu,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     cu.idupd > l_cdc_lastkey_cu_corp
                    AND cu.idupd <= l_cdc_newkey_cu_corp
                    AND cu.kf = kflist.kf
                    AND (   cu.custtype <> 3
                         OR (cu.custtype = 3 AND cu.sed = 91))
             UNION
             SELECT cpu.rnk, cpu.kf
               FROM corps_update cpu,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     cpu.idupd > l_cdc_lastkey_cpu_corp
                    AND cpu.idupd <= l_cdc_newkey_cpu_corp
                    AND cpu.kf = kflist.kf)
      LOOP
         l_sync_id :=
            ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.kf);
      END LOOP;

      -- берем всех клиентов ЮЛ и ФЛ, у которых было изменение в реквизитах и которые есть связанными лицами с ЮЛ
      SELECT MAX (cu.idupd)
        INTO l_cdc_newkey_cu_rel
        FROM customer_update cu;

      SELECT MAX (pu.idupd)
        INTO l_cdc_newkey_pu_rel
        FROM person_update pu;

      FOR cur
         IN (SELECT cr.rnk,
                    cr.rel_id,
                    cr.rel_rnk,
                    c.custtype AS rel_custtype,
                    c.sed AS rel_sed,
                    c.kf
               FROM customer_rel cr,
                    customer c,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     cr.rel_rnk = c.rnk
                    AND cr.rel_id > 0
                    AND c.kf = kflist.kf
                    --and cr.rel_intext = 1 --лише клієнти банку
                    AND cr.rnk IN (SELECT c.rnk
                                     FROM customer c
                                    WHERE    c.custtype <> 3
                                          OR     (    c.custtype = 3
                                                  AND c.sed = '91')
                                             AND date_off IS NULL)
                    AND cr.rel_rnk IN (SELECT cu.rnk
                                         FROM customer_update cu
                                        WHERE     cu.idupd >
                                                     l_cdc_lastkey_cu_rel
                                              AND cu.idupd <=
                                                     l_cdc_newkey_cu_rel
                                       UNION ALL
                                       SELECT pu.rnk
                                         FROM person_update pu
                                        WHERE     pu.idupd >
                                                     l_cdc_lastkey_pu_rel
                                              AND pu.idupd <=
                                                     l_cdc_newkey_pu_rel
                                       UNION ALL
                                       SELECT ce.id
                                         FROM customer_extern_update ce
                                        WHERE     ce.idupd >
                                                     l_cdc_lastkey_pu_rel
                                              AND ce.idupd <=
                                                     l_cdc_newkey_pu_rel))
      LOOP
         -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
         IF (   cur.rel_custtype != 3
             OR (cur.rel_custtype = 3 AND cur.rel_sed = 91))
         THEN
            l_sync_id :=
               ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rel_rnk), cur.kf);
         ELSE
            l_sync_id :=
               ead_pack.msg_create ('CLIENT', TO_CHAR (cur.rel_rnk), cur.kf);
         END IF;
      END LOOP;

      -- берем всех клиентов, у которых были добавлены 3-и лица за период от последней отправки
      SELECT MAX (cru.idupd)
        INTO l_cdc_newkey_cru_rel
        FROM customer_rel_update cru;

      FOR cur
         IN (SELECT DISTINCT cru.rnk,
                             (SELECT kf
                                FROM customer
                               WHERE rnk = cru.rnk)
                                kf
               FROM customer_rel_update cru
              WHERE     cru.idupd > l_cdc_lastkey_cru_rel
                    AND cru.idupd <= l_cdc_newkey_cru_rel
                    AND cru.rel_id > 0
                    AND cru.rnk IN (SELECT c.rnk
                                      FROM customer c
                                     WHERE (   c.custtype <> 3
                                            OR (c.custtype = 3 AND c.sed = 91))))
      LOOP
         -- поочередно отправляем карточки 3х лиц
         FOR cur1
            IN (SELECT cru.rnk,
                       cru.rel_rnk,
                       c.custtype AS rel_custtype,
                       c.sed AS rel_sed
                  FROM customer_rel_update cru,
                       customer c,
                       (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                          FROM web_barsconfig
                         WHERE     key LIKE 'ead.ServiceUrl%'
                               AND val IS NOT NULL
                               AND val NOT LIKE '-%') kflist
                 WHERE     cru.idupd > l_cdc_lastkey_cru_rel
                       AND cru.idupd <= l_cdc_newkey_cru_rel
                       AND c.kf = kflist.kf
                       AND cru.rel_id > 0
                       AND cru.rel_intext = 1 --лише кліенти банку, не клієнти відправляються в масиві (id, name, okpo) пов'язаними особами на UCLIENT'
                       AND cru.rel_rnk = c.rnk
                       AND cru.rnk = cur.rnk)
         LOOP
            -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
            IF (   cur1.rel_custtype != 3
                OR (cur1.rel_custtype = 3 AND cur1.rel_sed = '91'))
            THEN
               l_sync_id :=
                  ead_pack.msg_create ('UCLIENT',
                                       TO_CHAR (cur1.rel_rnk),
                                       cur.kf);
            ELSE
               l_sync_id :=
                  ead_pack.msg_create ('CLIENT',
                                       TO_CHAR (cur1.rel_rnk),
                                       cur.kf);
            END IF;
         END LOOP;

         FOR cur2
            IN (SELECT cr.rnk,
                       cr.rel_rnk,
                       cext.custtype AS rel_custtype,
                       cext.sed AS rel_sed
                  FROM customer_extern_update cext, customer_rel cr
                 WHERE     cext.idupd > l_cdc_lastkey_cru_rel
                       AND cext.idupd <= l_cdc_newkey_cru_rel
                       AND cr.rel_id > 0
                       AND cr.rel_rnk = cext.id
                       AND cr.rnk = cur.rnk)
         LOOP
            -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
            IF (   cur2.rel_custtype != 3
                OR (cur2.rel_custtype = 3 AND cur2.rel_sed = '91'))
            THEN
               l_sync_id :=
                  ead_pack.msg_create ('UCLIENT',
                                       TO_CHAR (cur2.rel_rnk),
                                       cur.kf);
            ELSE
               l_sync_id :=
                  ead_pack.msg_create ('CLIENT',
                                       TO_CHAR (cur2.rel_rnk),
                                       cur.kf);
            END IF;
         END LOOP;

         -- добавляем основного клиента
         l_sync_id :=
            ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.kf); --не клієнти відправляться тут, якщо вони були додані.
      END LOOP;

      -- сохраняем ключи захвата
      set_cdc_newkeys (l_cdc_newkey_cu_corp,
                       l_cdc_newkey_cpu_corp,
                       l_cdc_newkey_cu_rel,
                       l_cdc_newkey_pu_rel,
                       l_cdc_newkey_cru_rel);

      COMMIT;
   END cdc_client_u;

   -- Захват изменений - Угода Юр.лица.
   PROCEDURE cdc_agr_u
   IS
      l_sync_id                 ead_sync_queue.id%TYPE;

      l_cdc_lastkey_dpt         dpu_deal_update.idu%TYPE; --для депозитів деп.модуля
      l_cdc_newkey_dpt          dpu_deal_update.idu%TYPE;
      l_cdc_lastkey_acc         accounts_update.idupd%TYPE;  --поточні рахунки
      l_cdc_newkey_acc          accounts_update.idupd%TYPE;
      l_cdc_lastkey_specparam   specparam_update.idupd%TYPE;
      l_cdc_newkey_specparam    specparam_update.idupd%TYPE;
      l_cdc_lastkey_dpt_old     accounts_update.idupd%TYPE; --для депозитів поза деп.модулем
      l_cdc_newkey_dpt_old      accounts_update.idupd%TYPE;


      -- получение ключей захвата изменений
      PROCEDURE get_cdc_lastkeys (
         p_dpt         OUT dpu_deal_update.idu%TYPE,
         p_acc         OUT accounts_update.idupd%TYPE,
         p_dpt_old     OUT accounts_update.idupd%TYPE,
         p_specparam   OUT specparam_update.idupd%TYPE)
      IS
         l_cdc_lastkey   ead_sync_sessions.cdc_lastkey%TYPE;
      BEGIN
         SELECT NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               1)),
                     0),
                NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               2)),
                     0),
                NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               3)),
                     0),
                NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               4)),
                     0)
           INTO p_dpt,
                p_acc,
                p_dpt_old,
                p_specparam
           FROM ead_sync_sessions ss
          WHERE ss.type_id = 'UAGR';
      EXCEPTION
         WHEN OTHERS
         THEN
            SELECT MAX (ddu.idu)
              INTO p_dpt
              FROM dpu_deal_update ddu;

            SELECT MAX (au.idupd)
              INTO p_acc
              FROM accounts_update au;

            SELECT MAX (au.idupd)
              INTO p_dpt_old
              FROM accounts_update au;

            SELECT MAX (su.idupd)
              INTO p_specparam
              FROM specparam_update su;
      END get_cdc_lastkeys;

      -- сохранение ключей захвата изменений
      PROCEDURE set_cdc_newkeys (
         p_dpt         IN dpu_deal_update.idu%TYPE,
         p_acc         IN accounts_update.idupd%TYPE,
         p_dpt_old     IN accounts_update.idupd%TYPE,
         p_specparam   IN specparam_update.idupd%TYPE)
      IS
         l_cdc_newkey   ead_sync_sessions.cdc_lastkey%TYPE;
      BEGIN
         -- делаем составной ключ путем конкатенации
         l_cdc_newkey :=
               TO_CHAR (p_dpt)
            || ';'
            || TO_CHAR (p_acc)
            || ';'
            || TO_CHAR (p_dpt_old)
            || ';'
            || TO_CHAR (p_specparam);

         UPDATE ead_sync_sessions ss
            SET ss.cdc_lastkey = l_cdc_newkey
          WHERE ss.type_id = 'UAGR';

         IF (SQL%ROWCOUNT = 0)
         THEN
            INSERT INTO ead_sync_sessions (type_id, cdc_lastkey)
                 VALUES ('UAGR', l_cdc_newkey);
         END IF;
      END set_cdc_newkeys;
   BEGIN
      --bc.go('/');
      --sec_aud_temp_write ('EAD: cdc_agr_u');
      -- получение ключей захвата изменений
      get_cdc_lastkeys (l_cdc_lastkey_dpt,
                        l_cdc_lastkey_acc,
                        l_cdc_lastkey_dpt_old,
                        l_cdc_lastkey_specparam);

      -- депезиты по которым были изменения(заведені в деп.модулі)
      SELECT MAX (ddu.idu)
        INTO l_cdc_newkey_dpt
        FROM dpu_deal_update ddu;

      FOR cur
         IN (SELECT 'DPT' AS agr_type,
                    ddu.dpu_id,
                    ddu.rnk,
                    ddu.kf
               FROM dpu_deal_update ddu,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     ddu.idu > l_cdc_lastkey_dpt
                    AND ddu.idu <= l_cdc_newkey_dpt
                    AND ddu.kf = kflist.kf
                    AND (   EXISTS
                               (SELECT 1
                                  FROM accounts acc
                                 WHERE     DDU.ACC = acc.ACC
                                       AND (   ( (    acc.NBS = '2600'
                                                  AND acc.ob22 = '05'))
                                            OR (acc.NBS IN (SELECT nbs
                                                              FROM EAD_NBS
                                                             WHERE custtype =
                                                                      3)))
                                       AND acc.TIP = 'DEP')
                         OR EXISTS
                               (SELECT 1
                                  FROM accounts acc
                                 WHERE DDU.ACC = acc.ACC AND acc.TIP = 'NL8')))
      LOOP
         -- на всякий передаем клиента
         l_sync_id :=
            ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.kf);
         -- за ним сделку
         l_sync_id :=
            ead_pack.msg_create ('UAGR',
                                 cur.agr_type || ';' || TO_CHAR (cur.dpu_id),
                                 cur.kf);
      END LOOP;

      -- депезиты по которым были изменения(заведені поза  деп.модулем)
      SELECT MAX (au.idupd)
        INTO l_cdc_newkey_dpt_old
        FROM accounts_update au;

      FOR cur
         IN (SELECT DISTINCT 'DPT_OLD' AS agr_type,
                             TRUNC (au.daos) AS date_open,
                             au.nls,
                             au.acc,
                             au.rnk,
                             acc.kf
               FROM accounts_update au,
                    accounts acc,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     au.idupd > l_cdc_lastkey_dpt_old
                    AND au.idupd <= l_cdc_newkey_dpt_old
                    AND acc.kf = kflist.kf
                    AND acc.acc = au.acc
                    AND au.rnk IN (SELECT c.rnk
                                     FROM customer c
                                    WHERE    c.custtype <> 3
                                          OR (c.custtype = 3 AND c.sed = '91'))
                    AND (   (acc.NBS = '2600' AND acc.ob22 = '05')
                         OR (acc.NBS IN (SELECT nbs
                                           FROM EAD_NBS
                                          WHERE custtype = 3)))
                    AND acc.TIP NOT IN ('DEP', 'NL8'))
      LOOP
         -- на всякий передаем клиента
         l_sync_id :=
            ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.kf);
         -- за ним сделку
         l_sync_id :=
            ead_pack.msg_create (
               'UAGR',
                  cur.agr_type
               || ';'
               || cur.nls
               || '|'
               || TO_CHAR (cur.date_open, 'yyyymmdd')
               || '|'
               || TO_CHAR (cur.acc),
               cur.kf);
      END LOOP;

      -- текущие счета клиентов ЮЛ по которым были изменения
      SELECT MAX (au.idupd)
        INTO l_cdc_newkey_acc
        FROM accounts_update au;

      SELECT MAX (su.idupd)
        INTO l_cdc_newkey_specparam
        FROM specparam_update su;

      IF (l_cdc_lastkey_acc = 0)
      THEN
         l_cdc_lastkey_acc := l_cdc_newkey_acc;
      END IF;

      IF (l_cdc_lastkey_specparam = 0)
      THEN
         l_cdc_lastkey_specparam := l_cdc_newkey_specparam;
      END IF;

      --перероблено на одну відпрвку по одному рахунку при змінах в accounts or specparam
      FOR cur
         IN (SELECT DISTINCT 'ACC' AS agr_type,
                             au.acc AS acc,
                             au.rnk AS rnk,
                             au.kf
               FROM accounts_update au,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     au.idupd > l_cdc_lastkey_acc
                    AND au.idupd <= l_cdc_newkey_acc
                    AND au.kf = kflist.kf
                    AND au.rnk IN (SELECT c.rnk
                                     FROM customer c
                                    WHERE    c.custtype <> 3
                                          OR (c.custtype = 3 AND c.sed = '91'))
                    AND NOT EXISTS
                           (SELECT 1
                              FROM dpu_accounts da
                             WHERE da.accid = au.acc)
                    AND EXISTS
                           (SELECT 1
                              FROM accounts a
                             WHERE     a.acc = au.acc
                                   AND (   (CASE
                                               WHEN     a.daos =
                                                           TRUNC (a.dazs)
                                                    AND nbs IS NULL
                                               THEN
                                                  SUBSTR (a.nls, 1, 4)
                                               ELSE
                                                  a.nbs
                                            END) IN ( (SELECT nbs
                                                         FROM EAD_NBS
                                                        WHERE custtype = 2))
                                        OR (    (CASE
                                                    WHEN     a.daos =
                                                                TRUNC (
                                                                   a.dazs)
                                                         AND nbs IS NULL
                                                    THEN
                                                       SUBSTR (a.nls, 1, 4)
                                                    ELSE
                                                       a.nbs
                                                 END) = '2600'
                                            AND a.ob22 IN ('01', '02', '10')))
                                   AND au.tip NOT IN ('DEP', 'DEN', 'NL8'))
             UNION
             SELECT DISTINCT 'ACC' AS agr_type,
                             su.acc AS acc,
                             au.rnk AS rnk,
                             su.kf
               FROM specparam_update su,
                    accounts au,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     su.acc = au.acc
                    AND su.idupd > l_cdc_lastkey_specparam
                    AND su.idupd <= l_cdc_newkey_specparam
                    AND au.kf = kflist.kf
                    AND au.rnk IN (SELECT c.rnk
                                     FROM customer c,
                                          (SELECT TRIM (
                                                     REPLACE (
                                                        key,
                                                        'ead.ServiceUrl',
                                                        ''))
                                                     KF
                                             FROM web_barsconfig
                                            WHERE     key LIKE
                                                         'ead.ServiceUrl%'
                                                  AND val IS NOT NULL
                                                  AND val NOT LIKE '-%')
                                          kflist
                                    WHERE    c.custtype <> 3
                                          OR     (    c.custtype = 3
                                                  AND c.sed = '91')
                                             AND c.kf = kflist.kf)
                    AND NOT EXISTS
                           (SELECT 1
                              FROM dpu_accounts da
                             WHERE da.accid = au.acc)
                    AND EXISTS
                           (SELECT 1
                              FROM accounts a,
                                   (SELECT TRIM (
                                              REPLACE (key,
                                                       'ead.ServiceUrl',
                                                       ''))
                                              KF
                                      FROM web_barsconfig
                                     WHERE     key LIKE 'ead.ServiceUrl%'
                                           AND val IS NOT NULL
                                           AND val NOT LIKE '-%') kflist
                             WHERE     a.acc = au.acc
                                   AND a.kf = kflist.kf
                                   AND (   (CASE
                                               WHEN     a.daos =
                                                           TRUNC (a.dazs)
                                                    AND nbs IS NULL
                                               THEN
                                                  SUBSTR (a.nls, 1, 4)
                                               ELSE
                                                  a.nbs
                                            END) IN (SELECT nbs
                                                       FROM EAD_NBS
                                                      WHERE custtype = 2)
                                        OR (    (CASE
                                                    WHEN     a.daos =
                                                                TRUNC (
                                                                   a.dazs)
                                                         AND nbs IS NULL
                                                    THEN
                                                       SUBSTR (a.nls, 1, 4)
                                                    ELSE
                                                       a.nbs
                                                 END) = '2600'
                                            AND a.ob22 IN ('01', '02', '10'))))
                    AND au.tip NOT IN ('DEP', 'DEN', 'NL8'))
      LOOP
         -- на всякий передаем клиента
         l_sync_id :=
            ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.kf);
         -- за ним сделку
  -- за ним сделку, если это "старый счет" = не в рамках ДБО
         IF get_acc_info (cur.acc) = 0
         THEN
            bars_audit.info (
                  'ead_pack.msg_create(''UAGR'', '
               || cur.agr_type
               || ','
               || TO_CHAR (cur.acc));
            l_sync_id :=
               ead_pack.msg_create ('UAGR',
                                    cur.agr_type || ';' || TO_CHAR (cur.acc), cur.kf);
         ELSE
            IF is_first_accepted_acc (cur.acc) = 1
            THEN
               l_sync_id :=
                  ead_pack.msg_create ('UAGR', 'DBO;' || TO_CHAR (cur.rnk), cur.kf);
            END IF;
         END IF;
      END LOOP;

      -- сохранение ключей захвата изменений
      set_cdc_newkeys (l_cdc_newkey_dpt,
                       l_cdc_newkey_acc,
                       l_cdc_newkey_dpt_old,
                       l_cdc_newkey_specparam);

      COMMIT;
   END cdc_agr_u;

   -- Захват изменений - счета клієнта Юр.Лицо
   PROCEDURE cdc_acc
   IS
      l_sync_id           ead_sync_queue.id%TYPE;

      l_cdc_lastkey_acc   accounts_update.idupd%TYPE;
      l_cdc_newkey_acc    accounts_update.idupd%TYPE;

      -- получение ключей захвата изменений
      PROCEDURE get_cdc_lastkeys (p_acc OUT accounts_update.idupd%TYPE)
      IS
         l_cdc_lastkey   ead_sync_sessions.cdc_lastkey%TYPE;
      BEGIN
         SELECT ss.cdc_lastkey
           INTO l_cdc_lastkey
           FROM ead_sync_sessions ss
          WHERE ss.type_id = 'ACC';

         p_acc := TO_NUMBER (l_cdc_lastkey);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT MAX (au.idupd)
              INTO p_acc
              FROM accounts_update au;
      END get_cdc_lastkeys;

      -- сохранение ключей захвата изменений
      PROCEDURE set_cdc_newkeys (p_acc IN accounts_update.idupd%TYPE)
      IS
         l_cdc_newkey   ead_sync_sessions.cdc_lastkey%TYPE;
      BEGIN
         -- делаем составной ключ путем конкатенации
         l_cdc_newkey := TO_CHAR (p_acc);

         UPDATE ead_sync_sessions ss
            SET ss.cdc_lastkey = l_cdc_newkey
          WHERE ss.type_id = 'ACC';

         IF (SQL%ROWCOUNT = 0)
         THEN
            INSERT INTO ead_sync_sessions (type_id, cdc_lastkey)
                 VALUES ('ACC', l_cdc_newkey);
         END IF;
      END set_cdc_newkeys;
   BEGIN
      --bc.go('/');
      --sec_aud_temp_write ('EAD: cdc_acc');
      -- получение ключей захвата изменений
      get_cdc_lastkeys (l_cdc_lastkey_acc);

      -- берем все изменения по счетам клиентов
      SELECT MAX (au.idupd)
        INTO l_cdc_newkey_acc
        FROM accounts_update au;

      FOR cur
         IN (SELECT 'DPT' AS agr_type, au.acc, au.kf
               FROM accounts_update au,
                    accounts acc,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     au.idupd > l_cdc_lastkey_acc
                    AND au.idupd <= l_cdc_newkey_acc
                    AND acc.kf = kflist.kf
                    AND acc.acc = au.acc
                    AND acc.TIP IN ('DEP', 'NL8')
                    AND (   (    (CASE
                                     WHEN     acc.daos = TRUNC (acc.dazs)
                                          AND acc.nbs IS NULL
                                     THEN
                                        SUBSTR (acc.nls, 1, 4)
                                     ELSE
                                        acc.nbs
                                  END) = '2600'
                             AND acc.ob22 = '05')
                         OR ( (CASE
                                  WHEN     acc.daos = TRUNC (acc.dazs)
                                       AND acc.nbs IS NULL
                                  THEN
                                     SUBSTR (acc.nls, 1, 4)
                                  ELSE
                                     acc.nbs
                               END) IN (SELECT nbs
                                          FROM EAD_NBS
                                         WHERE custtype = 3)))
                    AND EXISTS
                           (SELECT 1
                              FROM dpu_accounts da
                             WHERE da.accid = au.acc)
             UNION ALL
             SELECT 'ACC' AS agr_type, au.acc, au.kf
               FROM accounts_update au,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     au.idupd > l_cdc_lastkey_acc
                    AND au.idupd <= l_cdc_newkey_acc
                    AND au.kf = kflist.kf
                    AND au.rnk IN (SELECT c.rnk
                                     FROM customer c
                                    WHERE    c.custtype <> 3
                                          OR (c.custtype = 3 AND c.sed = '91'))
                    AND EXISTS
                           (SELECT 1
                              FROM accounts a
                             WHERE     a.acc = au.acc
                                   AND (   (CASE
                                               WHEN     a.daos =
                                                           TRUNC (a.dazs)
                                                    AND nbs IS NULL
                                               THEN
                                                  SUBSTR (a.nls, 1, 4)
                                               ELSE
                                                  a.nbs
                                            END) IN (SELECT nbs
                                                       FROM EAD_NBS
                                                      WHERE custtype = 2)
                                        OR (    (CASE
                                                    WHEN     a.daos =
                                                                TRUNC (
                                                                   a.dazs)
                                                         AND nbs IS NULL
                                                    THEN
                                                       SUBSTR (a.nls, 1, 4)
                                                    ELSE
                                                       a.nbs
                                                 END) = '2600'
                                            AND a.ob22 IN ('01', '02', '10')))
                                   AND a.tip NOT IN ('DEP', 'DEN', 'NL8'))
                    AND NOT EXISTS
                           (SELECT 1
                              FROM dpu_accounts da
                             WHERE da.accid = au.acc)
             UNION ALL
             SELECT 'DPT_OLD' AS agr_type, au.acc, au.kf
               FROM accounts_update au,
                    accounts acc,
                    (SELECT TRIM (REPLACE (key, 'ead.ServiceUrl', '')) KF
                       FROM web_barsconfig
                      WHERE     key LIKE 'ead.ServiceUrl%'
                            AND val IS NOT NULL
                            AND val NOT LIKE '-%') kflist
              WHERE     au.idupd > l_cdc_lastkey_acc
                    AND au.idupd <= l_cdc_newkey_acc
                    AND acc.kf = kflist.kf
                    AND acc.acc = au.acc
                    AND au.rnk IN (SELECT c.rnk
                                     FROM customer c
                                    WHERE    c.custtype <> 3
                                          OR (c.custtype = 3 AND c.sed = '91'))
                    AND (   (    (CASE
                                     WHEN     acc.daos = TRUNC (acc.dazs)
                                          AND acc.nbs IS NULL
                                     THEN
                                        SUBSTR (acc.nls, 1, 4)
                                     ELSE
                                        acc.nbs
                                  END) = '2600'
                             AND acc.ob22 = '05')
                         OR ( (CASE
                                  WHEN     acc.daos = TRUNC (acc.dazs)
                                       AND acc.nbs IS NULL
                                  THEN
                                     SUBSTR (acc.nls, 1, 4)
                                  ELSE
                                     acc.nbs
                               END) IN (SELECT nbs
                                          FROM EAD_NBS
                                         WHERE custtype = 3)))
                    AND acc.TIP NOT IN ('DEP', 'NL8'))
      LOOP
         l_sync_id :=
            ead_pack.msg_create ('ACC',
                                 cur.agr_type || ';' || TO_CHAR (cur.acc),
                                 cur.kf);
      END LOOP;

      -- сохранение ключей захвата изменений
      set_cdc_newkeys (l_cdc_newkey_acc);

      COMMIT;
   END cdc_acc;

   -- !!! Пока в ручном режиме DICT  Довідник  SetDictionaryData

   -- Передача в ЭА сообщение типа
   PROCEDURE type_process (p_type_id IN ead_types.id%TYPE)
   IS
      l_t_row   ead_types%ROWTYPE;
      l_s_row   ead_sync_sessions%ROWTYPE;
      l_rows    NUMBER;    --ограничение кол-ва строк обработки за один запуск

      FUNCTION get_sum (n NUMBER)
         RETURN NUMBER
      IS
         l_res   NUMBER := 0;
      BEGIN
         FOR i IN 1 .. n
         LOOP
            l_res := l_res + i;
         END LOOP;

         RETURN l_res;
      END get_sum;
   BEGIN
      --sec_aud_temp_write ('EAD: type_process');

      -- параметры
      SELECT *
        INTO l_t_row
        FROM ead_types t
       WHERE t.id = p_type_id;

      BEGIN
         SELECT *
           INTO l_s_row
           FROM ead_sync_sessions s
          WHERE s.type_id = p_type_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
               'type_process: не найдено ключа=' || p_type_id);
      END;

      -- дата/время старта
      l_s_row.sync_start := SYSDATE;

      --кол-во строк за один пробег
      BEGIN
         SELECT NVL (val, 1000)
           INTO l_rows
           FROM PARAMS$GLOBAL
          WHERE par = 'EAD_ROWS';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_rows := 1000;
      END;

      -- обработка каждого запроса по отдельности
      FOR cur
         IN (select * from (SELECT sq.id,
                    sq.crt_date,
                    sq.type_id,
                    sq.status_id,
                    sq.err_count,
                    sq.kf
               FROM ead_sync_queue sq
              WHERE     sq.type_id = p_type_id
                    AND sq.status_id IN ('NEW', 'ERROR')
                    AND nvl(sq.err_count, 0) < 30
--                    and regexp_like(sq.err_text, 'rnk \d+ not found', 'i')
                    AND sq.crt_date > ADD_MONTHS (SYSDATE, -1 * g_process_actual_time)
               order by status_id desc, id asc) where ROWNUM < NVL (l_rows, 1000))
      LOOP
         IF (cur.status_id = 'NEW')
         THEN
            -- новые отправляем
            msg_process (cur.id, cur.kf);
         ELSE
            IF ( (l_s_row.sync_start - cur.crt_date) * 24 * 60 >=
                   l_t_row.msg_lifetime)
            THEN
               -- если вышло время актуальности, то сбрасываем в OUTDATED
               msg_set_status_outdated (cur.id, cur.kf);
            ELSIF ( (l_s_row.sync_start - cur.crt_date) * 24 * 60 >=
                        l_t_row.msg_retry_interval
                      * get_sum (cur.err_count + 1))
            THEN
               -- смотрим пришло ли время повторного запроса
               msg_process (cur.id, cur.kf);
            END IF;
         END IF;
      END LOOP;

      -- дата/время финиша
      l_s_row.sync_end := SYSDATE;

      -- сохраняем
      UPDATE ead_sync_sessions s
         SET s.sync_start = l_s_row.sync_start, s.sync_end = l_s_row.sync_end
       WHERE s.type_id = p_type_id;

      COMMIT;
   END type_process;

   FUNCTION get_acc_info (p_acc IN accounts.acc%TYPE)
      RETURN INT
   IS
      l_result   INT := 0;
      l_ndbo     VARCHAR2 (50);
      l_sdbo     VARCHAR2 (50);
      l_daos     DATE;
   BEGIN
      -- узнать, является ли счет - счетом в рамках ДБО
      --1) наличие у клиента ДБО-договора
      SELECT kl.get_customerw (rnk, 'NDBO'),
             kl.get_customerw (rnk, 'DDBO'),
             daos
        INTO l_ndbo, l_sdbo, l_daos
        FROM accounts
       WHERE acc = p_acc;

      --2) если нет договора ДБО - то точно это обычный, резалт еще 0
      --3) если ДБО оформлен, счет может быть открыт до ДБО, его считаем "старым"
      IF (    l_ndbo IS NOT NULL
          AND TRUNC (l_daos) >=
                 TO_DATE (REPLACE (l_sdbo, '.', '/'), 'dd/mm/yyyy'))
      THEN
         l_result := 1;
      END IF;

      RETURN l_result;
   END;

   -- функция возвращает 1 если это первый акцептированный счет в рамках ДБО, 0 - если не первый
   FUNCTION is_first_accepted_acc (p_acc IN accounts.acc%TYPE)
      RETURN INT
   IS
      l_result   INT := 0;
      l_rnk      customer.rnk%TYPE;
      l_count    INT := 0;
   BEGIN
      IF (get_acc_info (p_acc) = 1)                       -- счет в рамках ДБО
      THEN
         BEGIN
            SELECT rnk
              INTO l_rnk
              FROM accounts
             WHERE     acc = p_acc
                   AND nbs IS NOT NULL -- это значит, что счет точно не в статусе "зарезервирован"
                   AND nbs IN (SELECT nbs FROM EAD_NBS);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_rnk := NULL;
         END;
      END IF;

      IF l_rnk IS NOT NULL
      THEN
         SELECT COUNT (acc)
           INTO l_count
           FROM accounts
          WHERE     rnk = l_rnk
                AND nbs IN (SELECT nbs FROM EAD_NBS) -- значит счет не в статусе "зарезервирован", раз у него есть НБС
                AND get_acc_info (acc) = 1 -- значит другие счета относятся к договору ДБО
                AND acc != p_acc;
      END IF;

      IF l_count = 0
      THEN
         l_result := 1;
      END IF;

      RETURN l_result;
   END;
BEGIN
   -- Initialization
   NULL;
END ead_pack;
/
 show err;
 
PROMPT *** Create  grants  EAD_PACK ***
grant EXECUTE                                                                on EAD_PACK        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ead_pack.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 