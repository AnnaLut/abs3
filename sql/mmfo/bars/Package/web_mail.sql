
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/web_mail.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WEB_MAIL 
is
    -----------------------------------------------------------------
    --
    -- Пакет для работы с сообщениями (почтой)
    --
    g_header_version  constant varchar2(64)  := 'version 1.0 13/07/2009';
    g_awk_header_defs constant varchar2(512) := '';
    --
    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;
    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2;

    --
    --  Отправить сообщение
    --
    procedure create_mail(p_mail_subject in  varchar, p_mail_body in  varchar, p_mail_id out number);

    --
    --  Добавить получателя
    --
    procedure add_recipient(p_mail_id in number, p_user_id in number);

    --
    --  Удалить сообщение
    --
    procedure delete_mail(p_mail_id in number);

    --
    --  Вставить файл
    --
    procedure attach_file(p_mail_id in number, p_file_name in varchar2, p_attach in blob, p_attach_size in number, p_attach_sign in varchar default null);

    --
    --  Список получателей указаного письма, разделенных запятой
    --
    function mail_recipients(p_mail_id in number) return varchar2;

    --
    --  Проверить наличие непрочитаных писем
    --
    function check_mail(p_user_id in number default null) return number;

    --
    --  Номер групы пользователя
    --
    function get_user_group(p_user_id in number default null) return number;

    --
    --  Постаивить отметку о прочтении присьма
    --
    procedure mail_readed(p_mail_id in number);

    --
    --  Является ли пользователь администратором
    --
    function is_admin return number;

END web_mail;
/
CREATE OR REPLACE PACKAGE BODY BARS.WEB_MAIL is
    -----------------------------------------------------------------
    --
    -- Пакет для работы с сообщениями (почтой)
    --
    g_body_version  constant varchar2(64)  := 'version 1.0 13/07/2009';
    g_awk_body_defs constant varchar2(512) := '';
    --
    -----
    -- header_version - возвращает версию заголова пакета
    --
    function header_version return varchar2 is
    begin
      return 'Package header bars_reminder '||g_header_version||'.'||chr(10)
           ||'AWK definition: '||chr(10)
           ||g_awk_header_defs;
    end header_version;
    -----
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2 is
    begin
      return 'Package body bars_reminder '||g_body_version||'.'||chr(10)
           ||'AWK definition: '||chr(10)
           ||g_awk_body_defs;
    end body_version;
    --
    --
    --  Отправить сообщение
    --
    procedure create_mail(p_mail_subject in varchar, p_mail_body in  varchar, p_mail_id out number)
    is
    begin
     insert into web_mail_box(mail_sender_id, mail_subject, mail_body, mail_date)
     values (user_id, p_mail_subject, p_mail_body, sysdate) returning mail_id into p_mail_id;
    end create_mail;

    --
    --  Добавить получателя
    --
    procedure add_recipient(p_mail_id in number, p_user_id in number)
    is
    begin
     insert into web_mail_to(mail_id, mail_recipient_id) values (p_mail_id, p_user_id);
    end add_recipient;

    --
    --  Удалить сообщение
    --
    procedure delete_mail(p_mail_id in number)
    is
    begin
        delete from web_mail_to where mail_id=p_mail_id;
        delete from web_mail_attach where mail_id=p_mail_id;
        delete from web_mail_box where mail_id=p_mail_id;
    end;

    --
    --  Вставить файл
    --
    procedure attach_file(p_mail_id in number, p_file_name in varchar2, p_attach in blob, p_attach_size in number, p_attach_sign in varchar default null)
    is
        p_count number;
    begin
        select count(attach_id) into p_count from web_mail_attach where mail_id=p_mail_id;
        insert into web_mail_attach(mail_id, attach_id, file_name, attachment, attach_size, attach_sign)
        values (p_mail_id, p_count, p_file_name, p_attach, p_attach_size, p_attach_sign);
    end;

    --
    --  Список получателей указаного письма, разделенных запятой
    --
    function mail_recipients(p_mail_id in number) return varchar2
    is
        p_result_list varchar2(4000) := '';
        p_fio varchar2(60);
    begin
        if(is_admin = 1) then
         for c in (select mail_recipient_id from web_mail_to where mail_id=p_mail_id)
         loop
            select fio into p_fio from staff where id=c.mail_recipient_id;
            p_result_list := p_result_list || ',' || p_fio;
         end loop;
        else
         for c in (select mail_recipient_id from web_mail_to where mail_id=p_mail_id and (mail_recipient_id=bars.user_id or mail_recipient_id in (select user_id from web_mail_from where group_id in (select group_id from web_mail_user_groups where group_id=get_user_group or admin=1))) )
         loop
            select fio into p_fio from staff where id=c.mail_recipient_id;
            p_result_list := p_result_list || ',' || p_fio;
         end loop;
        end if;

        return substr(p_result_list,2);
    end;

    --
    --  Проверить наличие непрочитаных писем
    --
    function check_mail(p_user_id in number default null) return number
    is
        p_count number;
        p_user number;
    begin
        if (p_user_id is null) then
            p_user := user_id;
        else
            p_user := p_user_id;
        end if;
        select count(mail_id) into p_count from web_mail_to where readed=0 and mail_recipient_id=p_user;

        return p_count;
    end;

    --
    --  Номер групы пользователя
    --
    function get_user_group(p_user_id in number default null) return number
    is
        p_group_id number;
    begin
        select group_id into p_group_id from web_mail_from where user_id = nvl(p_user_id, bars.user_id);
        return p_group_id;
    end;

    --
    --  Постаивить отметку о прочтении присьма
    --
    procedure mail_readed(p_mail_id in number)
    is
    begin
        update web_mail_to set readed=1, readed_date=sysdate where readed=0 and mail_id=p_mail_id and mail_recipient_id=bars.user_id;
    end;

    --
    --  Является ли пользователь администратором
    --
    function is_admin return number
    is
        p_count number(1);
    begin
     select count(user_id) into p_count
     from web_mail_user_groups g, web_mail_from f
     where g.group_id=f.group_id and f.user_id=bars.user_id and g.admin=1;

     return p_count;
    end;

begin
    null;
end web_mail;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/web_mail.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 