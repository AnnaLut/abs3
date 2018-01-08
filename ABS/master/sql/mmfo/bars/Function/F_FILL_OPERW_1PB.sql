create or replace function F_FILL_OPERW_1PB(
                                   p_ref        in number,
                                   p_typ        in number,
                                   p_val        in varchar2,
                                   o_err_mes    out varchar2) return number
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   функція оновлення допреквізитів для 1ПБ
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% AUTHOR      :   VirkoTV
% VERSION     :  10/05/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Вхідні параметри
%
% p_ref - РЕФ документу
% p_typ - тип памаетру (1 - KOD_B, 2 - KOD_N, 3 -KOD_G 
% p_val - значення параметру 
%
%   Вихідні параметри
%
%        функція повертає 0, якщо все добре, а інакще - код помилки +
%        у параметрі OUT o_err_mes - повідомлення про помилку
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
is 
    l_tag varchar2(10);
begin
    if p_typ = 1 then
       l_tag := 'KOD_B';
    elsif p_typ = 2 then
       l_tag := 'KOD_N';
    elsif p_typ = 3 then
       l_tag := 'KOD_G';    
    else
       l_tag := '';
    end if;
    
    if trim(l_tag) is not null and
       p_ref is not null
    then
       if trim(p_val) is null then
          DELETE 
          FROM operw
          WHERE  ref= p_ref AND 
                 tag = l_tag;
       else
          MERGE INTO operw o
          USING (select p_ref ref, l_tag tag, p_val value
                 from dual) p
          ON (o.ref = p.ref and
              o.tag = p.tag)
          WHEN MATCHED THEN
            UPDATE SET o.value = p_val
          WHEN NOT MATCHED THEN
            INSERT (o.ref, o.tag, o.value)
            VALUES (p_ref, l_tag, p_val);
       end if; 
    end if;
    
    return 0;
exception
    when others then
        o_err_mes := sqlerrm;
        
        return sqlcode;
end;
/                                    