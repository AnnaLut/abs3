
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/advt_pack.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ADVT_PACK is

    --
    -- Автор  : Oleg Muzyka
    -- Создан : 04.12.2014
    --
    -- Purpose : робота з рекламними блоками
    --

    -- Public constant declarations
    g_header_version  constant varchar2(64)  := 'version 1.0 04/12/2014';
    g_awk_header_defs constant varchar2(512) := '';

    --------------------------------------------------------------------------------
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    --------------------------------------------------------------------------------
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2;

    procedure set_advt(p_id in out tickets_advertising.id%type,
                    p_name tickets_advertising.name%type,
                    p_dat_begin tickets_advertising.dat_begin%type,
                    p_dat_end tickets_advertising.dat_end%type,
                    p_active tickets_advertising.active%type,
                    p_data_body_html tickets_advertising.data_body_html%type,
                    p_data_body tickets_advertising.data_body%type,
                    p_description tickets_advertising.description%type,
                    --p_userid tickets_advertising.userid%type,
                    --p_branch tickets_advertising.branch%type,
                    p_transaction_code_list tickets_advertising.transaction_code_list%type,
                    p_def_flag tickets_advertising.def_flag%type,
                    p_width tickets_advertising.width%type default null,
                    p_height tickets_advertising.height%type default null);

    function get_advt(p_transactioncode tts.tt%type) return blob;

    function get_advt_id(p_transactioncode tts.tt%type) return tickets_advertising.id%type;

end advt_pack;
/
CREATE OR REPLACE PACKAGE BODY BARS.ADVT_PACK is

  --
  -- Автор  : Oleg Muzyka
  -- Создан : 04.12.2014
  --
  -- Purpose : робота з рекламними блоками
  --

  -- Private constant declarations
  g_body_version  constant varchar2(64) := 'version 1.1 06/01/2015';
  g_awk_body_defs constant varchar2(512) := '';
  g_dbgcode       constant varchar2(12) := 'advt_pack.';

  ------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header advt_pack ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
  end header_version;
--------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2 is
  begin
    return 'Package body advt_pack ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;

  FUNCTION c2b( c IN CLOB ) RETURN BLOB
