 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ead_pack.sql =========*** Run *** ==
 PROMPT ===================================================================================== 

 CREATE OR REPLACE PACKAGE EAD_PACK is

  -- Author  : TVSUKHOV
  -- Created : 12.06.2013 16:56:08
  -- Changed : 08.02.2016 A.Yurchenko
  -- Purpose : Взаємодія з ЕА

  -- Public type declarations
  -- type <TypeName> is <Datatype>;
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 3.3  10.08.2018 MMFO';

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;
  -- Public constant declarations
  g_transfer_timeout constant number := 180;
  function g_process_actual_time return number;

  -- Сброс (обнуление) Сиквенсов в базе
  procedure reset_seq(p_seq_name in varchar2);
  -- Сброс (обнуление) Сиквенсов.
  -- Если год обновления в справочнике отличается от текущего года  sysdate - обнуляем все сиквенсы из справочника EAD_GENSEQUENCEKF
  procedure ead_reset_seq;

   -- Добивает спереди строку нулями.
  function add_0_num (p_InNum number,
                      p_0Num  number default 8) return varchar2;

   -- Унікальний № друку.
  function print_number (p_kf  IN ead_sync_queue.kf%TYPE,
                         p_num in number --10	АБС «БАРС», 20	Card Management, 99	Електронний архів (ІМС)
                         ) return  varchar2;

  -- Проверка изменений по счету, которые необходимо отправлять в ЕА.
  function Check_Acc_update (p_acc        number,
          --                   p_kf         VARCHAR2,
                             p_idupd_from number,
                             p_idupd_to   number ) return number;

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
                      p_agr_id       in ead_docs.agr_id%type default null,
                      p_acc          in ead_docs.acc%type default null)
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

  --Установить статус сообщению
  PROCEDURE msg_set_status(p_sync_id   IN ead_sync_queue.id%TYPE,
                           p_status_id IN EAD_SYNC_QUEUE.STATUS_ID%TYPE);
  --Установить параметры сообщению
  PROCEDURE msg_set_message(p_sync_id       IN ead_sync_queue.id%TYPE,
                            p_status_id     IN ead_sync_queue.status_id%TYPE,
                            p_message_id    IN ead_sync_queue.message_id%TYPE,
                            p_message_date  IN ead_sync_queue.message_date%TYPE,
                            p_message       IN ead_sync_queue.MESSAGE%TYPE,
                            p_responce      IN ead_sync_queue.responce%TYPE,
                            p_responce_id   IN ead_sync_queue.responce_id%TYPE,
                            p_responce_date IN ead_sync_queue.responce_date%TYPE,
                            p_err_text      IN ead_sync_queue.err_text %TYPE,
                            p_err_count     IN ead_sync_queue.err_count %TYPE);

  -- апдейт таблиці ead_sync_sessions по конкретному типу
  procedure update_sync_sessions(p_type_id    in bars.ead_types.id%type,
                                 p_sync_start in bars.ead_sync_sessions.sync_start%type,
                                 p_sync_end   in bars.ead_sync_sessions.sync_end %type);

  -- Створити повідомлення
  function msg_create(p_type_id in ead_sync_queue.type_id%type,
                      p_obj_id  in ead_sync_queue.obj_id%type,
                      p_rnk     in ead_sync_queue.rnk%TYPE,
                      p_kf      in ead_sync_queue.KF%TYPE)
    return ead_sync_queue.id%type;

  procedure msg_create (p_type_id   IN ead_sync_queue.type_id%TYPE,
                        p_obj_id    IN ead_sync_queue.obj_id%TYPE,
                        p_rnk       IN ead_sync_queue.rnk%TYPE,
                        p_kf        IN ead_sync_queue.kf%TYPE);

  -- Отправить сообщение на прокси веб-сервис
  procedure msg_process (p_sync_id   IN ead_sync_queue.id%TYPE,
                         p_kf        IN ead_sync_queue.KF%TYPE,
                         p_force     IN character default null); -- если нужно протолкнуть мес несмотя на то что он уже отправлен или устарел

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
  procedure cdc_uacc;

  -- Захват изменений - Надрукований документ
  procedure cdc_doc;

  -- Захват изменений - счета физлиц (2625,2630)
  PROCEDURE cdc_acc;

  procedure get_sync_queue_proc(p_type           in varchar2,
                                p_kf             in varchar2,
                                p_count          in number,
                                p_retry_interval in number,
                                res              out t_ead_sync_que_list);

  -- !!! Пока в ручном режиме DICT  Довідник  SetDictionaryData

  -- Передача в ЭА сообщение типа
  procedure type_process;
  -- функция возвращает 0 если счет не в рамках ДБО, 1 если счет в рамках ДБО
  function get_acc_info(p_acc in accounts.acc%type) return int;
  -- функция возвращает 1 если это первый акцептированный счет в рамках ДБО, 0 - если не первый
  function is_first_accepted_acc(p_acc in accounts.acc%type) return int;

  -- функция возвращает nbs для открытого и псевдо - nbs для зарезервированного счета
  function get_acc_nbs(p_acc in accounts.acc%type) return char;
  -- функция возвращает "2" для юрлиц и спд, "3" для фо

  function LOCK_ROW(rid in rowid) return number;
  function get_custtype(p_rnk in customer.rnk%type) return number;

end ead_pack;
/
CREATE OR REPLACE PACKAGE BODY EAD_PACK IS

   g_body_version constant varchar2(64) := 'version 3.3  10.08.2018 MMFO';
   kflist bars.string_list; -- Список рабочих kf
   gn_dummy   number;  -- Для возвратов функций

   function body_version return varchar2 is
   begin
      return 'Package body ead_pack ' || g_body_version;
   end body_version;

   function header_version return varchar2 is
   begin
      return 'Package body ead_pack ' || g_body_version;
   end header_version;

  function g_process_actual_time return number is
  begin
    return 1;
  end g_process_actual_time;

  function g_wsproxy_url return varchar2 is
    l_wsproxy_url varchar2(100);
  begin
    select min(b.val)
      into l_wsproxy_url
      from web_barsconfig b
     where b.key = 'ead.WSProxy.Url';
    return l_wsproxy_url;
  end g_wsproxy_url;

  function g_wsproxy_walletdir return varchar2 is
    l_wsproxy_walletdir varchar2(100);
  begin
    select min(val)
      into l_wsproxy_walletdir
      from web_barsconfig
     where key = 'ead.WSProxy.WalletDir';
    return l_wsproxy_walletdir;
  end g_wsproxy_walletdir;

  function g_wsproxy_walletpass return varchar2 is
    l_wsproxy_walletpass varchar2(100);
  begin
    select min(val)
      into l_wsproxy_walletpass
      from web_barsconfig
     where key = 'ead.WSProxy.WalletPass';
    return l_wsproxy_walletpass;
  end g_wsproxy_walletpass;

  function g_wsproxy_ns return varchar2 is
    l_wsproxy_ns varchar2(100);
  begin
    select min(val)
      into l_wsproxy_ns
      from web_barsconfig
     where key = 'ead.WSProxy.NS';
    return l_wsproxy_ns;
  end g_wsproxy_ns;

  function g_wsproxy_username return varchar2 is
    l_wsproxy_username varchar2(100);
  begin
    select min(val)
      into l_wsproxy_username
      from web_barsconfig
     where key = 'ead.WSProxy.UserName';
    return l_wsproxy_username;
  end g_wsproxy_username;

  function g_wsproxy_password return varchar2 is
    l_wsproxy_password varchar2(100);
  begin
    select min(val)
      into l_wsproxy_password
      from web_barsconfig
     where key = 'ead.WSProxy.Password';
    return l_wsproxy_password;
  end g_wsproxy_password;

   -- Private variable declarations
   -- < VariableName > < Datatype >;

   -- Function and procedure implementations

   -- Обнуление сиквенсов в БД
  procedure reset_seq(p_seq_name in varchar2) is
    l_val number;
  begin
    execute immediate 'select ' || p_seq_name || '.nextval from dual'
      INTO l_val;

    execute immediate 'alter sequence ' || p_seq_name || ' increment by -' ||
                      l_val || ' minvalue 0';

    execute immediate 'select ' || p_seq_name || '.nextval from dual'
      INTO l_val;

    execute immediate 'alter sequence ' || p_seq_name ||
                      ' increment by 1 minvalue 0';
  end;

  -- Обнуление Сиквенсов.
  -- Если год обновления в справочнике отличается от текущего года  sysdate - обнуляем все сиквенсы из справочника EAD_GENSEQUENCEKF
  procedure ead_reset_seq is
      l_yestaryear varchar2(4);
      l_year       varchar2(4);

  begin
   begin

  for rec in (  select sq.sequence, sq.id, extract(year from sysdate) sys_date ,extract(year from sq.date_update) seq_date
                     from EAD_GENSEQUENCEKF sq
                       where extract(year from sq.date_update) <> extract(year from sysdate)
      )
 loop

 begin
   -- Обнуляем сиквенс
   ead_pack.reset_seq(p_seq_name => rec.sequence);

   update EAD_GENSEQUENCEKF sq set sq.date_update = sysdate where sq.sequence = rec.sequence ;
      exception
        when others then
          bars_audit.info('ead_pack.ead_reset_seq: Ошибка при обнулении сиквенса' || rec.sequence||':->'||sqlerrm);
      end;

 end loop;
