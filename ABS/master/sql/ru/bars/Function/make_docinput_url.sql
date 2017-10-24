
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/make_docinput_url.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MAKE_DOCINPUT_URL (
    p_tt            in varchar2,
    p_visual_name   in varchar2,
    p_tag1          in varchar2 default null, p_value1   in varchar2 default null,
    p_tag2          in varchar2 default null, p_value2   in varchar2 default null,
    p_tag3          in varchar2 default null, p_value3   in varchar2 default null,
    p_tag4          in varchar2 default null, p_value4   in varchar2 default null,
    p_tag5          in varchar2 default null, p_value5   in varchar2 default null,
    p_tag6          in varchar2 default null, p_value6   in varchar2 default null,
    p_tag7          in varchar2 default null, p_value7   in varchar2 default null,
    p_tag8          in varchar2 default null, p_value8   in varchar2 default null,
    p_tag9          in varchar2 default null, p_value9   in varchar2 default null,
    p_tag10         in varchar2 default null, p_value10  in varchar2 default null,
    p_tag11         in varchar2 default null, p_value11  in varchar2 default null,
    p_tag12         in varchar2 default null, p_value12  in varchar2 default null,
    p_tag13         in varchar2 default null, p_value13  in varchar2 default null,
    p_tag14         in varchar2 default null, p_value14  in varchar2 default null,
    p_tag15         in varchar2 default null, p_value15  in varchar2 default null,
    p_tag16         in varchar2 default null, p_value16  in varchar2 default null,
    p_tag17         in varchar2 default null, p_value17  in varchar2 default null,
    p_tag18         in varchar2 default null, p_value18  in varchar2 default null,
    p_tag19         in varchar2 default null, p_value19  in varchar2 default null

  ) return varchar2 is
begin
    return
    '<a href="/barsroot/docinput/docinput.aspx?tt='||p_tt
    ||
    case when p_tag1 is not null then '&'||p_tag1||'='||utl_url.escape(url=>p_value1, url_charset=>'AL32UTF8')
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
--
    ||
    case when p_tag10 is not null then '&'||p_tag10||'='||utl_url.escape(url=>p_value10, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag11 is not null then '&'||p_tag11||'='||utl_url.escape(url=>p_value11, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag12 is not null then '&'||p_tag12||'='||utl_url.escape(url=>p_value12, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag13 is not null then '&'||p_tag13||'='||utl_url.escape(url=>p_value13, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag14 is not null then '&'||p_tag14||'='||utl_url.escape(url=>p_value14, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag15 is not null then '&'||p_tag15||'='||utl_url.escape(url=>p_value15, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag16 is not null then '&'||p_tag16||'='||utl_url.escape(url=>p_value16, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag17 is not null then '&'||p_tag17||'='||utl_url.escape(url=>p_value17, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag18 is not null then '&'||p_tag18||'='||utl_url.escape(url=>p_value18, url_charset=>'AL32UTF8')
    else '' end
    ||
    case when p_tag19 is not null then '&'||p_tag19||'='||utl_url.escape(url=>p_value19, url_charset=>'AL32UTF8')
    else '' end

--
    ||'">'||p_visual_name||'</a>';
end make_docinput_url;
/
 show err;
 
PROMPT *** Create  grants  MAKE_DOCINPUT_URL ***
grant EXECUTE                                                                on MAKE_DOCINPUT_URL to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/make_docinput_url.sql =========*** 
 PROMPT ===================================================================================== 
 