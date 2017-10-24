create or replace package crkr_compen
is
  version_header  constant  varchar2(64) := 'version 1.45 30.03.2017 13:36';

  procedure create_recport (p_record       in clob    ,
                            p_err         out varchar2,
                            p_ret         out int);

  procedure drop_port_tvbv (p_tvbv         in varchar2,
                            p_kf           in varchar2,
                            p_err         out varchar2,
                            p_ret         out int);

  procedure fix_port_tvbv  (p_tvbv         in varchar2,
                            p_kf           in varchar2,
                            p_err         out varchar2,
                            p_ret         out int);

  procedure make_wiring    (p_tvbv         in varchar2,
                            p_summa        in varchar2, --number
                            p_nls          in varchar2,
                            p_ob22         in varchar2,
                            p_kv           in varchar2, --number
                            p_branch       in varchar2,
                            p_date_import  in varchar2, --date
                            p_err         out varchar2,
                            p_ret         out int);

  procedure drop_wiring    (p_tvbv         in varchar2,
                            p_kf           in varchar2,
                            p_date_import  in varchar2,
                            p_err         out varchar2,
                            p_ret         out int);

  procedure count_compen   (p_mode         in varchar2,
                            p_tvbv         in varchar2,
                            p_mfo          in varchar2,
                            p_err         out varchar2,
                            p_ret         out int);

  procedure get_info_vkl   (p_mode         in varchar2,
                            p_tvbv         in varchar2,
                            p_brmf         in varchar2,
                            p_ret         out clob);

  --Імпорт користувачів з РУ
  procedure compen_user_create(p_logname staff.logname%type,
                               p_fio staff.fio%type,
                               p_branch staff.branch%type,
                               p_can_select_branch staff.can_select_branch%type,
                               p_method varchar2,
                               p_dateprivstart date,
                               p_dateprivend date);

  function header_version   return varchar2;

  function body_version     return varchar2;

  function b64d (p_s clob)  return clob;

  function f_dbcode        (p_doctype  number  ,
                            p_serial   varchar2,
                            p_number   varchar2)
                            return varchar2;
                            
  procedure update_info_from_file_j(p_record       in clob    ,
                                    p_err          out varchar2,
                                    p_ret          out int);                            

end crkr_compen;
/