/* if SQL%NOTFOUND  then  null; end if; */
       end;
 end ead_reset_seq;

   -- Функция добивает спереди строку нулями.
 function add_0_num (p_InNum  number, p_0Num number default 8) return varchar2 is
   l_InNum   varchar2(15);
   l_LengRef number(15);
  begin
    begin

  select  length(p_InNum)
   into  l_LengRef
   from dual;

   if  l_LengRef < p_0Num then
    l_InNum := lpad(p_InNum, p_0Num,0);
   else
      l_InNum := p_InNum;
   end if;

   return l_InNum;
     end;
  end add_0_num;


   -- Унікальний № друку.
  function print_number (p_kf  IN ead_sync_queue.kf%TYPE,
                         p_num in number --10	АБС «БАРС», 20	Card Management, 99	Електронний архів (ІМС)
                         ) return  varchar2 is

   l_kf       varchar2(6);
   l_prn_num  varchar2(225);
   l_point    varchar2(1):='.'; -- куда-то терялась точка в номере. По этому сделал так....
   l_sequence varchar2(255);
   l_ru_num   varchar2(5):='01';  --- Справочник (- код РУ, у відділенні якого співробітник формував документ )
   l_date     varchar2(10):= to_char(gl.bd,'YY');
    begin
     begin
   l_kf := nvl(p_kf, sys_context ('bars_context', 'user_mfo'));

  -- обнуляем сиквенсы, если необходимо.
   ead_pack.ead_reset_seq;

  --  <- Справочник сюда!
  select  s.sequence, s.id
  into l_sequence, l_ru_num
    from EAD_GENSEQUENCEKF s where s.kf = nvl(p_kf,l_kf);

  -- l_ru_num Генерим последовательный номер и добиваем 0(в начале строки) до необходимого количества символов = 7
  execute immediate 'select '||p_num||l_ru_num||l_date||'||ead_pack.add_0_num( '||l_sequence||'.Nextval,7) from dual'
                       into l_prn_num;


   return substr(l_prn_num,1,6)||l_point||substr(l_prn_num,7,7);

     end;
   end;

   -- Проверка изменений по счету, которые необходимо отправлять в ЕА.
  function Check_Acc_update (p_acc        number,
                        --     p_kf         VARCHAR2,
                             p_idupd_from number,
                             p_idupd_to   number ) return number is
    l_idupd number(38);
    l_acc number(38);
  begin
 -----
    begin
      select xx.acc, xx.idupd
        into l_acc , l_idupd
         from (
          select max(x.idupd) idupd
                    ,x.acc
                    ,x.nls,  x.kv  , x.kf, x.daos, x.dazs, x.doneby
                    ,x.blkd, x.blkk,
                      row_number() over(partition by x.acc order by max(x.idupd)) rn
                   --  ,count(x.acc)over(partition by x.acc order by x.acc) c_n
                    ,x.c_n
        from (select au.idupd
                    ,au.acc
                    ,au.nls,  au.kv  , au.kf, au.daos, au.dazs, au.doneby
                    ,au.blkd, au.blkk -- состояние счета вычисляется в EAD_integration
              from accounts_update au
             where au.acc = p_acc -- in (32979301 /*, 1448383401*/)
            --   and au.kf  = p_kf
               and au.idupd between  p_idupd_from and p_idupd_to
              order by au.idupd desc )x
         where rownum < 3
           group by x.acc, x.nls,  x.kv  , x.kf, x.daos, x.dazs, x.doneby, x.blkd, x.blkk
            ) xx
         where xx.rn > 1;

 EXCEPTION
    WHEN NO_DATA_FOUND  THEN
          l_idupd := null;
      END;

  return l_idupd;

   end Check_Acc_update ;

   -- ==== Надруковані документи ====
   -- Створити надрукований документ
  function doc_create(p_type_id      in ead_docs.type_id%type,
                      p_template_id  in ead_docs.template_id%type,
                      p_scan_data    in ead_docs.scan_data%type,
                      p_ea_struct_id in ead_docs.ea_struct_id%type,
                      p_rnk          in ead_docs.rnk%type,
                      p_agr_id       in ead_docs.agr_id%type default null,
                      p_acc          in ead_docs.acc%type default null)
 return ead_docs.id%type is
      l_id   ead_docs.id%TYPE;
      l_kf   ead_docs.kf%TYPE;
      l_acc  accounts.acc%type;
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
      l_id := TO_NUMBER('10' || TO_CHAR(bars_sqnc.get_nextval('S_EADDOCS')));
      l_acc := p_acc;

      -- так как внедряем ДКБО, появляется "документ счета", пришлось расширить и для депозитов. в Вебе передаю нулл, так как вычитывать его во всех точках входа - много, то пишу NULL
      if p_acc is null and p_agr_id is not null then
        select max(acc) into l_acc from dpt_deposit where deposit_id = p_agr_id;
      end if;

      -- создаем запись
    insert into ead_docs
      (id,
       crt_date,
       crt_staff_id,
       crt_branch,
       type_id,
       template_id,
       scan_data,
       ea_struct_id,
       rnk,
       agr_id,
       kf,
       acc)
    values
      (l_id,
       sysdate,
       user_id,
       sys_context('bars_context', 'user_branch'),
       p_type_id,
       p_template_id,
       p_scan_data,
       p_ea_struct_id,
       p_rnk,
       p_agr_id,
       l_kf,
       l_acc);

    return l_id;
  end doc_create;

   -- Видалити надрукований документ
   procedure doc_del (p_doc_id in ead_docs.id%type)
   is
   begin
      delete from ead_docs where id = p_doc_id;
   end doc_del;

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
       WHERE sq.id = p_sync_id
         AND sq.kf = p_kf;

      COMMIT;
   END msg_set_status_send;

  -- Установить статус сообщению "Повідомлення відправлено"
  PROCEDURE msg_set_message(p_sync_id       IN ead_sync_queue.id%TYPE,
                            p_status_id     IN ead_sync_queue.status_id%TYPE,
                            p_message_id    IN ead_sync_queue.message_id%TYPE,
                            p_message_date  IN ead_sync_queue.message_date%TYPE,
                            p_message       IN ead_sync_queue.MESSAGE%TYPE,
                            p_responce      IN ead_sync_queue.responce%TYPE,
                            p_responce_id   IN ead_sync_queue.responce_id%TYPE,
                            p_responce_date IN ead_sync_queue.responce_date%TYPE,
                            p_err_text      IN ead_sync_queue.err_text %TYPE,
                            p_err_count     IN ead_sync_queue.err_count %TYPE) IS
  BEGIN
    -- ставим параметры сообщению
    UPDATE ead_sync_queue sq
       SET sq.message_id    = p_message_id,
           sq.message_date  = p_message_date,
           sq.MESSAGE       = p_message,
           sq.RESPONCE      = p_responce,
           sq.RESPONCE_ID   = p_responce_id,
           sq.RESPONCE_DATE = p_responce_date,
           sq.err_text      = p_err_text,
           sq.err_count     = p_err_count,
           sq.status_id     = p_status_id
     WHERE sq.id = p_sync_id;

    --    COMMIT;
  END msg_set_message;

  function LOCK_ROW(rid in rowid) return number is
    ret_id number := 0;
  begin
    select 1
      into ret_id
      from bars.ead_sync_queue
     where rowid = rid
       for update nowait;
    return 1;
  exception
    when others then
      return 0;
  end;

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
       WHERE sq.id = p_sync_id
         AND sq.kf = p_kf;

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
       WHERE sq.id = p_sync_id
         AND sq.kf = p_kf;

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
       WHERE sq.id = p_sync_id
         AND sq.kf = p_kf;

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
       WHERE sq.id = p_sync_id
         AND sq.kf = p_kf;

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
       WHERE sq.id = p_sync_id
         AND sq.kf = p_kf;

      COMMIT;
   END msg_set_status_outdated;

  -- Установить статус сообщению
  PROCEDURE msg_set_status(p_sync_id   IN ead_sync_queue.id%TYPE,
                           p_status_id IN EAD_SYNC_QUEUE.STATUS_ID%TYPE) IS
  BEGIN
    -- ставим статус
    UPDATE ead_sync_queue sq
       SET sq.status_id = p_status_id
     WHERE sq.id = p_sync_id;

    COMMIT;
  END msg_set_status;
   -- Створити повідомлення
   FUNCTION msg_create (p_type_id   IN ead_sync_queue.type_id%TYPE,
                        p_obj_id    IN ead_sync_queue.obj_id%TYPE,
                        p_rnk       IN ead_sync_queue.rnk%TYPE,
                        p_kf        IN ead_sync_queue.kf%TYPE)
      RETURN ead_sync_queue.id%TYPE
   IS
      l_id   ead_sync_queue.id%TYPE;
      l_kf   VARCHAR2 (6);
   BEGIN
      l_kf := nvl(p_kf, sys_context ('bars_context', 'user_mfo'));

      -- создаем запись
      INSERT INTO ead_sync_queue
        (id, crt_date, type_id, obj_id, rnk, status_id, kf)
      VALUES
        (S_EADSYNCQUEUE.nextval, SYSDATE, p_type_id, p_obj_id, p_rnk, 'NEW', l_kf)
      RETURNING id INTO l_id;

      -- все предыдущие записи по даному объекту помечаем как устаревшие
      FOR cur IN (SELECT * FROM ead_sync_queue
                   WHERE 1=1
--                     and crt_date > ADD_MONTHS(SYSDATE, -1 * g_process_actual_time)
                     and crt_date > sysdate - interval '15' day
                     AND type_id = p_type_id
                     AND obj_id = p_obj_id
                     AND id < l_id
                     AND status_id <> 'DONE'
                     AND kf = l_kf) LOOP
        msg_set_status_outdated(cur.id, cur.kf);
      END LOOP;

      RETURN l_id;
      bars_audit.info ('EAD: msg_create:l_id=' || TO_CHAR (l_id));
   END msg_create;

   PROCEDURE msg_create (p_type_id   IN ead_sync_queue.type_id%TYPE,
                         p_obj_id    IN ead_sync_queue.obj_id%TYPE,
                         p_rnk       IN ead_sync_queue.rnk%TYPE,
                         p_kf        IN ead_sync_queue.kf%TYPE) IS
   BEGIN
     gn_dummy := msg_create(p_type_id, p_obj_id, p_rnk, p_kf);
   END msg_create;

   -- Отправить сообщение на прокси веб-сервис
   PROCEDURE msg_process (p_sync_id   IN ead_sync_queue.id%TYPE,
                          p_kf        IN ead_sync_queue.KF%TYPE,
                          p_force     IN character default null) -- если нужно протолкнуть мес несмотя на то что он уже отправлен или устарел
   IS
   BEGIN
      -- ставим статус "Обробка"
      -- проверка статуса на всякий случай, если мес отправили из другой сессии (например руками) раньше, чем job дошел
      UPDATE ead_sync_queue sq
         SET sq.status_id = 'PROC',
             sq.err_count = DECODE (sq.status_id, 'ERROR', err_count + 1, 0)
       WHERE sq.id = p_sync_id
         AND sq.kf = p_kf
         and (status_id in ('NEW', 'ERROR') or p_force = 'F');

      -- выход, если сообщение уже обработано (status_id in (DONE, OUTDATED))
       if sql%rowcount = 0 then
         return;
       end if;

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
         WHEN OTHERS THEN
            l_err_text := 'Помилка на статусі PROC:' || chr(13) || chr(10) || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;

            -- ставим статус "Помилка"
            UPDATE ead_sync_queue sq
               SET sq.status_id = 'ERROR', sq.err_text = l_err_text
             WHERE sq.id = p_sync_id
               AND sq.kf = p_kf;

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
            WHERE sq.id = p_sync_id
              AND sq.kf = p_kf;

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
            WHERE sq.crt_date < p_date
              AND sq.kf = p_kf;

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
  --------------------------------- физлица ---------------------------------
   -- Захват изменений - Клієнт
  procedure cdc_client is
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
    for cur in (select cu.idupd, cu.rnk, cu.kf
                  from customer_update cu
                 where cu.idupd > l_cdc_lastkey
                 and cu.kf member of kflist
                   and get_custtype(cu.rnk) = 3
				   and  cu.kf member of kflist
/* COBUSUPABS-5837
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
                                                                               )  */
             ORDER BY cu.idupd)
      LOOP
         ead_pack.msg_create (l_type_id, TO_CHAR (cur.rnk), cur.rnk, cur.kf);
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
      for cur in (select pvd.chgdate, pvd.rnk, kf
                    from person_valid_document_update pvd
                   where get_custtype(pvd.rnk) = 3
                     and pvd.chgdate > l_cdc_lastkey
                     and pvd.kf member of kflist
                   order by pvd.chgdate)
      LOOP
         -- клиент на всякий случай
         ead_pack.msg_create ('CLIENT', TO_CHAR (cur.rnk), cur.rnk, cur.kf);

         ead_pack.msg_create (l_type_id, TO_CHAR (cur.rnk), cur.rnk, cur.kf);
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
      l_cdc_lastkey_dkbo   deal.ID%TYPE;
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
                     0),
                NVL (TO_NUMBER (REGEXP_SUBSTR (SS.CDC_LASTKEY,
                                               '[^;]+',
                                               1,
                                               5)),
                     0)
           INTO l_cdc_lastkey_dpt,
                l_cdc_lastkey_agr,
                l_cdc_lastkey_way4,
                l_cdc_lastkey_2620,
                l_cdc_lastkey_dkbo
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

            SELECT MAX (d.ID)
              INTO l_cdc_lastkey_dkbo
              FROM deal d;
      END;


    -- депозиты по которым были изменения
    for cur in (select idupd, rnk, deposit_id, kf
                  from dpt_deposit_clos
                 where idupd > l_cdc_lastkey_dpt
                   and archdoc_id > 0
                   and kf member of kflist
                 order by idupd)
    loop
         -- клиент
         msg_create ('CLIENT', TO_CHAR (cur.rnk), cur.rnk, cur.kf);

         -- связанные РНК
         FOR cur1 IN (SELECT DISTINCT t.rnk_tr AS rnk
                        FROM dpt_trustee t
                       WHERE t.dpt_id = cur.deposit_id)
         LOOP
            msg_create ('CLIENT', TO_CHAR (cur1.rnk), cur.rnk, cur.kf);
         END LOOP;

         msg_create (l_type_id, 'DPT;' || TO_CHAR (cur.deposit_id), cur.rnk, cur.kf);

         l_cdc_lastkey_dpt := cur.idupd;
    end loop;

    -- депозиты по которым были допсоглашения
    for cur in (select agrmnt_id, dpt_id, rnk, kf from (
                select a.agrmnt_id,
                       a.dpt_id,
                       a.kf,
                      (select min(rnk) keep(dense_rank last order by idupd) from bars.dpt_deposit_clos dds where dds.kf = a.kf and dds.deposit_id = a.dpt_id AND dds.archdoc_id > 0) as rnk   -- последний владелец счета, причем в ЕБП archdoc_id >= 0
/*
                      (SELECT DISTINCT FIRST_VALUE (dds.rnk) OVER (ORDER BY idupd DESC)
                          FROM dpt_deposit_clos dds
                         WHERE dds.deposit_id = a.dpt_id
                           AND nvl(dds.archdoc_id, 0) > 0) as rnk -- последний владелец счета, причем в ЕБП archdoc_id >= 0
*/
                  from dpt_agreements a
                 where a.agrmnt_id > l_cdc_lastkey_agr
                   and a.agrmnt_state = 1
                   and a.kf member of kflist
                   and a.agrmnt_type != 25   -- lypskykh #COBUMMFO-5263
                 ) where rnk is not null
             ORDER BY agrmnt_id)
      LOOP
         -- клиент
         ead_pack.msg_create('CLIENT', to_char(cur.rnk), cur.rnk, cur.kf);

         -- связанные РНК
         FOR cur1 IN (SELECT DISTINCT t.rnk_tr AS rnk FROM dpt_trustee t WHERE t.dpt_id = cur.dpt_id)
         LOOP
            ead_pack.msg_create ('CLIENT', TO_CHAR (cur1.rnk), cur.rnk, cur.kf);
         END LOOP;

         ead_pack.msg_create (l_type_id, 'DPT;' || TO_CHAR (cur.dpt_id), cur.rnk, cur.kf);
         l_cdc_lastkey_agr := cur.agrmnt_id;
      END LOOP;

      -- рахунок(обробка не знаходження значення і заборона на передачу всіх змін в чергу)
      IF (l_cdc_lastkey_way4 < 1)
      THEN
         SELECT MAX (W4.IDUPD)
           INTO l_cdc_lastkey_way4
           FROM w4_acc_update w4;
      END IF;

