set pagesize 100 
set linesize 4000
set trims ON
set serverout ON size 1000000
set feedback on
set pause off
set heading off
set spool on

column mfo new_value mfo 
accept mfo prompt 'Введите МФО для работы замены некорретных символов в адресах клиента. Пусто  - все МФО'
column rnk new_value rnk 
accept rnk prompt 'Введите RNK клиента для замены некорректных символов. ПУСТО - все клиенты'

spool D:\adr_replace.log

select 'Параметры для работы: МФО = '||decode(nvl('&mfo','-'),'-','ВСЕ',to_char('&mfo'))||', RNK = '||decode(nvl('&rnk','-'),'-','ВСЕ',to_char('&rnk'))
  from dual;
set termout off
set feedback off

declare 
  v_num integer;
begin
  select count(1) into v_num
    from user_tables 
    where table_name = 'TMP_ADDR_UPDATE';
  if v_num = 0 then
    execute immediate 'create table tmp_addr_update (kf varchar2(6), rnk number, dt_update date,
                               domain_old varchar2(30), domain_new varchar2(30),
                               region_old varchar2(30), region_new varchar2(30),
                               locality_old varchar2(30), locality_new varchar2(30),
                               address_old varchar2(100), address_new varchar2(100),
                               street_old varchar2(100), street_new varchar2(100),
                               home_old varchar2(100), home_new varchar2(100),
                               room_old varchar2(100), room_new varchar2(100),
                               zip_old varchar2(20), zip_new varchar2(20))';
  end if;
end;
/


