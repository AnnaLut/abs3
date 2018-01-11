
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_error.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ERROR 
is

    -----------------------------------------------------------------
    --
    -- ����� �������� � ������� ��� ������ � �������� ���������
    --
    --
    --
    --
    --


    -----------------------------------------------------------------
    --
    -- ���������
    --
    --
    --
    VERSION_HEADER        constant varchar2(64)  := 'version 1.04 01.10.2007';
    VERSION_HEADER_DEFS   constant varchar2(512) := '';

    SCOPE_SESSION         constant number        := 0;
    SCOPE_CONFIG          constant number        := 1;


    --
    -- ����������
    --

    ERR    exception;
    pragma exception_init(ERR, -20097);




    -----------------------------------------------------------------
    -- RAISE_ERROR()
    --
    --     ��������� ��������� ������ � ��������� �����
    --
    --     ���������:
    --
    --         p_errmod     ��� ������
    --
    --         p_errnum     ����� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    procedure raise_error(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errnum  in  err_codes.err_code%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  );


    -----------------------------------------------------------------
    -- RAISE_ERROR()
    --
    --     ��������� ��������� ������ � ��������� �����
    --
    --     ���������:
    --
    --         p_errcode    ��� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    procedure raise_error(
                  p_errcode in  varchar2,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  );



    -----------------------------------------------------------------
    -- RAISE_NERROR()
    --
    --     ��������� ��������� ������ � ������������� �����
    --
    --     ���������:
    --
    --         p_errcode    ��� ������
    --
    --         p_errname    ������������� ��� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    procedure raise_nerror(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errname in  err_codes.err_name%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  );



    -----------------------------------------------------------------
    -- GET_ERROR_TEXT()
    --
    --     ������� ��������� ������ ������ �� �� ������
    --
    --     ���������:
    --
    --         p_errmod     ��� ������
    --
    --         p_errnum     ����� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    function get_error_text(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errnum  in  err_codes.err_code%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2;


    -----------------------------------------------------------------
    -- GET_ERROR_TEXT()
    --
    --     ������� ��������� ������ ������ �� �� ����
    --
    --     ���������:
    --
    --         p_errcode    ��� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    function get_error_text(
                  p_errcode in  varchar2,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2;

    -----------------------------------------------------------------
    -- GET_NERROR_TEXT()
    --
    --     ������� ��������� ������ ������ �� �� �������������� ����
    --
    --     ���������:
    --
    --         p_errmod     ��� ������
    --
    --         p_errname    ������������� ��� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    function get_nerror_text(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errname in  err_codes.err_name%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2;


    -----------------------------------------------------------------
    -- GET_ERROR_CODE()
    --
    --     ������� ��������� ���������� ������ �� ������ ����������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ����������
    --
    --
    --
    function get_error_code(
                  p_errtxt   in  varchar2 ) return varchar2;


    -----------------------------------------------------------------
    -- GET_NERROR_CODE()
    --
    --     ������� �������������� ���� ������ �� ������ ����������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ����������
    --
    --
    --
    function get_nerror_code(
                  p_errtxt   in  varchar2 ) return varchar2;



    -----------------------------------------------------------------
    -- GET_ERROR_INFO()
    --
    --     ��������� ��������� �������� ������ �� �� ������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ���������� ������
    --
    --         p_errumsg    ����� ������ ��� ������������
    --
    --         p_erracode   ��� ���������� ������
    --
    --         p_erramsg    ����� ���������� ������
    --
    --         p_errahlp    �������� ������
    --
    --         p_modcode    ��� ������
    --
    --         p_modname    ������������ ������
    --
    --         p_errmsg     ����� �������� ������
    --
    --
    --
    procedure get_error_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2,
                  p_errahlp  out varchar2,
                  p_modcode  out varchar2,
                  p_modname  out varchar2,
                  p_errmsg   out varchar2  );


    -----------------------------------------------------------------
    -- GET_ERROR_INFO()
    --
    --     ��������� ��������� �������� ������ �� �� ������ ��� ������������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ���������� ������
    --
    --         p_errumsg    ����� ������ ��� ������������
    --
    --         p_erracode   ��� ���������� ������
    --
    --
    --
    --
    procedure get_error_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2);

    -----------------------------------------------------------------
    -- ADD_LANG()
    --
    --     ��������� ���������� ����� � ���������� ���������
    --
    --     ���������:
    --
    --         p_lngcode    ��� ����� ���������
    --
    --         p_lngname    ������������ ����� ���������
    --
    --         p_forceupd   ������� ����������, ���� ����������
    --
    --
    --
    procedure add_lang(
                  p_lngcode  in  err_langs.errlng_code%type,
                  p_lngname  in  err_langs.errlng_name%type,
                  p_forceupd in  number default 0           );

    -----------------------------------------------------------------
    -- ADD_MODULE()
    --
    --     ��������� ���������� ������ � ���������� ���������
    --
    --     ���������:
    --
    --         p_modcode    ��� ������
    --
    --         p_modname    ������������ ������
    --
    --         p_forceupd   ������� ����������, ���� ����������
    --
    --
    --
    procedure add_module(
                  p_modcode  in  err_modules.errmod_code%type,
                  p_modname  in  err_modules.errmod_name%type,
                  p_forceupd in  number default 0             );

    -----------------------------------------------------------------
    -- ADD_MESSAGE()
    --
    --     ��������� ���������� ������ ��������� �� ������
    --     � ���������� ���������
    --
    --     ���������:
    --
    --         p_modcode    ��� ������
    --
    --         p_errcode    ����� ������
    --
    --         p_lngcode    ��� �����
    --
    --         p_errmsg     ����� ��������� �� ������
    --
    --         p_errhlp     ����� �������� ������
    --
    --         p_forceupd   ������� ����������, ���� ����������
    --
    --
    --
    procedure add_message(
                  p_modcode  in  err_texts.errmod_code%type,
                  p_errcode  in  err_texts.err_code%type,
                  p_excpnum  in  err_codes.err_excpnum%type,
                  p_lngcode  in  err_texts.errlng_code%type,
                  p_errmsg   in  err_texts.err_msg%type,
                  p_errhlp   in  err_texts.err_hlp%type,
                  p_forceupd in  number default 0,
                  p_errname  in  err_codes.err_name%type default null);


    -----------------------------------------------------------------
    -- GET_LANG()
    --
    --     ������� ��������� �������� ����� ���������
    --
    --
    function get_lang return varchar2;

    -----------------------------------------------------------------
    -- SET_LANG()
    --
    --     ��������� ��������� �������� ����� ���������
    --
    --
    procedure set_lang(
                  p_lngcode  in  err_langs.errlng_code%type,
                  p_scope    in  number  default SCOPE_SESSION );


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ���������� ������ � ������� ��������� ������
    --
    --
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ���������� ������ � ������� ���� ������
    --
    --
    --
    function body_version return varchar2;



end bars_error;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ERROR 
is


    -----------------------------------------------------------------
    --
    -- ���������
    --
    --
    VERSION_BODY      constant varchar2(64)  := 'version 1.09 11.11.2016';
    VERSION_BODY_DEFS constant varchar2(512) := '';


    --
    -- ������ ������������� ���� ������
    --

    ERROR_PRFLEN   constant number      := 3;
    ERROR_NUMLEN   constant number      := 5;
    ERROR_NAMLEN   constant number      := 30;


    --
    -- ���������� ������ ������� ������ (99800-99900)
    --

    ERRCODE_SYSTEM      constant varchar2(9)    := 'BRS-99800';
    ERRCODE_UNDEFINED   constant varchar2(9)    := 'BRS-99801';
    ERRCODE_INVALID     constant varchar2(9)    := 'BRS-99802';
    ERRCODE_DEVENV      constant varchar2(9)    := 'BRS-99803';
    ERRCODE_ACCESSVIO   constant varchar2(9)    := 'BRS-99804';
    ERRCODE_INVALIDLANG constant varchar2(9)    := 'BRS-99805';
    ERRCODE_UNDEFNAME   constant varchar2(9)    := 'BRS-99806';
    ERRCODE_INVALIDNAME constant varchar2(9)    := 'BRS-99807';
    ERRCODE_DUPLERRNAME constant varchar2(9)    := 'BRS-99808';
    ERRCODE_INTERNAL    constant varchar2(9)    := 'BRS-99999';



    --
    -- ������������� ���� ���������
    --

    LANG_DEFAULT        constant varchar2(3) := 'RUS';
    LANG_PARAMNAME      constant varchar2(8) := 'ERRLNG';


    --
    -- ����� ���������� (�������� � ����������)
    --

    BARS_ERRNUM          constant number(5)     := -20097;




    -----------------------------------------------------------------
    --
    -- ���������� ���� ������
    --
    --

    type narg is record (                  /*           ��� ����������� ��������� */
             name varchar2(30),            /*           ��� ����������� ��������� */
             value varchar2(2000));        /*      �������� ����������� ��������� */

    type nargs is table of narg;           /*   ��� ������� ���������� ���������� */
    type args  is table of varchar2(2000); /*              ��� ������� ���������� */



    -----------------------------------------------------------------
    --
    -- ���������� ���������� ������
    --
    --

    --
    -- ������� ���� ���������
    --

    g_lngcode    err_langs.errlng_code%type;




    -----------------------------------------------------------------
    -- GET_ERROR_BASEMSG()
    --
    --     ������� ��������� ������ ������ �� �� ������
    --
    --     ���������:
    --
    --         p_errnum     ����� ������
    --
    --         p_lngcode    ��� �����
    --
    --
    function get_error_basemsg(
                 p_errmod  in  err_codes.errmod_code%type,
                 p_errnum  in  err_codes.err_code%type     )  return err_texts.err_msg%type
    is
    l_errmsg    err_texts.err_msg%type;  /* ������� ��������� �� ������ */
    begin
        select err_msg into l_errmsg
          from err_texts
         where errmod_code = p_errmod
           and err_code    = p_errnum
           and errlng_code = g_lngcode;
        return l_errmsg;

    exception
        when NO_DATA_FOUND then
            begin
                select err_msg into l_errmsg
                  from err_texts
                 where errmod_code = p_errmod
                   and err_code    = p_errnum
                   and errlng_code = LANG_DEFAULT;
                return l_errmsg;
            exception
                when NO_DATA_FOUND then
                    bars_audit.trace('BARS_ERROR: �� ��������� ����� ��� ������ � ������� %s ��� ������ %s', to_char(p_errnum), p_errmod);
                    return null;
            end;
    end get_error_basemsg;


    -----------------------------------------------------------------
    -- GET_ERROR_DESC()
    --
    --     ������� ��������� �������� ������ �� �� ����
    --
    --     ���������:
    --
    --         p_errcode    ��� ������
    --
    --
    function get_error_desc(
                 p_errcode in  varchar2 )  return err_texts.err_hlp%type
    is
    l_errhlp    err_texts.err_hlp%type;      /*    �������� ������ */
    begin
        select err_hlp into l_errhlp
          from err_texts
         where errmod_code = substr(p_errcode, 1, ERROR_PRFLEN)
           and err_code    = to_number(substr(p_errcode, ERROR_PRFLEN+2, ERROR_NUMLEN))
           and errlng_code = g_lngcode;
        return l_errhlp;
    exception
        when NO_DATA_FOUND then return null;
    end get_error_desc;


    -----------------------------------------------------------------
    -- GET_ERROR_USRMSG()
    --
    --     ������� ��������� ����� ��������� ��� ������������
    --     �� ������� ������ ���������
    --
    --     ���������:
    --
    --         p_erramsg   ����� ��������� �� ������
    --
    --
    function get_error_usrmsg(
                 p_erramsg in  varchar2 )  return varchar2
    is
    begin
        return substr(p_erramsg, ERROR_PRFLEN+ERROR_NUMLEN+3);
    end get_error_usrmsg;


    -----------------------------------------------------------------
    -- GET_ERROR_MODULE()
    --
    --     ������� ��������� ���� � ����� ������ �� ���� ������
    --
    --     ���������:
    --
    --         p_errcode  ��� ������
    --
    --
    procedure get_error_module(
                 p_errcode in  varchar2,
                 p_modcode out varchar2,
                 p_modname out varchar2 )
    is
    begin
        select errmod_code, errmod_name
          into p_modcode, p_modname
          from err_modules
         where errmod_code = substr(p_errcode, 1, ERROR_PRFLEN);
    exception
        when NO_DATA_FOUND then null;
    end get_error_module;





    -----------------------------------------------------------------
    -- ADD_ARG_LIST()
    --
    --     ������� ���������� ��������� � ���� �� ������� ����������
    --     (������������ �������� ��� ���������� ��������)
    --
    --     ���������:
    --
    --         p_prevarg    �������� ����������� ���������
    --
    --         p_thisarg    �������� �������� ���������
    --
    --         p_nextarg    �������� ���������� ���������
    --
    --         p_list       ������ ������������ ����������
    --
    --         p_nlist      ������ ���������� ����������
    --
    --
    procedure add_param_list(
                  p_prevarg   in      varchar2,
                  p_thisarg   in      varchar2,
                  p_nextarg   in      varchar2,
                  p_list      in out  args,
                  p_nlist     in out  nargs    )
    is

    l_recno   number;     /* ������� ������� ������ */

    begin

        --
        -- ���� ���������� �������� ��� ������ ������ �����������
        -- ���������, �� ��������� (p_thisarg)  ��� ��� ��������,
        -- ������� �� ������ � ������
        --
        if (p_prevarg is not null and substr(p_prevarg, 1, 1) = '$') then
            return;
        end if;

        --
        -- ���� ������� �������� ����, �� �������
        --
        if (p_thisarg is null) then return;
        end if;


        --
        -- ��������� �������� �� �������� p_thisarg ������ �����������
        -- ���������
        --
        if (p_thisarg is not null and substr(p_thisarg, 1, 1) = '$') then

            -- ��������� � ������ ���������� ����������
            l_recno := p_nlist.count + 1;
            p_nlist.extend(1);
            p_nlist(l_recno).name  := substr(p_thisarg, 2, 30);
            p_nlist(l_recno).value := substr(p_nextarg, 1, 2000);

        else

            -- ��������� � ������ ������������ ����������
            l_recno := p_list.count + 1;
            p_list.extend(1);
            p_list(l_recno) := substr(p_thisarg, 1, 2000);

        end if;

    end add_param_list;




    -----------------------------------------------------------------
    -- GET_ERROR_TEXT()
    --
    --     ������� ��������� ������ ������ �� �� ������
    --
    --     ���������:
    --
    --         p_modcode    ��� ������
    --
    --         p_errnum     ����� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    function get_error_text(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errnum  in  err_codes.err_code%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2
    is

    l_args     args     := args();         /*           ������ ���������� ������  */
    l_nargs    nargs    := nargs();        /* ������ ���������� ���������� ������ */
    l_argn     number;                     /*           ����� �������� ���������  */
    l_argc     number;                     /*           ������ ������� ���������� */

    l_src      err_texts.err_msg%type;     /*  ������� ��������� (�� �����������) */
    l_pos      number;                     /* ������� � ������ �������� ��������� */
    l_dummy    number;                     /*                  ����� ��� �������� */

    l_errmsg   varchar2(4000);             /*                 ��������� �� ������ */

    begin

        --
        -- ��������� ���������������� �� ������
        --
        begin

            select 1 into l_dummy
              from err_codes
             where errmod_code = p_errmod
               and err_code    = p_errnum;

        exception
            when NO_DATA_FOUND then
                raise_error(ERRCODE_UNDEFINED, upper(p_errmod) || '-' || lpad(p_errnum, ERROR_NUMLEN, '0'));
        end;


        -- �������� ������� ���������
        l_src := get_error_basemsg(p_errmod, p_errnum);

        -- ������� ������ ����������
        add_param_list(    null, p_param1, p_param2, l_args, l_nargs);
        add_param_list(p_param1, p_param2, p_param3, l_args, l_nargs);
        add_param_list(p_param2, p_param3, p_param4, l_args, l_nargs);
        add_param_list(p_param3, p_param4, p_param5, l_args, l_nargs);
        add_param_list(p_param4, p_param5, p_param6, l_args, l_nargs);
        add_param_list(p_param5, p_param6, p_param7, l_args, l_nargs);
        add_param_list(p_param6, p_param7, p_param8, l_args, l_nargs);
        add_param_list(p_param7, p_param8, p_param9, l_args, l_nargs);
        add_param_list(p_param8, p_param9,     null, l_args, l_nargs);

        -- ����������� ����������
        l_pos  := 0;
        l_argn := 1;
        l_argc := l_args.count;

        --
        -- dbms_output.put_line('Not-named argument list:');
        -- dbms_output.put_line('------------------------');
        --
        -- if (l_args.count > 0) then
        --
        --     for i in l_args.first..l_args.last
        --     loop
        --         dbms_output.put_line('...arg[' || to_char(i) || ']=>' || l_args(i));
        --     end loop;
        --
        -- end if;
        --
        --
        -- dbms_output.put_line('Named argument list:');
        -- dbms_output.put_line('--------------------');
        --
        -- if (l_nargs.count > 0) then
        --
        --     for i in l_nargs.first..l_nargs.last
        --     loop
        --         dbms_output.put_line('...arg[' || l_nargs(i).name || ']=>' || l_nargs(i).value);
        --     end loop;
        --
        -- end if;
        --


        --
        -- ��������� � ��������� ������������ ���������
        --

        loop

            --
            -- �������� ������ ������� ������� %s
            --
            l_pos := instr(l_src, '%s');

            --
            -- �������, ���� ������� ��� (0, null) ��� ���
            -- ���������� ��� ��������� ���������
            --
            exit when (l_pos = 0 or l_pos is null);

            --
            -- ��������� ����� �� ��������� � ������� ��������
            -- � �������� ���������
            --
            l_errmsg := substr(l_errmsg || substr(l_src, 1, l_pos-1), 1, 4000);

            if (l_argn <= l_argc) then
                l_errmsg  := substr(l_errmsg || l_args(l_argn), 1, 4000);
            end if;

            l_src     := substr(l_src, l_pos+2);
            l_argn    := l_argn + 1;

        end loop;

        if (l_src is not null) then
            l_errmsg := l_errmsg || l_src;
        end if;

        -- dbms_output.put_line('after no-named=>' || l_errmsg);


        --
        -- ��������� � ��������� ���������� ���������
        --
        for i in 1..l_nargs.count
        loop
            l_src := l_errmsg;
            l_pos := instr(l_src, '$(' || l_nargs(i).name || ')');

            if (l_pos is not null and l_pos != 0) then

                l_errmsg := substr(substr(l_src, 1, l_pos-1) || l_nargs(i).value, 1, 4000);
                l_errmsg := substr(l_errmsg || substr(l_src, l_pos + length(l_nargs(i).name) + 3), 1, 4000);

            end if;

        end loop;

        -- dbms_output.put_line('after named=>' || l_errmsg);


        -- ������� �������
        l_errmsg := upper(p_errmod) || '-' || lpad(p_errnum, ERROR_NUMLEN, '0') || ' ' || l_errmsg;

        return l_errmsg;

    end get_error_text;



    -----------------------------------------------------------------
    -- GET_ERROR_TEXT()
    --
    --     ������� ��������� ������ ������ �� �� ����
    --
    --     ���������:
    --
    --         p_errcode    ��� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    function get_error_text(
                  p_errcode in  varchar2,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2
    is

    l_errmod  err_codes.errmod_code%type;  /*     ��� ������ */
    l_errnum  err_codes.err_code%type;     /*   ����� ������ */

    begin

        begin
            l_errmod := substr(p_errcode, 1, ERROR_PRFLEN);
            l_errnum := to_number(substr(p_errcode, ERROR_PRFLEN+2));
        exception
            when OTHERS then
                raise_error(ERRCODE_UNDEFINED, p_errcode);
        end;

        return get_error_text(
                  p_errmod  => l_errmod,
                  p_errnum  => l_errnum,
                  p_param1  => p_param1,
                  p_param2  => p_param2,
                  p_param3  => p_param3,
                  p_param4  => p_param4,
                  p_param5  => p_param5,
                  p_param6  => p_param6,
                  p_param7  => p_param7,
                  p_param8  => p_param8,
                  p_param9  => p_param9  );

    end get_error_text;


    -----------------------------------------------------------------
    -- GET_NERROR_TEXT()
    --
    --     ������� ��������� ������ ������ �� �� �������������� ����
    --
    --     ���������:
    --
    --         p_errmod     ��� ������
    --
    --         p_errname    ������������� ��� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    function get_nerror_text(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errname in  err_codes.err_name%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2
    is

    l_errnum   err_codes.err_code%type;   /* ����� ������ */


    begin

        begin
            select err_code into l_errnum
              from err_codes
             where errmod_code = p_errmod
               and err_name    = p_errname;
        exception
            when NO_DATA_FOUND then
                raise_error(ERRCODE_UNDEFINED, upper(p_errmod) || '-' || p_errname);
        end;

        return get_error_text(
                  p_errmod  => p_errmod,
                  p_errnum  => l_errnum,
                  p_param1  => p_param1,
                  p_param2  => p_param2,
                  p_param3  => p_param3,
                  p_param4  => p_param4,
                  p_param5  => p_param5,
                  p_param6  => p_param6,
                  p_param7  => p_param7,
                  p_param8  => p_param8,
                  p_param9  => p_param9  );

    end get_nerror_text;





  -----------------------------------------------------------------
  -- RAISE_ERROR()
  --
  --     ��������� ��������� ������ � ��������� �����
  --
  --     ���������:
  --
  --         p_errmod     ��� ������
  --
  --         p_errnum     ����� ������
  --
  --         p_param<n>   ���������, ����������� ��� ������
  --
  --
  procedure raise_error
  ( p_errmod  in  err_codes.errmod_code%type,
    p_errnum  in  err_codes.err_code%type,
    p_param1  in  varchar2 default null,
    p_param2  in  varchar2 default null,
    p_param3  in  varchar2 default null,
    p_param4  in  varchar2 default null,
    p_param5  in  varchar2 default null,
    p_param6  in  varchar2 default null,
    p_param7  in  varchar2 default null,
    p_param8  in  varchar2 default null,
    p_param9  in  varchar2 default null
  ) is

    l_excpnum  err_codes.err_excpnum%type; /* ����� ���������� oracle */
    l_errmsg   varchar2(512);              /* ����� ������ ( up to 2048 bytes long ) */

  begin

    begin

      select ERR_EXCPNUM
        into l_excpnum
        from ERR_CODES
       where ERRMOD_CODE = p_errmod
         and ERR_CODE    = p_errnum;

      if ( l_excpnum not between -20999 and -20001 )
      then
        l_excpnum := BARS_ERRNUM;
      end if;

    exception
      when NO_DATA_FOUND then

        bars_audit.trace('BARS_ERROR: �� ���������� ������ � ������� %s ��� ������ %s', to_char(p_errnum), p_errmod);

        if (p_errmod || '-' || lpad(to_char(p_errnum), ERROR_NUMLEN, '0') = ERRCODE_UNDEFINED)
        then
          raise_application_error(BARS_ERRNUM, 'internal error [error ERRCODE_UNDEFINED not found]');
        else
          raise_error( p_errcode => ERRCODE_UNDEFINED,
                       p_param1  => '[' || p_errmod || '-' || to_char(p_errnum) || ']',
                       p_param2  => '[' || p_param1  || ']',
                       p_param3  => '[' || p_param2  || ']'  );
        end if;

    end;

    l_errmsg := substr(get_error_text(p_errmod => p_errmod,
                                      p_errnum => p_errnum,
                                      p_param1 => p_param1,
                                      p_param2 => p_param2,
                                      p_param3 => p_param3,
                                      p_param4 => p_param4,
                                      p_param5 => p_param5,
                                      p_param6 => p_param6,
                                      p_param7 => p_param7,
                                      p_param8 => p_param8,
                                      p_param9 => p_param9), 1, 512);

    bars_audit.trace('err=%s', l_errmsg);
    bars_audit.error(l_errmsg);

    raise_application_error( l_excpnum, l_errmsg );

  end raise_error;

    -----------------------------------------------------------------
    -- RAISE_ERROR()
    --
    --     ��������� ��������� ������ � ��������� �����
    --
    --     ���������:
    --
    --         p_errcode    ��� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    procedure raise_error(
                  p_errcode in  varchar2,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )
    is

    l_errmod  err_codes.errmod_code%type;  /*     ��� ������ */
    l_errnum  err_codes.err_code%type;     /*   ����� ������ */

    begin

        begin
            l_errmod := substr(p_errcode, 1, ERROR_PRFLEN);
            l_errnum := to_number(substr(p_errcode, ERROR_PRFLEN+2));
        exception
            when OTHERS then

                raise_error(
                    p_errcode => ERRCODE_INVALID,
                    p_param1  => '[' || p_errcode || ']',
                    p_param2  => '[' || p_param1  || ']',
                    p_param3  => '[' || p_param2  || ']'  );

        end;


        raise_error(
            p_errmod  => l_errmod,
            p_errnum  => l_errnum,
            p_param1  => p_param1,
            p_param2  => p_param2,
            p_param3  => p_param3,
            p_param4  => p_param4,
            p_param5  => p_param5,
            p_param6  => p_param6,
            p_param7  => p_param7,
            p_param8  => p_param8,
            p_param9  => p_param9 );

    end raise_error;



    -----------------------------------------------------------------
    -- RAISE_NERROR()
    --
    --     ��������� ��������� ������ � ������������� �����
    --
    --     ���������:
    --
    --         p_errcode    ��� ������
    --
    --         p_errname    ������������� ��� ������
    --
    --         p_param<n>   ���������, ����������� ��� ������
    --
    --
    procedure raise_nerror(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errname in  err_codes.err_name%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )
    is

    l_errnum   err_codes.err_code%type;    /* ��� ������     */

    begin

        begin
            select err_code
              into l_errnum
              from err_codes
             where errmod_code = p_errmod
               and err_name    = p_errname;
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('BARS_ERROR: �� ���������� ������ � ������ %s ��� ������ %s', p_errname, p_errmod);

                if (p_errmod || '-' || p_errname = ERRCODE_UNDEFNAME) then
                    raise_application_error(BARS_ERRNUM, 'internal error [error ERRCODE_UNDEFINED not found]');
                else
                    raise_error(
                        p_errcode => ERRCODE_UNDEFNAME,
                        p_param1  => '[' || p_errmod || '-' || to_char(p_errname) || ']',
                        p_param2  => '[' || p_param1  || ']',
                        p_param3  => '[' || p_param2  || ']'  );
                end if;
        end;

        raise_error(
            p_errmod  => p_errmod,
            p_errnum  => l_errnum,
            p_param1  => p_param1,
            p_param2  => p_param2,
            p_param3  => p_param3,
            p_param4  => p_param4,
            p_param5  => p_param5,
            p_param6  => p_param6,
            p_param7  => p_param7,
            p_param8  => p_param8,
            p_param9  => p_param9 );

    end raise_nerror;



    -----------------------------------------------------------------
    -- GET_ERROR_CODE()
    --
    --     ������� ��������� ���������� ������ �� ������ ����������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ����������
    --
    --
    --
    function get_error_code(
                  p_errtxt   in  varchar2 ) return varchar2
    is
    begin
        return substr(p_errtxt, 12, ERROR_PRFLEN+ERROR_NUMLEN+1);
    end get_error_code;


    -----------------------------------------------------------------
    -- GET_NERROR_CODE()
    --
    --     ������� �������������� ���� ������ �� ������ ����������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ����������
    --
    --
    --
    function get_nerror_code(
                  p_errtxt   in  varchar2 ) return varchar2
    is

    l_errfcode  varchar2(20);                /* ������ ��������� ��� ������ */
    l_modcode   err_codes.errmod_code%type;  /* ��� ������ */
    l_errnum    err_codes.err_code%type;     /* ����� ������ */
    l_errname   err_codes.err_name%type;     /* ������. ��� ������ */

    begin

        l_errfcode := get_error_code(p_errtxt);

        begin
            l_modcode := substr(l_errfcode, 1, ERROR_PRFLEN);
            l_errnum  := to_number(substr(l_errfcode, ERROR_PRFLEN+2));
        exception
            when OTHERS then return l_errfcode;
        end;

        begin
            select err_name into l_errname
              from err_codes
             where errmod_code = l_modcode
               and err_code    = l_errnum;
        exception
            when NO_DATA_FOUND then return l_errfcode;
        end;

        return l_modcode || '-' || l_errname;

    end get_nerror_code;




    -----------------------------------------------------------------
    -- GET_SYSERROR_INFO()
    --
    --     ��������� ��������� �������� ��������� ������ �� �� ������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ���������� ������
    --
    --         p_errumsg    ����� ������ ��� ������������
    --
    --         p_erracode   ��� ���������� ������
    --
    --         p_erramsg    ����� ���������� ������
    --
    --         p_errahlp    �������� ������
    --
    --         p_modcode    ��� ������
    --
    --         p_modname    ������������ ������
    --
    --         p_errmsg     ����� �������� ������
    --
    --
    --
    procedure get_syserror_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2,
                  p_errahlp  out varchar2,
                  p_modcode  out varchar2,
                  p_modname  out varchar2,
                  p_errmsg   out varchar2  )
    is
    begin

        --
        -- �� ������ ������ ��� ������ �� ���� ����������
        -- ������������ ��� ���������� ������ (BRS-99999)
        -- � ������ ���������� "������ � ����� ����������"
        -- (BRS-99803)
        --

        p_erracode := ERRCODE_INTERNAL;
        p_erramsg  := get_error_text(p_erracode, '[' || ERRCODE_DEVENV || ']');
        p_errmsg   := p_errtxt;
        p_errumsg  := get_error_usrmsg(p_erracode);

        --
        -- �� ����� ������ �������� ������
        --
        get_error_module(
            p_errcode  => p_erracode,
            p_modcode  => p_modcode,
            p_modname  => p_modname  );

        --
        -- �������� �������� ������
        --
        p_errahlp := get_error_desc(p_erracode);

    end get_syserror_info;




    -----------------------------------------------------------------
    -- GET_DBERROR_INFO()
    --
    --     ��������� ��������� �������� ��������� ������ �� �� ������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ���������� ������
    --
    --         p_errumsg    ����� ������ ��� ������������
    --
    --         p_erracode   ��� ���������� ������
    --
    --         p_erramsg    ����� ���������� ������
    --
    --         p_errahlp    �������� ������
    --
    --         p_modcode    ��� ������
    --
    --         p_modname    ������������ ������
    --
    --         p_errmsg     ����� �������� ������
    --
    --
    --
    procedure get_dberror_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2,
                  p_errahlp  out varchar2,
                  p_modcode  out varchar2,
                  p_modname  out varchar2,
                  p_errmsg   out varchar2  )
    is

    CR           constant varchar2(1) := chr(10);

    l_excpnum    number;                     /*     ����� ���������� oracle */
    l_errmsg     varchar2(4000);             /*    ����� ������ ��� ������� */
    l_errmod     err_codes.errmod_code%type; /*                  ��� ������ */
    l_errnum     err_codes.err_code%type;    /*                ����� ������ */
    l_dummy      number;                     /*                       ����� */
    l_pos        number;                     /*  ������� �������. ��������� */
    l_arg        varchar2(4000);             /*     �������������� �������� */

    begin

        begin
            -- ���������� ����� ����������
            l_excpnum := to_number(substr(p_errtxt, 5, 5));
        exception
            when OTHERS then

                -- ���������� ������
                p_erracode := ERRCODE_INTERNAL;
                p_erramsg  := get_error_text(p_erracode, '[' || ERRCODE_INVALID || ']');
                p_errmsg   := p_errtxt;
                p_errumsg  := get_error_usrmsg(get_error_text(p_erracode));

                --
                -- �� ����� ������ �������� ������
                --
                get_error_module(
                    p_errcode  => p_erracode,
                    p_modcode  => p_modcode,
                    p_modname  => p_modname  );

                --
                -- �������� �������� ������
                --
                p_errahlp := get_error_desc(p_erracode);

                return;
        end;

        if (l_excpnum < 20000 or l_excpnum > 20999) then

            --
            -- ��������� ������
            --
            p_erracode := ERRCODE_SYSTEM;
            p_erramsg  := get_error_text(p_erracode, '[' || substr(p_errtxt, 1, 9) || ']');
            p_errmsg   := p_errtxt;
            p_errumsg  := get_error_usrmsg(get_error_text(p_erracode));


            --
            -- �� ����� ������ �������� ������
            --
            get_error_module(
                p_errcode  => p_erracode,
                p_modcode  => p_modcode,
                p_modname  => p_modname  );

            --
            -- �������� �������� ������
            --
            p_errahlp := get_error_desc(p_erracode);

            return;

        end if;


        -- ���������� ����������, ����� ��� �� ����������
        l_errmsg := substr(p_errtxt, 12);

        --
        -- ����������� ��� ���������� ������
        --
        if (substr(l_errmsg, 1, 1) = '\') then

            --
            -- ��� ������ ������� (����� S_ER)
            --

            p_erracode := 'BRS-0' || substr(l_errmsg, 2, 4);

            --
            -- �� ����� ������ �������� ������
            --
            get_error_module(
                p_errcode  => p_erracode,
                p_modcode  => p_modcode,
                p_modname  => p_modname  );

            begin
                select n_er  into p_errumsg
                  from s_er
                 where k_er = substr(l_errmsg, 2, 4);
            exception
                when NO_DATA_FOUND then
                    p_errumsg := substr(trim(regexp_replace(l_errmsg, '\\\d+')), 1, 250);
            end;

            --
            -- ����������� ���������
            --
            l_pos := instr(l_errmsg, '#');

            if (l_pos is not null and l_pos != 0) then

                l_arg     := substr(l_errmsg, l_pos+1);
                if (nvl(instr(l_arg, CR), 0) != 0) then
                    l_arg := substr(l_arg, 1, instr(l_arg, CR)-1);
                end if;

                p_errumsg := p_errumsg || ' ' || l_arg;
            end if;

            p_erramsg := p_erracode || ' ' || p_errumsg;
            p_errahlp := null;
            p_errmsg  := p_errtxt;

        else

            --
            -- ��������� ������ ���� ������
            --
            begin
                l_errmod := substr(l_errmsg, 1, ERROR_PRFLEN);
                l_errnum := to_number(substr(l_errmsg, ERROR_PRFLEN+2, ERROR_NUMLEN));
            exception
                when OTHERS then

                    -- ���������� ������
                    p_erracode := ERRCODE_INTERNAL;
                    p_erramsg  := get_error_text(p_erracode, '[' || ERRCODE_INVALID || ']');
                    p_errmsg   := p_errtxt;
                    p_errumsg  := get_error_usrmsg(get_error_text(p_erracode));

                    --
                    -- �� ����� ������ �������� ������
                    --
                    get_error_module(
                        p_errcode  => p_erracode,
                        p_modcode  => p_modcode,
                        p_modname  => p_modname  );

                    --
                    -- �������� �������� ������
                    --
                    p_errahlp := get_error_desc(p_erracode);

                    return;

            end;

            --
            -- ��������� ������� ������
            --
            begin
                select 1 into l_dummy
                  from err_codes
                 where errmod_code = l_errmod
                   and err_code    = l_errnum;
            exception
                when NO_DATA_FOUND then

                    -- ���������� ������
                    p_erracode := ERRCODE_UNDEFINED;
                    p_erramsg  := get_error_text(p_erracode, substr(l_errmsg, 1, ERROR_PRFLEN+ERROR_NUMLEN+1));
                    p_errmsg   := p_errtxt;
                    p_errumsg  := get_error_usrmsg(p_erramsg);

                    --
                    -- �� ����� ������ �������� ������
                    --
                    get_error_module(
                        p_errcode  => p_erracode,
                        p_modcode  => p_modcode,
                        p_modname  => p_modname  );

                    --
                    -- �������� �������� ������
                    --
                    p_errahlp := get_error_desc(p_erracode);

                    return;

            end;

            -- ���������� ������
            p_erracode := substr(l_errmsg, 1, ERROR_PRFLEN+ERROR_NUMLEN+1);
            p_erramsg  := l_errmsg;
            p_errmsg   := p_errtxt;
            p_errumsg  := get_error_usrmsg(p_erramsg);

            --
            -- �� ����� ������ �������� ������
            --
            get_error_module(
                p_errcode  => p_erracode,
                p_modcode  => p_modcode,
                p_modname  => p_modname  );

            --
            -- �������� �������� ������
            --
            p_errahlp := get_error_desc(p_erracode);

        end if;

    end get_dberror_info;



    -----------------------------------------------------------------
    -- GET_ERROR_INFO()
    --
    --     ��������� ��������� �������� ������ �� �� ������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ���������� ������
    --
    --         p_errumsg    ����� ������ ��� ������������
    --
    --         p_erracode   ��� ���������� ������
    --
    --         p_erramsg    ����� ���������� ������
    --
    --         p_errahlp    �������� ������
    --
    --         p_modcode    ��� ������
    --
    --         p_modname    ������������ ������
    --
    --         p_errmsg     ����� �������� ������
    --
    --
    --
    procedure get_error_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2,
                  p_errahlp  out varchar2,
                  p_modcode  out varchar2,
                  p_modname  out varchar2,
                  p_errmsg   out varchar2  )
    is
    begin

        if (substr(p_errtxt, 1, 4) != 'ORA-') then

            -- �������� ������ �� ���� ������
            get_syserror_info(
                p_errtxt   => p_errtxt,
                p_errumsg  => p_errumsg,
                p_erracode => p_erracode,
                p_erramsg  => p_erramsg,
                p_errahlp  => p_errahlp,
                p_modcode  => p_modcode,
                p_modname  => p_modname,
                p_errmsg   => p_errmsg   );

            return;

        else

            -- �������� ������ ���� ������
            get_dberror_info(
                p_errtxt   => p_errtxt,
                p_errumsg  => p_errumsg,
                p_erracode => p_erracode,
                p_erramsg  => p_erramsg,
                p_errahlp  => p_errahlp,
                p_modcode  => p_modcode,
                p_modname  => p_modname,
                p_errmsg   => p_errmsg   );

            return;

        end if;

    end get_error_info;


    -----------------------------------------------------------------
    -- GET_ERROR_INFO()
    --
    --     ��������� ��������� �������� ������ �� �� ������ ��� ������������
    --
    --     ���������:
    --
    --         p_errtxt     ����� ���������� ������
    --
    --         p_errumsg    ����� ������ ��� ������������
    --
    --         p_erracode   ��� ���������� ������
    --
    --
    --
    --
    procedure get_error_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2)
    is

    l_errahlp  err_texts.err_hlp%type;
    l_modcode  err_codes.errmod_code%type;
    l_modname  err_modules.errmod_name%type;
    l_errmsg   varchar2(8000);

    begin

        get_error_info(p_errtxt,
                       p_errumsg,
                       p_erracode,
                       p_erramsg,
                       l_errahlp,
                       l_modcode,
                       l_modname,
                       l_errmsg);
    end;

    -----------------------------------------------------------------
    -- CHECK_ADMIN_PRIVS()
    --
    --     ��������� �������� ���� �� ���������� ������ � �����������
    --
    --
    procedure check_admin_privs
    is
    begin

        if (sys_context('userenv', 'session_user') != 'BARS') then
            raise_error(ERRCODE_ACCESSVIO, sys_context('userenv', 'session_user'));
        end if;

    end check_admin_privs;



    -----------------------------------------------------------------
    -- ADD_LANG()
    --
    --     ��������� ���������� ����� � ���������� ���������
    --
    --     ���������:
    --
    --         p_lngcode    ��� ����� ���������
    --
    --         p_lngname    ������������ ����� ���������
    --
    --         p_forceupd   ������� ����������, ���� ����������
    --
    --
    --
    procedure add_lang(
                  p_lngcode  in  err_langs.errlng_code%type,
                  p_lngname  in  err_langs.errlng_name%type,
                  p_forceupd in  number  default 0            )
    is
    begin

        -- ��������� ����� �� ���������
        check_admin_privs;

        begin
            insert into err_langs(errlng_code, errlng_name)
            values (p_lngcode, p_lngname);
        exception
            when DUP_VAL_ON_INDEX then

                if (p_forceupd = 1) then

                    update err_langs
                       set errlng_name = p_lngname
                     where errlng_code = p_lngcode;

                end if;

        end;

    end add_lang;


    -----------------------------------------------------------------
    -- ADD_MODULE()
    --
    --     ��������� ���������� ������ � ���������� ���������
    --
    --     ���������:
    --
    --         p_lngcode    ��� ������
    --
    --         p_lngname    ������������ ������
    --
    --         p_forceupd   ������� ����������, ���� ����������
    --
    --
    --
    procedure add_module(
                  p_modcode  in  err_modules.errmod_code%type,
                  p_modname  in  err_modules.errmod_name%type,
                  p_forceupd in  number default 0             )
    is
    begin

        -- ��������� ����� �� ���������
        check_admin_privs;

        begin
            insert into err_modules(errmod_code, errmod_name)
            values (p_modcode, p_modname);
        exception
            when DUP_VAL_ON_INDEX then

                if (p_forceupd = 1) then

                    update err_modules
                       set errmod_name = p_modname
                     where errmod_code = p_modcode;

                end if;

        end;

    end add_module;


    -----------------------------------------------------------------
    -- ADD_MESSAGE()
    --
    --     ��������� ���������� ������ ��������� �� ������
    --     � ���������� ���������
    --
    --     ���������:
    --
    --         p_modcode    ��� ������
    --
    --         p_errcode    ����� ������
    --
    --         p_lngcode    ��� �����
    --
    --         p_errmsg     ����� ��������� �� ������
    --
    --         p_errhlp     ����� �������� ������
    --
    --         p_forceupd   ������� ����������, ���� ����������
    --
    --         p_errname    ������������� ��� ������
    --
    --
    procedure add_message(
                  p_modcode  in  err_texts.errmod_code%type,
                  p_errcode  in  err_texts.err_code%type,
                  p_excpnum  in  err_codes.err_excpnum%type,
                  p_lngcode  in  err_texts.errlng_code%type,
                  p_errmsg   in  err_texts.err_msg%type,
                  p_errhlp   in  err_texts.err_hlp%type,
                  p_forceupd in  number default 0,
                  p_errname  in  err_codes.err_name%type default null)
    is

    l_dummy    number;                   /*          ��������� ����� */
    l_errname  err_codes.err_name%type;  /* ������������� ��� ������ */

    begin

        -- ��������� ����� �� ���������
        check_admin_privs;

        if (p_errname is not null) then

            --
            -- ������ ������ �������������� ����
            -- �� ����� ���� ������
            --
            begin

                l_dummy := to_number(substr(p_errname, 1, 1));
                raise_error(ERRCODE_INVALIDNAME, p_errname);

            exception
                when OTHERS then null;
            end;

            l_errname := substr(p_errname, 1, ERROR_NAMLEN);

        else
            l_errname := to_char(p_errcode);
        end if;


        -- ��������� � ���������� �����
        begin
            insert into err_codes(errmod_code, err_code, err_excpnum, err_name)
            values (p_modcode, p_errcode, p_excpnum, l_errname);
        exception
            when DUP_VAL_ON_INDEX then

                if (p_forceupd = 1) then

                    begin
                        update err_codes
                           set err_excpnum = p_excpnum,
                               err_name    = l_errname
                         where errmod_code = p_modcode
                           and err_code    = p_errcode;
                    exception
                        when DUP_VAL_ON_INDEX then
                            raise_error(ERRCODE_DUPLERRNAME, p_modcode, l_errname);
                    end;

                end if;
        end;


        begin
            insert into err_texts(errmod_code, err_code, errlng_code, err_msg, err_hlp)
            values (p_modcode, p_errcode, p_lngcode, p_errmsg, p_errhlp);
        exception
            when DUP_VAL_ON_INDEX then

                if (p_forceupd = 1) then

                    update err_texts
                       set err_msg = p_errmsg,
                           err_hlp = p_errhlp
                     where errmod_code = p_modcode
                       and err_code    = p_errcode
                       and errlng_code = p_lngcode;

                end if;

        end;

    end add_message;


    -----------------------------------------------------------------
    -- READ_LANG()
    --
    --     ��������� ��������� �������������� �������� �����
    --
    --
    procedure read_lang
    is
    begin

        select substr(val, 1, 3) into g_lngcode
          from params
         where par = LANG_PARAMNAME;

    exception
        when NO_DATA_FOUND then
            g_lngcode := LANG_DEFAULT;
    end read_lang;

    -----------------------------------------------------------------
    -- CHK_LANG()
    --
    --     ��������� �������� ������� ���������� �����
    --     � �����������
    --
    procedure chk_lang(
                  p_lngcode  in  err_langs.errlng_code%type )
    is
    l_dummy    number;    /* ����� */
    begin

        select count(*) into l_dummy
          from err_langs
         where errlng_code = p_lngcode;

        if (l_dummy = 0) then
            raise_error(ERRCODE_INVALIDLANG, p_lngcode);
        end if;

    end chk_lang;


    -----------------------------------------------------------------
    -- GET_LANG()
    --
    --     ������� ��������� �������� ����� ���������
    --
    --
    function get_lang return varchar2
    is
    begin

        if (g_lngcode is null) then
            read_lang;
        end if;

        return g_lngcode;

    end get_lang;


    -----------------------------------------------------------------
    -- SET_LANG()
    --
    --     ��������� ��������� �������� ����� ���������
    --
    --
    procedure set_lang(
                  p_lngcode  in  err_langs.errlng_code%type,
                  p_scope    in  number                     )
    is

    l_dummy    number;    /* ����� */

    begin

        --
        -- ������������ ���� � ������, ���� � ����������
        --
        if    (p_scope = SCOPE_SESSION) then

            if (p_lngcode is null) then
                read_lang;
            else

                -- ��������� ��� �����
                chk_lang(p_lngcode);

                -- �������������
                g_lngcode := p_lngcode;

            end if;

        elsif (p_scope = SCOPE_CONFIG ) then

            -- ��������� ����� �� �����������
            check_admin_privs;

            -- ��������� ��� �����
            chk_lang(p_lngcode);

            -- �������� ��������
            update params
               set val = p_lngcode
             where par = LANG_PARAMNAME;

            if (sql%rowcount = 0) then
                insert into params (par, val)
                values (LANG_PARAMNAME, p_lngcode);
            end if;

            -- �������������
            g_lngcode := p_lngcode;

        end if;

    end set_lang;


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ���������� ������ � ������� ��������� ������
    --
    --
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_ERROR ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
    end header_version;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ���������� ������ � ������� ���� ������
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_ERROR ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


begin
    read_lang;
end bars_error;
/
 show err;
 
PROMPT *** Create  grants  BARS_ERROR ***
grant EXECUTE                                                                on BARS_ERROR      to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_ERROR      to BARSAQ_ADM;
grant EXECUTE                                                                on BARS_ERROR      to BARSUPL;
grant EXECUTE                                                                on BARS_ERROR      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ERROR      to BASIC_INFO;
grant EXECUTE                                                                on BARS_ERROR      to DM;
grant EXECUTE                                                                on BARS_ERROR      to START1;
grant EXECUTE                                                                on BARS_ERROR      to UPLD;
grant EXECUTE                                                                on BARS_ERROR      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_error.sql =========*** End *** 
 PROMPT ===================================================================================== 
 