/*
      -- рахунки way4 по которым были изменения
      FOR cur
         IN (  SELECT w4.idupd,
                      acc.rnk,
                      w4.nd,
                      acc.kf
                 FROM w4_acc_update w4 join accounts acc on W4.ACC_PK = acc.acc
                WHERE acc.kf member of kflist
                  and w4.idupd > l_cdc_lastkey_way4
                  AND acc.nbs != '2605' --/COBUSUPABS-4497 11.05.2016 pavlenko inga
                  and acc.rnk >= 200 -- убираем резервирование   1||ru/kf
             ORDER BY w4.idupd)
      LOOP
        msg_create('CLIENT', to_char(cur.rnk), cur.rnk, cur.kf);
        msg_create(l_type_id, 'WAY;' || to_char(cur.nd), cur.rnk, cur.kf);

        l_cdc_lastkey_way4 := cur.idupd;
      END LOOP;
*/

      --рахунки 2620 ФО
      -- рахунок(обробка не знаходження значення і заборона на передачу всіх змін в чергу)
      IF (l_cdc_lastkey_2620 < 1)
      THEN
         SELECT MAX (ACC.IDUPD)
           INTO l_cdc_lastkey_2620
           FROM ACCOUNTS_UPDATE ACC;
      END IF;

      -- рахунки 2620, заведені за останній період
      for cur in (SELECT IDUPD AS idupd, RNK AS rnk, ead_pack.get_acc_nbs(acc) AS nbs, kf
                    FROM accounts_update
                   WHERE idupd > l_cdc_lastkey_2620
                     AND CHGACTION = 1
                     AND kf member of kflist
                     AND ead_pack.get_custtype(rnk) = 3
                     AND nbs = '2620'
                   ORDER BY idupd) LOOP
        -- надсилати лише клієнта ФО при заведенні рахунку. В подальшому всі зміни передавати лише при зміні атрибутів клієнта/*COBUSUPABS-4045*/
        IF (cur.nbs = '2620') THEN
          ead_pack.msg_create('CLIENT', TO_CHAR(cur.rnk), cur.rnk, cur.kf);
        END IF;

        l_cdc_lastkey_2620 := cur.idupd;
      END LOOP;

    -- захватываем для ДКБО все изменения 22.05.2017

     -- угода (обробка не знаходження значення і заборона на передачу всіх змін в чергу)
      IF (l_cdc_lastkey_dkbo < 1)
      THEN
         SELECT MAX (d.ID)
           INTO l_cdc_lastkey_dkbo
           FROM deal d;
      END IF;

      FOR cur_dkbo IN (select customer_id as rnk, d.id, c.kf
                         from deal d
                         join customer c on d.customer_id = c.rnk
                         join object_type ot on d.deal_type_id = ot.id
                        where ot.type_code = 'DKBO' and d.id > l_cdc_lastkey_dkbo
                         order by d.id)
      loop
        ead_pack.msg_create('CLIENT', TO_CHAR(cur_dkbo.rnk), cur_dkbo.rnk, cur_dkbo.kf);
        ead_pack.msg_create(l_type_id, 'DKBO;' || TO_CHAR(cur_dkbo.id), cur_dkbo.rnk, cur_dkbo.kf);
        l_cdc_lastkey_dkbo := cur_dkbo.id;
      end loop;
    ------------


      -- сохраняем ключ захвата
      l_cdc_newkey :=
            TO_CHAR (l_cdc_lastkey_dpt)
         || ';'
         || TO_CHAR (l_cdc_lastkey_agr)
         || ';'
         || TO_CHAR (l_cdc_lastkey_way4)
         || ';'
         || TO_CHAR (l_cdc_lastkey_2620)
         || ';'
         || TO_CHAR (l_cdc_lastkey_dkbo);


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
      l_cdc_last_time ead_sync_sessions.sync_start%TYPE;
      l_cdc_start_time ead_sync_sessions.sync_start%TYPE; 
   BEGIN
      --bc.go('/');
      --sec_aud_temp_write ('EAD: cdc_doc');
      l_cdc_start_time:=sysdate;
      -- находим ключ захвата изменений
      BEGIN
         SELECT TO_NUMBER (ss.cdc_lastkey), sync_start
           INTO l_cdc_lastkey, l_cdc_last_time
           FROM ead_sync_sessions ss
          WHERE ss.type_id = l_type_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT NVL (MAX (d.id), 0), sysdate
              INTO l_cdc_lastkey, l_cdc_last_time
              FROM ead_docs d;
      END;

    -- берем все документы
    for cur in (select id, rnk, ea_struct_id, agr_id, d.kf, da.deposit_id
                  from ead_docs d left outer join dpt_deposit_all da on d.agr_id = da.deposit_id
                 where 1=1
				   and d.EA_STRUCT_ID <> '333'
--                   and id > l_cdc_lastkey
--                   and (sign_date IS NOT NULL OR type_id = 'SCAN') --отбираем только подписанные документы или сканкопии.
                   and (type_id = 'SCAN' and id > l_cdc_lastkey
                     or type_id = 'DOC' and sign_date > (l_cdc_last_time - interval '15' minute)
                       and not exists (select 1 from ead_sync_queue where obj_id = to_char(d.id) and type_id = 'DOC' and crt_date > trunc(sysdate))) --отбираем только подписанные документы или сканкопии.
--                   and lnnvl(template_id = 'WB_CREATE_DEPOSIT')  -- все кроме онлайн-депозитов
                   and lnnvl(template_id = 'DPT_AGRMREG')  --  тікети 190 форми. COBUMMFO-6372
                 order by id)
    loop
        --насильно отправляем клиента
        -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
        if cur.ea_struct_id like ('001%') then  -- Зарплата (ЮрЛица первые сканы)
          ead_pack.msg_create('UCLIENT', to_char(cur.rnk), cur.rnk, cur.kf);
          ead_pack.msg_create ('UAGR', 'SALARY;'||TO_CHAR (cur.agr_id), cur.rnk, cur.kf);
