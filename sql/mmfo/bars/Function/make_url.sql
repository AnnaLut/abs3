
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/make_url.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MAKE_URL (
    p_url           in varchar2,
    p_name          in varchar2,
    p_tag1          in varchar2 default null, p_value1   in varchar2 default null,
    p_tag2          in varchar2 default null, p_value2   in varchar2 default null,
    p_tag3          in varchar2 default null, p_value3   in varchar2 default null,
    p_tag4          in varchar2 default null, p_value4   in varchar2 default null,
    p_tag5          in varchar2 default null, p_value5   in varchar2 default null,
    p_tag6          in varchar2 default null, p_value6   in varchar2 default null,
    p_tag7          in varchar2 default null, p_value7   in varchar2 default null,
    p_tag8          in varchar2 default null, p_value8   in varchar2 default null,
    p_tag9          in varchar2 default null, p_value9   in varchar2 default null
  ) return varchar2 is
  --
  -- порождает URL-ссылку с параметрами
  --
begin
    return '<a href="'||p_url
    ||
    case when p_tag1 is not null then '?'||p_tag1||'='||utl_url.escape(url=>p_value1, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag2 is not null then '&'||p_tag2||'='||utl_url.escape(url=>p_value2, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag3 is not null then '&'||p_tag3||'='||utl_url.escape(url=>p_value3, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag4 is not null then '&'||p_tag4||'='||utl_url.escape(url=>p_value4, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag5 is not null then '&'||p_tag5||'='||utl_url.escape(url=>p_value5, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag6 is not null then '&'||p_tag6||'='||utl_url.escape(url=>p_value6, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag7 is not null then '&'||p_tag7||'='||utl_url.escape(url=>p_value7, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag8 is not null then '&'||p_tag8||'='||utl_url.escape(url=>p_value8, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag9 is not null then '&'||p_tag9||'='||utl_url.escape(url=>p_value9, url_charset=>'AL32UTF8')
    else '' end
    ||'">'||p_name||'</a>';
end make_url;
 
/
 show err;
 
PROMPT *** Create  grants  MAKE_URL ***
grant EXECUTE                                                                on MAKE_URL        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/make_url.sql =========*** End *** =
 PROMPT ===================================================================================== 
 