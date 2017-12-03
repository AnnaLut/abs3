create or replace view nd_drec as
select  to_number(pul.Get_Mas_Ini_Val('ND')) ND,
        t.TAG,
        t.name,
        substr((select txt from nd_txt where tag = t.tag and nd = pul.Get_Mas_Ini_Val('ND')), 1, 100) VAL
from cc_tag t where t.tag in('VNCRR','VNCRP','PAWN','NEINF','KHIST','BUS_MOD','SPPI','IFRS');