--          ead_pack.msg_create (l_type_id, 'SALARY;' || TO_CHAR (cur.id), cur.rnk, cur.kf);
        elsif cur.deposit_id is not null then
          ead_pack.msg_create('CLIENT', to_char(cur.rnk), cur.rnk, cur.kf);
          --а также договор по подписанному документу, если такой имеется
          if cur.agr_id is not null then
            msg_create ('AGR', 'DPT;' || TO_CHAR (cur.agr_id), cur.rnk, cur.kf);
          end if;
          -- Сканкопии по депозитам и не только...
--          ead_pack.msg_create (l_type_id, 'ALL;' || TO_CHAR (cur.id), cur.rnk, cur.kf);
        end if;

        ead_pack.msg_create (l_type_id, TO_CHAR (cur.id), cur.rnk, cur.kf);
        l_cdc_lastkey := cur.id;
    end loop;

   -- сохраняем ключ захвата
      l_cdc_newkey := TO_CHAR (l_cdc_lastkey);

      UPDATE ead_sync_sessions ss
         SET ss.cdc_lastkey = l_cdc_newkey,
             ss.sync_start = l_cdc_start_time,
             ss.sync_end = sysdate
       WHERE ss.type_id = l_type_id;

      IF (SQL%ROWCOUNT = 0)
      THEN
         INSERT INTO ead_sync_sessions (type_id, cdc_lastkey, sync_start, sync_end)
              VALUES (l_type_id, l_cdc_newkey, sysdate, sysdate);
      END IF;


      COMMIT;
   END cdc_doc;
  --------------------------------- юрлица ---------------------------------
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
    select max(cu.idupd) into l_cdc_newkey_cu_corp from customer_update cu;
    select max(cpu.idupd) into l_cdc_newkey_cpu_corp from corps_update cpu;

    for cur in (select cu.rnk, cu.kf from customer_update cu
                 where cu.idupd > l_cdc_lastkey_cu_corp
                   and cu.idupd <= l_cdc_newkey_cu_corp
                   and cu.date_off is null
                   and ead_pack.get_custtype(cu.rnk) = 2
                   and cu.kf member of kflist
                union
                select cpu.rnk, cpu.kf from corps_update cpu
                 where cpu.idupd > l_cdc_lastkey_cpu_corp
                   and cpu.idupd <= l_cdc_newkey_cpu_corp
                   and cpu.kf member of kflist)
    loop
      ead_pack.msg_create('UCLIENT', to_char(cur.rnk), cur.rnk, cur.kf);
    end loop;

    -- берем всех клиентов ЮЛ и ФЛ, у которых было изменение в реквизитах и которые есть связанными лицами с ЮЛ
    select max(cu.idupd) into l_cdc_newkey_cu_rel from customer_update cu;
    select max(pu.idupd) into l_cdc_newkey_pu_rel from person_update pu;
    for cur in (select cr.rnk,
                       cr.rel_id,
                       cr.rel_rnk,
                       c.kf
                  from customer_rel cr, customer c
                 where cr.rel_rnk = c.rnk
                   and cr.rel_id > 0
                   and c.kf member of kflist
                   --and cr.rel_intext = 1 --лише клієнти банку
                   and cr.rnk in
                       (select c.rnk
                          from customer c
                         where ead_pack.get_custtype(c.rnk) = 2
                           and date_off is null)
                   and cr.rel_rnk in
                       (select cu.rnk
                          from customer_update cu
                         where cu.idupd > l_cdc_lastkey_cu_rel
                           and cu.idupd <= l_cdc_newkey_cu_rel
                        union all
                        select pu.rnk
                          from person_update pu
                         where pu.idupd > l_cdc_lastkey_pu_rel
                           and pu.idupd <= l_cdc_newkey_pu_rel
                         union all
                        select ce.id
                          from customer_extern_update ce
                         where ce.idupd > l_cdc_lastkey_pu_rel
                           and ce.idupd <= l_cdc_newkey_pu_rel)   )
    loop
      -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
      if (ead_pack.get_custtype(cur.rel_rnk) = 2) then
        ead_pack.msg_create('UCLIENT', to_char(cur.rel_rnk), cur.rnk, cur.kf);
      else
        ead_pack.msg_create('CLIENT', to_char(cur.rel_rnk), cur.rnk, cur.kf);
      end if;
    end loop;

      -- берем всех клиентов, у которых были добавлены 3-и лица за период от последней отправки
      SELECT MAX (cru.idupd)
        INTO l_cdc_newkey_cru_rel
        FROM customer_rel_update cru;

    for cur in (select distinct cru.rnk, cru.kf
                  from customer_rel_update cru
                 where cru.idupd > l_cdc_lastkey_cru_rel
                   and cru.idupd <= l_cdc_newkey_cru_rel
                   and cru.rel_id > 0
                   and cru.kf member of kflist
                   and ead_pack.get_custtype(cru.rnk) = 2)
    loop
      -- поочередно отправляем карточки 3х лиц
      for cur1 in (select cru.rnk,
                          cru.rel_rnk, cru.kf
                     from customer_rel_update cru
                    where cru.idupd > l_cdc_lastkey_cru_rel
                      and cru.idupd <= l_cdc_newkey_cru_rel
                      and cru.rel_id > 0
                      and cru.kf member of kflist
                      and cru.rel_intext = 1--лише кліенти банку, не клієнти відправляються в масиві (id, name, okpo) пов'язаними особами на UCLIENT'
                      and cru.rnk = cur.rnk)
      loop
        -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
        if (ead_pack.get_custtype(cur1.rel_rnk) = 2)
        then ead_pack.msg_create('UCLIENT', to_char(cur1.rel_rnk), cur.rnk, cur1.kf);
        else ead_pack.msg_create('CLIENT',  to_char(cur1.rel_rnk), cur.rnk, cur1.kf);
        end if;
      end loop;

      for cur2 in (select cr.rnk,
                          cr.rel_rnk,
                          cext.kf
                     from customer_extern_update cext, customer_rel cr
                    where cext.idupd > l_cdc_lastkey_cru_rel
                      and cext.idupd <= l_cdc_newkey_cru_rel
                      and cr.rel_id > 0
                      and cext.kf member of kflist
                      and cr.rel_rnk = cext.id
                      and cr.rnk = cur.rnk)
      loop
        -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
        if (ead_pack.get_custtype(cur2.rel_rnk) = 2)
        then ead_pack.msg_create('UCLIENT', to_char(cur2.rel_rnk), cur.rnk, cur2.kf);
        else ead_pack.msg_create('CLIENT',  to_char(cur2.rel_rnk), cur.rnk, cur2.kf);
        end if;
      end loop;
         -- добавляем основного клиента
         ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.rnk, cur.kf); --не клієнти відправляться тут, якщо вони були додані.
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

        FOR CUR IN
                (select 'DPT' as agr_type, ddu.dpu_id, ddu.rnk, ddu.kf
                  from dpu_deal_update ddu
                 where ddu.idu > l_cdc_lastkey_dpt
                   and ddu.idu <= l_cdc_newkey_dpt
                   and ddu.kf member of kflist
                   and (exists(SELECT 1
                                 FROM accounts acc
                                WHERE DDU.ACC = acc.ACC
                                  AND acc.kf member of kflist
                                  AND ((  (acc.NBS = '2600' AND acc.ob22 = '05'))
                                       OR (acc.NBS IN (select nbs from EAD_NBS where custtype = 2))) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                                  AND acc.TIP = 'DEP')
                        or
                        exists(SELECT 1
                                 FROM accounts acc
                                WHERE DDU.ACC = acc.ACC
                                  AND acc.kf = ddu.kf
                                  AND acc.TIP = 'NL8')
                        )
                   )
      LOOP
         -- на всякий передаем клиента
         ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.rnk, cur.kf);
         -- за ним сделку
         ead_pack.msg_create ('UAGR', cur.agr_type || ';' || TO_CHAR (cur.dpu_id), cur.rnk, cur.kf);
      END LOOP;