-- typecasts CLOB to BLOB (binary conversion)
IS
    pos PLS_INTEGER := 1;
    buffer RAW( 32767 );
    res BLOB;
    lob_len PLS_INTEGER := DBMS_LOB.getLength( c );
    BEGIN
    DBMS_LOB.createTemporary( res, TRUE );
    DBMS_LOB.OPEN( res, DBMS_LOB.LOB_ReadWrite );

    LOOP
    buffer := UTL_RAW.cast_to_raw( DBMS_LOB.SUBSTR( c, 16000, pos ) );

    IF UTL_RAW.LENGTH( buffer ) > 0 THEN
    DBMS_LOB.writeAppend( res, UTL_RAW.LENGTH( buffer ), buffer );
    END IF;

    pos := pos + 16000;
    EXIT WHEN pos > lob_len;
    END LOOP;

    RETURN res; -- res is OPEN here
    END c2b;

    procedure set_advt(p_id       in out       tickets_advertising.id%type,
                    p_name                  tickets_advertising.name%type,
                    p_dat_begin             tickets_advertising.dat_begin%type,
                    p_dat_end               tickets_advertising.dat_end%type,
                    p_active                tickets_advertising.active%type,
                    p_data_body_html        tickets_advertising.data_body_html%type,
                    p_data_body             tickets_advertising.data_body%type,
                    p_description           tickets_advertising.description%type,
                    --p_userid                tickets_advertising.userid%type,
                    --p_branch                tickets_advertising.branch%type,
                    p_transaction_code_list tickets_advertising.transaction_code_list%type,
                    p_def_flag              tickets_advertising.def_flag%type,
                    p_width tickets_advertising.width%type default null,
                    p_height tickets_advertising.height%type default null) is
        l_id  tickets_advertising.id%type;
    begin

        if (p_def_flag='Y') then
            update tickets_advertising t set t.def_flag='N'
            where t.def_flag='Y';
        end if;

        update tickets_advertising t
            set t.name                  = p_name,
                t.dat_begin             = p_dat_begin,
                t.dat_end               = p_dat_end,
                t.active                = p_active,
                t.data_body_html        = p_data_body_html,
                t.data_body             = p_data_body,
                t.description           = p_description,
                --t.userid                = p_userid,
                /*t.branch                = nvl(p_branch,
                                                '/' ||
                                                sys_context('bars_context',
                                                            'user_mfo') || '/'),*/
                t.transaction_code_list = p_transaction_code_list,
                t.def_flag              = p_def_flag,
                t.width                 = width,
                t.height                = p_height
        where t.id = p_id;

        if (sql%rowcount = 0) then

            l_id:=S_TICKETS_ADVERTISING.NEXTVAL;

            p_id:=l_id;

            insert into tickets_advertising(
                id,
                name,
                dat_begin,
                dat_end,
                active,
                data_body_html,
                data_body,
                description,
                --userid,
                --branch,
                transaction_code_list,
                def_flag,
                width,
                height)
            values
                (l_id,
                p_name,
                p_dat_begin,
                p_dat_end,
                p_active,
                p_data_body_html,
                p_data_body,
                p_description,
                --p_userid,
                --nvl(p_branch, '/' || sys_context('bars_context', 'user_mfo') || '/'),
                p_transaction_code_list,
                p_def_flag,
                p_width,
                p_height);
        end if;
    end set_advt;

    function encode_row_to_base(par varchar2) return varchar2 is
    begin
        return utl_encode.text_encode(par, encoding => utl_encode.base64);
    end;

    function get_advt(p_transactioncode tts.tt%type) return blob is
          l_body blob;
          l_tt tts.tt%type;
          l_id tickets_advertising.id%type;
      begin
      -- Перевірка на наявність операції
          begin
              select tt into l_tt from tts where tt=p_transactioncode;
          exception when no_data_found then
              raise_application_error(-20000, 'Не допустимий код операції "'||p_transactioncode||'"');
          end;
      -- Читаємо рекламу Random
      begin
          select
              data_body into l_body
          from
            tickets_advertising
          where
            id = get_advt_id(p_transactioncode);
              /*(select
                  *
              from
                  (select
                      t.id,
                      t.data_body
                  from
                      tickets_advertising t,
                      tickets_advertising_branch b
                  where
                      t.dat_begin <= sysdate
                      and t.dat_end >= sysdate
                      and t.id = b.advertising_id
                      --and nvl(t.userid, user_id) = user_id
                      and b.branch = sys_context('bars_context', 'user_branch')
                      and t.active = 'Y'
                      and instr(nvl(t.transaction_code_list, p_transactioncode), p_transactioncode) >= 1)
                 order by dbms_random.value)
          where rownum = 1;*/
          --Якщо нічого не підпадає під наш критерій то берем значення по замовчуванню без фільтрації по датам, активності і т.д.
      exception
        when no_data_found then
          l_body := null;
      end;
      return l_body;
    end get_advt;

    function get_advt_id(p_transactioncode tts.tt%type) return tickets_advertising.id%type is
           l_id tickets_advertising.id%type;
           l_tt tts.tt%type;
        begin
            -- Перевірка на наявність операції
            begin
                select tt into l_tt from tts where tt=p_transactioncode;
            exception when no_data_found then
                raise_application_error(-20000, 'Не допустимий код операції "'||p_transactioncode||'"');
            end;
            begin
                select
                    id into l_id
                from
                    (select
                        *
                    from
                        (select
                            t.id
                        from
                            tickets_advertising t,
                            tickets_advertising_branch b
                        where
                            t.dat_begin <= sysdate
                            and t.dat_end >= sysdate
                            and t.id = b.advertising_id
                            --and nvl(t.userid, user_id) = user_id
                            and b.branch = sys_context('bars_context', 'user_branch')
                            and t.active = 'Y'
                            and instr(nvl(t.transaction_code_list, p_transactioncode), p_transactioncode) >= 1)
                       order by dbms_random.value)
                where rownum = 1;
                --Якщо нічого не підпадає під наш критерій то берем значення по замовчуванню без фільтрації по датам, активності і т.д.
                exception
                  when no_data_found then
                    begin
                      select id
                        into l_id
                        from (select t.id
                                from tickets_advertising t
                               where t.def_flag = 'Y'
                               order by dbms_random.value)
                       where rownum = 1;
                       --Якщо немає значення по замовчуванню
                    exception
                      when no_data_found then
                        l_id := null;
                    end;
            end;
            return l_id;
        end get_advt_id;

    begin
    -- Initialization
       null;
end advt_pack;
/
 show err;
 
PROMPT *** Create  grants  ADVT_PACK ***
grant EXECUTE                                                                on ADVT_PACK       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/advt_pack.sql =========*** End *** =
 PROMPT ===================================================================================== 
 