declare 
  -- Local variables here
  v_rowids sys.odciridlist;
  v_cnt number;
  v_cnt_upd number;
  v_rnk number := to_number('&rnk');
  v_limit number := null;
  v_flag integer;
  v_rec customer_address%rowtype;
  v_start_time timestamp := systimestamp;
  v_okpo customer.okpo%type;
  v_kf_start_time timestamp := systimestamp;

  function translate_field (p_str in varchar2,
                            p_flag in number default 0) 
    return varchar2
    is 
    v_ret varchar2(2000) := replace(p_str,'''','"');
    v_pos number;
    v_sql varchar2(1000);
    v_num integer;
  begin
--    dbms_output.put(v_ret||' -> ');
    -- п.3 видалити комбінацію - #Ссылка!
    v_ret := trim(replace(replace(v_ret,'#Ссылка!'),'#ССЫЛКА!'));

    if v_ret like '%—%' then
      v_ret := replace(v_ret,'—','-');
    end if;


    -- п.5
    -- Якщо дані поля складаються лише з одного символа, цифри чи букви, який повторюється декілька разів, то очистити поле
    if nvl(p_flag,0) > 0 then
--      v_ret := regexp_replace(upper(v_ret),'^(.)\1+$');
      if regexp_like(upper(v_ret),'^(.)\1+$') then
        return null;
      end if;
    end if;
    if v_ret is null then
      return null;
    end if;
    
    -- п.6
    -- Якщо дані поля складаються виключно з набору символів, включаючи пробіли (букви та цифри відсутні), то очистити поле
    if not regexp_like(v_ret,'[[:alnum:]]') then
      return null;
    end if;



    -- п.7
    -- Якщо в слові 4 та більше латинських символи, провести транслітерацію англійських букв та символів ([]{};':",.<>) у кирилицю, відповідно до QWERTY / ЙЦУКЕН розкладки. 
    if length(v_ret)-length(regexp_replace(v_ret,'[a-zA-Z]'))>=4 then
      v_ret := initcap(translate(v_ret,'—–”“’‘`QWERTYUIOPASDFGHJKLZXCVBNM{qwertyuiopasdfghjklzxcvbnm[<:,;^«»','--''''''''''ЙЦУКЕНГШЩЗФІВАПРОЛДЯЧСМИТЬХйцукенгшщзфівапролдячсмитьхБЖбж'));
    else
    -- п.8
    --Якщо в полі 3 або менше латинських символи, провести заміну англійських букв наступним чином
    -- англійську "і" замінити на українську "і"
    --англійську "р" замінити на українську "р"
      v_ret := translate(v_ret,'iIpP','іІрР');
    end if;

    -- п.9
    -- замінити "\" на "/" (слеш) 
    v_ret := replace(v_ret,'\','/');
    
    -- п.10
    -- "^" прикінцевий видалити
    v_ret := rtrim(v_ret,'^');
    
    -- п.11
    -- видалити лідуючі крапки (.)
    v_ret := ltrim(v_ret,'.');
    
    -- п.12
    -- замінити #Вка на ївка, якщо це останні чотири символа/букви у полі
    if v_ret like '%#Вка' then
      v_ret := replace(v_ret,'#Вка','ївка');
    end if;

    -- п.13
    -- замінити #Нка на їнка, якщо це останні чотири символа/букви у полі
    if v_ret like '%#Нка' then
      v_ret := replace(v_ret,'#Нка','їнка');
    end if;

    -- п.14 
    -- замінити #В на ів, якщо це останні два символа/букви у полі
    if v_ret like '%#В' then
      v_ret := replace(v_ret,'#В','їв');
    end if;
   
-- п.33
--Видалити прикінцеві символи 
--‘ (відкриваюча кавичка)
--' (апостроф)
    if nvl(p_flag,0)>0 then
      v_ret := rtrim(rtrim(rtrim(v_ret,'‘'),''''),'*');
    end if;

    -- п.15
    -- "Замінити на апостроф наступні символи:
    -- ""`""
    -- ""‘""
    -- ""’""
    -- ""@"" 
    -- подвійні лапки                                                                                                     
    v_ret := replace(replace(v_ret,chr(38)||'Quo',''''),chr(38)||'Qu','''');
    v_ret := translate(v_ret,chr(38)||'`‘’"','''''''''''');
    
    
    -- п.17
    -- "Вимогу алгоритму необхідно уточнити :
    -- якщо перед ""*"" стоїть одна з букв б,п,в,м,ф,р та одночасно після ""*"" стоїть одна з букв я,ю,є,ї , 
    -- то зробити заміну ""*"" на апостроф. В решті випадків заміну не виконувати"
    v_ret := regexp_replace(v_ret,'([БПВМФРбпвмфр])(\*)([ЯЮЄЇяюєї])','\1''\3');
    
    --п.18
    -- "~в" замінити на "ів"
    v_ret := replace(v_ret,'~в','ів');
    
    --п.19
    -- Символ "ў" замінити на "і"
    v_ret := translate(v_ret,'Ўў','Іі');
    
    -- п.21
    -- Букву "Ы"  замінити на "і"
    v_ret := replace(v_ret,'Ыы','Іі');
    
    -- п.20
    -- "Замінити на дефіс наступні символи та комбінації:
    --тире  (–)
    --""-="" 
    --""=-""
    --""="""
    v_ret := regexp_replace(translate(v_ret,'–=','--'),'([ =])([-])|([-])([ =])','-');
    
    -- п.21
    /*
      "- замінювати наступні комбінації символів з ""1"" за умови, що символи справа і зліва від ""1"" не є буквами ""і"":
      ""1в"" на ""ів""
      ""ц1"", якщо наступний символ пробіл або це останні символи поля - заміняти  на ""ці""
      ""п1д"" на ""під""
      ""б1л"" на ""біл""
      ""с1н"" на ""сін""
      ""г1р"" на ""гір""
      ""ч1"", якщо наступний символ пробіл або це останні символи поля - заміняти  на ""чі""
      - заміняти ""1"" на ""ї"",  за умови, що символ зліва від ""1""  є буквою ""і"""
    */
    if p_flag = 2 then
      if v_ret like '%i1' then
        v_ret := replace(v_ret,'i1','iї');
      end if;
      v_ret := replace(regexp_replace(v_ret,'([пбсчгц])([1])','\1і'),'1в','ів');
--      v_ret := regexp_replace(v_ret,'([:а-зї-я])([1])','\1і');
    end if;
-- якщо поле складається лише з будь-якого 1 символа (включаючи букви та цифри, "пробіл"), очистити поле
    if length(v_ret) = 1 and nvl(p_flag,0) > 0 then -- п.4
      return null; 
    end if;

    -- п.22
    -- замінити !- на 1- у полі ВУЛИЦЯ
    if p_flag = 2 and v_ret like '%!-%' then
      v_ret := replace(v_ret,'!-','1-');
    end if;
  
    if p_flag = 1 then 
    -- п.23
    -- Замінити всі 1 на "і", причому, якщо 1 стоїть на початку слова, то замінити на велику "і". 
    -- А потім знайти всі випадки, де зустрічаються дві "і" підряд і замінити другу на "ї".
      if v_ret not like '%-%1%' and not regexp_like(v_ret,'^[[:digit:]]+$') then
        v_ret := replace(replace(replace(regexp_replace(v_ret,'^1','I'),' 1',' І'),'1','і'),'іі','ії');
      end if;
    -- п.26
    --"Заміняти  наступні комбінації символів, якщо вони стоять на початку поля:
    -- ""с/""  на ""с.""
    --""с,"" на ""с.""
    --""С>"" на ""с.""
    --""м,""  на ""м.""
    --""м/""  на ""м.""
    --""смт,""  на ""смт.""
    --""смт/""  на ""смт."""
      v_ret := regexp_replace(ltrim(v_ret),'^((с)|(С)|(м)|(смт))[/,>?]','\1.');
    end if;
    
    -- п.24
    -- Замінити "«", "“" (відкриваючі подвійні кавички), "»", "”" (закриваючі подвійні кавички) на одинарну кавичку відкриваючу чи закриваючу відповідно
    v_ret := translate(v_ret,'«“»”','’’‘‘');
    
    -- п.25
    -- "Заміняти  наступні комбінації символів, якщо вони стоять на початку поля:
    -- ""вул,"" на ""вул.""
    -- ""вул/"" на ""вул.""
    --""пров,"" на ""пров.""
    --""пров/"" на ""пров.""
    --""бул,"" на ""бул.""
    --""бул/"" на ""бул."""
    if p_flag = 2 then
      v_ret := regexp_replace(v_ret,'^((вул)|(пров)|(бул))[,/]','\1.');
    end if;
    
    
--п.26
--видалити лідуючі та прикінцеві символи в строці
-- коми (,) 
--2 коми (,,)
--кома пробіл кома (, ,)
-- слеш (/)
--пара дужок ()"

    v_ret := ltrim(rtrim(ltrim(rtrim(v_ret,','),','),'/'),'/');
    if v_ret like ',,%' then 
      v_ret := substr(v_ret,3);
    end if;
    if v_ret like '%,,' then
      v_ret:=substr(v_ret,1,length(v_ret)-2);
    end if;
    if v_ret like ', ,%' then
      v_ret := substr(v_ret,4);
    end if;
    if v_ret like '%, ,' then
      v_ret:=substr(v_ret,1,length(v_ret)-3);
    end if;
    if v_ret like '()%' then 
      v_ret := substr(v_ret,3);
    end if;
    if v_ret like '%()' then
      v_ret:=substr(v_ret,1,length(v_ret)-2);
    end if;

    -- п.28
    -- Якщо комбінація ". " (крапка пробіл) стоїть на початку рядка або якщо після цих символів стоїть дефіс, то видалити ". "
    v_ret := replace(ltrim(v_ret,'. '),'.-','-');
    
    -- п.29
    -- провести заміну будь-яких двох однакових символів на один той самий символ (крім букв та цифр). Проводити заміну, поки подвійні символи не закінчаться
    v_ret := regexp_replace(v_ret,'([^[:alnum:]])\1+','\1');

    -- п.30
    -- Видалити лідуючі та прикінцеві пробіли
    v_ret := trim(v_ret);
    
-- п.31
-- Вимогу алгоритму необхідно уточнити :
-- якщо перед "@" стоїть одна з букв б,п,в,м,ф,р та одночасно після "@" стоїть одна з букв я,ю,є,ї , то зробити заміну "@" на апостроф. В решті випадків символ "@" видалити
    v_ret := regexp_replace(v_ret,'([БПВМФРбпвмфр])(@)([ЯЮЄЇяюєї])','\1''\3');
    v_ret := replace(v_ret,'@','');



/*    if regexp_like(v_ret,'[А-Я]') then
      v_ret := initcap(v_ret);
    end if;
*/    
    return v_ret;
  end;

begin

  for b in (select * from mv_kf where kf = nvl('&mfo',kf)) loop
    v_kf_start_time := systimestamp;
    bc.go(b.kf);
    v_okpo := f_ourokpo;
    v_cnt := 0;
    v_cnt_upd := 0;
dbms_output.put_line('mfo = '||b.kf);
    dbms_application_info.set_action('start select kf = '||b.kf);
    for cln in (select ca.rowid, ca.*
                  from customer_address ca, 
                       customer c,
                       codcagent cc
                  where (c.custtype = 3 or (c.custtype=2 and c.sed=91))
                    and c.kf = b.kf 
                    and ca.kf = b.kf
                    and c.rnk = ca.rnk 
                    and c.okpo != v_okpo
                    and c.rnk = nvl(v_rnk,c.rnk)
                    and c.date_off is null
                    and c.codcagent = cc.codcagent
                    and cc.rezid = 1
                    and ((v_limit is not null and rownum< nvl(v_limit,1)) or 
                         (v_limit is null))
)
    loop 
        select * into v_rec from customer_address where rowid = cln.rowid;
        v_cnt := v_cnt +1;
        dbms_application_info.set_action('kf = '||b.kf||'('||v_cnt||')');
         v_rec.locality := translate_field(cln.locality,1);

         v_rec.region   := translate_field(cln.region,3);

--  якщо поле індекс складається із цифр та літери "О" (кирилицею або латиницею), то замінити "О" на цифру "0"
         if regexp_count(cln.zip,'\d') = 5 and length(cln.zip)>5 then
           v_rec.zip := regexp_replace(cln.zip,'[^[:digit:]]');
         else 
           v_rec.zip := cln.zip;
         end if;
         if v_rec.zip like '%O%' or v_rec.zip like '%О%' then
           v_rec.zip      := regexp_replace(translate(v_rec.zip,'OО','00'),'\D');  -- translate= п.4
         end if;

         if cln.zip like '%O%' or cln.zip like '%О%' then
           if regexp_count(cln.zip,'\d') = 5 then
             v_rec.zip      := regexp_replace(cln.zip,'[^[:digit:]]');
           else 
             v_rec.zip      := regexp_replace(translate(cln.zip,'OО','00'),'\D');  -- translate= п.4
           end if;
         end if;
-- п.6 для индекса отдельно
         if length(v_rec.zip) = 1 then
           v_rec.zip := null;
         end if;

         v_rec.domain   := translate_field(cln.domain,1);

         v_rec.address  := translate_field(cln.address);

         v_rec.street   := translate_field(cln.street,2);

-- п.34
--"Виконувати заміну латинських літер на літери кирилиці наступним чином:
--А на А
--В на В
--І на І
--Т на Т
--К на К
--Р на Р
--Н на Н
--М на М

         v_rec.home     := translate(cln.home,'AaBbIiTtKkPhHhMm','АаВвІіТтКкРрНнМм');
    -- п.24
    -- Замінити "«", "“" (відкриваючі подвійні кавички), "»", "”" (закриваючі подвійні кавички) на одинарну кавичку відкриваючу чи закриваючу відповідно
         v_rec.home := translate(v_rec.home,'«“»”','’’‘‘');

         v_rec.home     := translate_field(v_rec.home);

         v_rec.room     := translate_field(cln.room);
         v_rec.room := translate(v_rec.room,'«“»”','’’‘‘');



           if   nvl(v_rec.domain,'Ґ') != cln.domain
             or nvl(v_rec.region,'Ґ') != cln.region
             or nvl(v_rec.locality,'Ґ') != cln.locality
             or nvl(v_rec.address,'Ґ') != cln.address
             or nvl(v_rec.street,'Ґ') != cln.street
             or nvl(v_rec.home,'Ґ') != cln.home
             or nvl(v_rec.room,'Ґ') != cln.room
             or nvl(v_rec.zip,'Ґ') != cln.zip then
             
             update customer_address
               set domain = v_rec.domain,
                   region = v_rec.region,
                   locality = v_rec.locality,
                   address = v_rec.address,
                   street = v_rec.street,
                   home = v_rec.home,
                   room = v_rec.room,
                   zip = v_rec.zip
               where rowid = cln.rowid;
             insert into tmp_addr_update 
               select b.kf, cln.rnk, sysdate,
                      case v_rec.domain
                        when cln.domain then null
                        else cln.domain
                      end,
                      case v_rec.domain
                        when cln.domain then null
                        else v_rec.domain
                      end,
                      case v_rec.region
                        when cln.region then null
                        else cln.region
                      end,
                      case v_rec.region
                        when cln.region then null
                        else v_rec.region
                      end,
                      case v_rec.locality
                        when cln.locality then null
                        else cln.locality
                      end,
                      case v_rec.locality
                        when cln.locality then null
                        else v_rec.locality
                      end,
                      case v_rec.address
                        when cln.address then null
                        else cln.address
                      end,
                      case v_rec.address
                        when cln.address then null
                        else v_rec.address
                      end,
                      case v_rec.street
                        when cln.street then null
                        else cln.street
                      end,
                      case v_rec.street
                        when cln.street then null
                        else v_rec.street
                      end,
                      case v_rec.home
                        when cln.home then null
                        else cln.home
                      end,
                      case v_rec.home
                        when cln.home then null
                        else v_rec.home
                      end,
                      case v_rec.room
                        when cln.room then null
                        else cln.room
                      end,
                      case v_rec.room
                        when cln.room then null
                        else v_rec.room
                      end,
                      case v_rec.zip
                        when cln.zip then null
                        else cln.zip
                      end,
                      case v_rec.zip
                        when cln.zip then null
                        else v_rec.zip
                      end
                 from dual;
                 v_cnt_upd := v_cnt_upd + 1;
                 if v_cnt_upd - round(v_cnt_upd,-3) = 0 then
--                   rollback;
                   commit;
                   null;
                 end if;
           end if;
          commit;    
--        rollback;
      end loop;
      dbms_output.put_line('KF = '||b.kf||': time - '||to_char(systimestamp - v_kf_start_time)||'(start '||to_char(v_kf_start_time,'hh24:mi:ssx')||', end '||to_char(systimestamp,'hh24:mi:ss')||'), count = '||v_cnt||', upd = '||v_cnt_upd);
    bars.bc.home;
  end loop;
  
  dbms_output.put_line('Total time = '||to_char(systimestamp - v_start_time)||'(start '||to_char(v_start_time,'hh24:mi:ssx')||', end '||to_char(systimestamp,'hh24:mi:ss')||', upd = '||v_cnt_upd);

end;
/

spool off