/* 17.10.2017  По счету nbs=2600, ob22=1, tip=ODB  вылезло 2 договора (UAGR;DPT_OLD  UAGR;DBO).
   Сам счет был по dbo. Поэтому выкашываем это старье, пока не вылезет чтото что должно было бы проехать через это

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
                    au.kf
               FROM accounts_update au
              WHERE au.idupd > l_cdc_lastkey_dpt_old
                AND au.idupd <= l_cdc_newkey_dpt_old
                AND au.kf member of kflist
                AND au.CHGDATE >= (SELECT MIN (t1.CHGDATE)
                                     FROM accounts_update t1
                                     WHERE t1.idupd > l_cdc_lastkey_dpt_old
                                       AND CHGDATE >= LAST_DAY (ADD_MONTHS (SYSDATE, -3)))
                AND ead_pack.get_custtype (au.rnk) = 2
                AND (   (ead_pack.get_acc_nbs(au.acc) = '2600' AND au.ob22 = '05')
                     OR (ead_pack.get_acc_nbs(au.acc) IN (SELECT nbs FROM EAD_NBS WHERE custtype = 2))-- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                    )
                AND au.TIP NOT IN ('DEP', 'NL8'))

      LOOP
         -- на всякий передаем клиента
         l_sync_id := ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.kf);
         -- за ним сделку
         l_sync_id := ead_pack.msg_create ('UAGR', cur.agr_type || ';'|| cur.nls|| '|'|| TO_CHAR (cur.date_open, 'yyyymmdd')|| '|'|| TO_CHAR (cur.acc), cur.kf);
      END LOOP;
*/

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
/*  -- 23/03/2018 Лесняк С.Б.
    for cur in (select distinct 'ACC' as agr_type,
                       au.acc as acc,
                       au.rnk as rnk,
                       au.kf
                  from accounts_update au
                 where au.idupd > l_cdc_lastkey_acc
                   and au.idupd <= l_cdc_newkey_acc
                   and au.kf member of kflist
                   and au.CHGDATE >= (SELECT MIN (t1.CHGDATE)
                                       FROM accounts_update t1
                                      WHERE t1.idupd > l_cdc_lastkey_acc
                                        AND t1.kf = au.kf
                                        AND CHGDATE >= LAST_DAY (ADD_MONTHS (SYSDATE, -3)))
                   and ead_pack.get_custtype(au.rnk) = 2
                   and not exists (select 1 from dpu_accounts da where da.accid = au.acc)
                   and exists (select 1
                                 from accounts a
                                where a.acc = au.acc
                                  and a.kf = au.kf
                                  and (   ead_pack.get_acc_nbs(a.acc) in (select nbs from EAD_NBS where custtype = 2) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                                       or ead_pack.get_acc_nbs(a.acc) = '2600' and a.ob22 in ('01', '02', '10')
                                      )
                   and au.tip not in ('DEP', 'DEN', 'NL8'))
          union
                select distinct 'ACC' as agr_type,
                       su.acc as acc,
                       (select rnk from accounts where acc = su.acc) as rnk,
                       su.kf
                  from specparam_update su
                 where su.idupd > l_cdc_lastkey_specparam
                   and su.idupd <= l_cdc_newkey_specparam
                   and su.kf member of kflist
                   and not exists (select 1 from dpu_accounts da where da.accid = su.acc)
                   and exists (select 1
                                 from accounts a
                                where a.acc = su.acc
                                  and a.kf = su.kf
                                  and ead_pack.get_custtype(a.rnk) = 2
                                  and a.tip not in ('DEP', 'DEN', 'NL8')
                                  and (   ead_pack.get_acc_nbs(a.acc) in (select nbs from EAD_NBS where custtype = 2) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                                       or ead_pack.get_acc_nbs(a.acc) = '2600' and a.ob22 in ('01', '02', '10')
                                      )
                   )
                 )
      LOOP
*/
 for cur in (

   /*    select --distinct 
   'ACC' as agr_type, au.acc as acc, au.rnk as rnk, au.kf
                  from accounts_update au, EAD_NBS e
                 where  e.id = ead_integration.ead_nbs_check_param(au.nls,substr(au.tip,1,2),au.ob22,2) -- проверка балансовых которые отправляем в ЕА по справочнику
                   and au.kf member of kflist
                   and au.idupd   >  l_cdc_lastkey_acc
                   and au.idupd   <= l_cdc_newkey_acc
                   and au.CHGDATE >= LAST_DAY (ADD_MONTHS (SYSDATE, -3)) -- не знаю.
                   and ead_pack.get_custtype(au.rnk) = 2
                   and not exists (select 1 from dpu_accounts da where da.accid = au.acc)
                   and au.idupd = ead_pack.check_acc_update(au.acc, l_cdc_lastkey_acc, l_cdc_newkey_acc) -- выгребаем последнюю запись с accounts_update, если она отличается от предпоследней
                   and au.tip not in ('DEP', 'DEN', 'NL8')
*/

                select distinct 'ACC' as agr_type, au.acc as acc, au.rnk as rnk, au.kf
                  from accounts_update au
                 where au.idupd > l_cdc_lastkey_acc and au.idupd <= l_cdc_newkey_acc and au.kf member of kflist
                       and au.CHGDATE >= LAST_DAY (ADD_MONTHS (SYSDATE, -3)) and ead_pack.get_custtype(au.rnk) = 2
                       and not exists (select 1 from dpu_accounts da where da.accid = au.acc)
                       and exists ( select 1
                                      from accounts a
                                     where a.acc = au.acc and a.kf = au.kf
                                           and ( ead_pack.get_acc_nbs(a.acc) in ( select nbs from EAD_NBS e where custtype = 2 and e.id = ead_integration.ead_nbs_check_param(a.nls,substr(a.tip,1,2),a.ob22) ) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                                                or ead_pack.get_acc_nbs(a.acc) = '2600' and a.ob22 in ('01', '02', '10') )
                       and au.tip not in ('DEP', 'DEN', 'NL8') )
         -- походу лишняк :) --09.08.2018
      /*    union
                select distinct 'ACC' as agr_type, su.acc as acc, a.rnk as rnk, su.kf
                  from specparam_update su
                       join accounts a on a.acc = su.acc and a.kf = su.kf and ead_pack.get_custtype(a.rnk) = 2 and a.tip not in ('DEP', 'DEN', 'NL8')
                                          and ( ead_pack.get_acc_nbs(a.acc) in (select nbs from EAD_NBS e where custtype = 2 and e.id = ead_integration.ead_nbs_check_param(a.nls,substr(a.tip,1,2),a.ob22) ) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                                                or ead_pack.get_acc_nbs(a.acc) = '2600' and a.ob22 in ('01', '02', '10') )
                 where su.idupd > l_cdc_lastkey_specparam
                   and su.idupd <= l_cdc_newkey_specparam
                   and su.kf member of kflist
                   and not exists (select 1 from dpu_accounts da where da.accid = su.acc)*/
                 )
      LOOP
         -- на всякий передаем клиента
         ead_pack.msg_create ('UCLIENT', TO_CHAR (cur.rnk), cur.rnk, cur.kf);
         -- за ним сделку, если это "старый счет" = не в рамках ДБО
         IF get_acc_info (cur.acc) = 0 THEN
            bars_audit.info ('ead_pack.msg_create(''UAGR'', ' || cur.agr_type || ',' || TO_CHAR (cur.acc));
            ead_pack.msg_create ('UAGR', cur.agr_type || ';' || TO_CHAR (cur.acc), cur.rnk, cur.kf);
         ELSIF is_first_accepted_acc (cur.acc) = 1 THEN
            ead_pack.msg_create ('UAGR', 'DBO;' || TO_CHAR (cur.rnk), cur.rnk, cur.kf);
         END IF;
      END LOOP;

      -- сохранение ключей захвата изменений
      set_cdc_newkeys (l_cdc_newkey_dpt,
                       l_cdc_newkey_acc,
                       l_cdc_newkey_acc,
                       l_cdc_newkey_specparam);

      COMMIT;
   END cdc_agr_u;

   -- Захват изменений - счета клієнта Юр.Лицо
   PROCEDURE cdc_uacc
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
          WHERE ss.type_id = 'UACC';

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
          WHERE ss.type_id = 'UACC';

         IF (SQL%ROWCOUNT = 0)
         THEN
            INSERT INTO ead_sync_sessions (type_id, cdc_lastkey)
                 VALUES ('UACC', l_cdc_newkey);
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

    for cur in (
      select agr_type, acc, rnk, kf from
        (select
        case when (ead_pack.get_acc_nbs(acc) = '2600' and ob22 = '05') OR (TIP IN ('DEP', 'NL8') AND EXISTS (SELECT 1 FROM dpu_accounts da WHERE da.accid = acc))
             then 'DPT'
             when (ead_pack.get_acc_nbs(acc) = '2600' and ob22 IN ('01', '02', '10')) OR (tip NOT IN ('DEP', 'DEN', 'NL8') AND NOT EXISTS (SELECT 1 FROM dpu_accounts da WHERE da.accid = acc))
             then 'ACC'
             when (ob22 = '05' AND TIP NOT IN ('DEP', 'NL8'))
             then 'DPT_OLD'
        end agr_type, acc, rnk, kf
        from accounts where (acc, kf) in
                (SELECT  acc, kf
                  FROM accounts_update au
                 WHERE     idupd > l_cdc_lastkey_acc
                       AND kf member of kflist
                       AND idupd <= l_cdc_newkey_acc
                       AND ead_pack.get_acc_nbs(acc) IN (SELECT nbs FROM EAD_NBS WHERE custtype = 2)))   -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3"
           where agr_type is not null
/*  select  agr_type,
          acc,
          rnk,
          kf
from(
   SELECT
        case when (ead_pack.get_acc_nbs(au.acc) = '2600' and au.ob22 = '05') OR (au.TIP IN ('DEP', 'NL8') AND EXISTS (SELECT 1 FROM dpu_accounts da WHERE da.accid = acc))
             then 'DPT'
             when (ead_pack.get_acc_nbs(au.acc) = '2600' and au.ob22 IN ('01', '02', '10')) OR (au.tip NOT IN ('DEP', 'DEN', 'NL8') AND NOT EXISTS (SELECT 1 FROM dpu_accounts da WHERE da.accid = acc))
             then 'ACC'
             when (au.ob22 = '05' AND au.TIP NOT IN ('DEP', 'NL8'))
             then 'DPT_OLD'
                           end agr_type,
            au.acc,
            au.rnk,
            au.kf
                  FROM accounts_update au, ead_nbs e
                 WHERE au.kf member of kflist
                       and au.idupd > l_cdc_lastkey_acc
                       AND au.idupd <= l_cdc_newkey_acc
                       and au.idupd = ead_pack.check_acc_update(au.acc, l_cdc_lastkey_acc, l_cdc_newkey_acc)  -- отсекаем изменения, которые не передаем в ЕА
                       AND ead_pack.get_acc_nbs(au.acc) = e.nbs
                       and e.id = ead_integration.ead_nbs_check_param(au.nls,substr(au.tip,1,2),au.ob22,2)  -- првоеряем справочник счетов EAD.
      ) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3"
  where agr_type is not null
*/
           )
    LOOP
      ead_pack.msg_create('UACC', cur.agr_type || ';' || TO_CHAR(cur.acc), cur.rnk, cur.kf);
    END LOOP;

      -- сохранение ключей захвата изменений
      set_cdc_newkeys (l_cdc_newkey_acc);

      COMMIT;
   END cdc_uacc;


   -- Захват изменений - счета клієнта Фіз.Лицо
   PROCEDURE cdc_acc
   IS
      l_sync_id           ead_sync_queue.id%TYPE;

      l_cdc_lastkey_acc   accounts_update.idupd%TYPE;
      l_cdc_newkey_acc    accounts_update.idupd%TYPE;

      -- получение ключей захвата изменений
      PROCEDURE get_cdc_lastkeys (p_acc OUT accounts_update.idupd%TYPE)
      IS
      BEGIN
         SELECT TO_NUMBER(ss.cdc_lastkey)
           INTO p_acc
           FROM ead_sync_sessions ss
          WHERE ss.type_id = 'ACC';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT MAX(idupd) INTO p_acc FROM accounts_update;
--             where nbs in (select nbs from ead_nbs where custtype = 3)
--               and CHGDATE >= LAST_DAY(ADD_MONTHS(SYSDATE, -3))
      END get_cdc_lastkeys;

      -- сохранение ключей захвата изменений
      PROCEDURE set_cdc_newkeys (p_acc IN accounts_update.idupd%TYPE)
      IS
      BEGIN
         -- делаем составной ключ путем конкатенации
         merge into ead_sync_sessions d
         using (select 'ACC' as type_id, TO_CHAR(p_acc) as cdc_lastkey from dual) s
         on (s.type_id = d.type_id)
         when matched then
           update set d.cdc_lastkey = s.cdc_lastkey
         when not matched then
           insert (type_id, cdc_lastkey) values (s.type_id, s.cdc_lastkey);

      END set_cdc_newkeys;
   BEGIN

      --sec_aud_temp_write ('EAD: cdc_acc');
      -- получение ключей захвата изменений
      get_cdc_lastkeys (l_cdc_lastkey_acc);
      SELECT MAX(idupd) INTO l_cdc_newkey_acc FROM accounts_update;

      -- берем все изменения по счетам клиентов
      FOR cur IN (
             select 'ACC' as agr_type, -- условный код, который расшифровывается внутри ead_integration.get_accagr_param() при отправке сообщения по счету
                    acc, nbs, rnk, kf
               from accounts
              where (acc, kf) in (select acc, kf
                                       from accounts_update au
                                                               join ead_nbs e on ead_pack.get_acc_nbs(au.acc) = e.nbs and e.custtype = 3
                                                              and case when e.tip is null then 1 when e.tip=substr(au.tip, 1, length(e.tip)) then 1 else 0 end=1 
                                                              and case when e.ob22 is null then 1 when e.ob22=au.ob22 then 1 else 0 end=1  

                                     where kf member of kflist and rnk > 199
                                       and idupd > l_cdc_lastkey_acc
                                       and idupd <= l_cdc_newkey_acc)
 /*select 'ACC' as agr_type -- условный код, который расшифровывается внутри ead_integration.get_accagr_param() при отправке сообщения по счету
      , au.acc
      , au.kf
      , au.nbs
      , au.rnk
   from accounts_update au, ead_nbs e
       where au.kf member of kflist
          and au.rnk > 199
          and ead_pack.get_acc_nbs(au.acc) = e.nbs
          and au.idupd = ead_pack.check_acc_update(au.acc, l_cdc_lastkey_acc, l_cdc_newkey_acc) -- отсекаем изменения, которые не передаем в ЕА
          and au.idupd > l_cdc_lastkey_acc
          and au.idupd <= l_cdc_newkey_acc
          and e.id = ead_integration.ead_nbs_check_param(au.nls,substr(au.tip,1,2),au.ob22,3)
*/
         )
      LOOP

        -- Договор по 2625
        if cur.nbs = '2625' then
          <<Way4>>
          declare
            l_deal_id         deal.id%type;
            l_deal_number     deal.deal_number%type;
            l_deal_start_date deal.start_date%type;
            l_deal_state_id   deal.state_id%type;
          begin

            bars.ead_integration.get_dkbo(p_acc         => cur.acc,
                                          p_id          => l_deal_id,
                                          p_deal_number => l_deal_number,
                                          p_start_date  => l_deal_start_date,
                                          p_state_id    => l_deal_state_id);

            if l_deal_id is not null then
              ead_pack.msg_create('AGR', 'DKBO;' || TO_CHAR(l_deal_id), cur.rnk, cur.kf);
            else
              select max(nd) into l_deal_id from bars.w4_acc where acc_pk = cur.acc;  -- max() as Workaround for no_data_found
              if l_deal_id is not null then
                ead_pack.msg_create('AGR', 'WAY;' || TO_CHAR(l_deal_id), cur.rnk, cur.kf);
              end if;
            end if;
          end Way4;
        end if;

         ead_pack.msg_create ('ACC', cur.agr_type || ';' || TO_CHAR (cur.acc), cur.rnk, cur.kf);
      END LOOP;

      -- сохранение ключей захвата изменений
      set_cdc_newkeys (l_cdc_newkey_acc);

      COMMIT;
   END cdc_acc;

  procedure update_sync_sessions(p_type_id    in bars.ead_types.id%type,
                                 p_sync_start in bars.ead_sync_sessions.sync_start%type,
                                 p_sync_end   in bars.ead_sync_sessions.sync_end %type) is
  begin
    update ead_sync_sessions s
       set s.sync_start = p_sync_start, s.sync_end = p_sync_end
     where s.type_id = p_type_id;
    commit;
  end update_sync_sessions;

  -- !!! Пока в ручном режиме DICT  Довідник  SetDictionaryData

  -- Передача в ЭА сообщение типа
  procedure type_process_old(p_type_id in bars.ead_types.id%type,
                             p_kf      in bars.ead_sync_queue.kf%type) is
    l_t_row ead_types%rowtype;
    l_s_row ead_sync_sessions%rowtype;
    l_rows  pls_integer; --ограничение кол-ва строк обработки за один запуск
  begin
      -- параметры
      select * into l_t_row from ead_types where id = p_type_id;

      begin
        select * into l_s_row from ead_sync_sessions where type_id = p_type_id;
      exception
        when no_data_found then
          bars_audit.info('type_process: не найдено ключа=' || p_type_id);
      end;

      -- дата/время старта
    l_s_row.sync_start := sysdate;
      --кол-во строк за один пробег
    begin
      select nvl(val, 500)
        into l_rows
        from PARAMS$GLOBAL
       where par = 'EAD_ROWS';
      EXCEPTION
      WHEN NO_DATA_FOUND then
            l_rows := 500;
    end;
      -- обработка каждого запроса по отдельности
      for cur in (select * from (select id, crt_date, type_id, status_id, kf,
                                 -- дата|час повторної передачі, зростає у арифметичній прогресії по кількості помилок
                                 crt_date + l_t_row.msg_retry_interval * err_count * (err_count + 1) / (2 * 60 * 24) as trans_date
                            FROM bars.ead_sync_queue
                           WHERE type_id = p_type_id
                             AND status_id IN ('NEW', 'ERROR')
                             AND err_count < 15
--                             and regexp_like(err_text, 'rnk \d+ not found', 'i')
                             and kf = p_kf
--                             AND crt_date > ADD_MONTHS(SYSDATE, -g_process_actual_time)
                             and crt_date > sysdate - interval '3' day
                           order by status_id  desc, trans_date asc, id asc)
                   where ROWNUM < NVL(l_rows, 500)
--                     and trans_date <= l_s_row.sync_start)
                     and trans_date <= sysdate)
      loop
        msg_process(cur.id, cur.kf);
/*
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
*/
    end loop;

    -- дата/время финиша
    l_s_row.sync_end := sysdate;

    -- сохраняем
    update ead_sync_sessions s
       set s.sync_start = l_s_row.sync_start, s.sync_end = l_s_row.sync_end
     where s.type_id = p_type_id;
    commit;
  end type_process_old;

  /* Formatted on 09/07/2018 15:40:58 (QP5 v5.326) */
  PROCEDURE type_process IS
    l_response wsm_mgr.t_response;
    --    l_response_msg varchar2(2000);
  BEGIN

    --подготовить вызов
    wsm_mgr.prepare_request(p_url             => g_wsproxy_url,
                            p_action          => null,
                            p_http_method     => bars.wsm_mgr.g_http_post,
                            p_wallet_path     => g_wsproxy_walletdir,
                            p_wallet_pwd      => g_wsproxy_walletpass,
                            p_content_type    => wsm_mgr.g_ct_xml,
                            p_content_charset => wsm_mgr.g_cc_win1251,
                            p_namespace       => g_wsproxy_ns,
                            p_soap_method     => 'ProcessQueue');

--    wsm_mgr.ADD_PARAMETER(p_name  => 'userName',
--                          p_value => g_wsproxy_username);
--    wsm_mgr.ADD_PARAMETER(p_name  => 'password',
--                          p_value => g_wsproxy_password);
--    wsm_mgr.ADD_PARAMETER(p_name => 'kf', p_value => p_kf);
--    wsm_mgr.ADD_PARAMETER(p_name => 'type', p_value => p_type_id);

    -- позвать метод веб-сервиса
    bars.wsm_mgr.execute_soap(l_response);

    --    l_response_msg := dbms_lob.substr(l_response.cdoc, 2000, 1);
    --    if length (l_response_msg)>0 then
    --        raise;
    --    end if;

  exception
    when OTHERS then
      bars_audit.info('EAD type_process: Something goes wrong');

  end type_process;

   FUNCTION get_acc_info (p_acc IN accounts.acc%TYPE)
      RETURN INT
   IS
      l_result   INT := 0;
      l_ndbo     VARCHAR2 (50);
      l_sdbo     VARCHAR2 (50);
      l_daos     DATE;
      l_agr_type ead_nbs.agr_type%type;
      l_acc_type ead_nbs.acc_type%type;
   BEGIN
      -- узнать, является ли счет - счетом в рамках ДБО
      --1) наличие у клиента ДБО-договора
      SELECT kl.get_customerw (a.rnk, 'NDBO'),
             kl.get_customerw (a.rnk, 'DDBO'),
             a.daos,
             e.agr_type,
             e.acc_type
        INTO l_ndbo, l_sdbo, l_daos, l_agr_type, l_acc_type
        FROM accounts a, ead_nbs e
             WHERE a.acc  = p_acc
               and e.id   = ead_integration.ead_nbs_check_param(a.nls,substr(a.tip,1,2),a.ob22);

      --2) если нет договора ДБО - то точно это обычный, резалт еще 0
      --3) если ДБО оформлен, счет может быть открыт до ДБО, его считаем "старым"
      IF (    l_ndbo IS NOT NULL
          AND TRUNC (l_daos) >= TO_DATE (REPLACE (l_sdbo, '.', '/'), 'dd/mm/yyyy')
          and l_agr_type not in ( 'acquiring_uo', 'salary_uo' ) ) -- Если на счете acquiring_uo, надо возвращать 0. (cdc_agr_u -> ead_pack.msg_create ('UAGR', cur.agr_type || ';' || TO_CHAR (cur.acc), cur.rnk, cur.kf);)
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

      IF l_count = 0 and kl.get_customerw (l_rnk, 'SDBO') is not null THEN
         l_result := 1;
      END IF;

      RETURN l_result;
   END;

     -- функция возвращает nbs для открытого и псевдо - nbs для зарезервированного счета
  function get_acc_nbs(p_acc in accounts.acc%type) return char is
    l_nbs char(4);
  begin
    select case
             when acc.daos = trunc(acc.dazs) and acc.nbs is null then
              substr(acc.nls, 1, 4)
             else
              acc.nbs
           end
      into l_nbs
      from accounts acc
     where acc.acc = p_acc;
    return l_nbs;
  end get_acc_nbs;

  -- функция возвращает "2" для юрлиц и спд, "3" для физлиц
  function get_custtype(p_rnk in customer.rnk%type) return number is
    l_custtype number(1);
  begin
    select case
             when custtype in (1, 2) then 2
             when custtype = 3 and rtrim(sed) = '91' /*and ise in ('14100', '14101', '14200', '14201')*/ then 2
             else 3
           end
      into l_custtype
      from customer
     where rnk = p_rnk;
    return l_custtype;
  end get_custtype;

  procedure get_sync_queue_proc(p_type           in varchar2,
                                p_kf             in varchar2,
                                p_count          in number,
                                p_retry_interval in number,
                                res              out t_ead_sync_que_list) is
    k                   number := 0;
    l_ead_sync_que_line t_ead_sync_que_line := t_ead_sync_que_line(null,
                                                                   null,
                                                                   null,
                                                                   null,
                                                                   null,
                                                                   null);
    l_ead_sync_que_list t_ead_sync_que_list := t_ead_sync_que_list();
begin
    for i in (SELECT id,
                     obj_id,
                     crt_date,
                     status_id,
                     kf,
                     err_count,
                     rowid,
                     type_id
                FROM bars.ead_sync_queue
               WHERE type_id = p_type
                 AND status_id IN ('NEW', 'ERROR')
                 AND err_count < 15
                 AND kf = p_kf
                 AND crt_date > sysdate - 3
                    -- арифметична прогресія по формулі n(n+1)/2, додатково ділиться на '60*24' для переведення хвилин у дні
                 AND (crt_date + (p_retry_interval * err_count *
                     (err_count + 1)) / (2 * 60 * 24)) <= SYSDATE
               ORDER BY status_id DESC, id ASC) loop
      if k = p_count then
        exit;
      end if;
      if ead_pack.LOCK_ROW(i.rowid) = 1 then
        k                             := k + 1;
        l_ead_sync_que_line.id        := i.id;
        l_ead_sync_que_line.crt_date  := i.crt_date;
        l_ead_sync_que_line.obj_id    := i.obj_id;
        l_ead_sync_que_line.status_id := i.status_id;
        l_ead_sync_que_line.err_count := i.err_count;
        l_ead_sync_que_line.type_id   := i.type_id;
        l_ead_sync_que_list.extend;
        l_ead_sync_que_list(l_ead_sync_que_list.last) := l_ead_sync_que_line;

      end if;
    end loop;
    res := l_ead_sync_que_list;
  end get_sync_queue_proc;

begin
  select replace(key, 'ead.ServiceUrl', '')
    bulk collect
    into kflist
    from bars.web_barsconfig
   where key like 'ead.ServiceUrl%'
     and val not like '-%';
/*
Predicted subpartition templates for upcoming mfo to migrate

CENTRAL
CRIMEA
VINNICA
VOLYN
DNIPRO
DONETSK
ZHYTO
ZAKARPATYE
ZAPORIZHYA
IVANOFRANK
KYIV
KIROVOGRAD
LUGANSK
LVIV
MYKOLAIV
ODESA
POLTAVA
RIVNE
SUMY
TERNOPIL
XARKIV
XERSON
XMEL
CHERKASY
CHERNIVCY
CHERNIGIV
*/
end ead_pack;
/
show errors


 
PROMPT *** grants on ead_pack ***
grant execute on ead_pack to bars_access_defrole;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ead_pack.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 
