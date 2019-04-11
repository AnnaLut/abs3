CREATE OR REPLACE PACKAGE BARS.monex is
  -- 07.05.2018 Sta Универсальное название участника
  -- 19.09.2017  Sta + Artem Юрченко Очистка пользовательского контекста
  -- 11.01.2017  Добавлена работа с БРАГАМИ

  TYPE rec1 IS RECORD (s number);
  TYPE tab1 IS TABLE  OF rec1 INDEX BY VARCHAR2(17);

---------------------------------------------------------
function UNAME ( p_Branch varchar2 )  return varchar2 ;

procedure clear_session_context; -- Очистка пользовательского контекста

function OB3  ( p_ob22 varchar2 )  return varchar2 ;
function NLSM_ext ( p_UO int, p_BBBBOO varchar2,  p_branch monexr.branch%type ) return varchar2 ;
function NLSM ( p_nbs  accounts.nbs%type,  p_ob22  monexr.ob22%type,  p_branch monexr.branch%type )  return varchar2 ;

function show_monex_ctx( tag VARCHAR2) return varchar2 ;

PROCEDURE set_monex_ctx( tag VARCHAR2, val VARCHAR2, client_id VARCHAR2 DEFAULT NULL);

PROCEDURE monex_KL (  p_UL number) ; --- p_dat1 date, p_dat2 date) ---- Выполнить расчеты  по ЮЛ --  текущее сальдо счета

--------------------------------------------------------------------- Загрузка XML-файла в таблицу MONEXR
 procedure GET_FIle (p_Mode int);
 ------------------------------------------
 procedure opl1( oo IN OUT oper%rowtype)  ;
 -------------------------------------------------------------------- Выполнить клиринг за период  дат на межбанке по СВИФТУ
 PROCEDURE monex_MB (p_kod_NBU varchar2, p_dat1 date, p_dat2 date);
 -------------------------------------------------------------------- Выполнить проводки по клирингу за период  дат
 PROCEDURE monexDS (p_dat1 date, p_dat2 date,system_ varchar2 default '%') ;
 PROCEDURE monexD (p_dat1 date, p_dat2 date, system_ varchar2) ;
 -------------------------------------------------------------------- Выполнить проводки по клирингу по одной системе и за одну дату
 PROCEDURE monexp( p_kod_NBU varchar2,  p_dat date) ;
 ---------------------------------------------------------------------......
 procedure DEL_FIle (p_fdat MONEXR.fdat%type, p_nbu  MONEXR.kod_nbu%type );
--------------------------------------------------
end monex;
/

CREATE OR REPLACE PACKAGE BODY BARS.monex is

  NLS7_AG varchar2(15) := '75098000200000';
  NLS6_AG varchar2(15) := '65102012600000';

/*
  22.10.2018 Sta COBUMMFO-9569
     - добавить деб.инф.сообщение для ОТРИЦ.сальдовых позиций на счета Агентов(т.е. Агент должен Ощадбанку)
     - В справочнике «BRAG-1 Довідник ЮО що працюють в СТП» необходимо добавить колонку с счетом для расчета по комиссии.
       При клиринге формировать сальдовую позицию на счет клиента/деб информационку по комиссии отдельно от сумм по переводам.


  29.08.2018 Sta Дата док= банк-дате ( также в версию   24/10/2017 LitvinSO )
  02.04.2018 Sta alter TABLE BARS.MONEX_MV_UO add ( KOMB6 varchar2(15), KOMB7 varchar2(15) )
                 Бизнес хочет видеть разницу в ЦА по отдельным счетам для каждого субагента и в разрезе систем переводов
  23.03.2018 Sta По рерультатам встречи с Ільяш Антон Миколайович [mailto:IlyashAM@oschadbank.ua]
                 согласованы бух.моб ВСЕХ видов комимссий 
  15.03.2018 Sta RETURNSENDFEE. Пул перем TOAD для загрузки из Тоада  COBUMMFO-6328 доопрацювання функцій «АРМу кліринг по платіжним системам»
         Огаренко Ірина Михайлівна, OgarenkoIM@oschadbank.ua, (044) 249-31-39
         MoneyGram необхідно внести зміни в процедуру клірингу в АБС.
         MoneyGram відтепер повертає комісію відправнику в повному обсязі, в будь-який день, в будь-якому пункті MoneyGram. 
         Тому при поверненні переказу не у пункті відправки – з пункту відправки забирається сума комісії отриманої за відправку переказу.
         Зі сторони «Єдиного вікна» в клірингові файли буде додано нове поле RETURNSendFEE в якому буде відображатись комісія, яку утримує MoneyGram для повернення клієнту.

         Зі сторони АБС необхідне доопрацювання «АРМу кліринг по платіжним системам»:
         1. В функції «1-2. Перегляд зведеного звіту «Кліринг»» необхідно врахувати цю суму (RETURNSendFEE) як відправку
         2. В функції «2-1. Кліринговий розрахунок з Агентами» при наявності суми в полі RETURNSendFEE по відділенню необхідно cтворити проведення Дт7509 Кт2909

         Також, звертаємо Вашу увагу, що на даний момент відсутня можливість створювати подібні проведення з рівня ЦА на рівень РУ (окрім ММФО), тому просимо запропонувати варіанти вирішення даної задачі.

         Будет 2 платежа:
         1) Грн-дебетлвый на счет 7 кл
         2 Кредитовый на сч 2909
----
  24/10/2017 LitvinSO При формировании Свифтов обрабатываем отрицательную суму если клиент нам должен
             SC-0366458 При формуванні проводки не вірно відображається ЕДРПО відправника платежу
  19.09.2017  Sta + Artem Юрченко Очистка пользовательского контекста
  13.03.2017 Sta  что-то по комис типа Гришкова
  28.02.2017 Сухова. Если СПП иммет расчетный счет у нас  - делаем внутренните проводки и по деб и по кред.
    типа глобал -мани

  27.02 Кемпф+ Гришков . Отметка про обработку поле Fl
  22.02.2017 Sta Кліринг з клієнтами - від рах
  11.01.2017 Sta Розрахунки з клієнтами
  16.12.2016 Sta добавлена работа с БРАГАМИ
  04.12.2016 Гришков Максим Валерійович <GrishkovMV@oschadbank.ua>
  Мережко Юлія Володимирівна <MerezhkoUV@oschadbank.ua>:
  -змінено порядок проведення розрахунків за системою WU (розрахунки за комісією в гривні):
    1. Комісія накопичується на окремому рахунку 3739 в грн.
    2. В В XML-файлі в полях SENTFEE, RECEIVEFEE, RETURNFEE значення комісійної винагороди передається в грн.
    3. Комісія за операції в грн обліковується штатним порядком з використанням штатного рахунку NLST.

  11.10.2016 Sta (Олег Музыка)  - при прийоме файла добавлено 3 поля
  -------------------------------------------------------------------


  04.08.2015 Гришков Максим Валерійович <GrishkovMV@oschadbank.ua>
  Мережко Юлія Володимирівна <MerezhkoUV@oschadbank.ua>:
  Для комиссии MasterCard MoneySend открыт отдельный счет на уровне ЦА 3739510080361 на этот счет зачисляется комиссия (FSB+Service manager),
  которая раз в месяц на основании Акта вручную перечисляется компании "Финансовое Сервис Бюро";
...
Гришков М.В. Відділ системної інтеграції  Управління інтеграції прикладних систем ДI АТ "Ощадбанк"
тел. 71-60
тел. +38(044)249-31-60

*/

    l_flag char(1);
    k_branch varchar2(30);

function UNAME ( p_Branch varchar2 )  return varchar2  IS  l_name varchar2(50) ;
begin

  begin    select name into l_name from BANKS_RU  where mfo    = substr( p_Branch, 2,6 );
  EXCEPTION WHEN NO_DATA_FOUND THEN 
     begin select name into l_name from Branch_uo where branch = p_Branch ;
     EXCEPTION WHEN NO_DATA_FOUND THEN null;
     end ;
  end ;
  return l_name ;
end UNAME ;
----------------------
    procedure clear_session_context    is     --    Очистка пользовательского контекста
    begin   sys.dbms_session.clear_context('BARS_CLEARING', client_id=>sys_context('userenv', 'client_identifier'));  end clear_session_context;
----------------------

--Для работы с БРАГАМИ-----------------------------------------------

  function OB3 ( p_ob22 varchar2 )  return varchar2  is
    s1_   char(1)     := substr( p_ob22,1,1  ) ;    l_ob3 varchar2(3) ;
  begin
    If s1_ >= '0' and s1_ <='9' then RETURN '0'||p_ob22; end if;
    ------------------------------------------------------------
    -- Превращение 2-х знач ОБ22 (симв) в 3-хнач цифровой
    If    s1_ = 'A' then l_ob3 := '10'   ;  ElsIf s1_ = 'B' then l_ob3 := '11' ;
    ElsIf s1_ = 'C' then l_ob3 := '12'   ;  ElsIf s1_ = 'D' then l_ob3 := '13' ;
    ElsIf s1_ = 'E' then l_ob3 := '14'   ;  ElsIf s1_ = 'F' then l_ob3 := '15' ;
    ElsIf s1_ = 'G' then l_ob3 := '16'   ;  ElsIf s1_ = 'H' then l_ob3 := '17' ;
    ElsIf s1_ = 'I' then l_ob3 := '18'   ;  ElsIf s1_ = 'J' then l_ob3 := '19' ;
    ElsIf s1_ = 'K' then l_ob3 := '20'   ;  ElsIf s1_ = 'L' then l_ob3 := '21' ;
    ElsIf s1_ = 'M' then l_ob3 := '22'   ;  ElsIf s1_ = 'N' then l_ob3 := '23' ;
    ElsIf s1_ = 'O' then l_ob3 := '24'   ;  ElsIf s1_ = 'P' then l_ob3 := '25' ;
    ElsIf s1_ = 'Q' then l_ob3 := '26'   ;  ElsIf s1_ = 'R' then l_ob3 := '27' ;
    ElsIf s1_ = 'S' then l_ob3 := '28'   ;  ElsIf s1_ = 'T' then l_ob3 := '29' ;
    ElsIf s1_ = 'U' then l_ob3 := '30'   ;  ElsIf s1_ = 'V' then l_ob3 := '31' ;
    ElsIf s1_ = 'W' then l_ob3 := '32'   ;  ElsIf s1_ = 'X' then l_ob3 := '33' ;
    ElsIf s1_ = 'Y' then l_ob3 := '34'   ;  ElsIf s1_ = 'Z' then l_ob3 := '35' ;
    end if ;
    RETURN ( l_ob3 || substr(p_ob22,2,1) );
  end ob3  ;
-------------
function NLSM_ext ( p_UO int, p_BBBBOO varchar2,  p_branch monexr.branch%type ) return varchar2  IS
      l_nls varchar2(15);
begin If p_UO > 0 then  l_nls := p_BBBBOO ;
      else              l_nls := monex.NLSM ( substr(p_BBBBOO,1,4), substr(p_BBBBOO,5,2), p_branch );
      end if ;
      RETURN l_nls;
end   NLSM_ext ;
----------------
function NLSM ( p_nbs  accounts.nbs%type,  p_ob22  monexr.ob22%type,  p_branch monexr.branch%type )  return varchar2 IS l_nls varchar2(15);
begin l_nls := vkrzn(substr(p_branch,2,5),  p_nbs||'00'|| MONEX.ob3(p_ob22) || '00' || substr(substr(p_branch,-4),1,3) ); RETURN l_nls;
     /* АААА К 0ННН NN FFF
    де,
    АААА – балансовий рахунок
    0ННН – значення „0” + значення ОВ22 (відсутні значення заповнюються нулями зліва)
    NN - 00 для всіх типів ТВБВ, в т.ч. ОПЕРв
    FFF - код ТВБВ.
     */
end NLSM;
----------
function show_monex_ctx( tag  varchar2)  return varchar2 IS
    sess_   varchar2(64) :=bars_login.get_session_clientid;
    sid_    varchar2(64);
 BEGIN
   SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
   sid_:=SYS_CONTEXT('BARS_CLEARING',tag);
   SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);
   return sid_;
end;
----------------

PROCEDURE set_monex_ctx( tag VARCHAR2, val VARCHAR2, client_id VARCHAR2 DEFAULT NULL) IS
BEGIN
   sys.dbms_session.set_context('BARS_CLEARING', tag, val,client_id =>client_id );
END set_monex_ctx;
----------------

-- Выполнить расчеты  по ЮЛ --  текущее сальдо счета
PROCEDURE monex_KL (  p_UL number) is ----, p_dat1 date, p_dat2 date) is  
  oo oper%rowtype     ;
begin 
  oo.datd := gl.bdate;
  oo.mfoa := gl.aMfo ;
  for kk in (select * from monex_UO where id > 0 and id=decode(p_ul,0, id, p_UL) and mfo is not null and nls is not null and okpo is not null)
  loop
      oo.id_b := trim(kk.okpo);
      oo.mfob := kk.Mfo ;  
      oo.nam_b:= substr(kk.name,1,38);

      -- по сумі переказів
      For ss in (select * from accounts where ostc <> 0 and ostb = ostc and nls in ( select trim(ob22_2909) from monex_mv_UO where uo = kk.ID and ob22_2909 is not null) )
      loop oo.kv    := ss.kv; 
           oo.kv2   := oo.KV; 
           oo.s     := abs(ss.ostc);  
           oo.s2    := oo.s; 
           oo.nlsa  := ss.nls ;  
           oo.nam_a := substr(ss.nms,1,38);  
           oo.nlsb  := trim(kk.nls) ;  
           SELECT okpo INTO oo.id_a FROM customer WHERE rnk=ss.rnk ;   -- COBUMMFO-5076 SC-0366458 При формуванні проводки не вірно відображається ЕДРПО відправника платежу
           If ss.ostc > 0          then oo.dk  := 1 ; oo.nazn := 'Перерахування кредитового' ;         oo.vob := 1 ;
           elsIf oo.MFOb = oo.Mfoa then oo.dk  := 0 ; oo.nazn := 'Списання дебетового';                oo.vob := 2 ;
           else                         oo.dk  := 2 ; oo.nazn := 'Вимога на відшкодування дебетового'; oo.vob := 2 ;
           end if ;
           oo.nazn := Substr(oo.nazn ||' сальдова позиція по сумі переказів по СТП '|| ss.nms, 1,160);
           MONEX.OPL1(oo);
      end loop; -- ss цикл по счетам

       -- по сумі комісій
      For ss in (select * from accounts where ostc <> 0 and ostb = ostc and nls in ( select trim(ob22_kom) from monex_mv_UO where uo = kk.ID and ob22_kom is not null) )
      loop oo.kv := ss.kv; 
           oo.kv2   := oo.KV; 
           oo.s     := abs(ss.ostc);  
           oo.s2    := oo.s; 
           oo.nlsa  := ss.nls ;  
           oo.nam_a := substr(ss.nms,1,38);  
           oo.nlsb  := trim(kk.nls) ;  
           SELECT okpo INTO oo.id_a FROM customer WHERE rnk=ss.rnk ;   -- COBUMMFO-5076 SC-0366458 При формуванні проводки не вірно відображається ЕДРПО відправника платежу
           If ss.ostc > 0          then oo.dk  := 1 ; oo.nazn := 'Перерахування кредитового' ;         oo.vob := 1 ;
           elsIf oo.MFOb = oo.Mfoa then oo.dk  := 0 ; oo.nazn := 'Списання дебетового';                oo.vob := 2 ;
           else                         oo.dk  := 2 ; oo.nazn := 'Вимога на відшкодування дебетового'; oo.vob := 2 ;
           end if ;
           oo.nazn := Substr(oo.nazn ||' сальдова позиція по сумі комісій по СТП '|| ss.nms, 1,160);
           MONEX.OPL1(oo);
        end loop; -- ss цикл по счетам

  end loop ; ------ kk  Цикл по клиентам

end monex_KL;

--------------------------------------------------------------

  --- получение текста атрибута тега по имени
  function getNodeAttr(node in dbms_xmldom.DOMNode, -- текущий тег
                       attr in varchar2 -- имя атрибута
                       ) return varchar2 is
  begin
    return dbms_xmldom.getNodeValue(dbms_xmldom.getnameditem(dbms_xmldom.getattributes(node),
                                                             attr));
  end getNodeAttr;

-----------------------------------------------------
  --- получение текста дочернего тега по имени
  function getChildNodeValue(node in dbms_xmldom.DOMNode, -- текущий тег
                             tag  in varchar2 -- имя тега
                             ) return varchar2 is
    l_children dbms_xmldom.DOMNodeList;
    l_child    dbms_xmldom.DOMNode;
    l_length   number;
  begin
    l_children := dbms_xmldom.getChildNodes(node);
    l_length   := dbms_xmldom.getLength(l_children);

    for i in 0 .. l_length - 1 loop
      l_child := dbms_xmldom.item(l_children, i);
      if (upper(dbms_xmldom.getNodeName(l_child)) = upper(tag)) then
        return dbms_xmldom.getNodeValue(DBMS_XMLDOM.getFirstChild(l_child));
      end if;
    end loop;

    return null;
  end getChildNodeValue;

--------------------------------------
  procedure GET_FIle(p_Mode int) is
    -- p_tag = BarsReport_item = заголовок строки

    g_numb_mask varchar2(100) := '9999999999999999999999999D99999999';
    g_nls_mask  varchar2(100) := 'NLS_NUMERIC_CHARACTERS = ''.,''';

    l_clob   clob;
    l_parser dbms_xmlparser.Parser := dbms_xmlparser.newParser;
    l_doc    dbms_xmldom.DOMDocument;

    l_children dbms_xmldom.DOMNodeList;
    l_child    dbms_xmldom.DOMNode;
    l_length   number;

    --переменные для считывания строки
    MX MONEXR%rowtype;

    l_FL   int := 0;
    l_dat1 MONEXR.FDAT%type;
    nTmp_ int;
  begin
    select max(fdat) into l_dat1 from MONEXR ;

    -- вычитываем clob по частям
    If PUL.GET('TOAD') = '1' then select c into l_clob from TMP_RI_CLOB;
    else                   bars_lob.import_clob(l_clob) ; 
    end if;

    -- парсим
    dbms_xmlparser.parseClob(l_parser, l_clob);
    l_doc := dbms_xmlparser.getDocument(l_parser);

    -- вычитываем свой тег (заголовок строки)
    l_children := dbms_xmldom.getElementsByTagName(l_doc,    'BarsReport_item');
    l_length   := dbms_xmldom.getLength           (l_children                 );

    for i in 0 .. l_length - 1 loop

      --вычитываем всю строку
      l_child := dbms_xmldom.item(l_children, i);

      -- вычитывае нужные  атрибуты строки:
      MX.FDAT := to_date(MONEX.getChildNodeValue(l_child, 'Date'), 'yyyy-mm-dd');

      If gl.bdate <= mx.FDAT  then
         raise_application_error(-20100,   'Банкiвська дата '|| to_char(gl.bdate,'dd.mm.yyyy') ||   ' <= дати з файлу ' || to_char( mx.FDAT, 'dd.mm.yyyy') );
      end if;

      MX.KOD_NBU   := substr(MONEX.getChildNodeValue(l_child, 'SystemCode'), 1, 2);

      If l_FL = 0 then
         -- попутно проверка на дубль даты + код системы (дубль файла)
         begin
           select distinct 1 into nTmp_ from  MONEXR where FDAT = mx.FDAT and kod_nbu = MX.KOD_NBU ;
           raise_application_error(-20100,    'Повторно: дата =' || to_char(mx.FDAT, 'dd.mm.yyyy') ||', код системи= ' || MX.KOD_NBU  );
         EXCEPTION WHEN NO_DATA_FOUND THEN null;
         end;
         l_FL := 1;
      end if;

      MX.Branch := trim(substr   (MONEX.getChildNodeValue(l_child, 'BarsPointCode'), 1, 22));
      
      begin 
      select 1  into nTmp_ from banks$base where mfo= (case when substr(MX.Branch,2,6) in (select distinct substr(branch,2,6) from BRANCH_UO)  then mfo else substr(MX.Branch,2,6) end) and rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN      raise_application_error(-20100,         'Увага: Відділення ' ||MX.Branch||' не дійсне.' );
      end;

      MX.KV       := to_number(MONEX.getChildNodeValue(l_child, 'CurrencyCode'));
      MX.S_2909   := to_number(MONEX.getChildNodeValue(l_child, 'SentAmount'),    g_numb_mask,  g_nls_mask) * 100;
      MX.K_2909   := to_number(MONEX.getChildNodeValue(l_child, 'SentFee'),       g_numb_mask,  g_nls_mask) * 100;
      MX.S_2809   := to_number(MONEX.getChildNodeValue(l_child, 'ReceiveAmount'), g_numb_mask,  g_nls_mask) * 100;
      MX.k_2809   := to_number(MONEX.getChildNodeValue(l_child, 'ReceiveFee'),    g_numb_mask,  g_nls_mask) * 100;
      MX.s_0000   := to_number(MONEX.getChildNodeValue(l_child, 'ReturnAmount'),  g_numb_mask,  g_nls_mask) * 100;
      MX.K_0000   := to_number(MONEX.getChildNodeValue(l_child, 'ReturnFee'),     g_numb_mask,  g_nls_mask) * 100;
/* 11/10/2016 добавлено 3 поля  komb1, komb2, komb3
комиссия оператора
комиссия субагента
комиссия субагента за анулирование
*/
      MX.KOMB1    := to_number(MONEX.getChildNodeValue(l_child, 'SentSyfee')    , g_numb_mask,  g_nls_mask) * 100;
      MX.KOMB2    := to_number(MONEX.getChildNodeValue(l_child, 'ReceiveSafee') , g_numb_mask,  g_nls_mask) * 100;
      MX.KOMB3    := to_number(MONEX.getChildNodeValue(l_child, 'ReturnSafee')  , g_numb_mask,  g_nls_mask) * 100;
      MX.RET_SEND := to_number(MONEX.getChildNodeValue(l_child, 'RETURNSENDFEE'), g_numb_mask,  g_nls_mask) * 100;

     if MX.S_2909 < 0  or  MX.K_2909 < 0   or  MX.S_2809 < 0  or  MX.k_2809 < 0  or   MX.s_0000 < 0  or   MX.K_0000 < 0  then 
        raise_application_error(-20100,         'Увага: у файлі є від*ємне значення! Файл не буде завантажено' );
     end if;

     insert into MONEXR  values  MX;

    end loop;

    commit;
    return;

  end GET_FIle;
-------------------------------------------------------------------------------------
  procedure opl1( oo IN OUT oper%rowtype)  is

    l_rec  arc_rrp.REC%type ;
    l_sos  oper.sos%type    ;
    l_err  int              ;
    l_msg  varchar2(100)    ;
    ind_   VARCHAR2(17)     ;
    --------------------------
 begin
    If    oo.kv <> oo.Kv2  
      and oo.nlsa like '3739%' 
      and oo.nlsb like '3739%' then oo.tt := '013' ;
    ElsIf oo.kv <> oo.Kv2      then oo.tt := 'D06' ;
    ElsIf oo.MFOa = oo.MFOB    then oo.tt := 'PS1' ;
    ElsIf oo.dk = 1            then oo.tt := 'MNK' ;
    ElsIf oo.dk = 0            then oo.tt := 'MND' ;
    ElsIf oo.dk = 2            then oo.tt := 'KLI' ;
    end if;

    gl.ref(oo.REF);
    oo.nd := substr(to_char(oo.ref), 1, 10);
    dbms_output.put_line( oo.Ref ||'*;*'|| oo.tt ||'*;*'|| oo.vob ||'*;*'|| oo.nd||'*;*'|| SYSDATE||'*;*'|| gl.BDATE||'*;*'|| oo.dk ||'*;*'|| oo.kv  ||'*;*'|| oo.S  ||'*;*'|| oo.kv2 ||'*;*'|| oo.S2||'*;*'|| null||'*;*'|| oo.datd ||'*;*'|| gl.bdate||'*;*'|| oo.nam_a||'*;*'|| oo.nlsa||'*;*'|| oo.Mfoa||'*;*'|| oo.nam_b||'*;*'|| oo.nlsb||'*;*'|| oo.mfob||'*;*'|| oo.nazn||'*;*'|| oo.d_rec||'*;*'|| oo.id_a ||'*;*'|| oo.id_b||'*;*'|| oo.id_o);

    gl.in_doc3(ref_  => oo.Ref  , tt_  => oo.tt  , vob_ => oo.vob , nd_  => oo.nd,  pdat_  => SYSDATE,  vdat_ => gl.BDATE,  dk_ => oo.dk ,
                kv_  => oo.kv   , s_   => oo.S   , kv2_ => oo.kv2 , s2_  => oo.S2,  sk_    => null,     data_ => gl.BDATE, datp_=> gl.bdate,
              nam_a_ => oo.nam_a, nlsa_=>  trim(oo.nlsa), mfoa_=> oo.Mfoa,
              nam_b_ => oo.nam_b, nlsb_=> trim(oo.nlsb), mfob_=> oo.mfob, nazn_=> oo.nazn, d_rec_=> oo.d_rec,
              id_a_  => oo.id_a , id_b_=> oo.id_b, id_o_=> oo.id_o, sign_=> null ,  sos_  => 1,   prty_ => null,  uid_ => null );

    If oo.dk in (1,0) then  paytt(0, oo.REF, gl.bDATE, oo.TT, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.S2);    end if;


   if nvl(GetGlobalOption('PEDAL_PROFIX'),0)=1 then

    gl.pay(2, oo.ref, gl.bDATE);
    If oo.mfoa <> oo.mfob then
       SEP.in_sep(err_     => l_err, -- OUT INTEGER,-- Return code
                  rec_     => l_rec, -- OUT INTEGER, -- Record number
                  mfoa_    => gl.aMfo, -- VARCHAR2,  -- Sender's MFOs
                  nlsa_    => oo.nlsa, -- VARCHAR2,  -- Sender's account number
                  mfob_    => oo.mfob, -- VARCHAR2,  -- Destination MFO
                  nlsb_    => oo.nlsb, -- VARCHAR2,  -- Target account number

                  dk_      => oo.dk, -- SMALLINT, -- Debet/Credit code
                  s_       => oo.s, -- DECIMAL,  -- Amount
                  vob_     => oo.vob, -- SMALLINT, -- Document type
                  nd_      => oo.nd, -- VARCHAR2, -- Document number
                  kv_      => oo.kv, -- SMALLINT, -- Currency code
                  data_    => gl.bdate, -- DATE,     -- Posting date
                  datp_    => gl.bdate, -- DATE,     -- Document date
                  nam_a_   => oo.nam_a, -- VARCHAR2, -- Sender's customer name
                  nam_b_   => oo.nam_b, -- VARCHAR2, -- Target customer name
                  nazn_    => oo.nazn, -- VARCHAR2, -- Narrative
                  naznk_   => null, -- CHAR,     -- Narrative code
                  nazns_   => (case when (oo.d_rec is not null) then '11' else '10' end), -- CHAR,     -- Narrative contens type
                  id_a_    => oo.id_a, -- VARCHAR2, -- Sender's customer identifier
                  id_b_    => oo.id_b, -- VARCHAR2, -- Target customer identifier
                  id_o_    => oo.id_o, -- VARCHAR2, -- Teller identifier
                  ref_a_   => substr('000000000' || oo.ref, -9), --VARCHAR2,-- Sender's reference
                  bis_     => 0, --  SMALLINT,    -- BIS number
                  sign_    => null, -- VARCHAR2,    -- Signature
                  fn_a_    => null, -- CHAR,        -- Input file name
                  rec_a_   => null, --- SMALLINT,   -- Input file record number
                  dat_a_   => null, --  DATE,       -- Input file date/time
                  d_rec_   => oo.d_rec , -- '#CBRANCH:'||k_branch|| '#',
                  otm_i    => 0, -- SMALLINT,    -- Processing flag
                  ref_i    => oo.ref, -- INTEGER    DEFAULT NULL, -- PreAssigned Reference
                  blk_i    => null, -- SMALLINT   DEFAULT NULL, -- Blocking code
                  ref_swt_ => null); -- VARCHAR2 DEFAULT NULL  -- Source REF ($A||#rec or Swift F20)

    end if;   --- mfoa<> mfob
  end if;

----------------
  end opl1;

-------------------------------------------------

-- Выполнить клиринг за период  дат на межбанке по СВИФТУ по всем валютаи системы
PROCEDURE monex_MB (p_kod_NBU varchar2, p_dat1 date, p_dat2 date) is
  oo oper%rowtype        ;
  mx monex0%rowtype      ;
  aa accounts%rowtype    ;
  l_txt operw.value%type ;
  nlchr char(2)          := chr(13)||chr(10);
  l_FL  int;
begin

  -- защита от повторной обработки ( даты + систмы)
  begin
    select 1 into l_FL from MONExR where KOD_NBU = p_KOD_NBU and fdat >= p_dat1 and fdat <= p_dat2
       and (fl is null or FM is NOT null ) and rownum = 1;
    RETURN;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  -- Клиринг на МБ идет по каждой системе отдельно , но за период - в целом
--  oo.tt    := '8С2' ; --Kempf
  oo.vob   :=  6         ;
  oo.nazn  := 'Сальдова позиція за ' || to_char( p_dat1, 'dd.mm.yyyy-') || to_char( p_dat2, 'dd.mm.yyyy') || ' по системі ' ;
  oo.d_rec := '#fMT 202#';

  for z in (select r.kv, ( + r.S_2909
                           + NVL2(c.NLSK,0,r.K_2909)
                           - r.S_2809
                           - NVL2(c.NLSK,0,r.K_2809)
                           - r.S_0000
                           - NVL2(c.NLSK,0,r.K_0000)
------------------------   + r.KOMB1        - r.KOMB2             - r.KOMB3
                           + r.RET_SEND
                         ) S   --  = 1+2-3-4-5-6+7-8-9
            from (select kv, sum (S_2909) S_2909,  --  +  1) дебетовый платеж  на 2909 - тело
                             Sum (K_2909) K_2909,  --  +  2) дебетовый платеж  на 2909 - комиссия
                             Sum (S_2809) S_2809,  --  -  3) кредитовый платеж на 2809 - тело
                             Sum (K_2809) K_2809,  --  -  4) кредитовый платеж на 6110 - комиссия
                             Sum (S_0000) S_0000,  --  -  5) кредитовый платеж на 2809 - тело (анул)
                             Sum (K_0000) K_0000,  --  -  6) кредитовый платеж на 2809 - комиссия по анул
-----------------------------Sum (nvl(KOMB1,0) ) KOMB1 ,  --  +  7) деб.платеж  SENTSYFEE.
-----------------------------Sum (nvl(KOMB2,0) ) KOMB2 ,  --  -  8) кред платеж RECEIVESAFEE
-----------------------------Sum (nvl(KOMB3,0) ) KOMB3    --  -  9) кред платеж RETURNSAFEE
                             Sum (nvl(RET_SEND,0) ) RET_SEND  --  -  7) Сума комісії, яку утримує оператор для повернення клієнту
                 from MONExR where KOD_NBU = p_KOD_NBU and fdat >= p_dat1 and fdat <= p_dat2 group by kv
                  ) r ,
                 (select * from SWI_MTI_LIST where KOD_NBU = p_KOD_NBU
                  ) l ,
                 SWI_MTI_CURR c
            where l.NUM = c.NUM and c.kv = r.kv
           )
  loop
    If z.s = 0 then goto NOT_PAY; end if; -- Нет суммы для перечисления

     ------------------------------------
     begin select * into mx from monex0   where KOD_NBU = p_KOD_NBU ;
           select * into aa from accounts where nls     = mx.nlsT   and kv = z.kv ;
     EXCEPTION WHEN NO_DATA_FOUND THEN goto NOT_PAY;
     end;
     oo.ref := null;

     If mx.MFOB = gl.aMfo and mx.NLSB is not null and z.kv = gl.baseval then
     oo.tt    := 'PS1' ; --Kempf
        begin
          select a.nls, substr(a.nms,1,38), c.okpo into oo.nlsB, oo.nam_b, oo.id_B
          from accounts a, customer c
          where a.dazs is null and a.kv = z.kv and a.nls = mx.NLSB and a.rnk = c.rnk ;
        EXCEPTION WHEN NO_DATA_FOUND THEN goto NOT_PAY;
        end;

        oo.id_a := oo.id_b ;
        If z.s > 0 then oo.dk := 1; oo.s := + z.s ;
        else            oo.dk := 0; oo.s := - z.s ;
        end if;

        gl.ref(oo.REF);
        if oo.ref >'999999999' then oo.nd := substr(to_char(oo.REF), -10);
        else                        oo.nd :=        to_char(oo.REF)      ;
        end if ;

        gl.in_doc3(ref_ => oo.ref  , tt_   => oo.tt  , vob_  => oo.VOB  , nd_   => oo.nd   , pdat_  => SYSDATE ,
                   vdat_=> gl.BDATE, dk_   => oo.dk  , kv_   => z.kv    , s_    => oo.S   , kv2_   => z.kv    ,
                   s2_  => oo.S    , sk_   => null   , data_ => gl.BDATE, datp_ => gl.bdate, nam_a_ => substr(aa.nms,1,38),
                   nlsa_=> aa.nls  , mfoa_ => gl.aMfo, nam_b_=> oo.nam_b, nlsb_ => oo.nlsb , mfob_  => mx.MFOB ,
                   nazn_=> oo.nazn ||mx.name         , d_rec_=> null    , id_a_ => oo.id_a , id_b_  => oo.id_b ,
                   id_o_=> null    , sign_ => null   , sos_  => 1       , prty_ => null    , uid_   => null ) ;
        gl.payv( 0, oo.REF, gl.bDATE , oo.tt, oo.dk, z.kv, aa.nls, oo.s, z.kv, oo.nlsb, oo.s )   ;

     else
         if z.S < 0 then  -- Если сума отрицательная (система должна нам!) Ничего не делаем что бы процедура отрабатывала, а не рейзила ошибку
           goto NOT_PAY;
         end if;
        --вал-свифт-проводка : Есть ли шаблон
         oo.tt    := '8C2' ; --Kempf

        for x in (select s.num, s.value, s.tag, l.CDOG , l.DDOG, l.name     from MONEX_SWI s, SWI_MTI_LIST l
                  where s.kv = z.kv and s.num = l.num and l.ob22_2909 = mx.ob22 and s.tag <>'f'
                  order by s.ord)
        loop
           If oo.ref is null then       gl.ref(oo.REF);
              if oo.ref >'999999999' then oo.nd := substr(to_char(oo.REF), -10);
              else                        oo.nd :=        to_char(oo.REF)      ;
              end if ;
              oo.nlsb  := vkrzn( substr( gl.Amfo,1,5),'191992' )  ;
              oo.nam_b := 'Транзит для закорд.переказiв';
              gl.in_doc3(ref_ => oo.ref  , tt_   => oo.TT  , vob_  => oo.VOB  , nd_   => oo.nd   , pdat_  => SYSDATE,
                         vdat_=> gl.BDATE, dk_   => 1      , kv_   => z.kv    , s_    => z.S     , kv2_   => z.kv,
                         s2_  => z.S     , sk_   => null   , data_ => gl.BDATE, datp_ => gl.bdate, nam_a_ => substr(aa.nms,1,38),
                         nlsa_=> aa.nls  , mfoa_ => gl.aMfo, nam_b_=> oo.nam_b, nlsb_ => oo.nlsb , mfob_  => gl.aMfo,
                         nazn_=> oo.nazn ||mx.name         , d_rec_=> oo.d_rec, id_a_ => gl.aOkpo, id_b_  => gl.aOkpo,
                         id_o_=> null    , sign_ => null   , sos_  => 1       , prty_ => null    , uid_   => null );
              gl.payv( 0, oo.REF, gl.bDATE , oo.tt, 1, z.kv, aa.nls, z.s, z.kv, oo.nlsb, z.s ) ;
           end if;

           l_txt := x.value ;

           -- Гришков Максим Валерійович <GrishkovMV@oschadbank.ua>  Чт 06/03/2014 14:44
           -- Согласовал с бек-офисом два универсальных назначения платежа (тег 72).
           -- Общие ограничения: Длинна строки (до переноса) не должна превышать 33 символа
           If x.tag = '72' then
              -- Два потому, что структура для 643 валюты существенно отличается от остальных.
              If z.kv = 643  then
                 l_txt := '/RPP/' || substr(oo.nd,-3) || '.' || to_char(sysdate,'yymmdd') || '.5.ELEK' || nlchr ||
                        '/NZP/’(VO80050)’ RAScETY PO' || nlchr ||
              '//DOG. n ' || x.CDOG ||' OT '|| to_char(x.DDOG,'DD.MM.YY') || nlchr ||
                          '//BEZ NDS';
              else
         l_txt := '/BNF/MONEY TRANSFERS ' || x.name || ' FOR' || nlchr ||
                          '//PERIOD ' || to_char(p_dat1,'dd/mm/yy-')  || to_char(p_dat2,'dd/mm/yy ') || nlchr ||
                          '//AGR. '|| x.CDOG ||' DD '|| to_char(x.DDOG,'DD/MM/YY');
                 -- для системы BLIZKO в конец тега необходимо добавить номер счета
         if    x.num = 5 and z.kv = 840 then l_txt := l_txt || nlchr || '//ACC/30233840903009107017';
         elsif x.num = 5 and z.kv = 978 then l_txt := l_txt || nlchr || '//ACC/30233978503009107017';
         end if;
              end if;

           end if ;
           insert into operw (REF,TAG,VALUE) values (oo.ref, trim(x.tag), l_txt);
        end loop ; -- x
     end if;

     <<NOT_PAY>> null; -- Независимо от того, есть или нет сумма к оплате, отметку о закрытом периоде надо ставить всегда !
     update MONExR set FM = 1 where KOD_NBU = p_KOD_NBU and fl is not null and fdat >= p_dat1 and fdat <= p_dat2 and kv =z.kv;
     commit;

  end loop   ; -- z по валютам за пириод

end monex_MB;

---------------
Procedure monexDS (p_dat1 date, p_dat2 date, system_ varchar2 default '%')  is   sid_    varchar2(64);
begin
  sid_ := show_monex_ctx('CLEARING');

  begin select sid into sid_ from v$session   where sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
        raise_application_error(-20112,'Процедура Клірингу вже запущена SID '|| sid_);
  exception  when no_data_found THEN NULL;
  end;

  set_monex_ctx('CLEARING',SYS_CONTEXT ('USERENV', 'SID'),NULL);

  if system_ = '%' then
     for s in (select distinct KOD_NBU from monexr where fdat >= p_dat1 and fdat <= p_dat2)
     loop  monexD(p_dat1, p_dat2, s.KOD_NBU);  end loop ;
  else
     for s in (select distinct KOD_NBU from monexr where fdat >= p_dat1 and fdat <= p_dat2 
                  and  (KOD_NBU IN (select distinct KS from (select  substr(s, level,2 ) KS, rownum as ID from    (select replace(system_,',','') as s from dual    )
                       connect by level <= length(s)) where mod(ID,2)<>0 )))

    loop   monexD(p_dat1, p_dat2, s.KOD_NBU);  end loop ;
  end if;
  set_monex_ctx('CLEARING','',NULL);

end MonexDS ;

PROCEDURE monexD (p_dat1 date, p_dat2 date, system_ varchar2 )  is
begin

     -- 1) клиринг с РУ идет по каждой системе и дате отдельно
     for k in (select distinct fdat from monexr where fdat >= p_dat1 and fdat <= p_dat2 and KOD_NBU = system_ ) loop
     bars_audit.info('CLEARING, monex.monexp: p_kod_NBU =>'||system_||', p_dat => '||k.fdat);
     monex.monexp   ( p_kod_NBU => system_, p_dat => k.fdat );                     commit ;   end loop;

     -- 2) клиринг за период  дат на межбанке по СВИФТУ по всем валютаи системы
     bars_audit.info('CLEARING, monex.monex_MB: p_kod_NBU =>'||system_||', p_dat1 => '||p_dat1||', p_dat2 => '||p_dat2);
     monex.monex_MB ( p_kod_NBU => system_, p_dat1 => p_dat1, p_dat2 => p_dat2) ;  commit ;


end monexD;

-----------------------------------------------

 PROCEDURE monexp( p_kod_NBU varchar2,  p_dat date) is
 -- клиринг с РУ идет по каждой дате и по каждой системе отдельно отдельно
    l_FL      int             ;
    l_100     varchar2(110)   ;
    l_nazn1   varchar2(120)   ;
    l_id_b    varchar2(8)     :=  gl.aOkpo;
    ---------------------------
    oo  oper%rowtype  ;
    x0  MONEx0%rowtype;
    UU  MONEX_MV_UO%rowtype;
    MR  monexr%rowtype;
    ---------------------------
    l_mfo  varchar2(12) :='******';

begin

  begin     select * into X0 from MONEx0 where kod_nbu = p_kod_nbu;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100, 'Не описана СП с кодом=' || p_kod_nbu ) ;
  end;

  -- защита от повторной обработки ( даты + систмы)
  begin  select 1 into l_FL from MONExR where fl is NOT null and fdat = p_dat and kod_NBU = p_kod_NBU and rownum = 1;   RETURN;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  oo.nam_a := substr(GetGlobalOption('NAME'), 1, 38);
     /* grishkovmv@oschadbank.ua
     * При проведении расчетов по комиссии по СМП-резидентам (ВестернЮнион) [признак: SWI_MTI_CURR.CCLC == 1], комиссия в <SENTFEE>, <RECEIVEFEE>, <RETURNFEE>
     * будет отображаться в эквиваленте нац. валюты независимо от кода валюты перевода
     */

  oo.Mfoa := gl.aMfo; oo.id_a := gl.aOkpo; oo.datd := p_dat ;

  for k in ( select r.*, r.ROWID RI, NVL2(c.CCLC, 980, r.kv) c_kv, c.CCLC, c.NLSK  -- grishkovmv@oschadbank.ua Если c.CCLC is not null - код валюты равен gl.baseval
             from  (select * from SWI_MTI_CURR x,  SWI_MTI_LIST l where L.NUM = x.NUM and p_KOD_NBU = L.kod_nbu ) c  ,
                   (select * from MONExR                          where fdat = p_dat  and p_KOD_NBU = KOD_NBU   ) R
             where  R.kv = C.kv (+)
            )
  loop
     -------------------------------
     k_branch := k.branch;

     BEGIN  SELECT IDPDR INTO UU.UO FROM BRANCH_UO WHERE trim(BRANCH)=trim(k.branch);  oo.mfob := gl.aMfo ;
     EXCEPTION WHEN NO_DATA_FOUND THEN                                  UU.UO   := 0;  oo.mfob := substr(k.branch,2,6); -- если нетт в списве Вирт.Бранчей, то это - реальный бранч ОБ
     end;

     begin  SELECT * INTO UU FROM MONEX_MV_UO where uo = UU.uo and mv = X0.kod_nbu;
     EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100, 'Не заданы параметры для ЮО='|| UU.uo|| ' + СТП='||X0.kod_nbu );
     end;

     begin
       If  UU.UO = 0 then select okpo into oo.id_b from BANKS_RU where mfo = oo.mfob ;
       else               select okpo into oo.id_b from monex_uo where id  = uu.UO   ;
       end if ;
     EXCEPTION WHEN NO_DATA_FOUND THEN oo.id_b := gl.aOkpo ;
     end;

     l_100     := substr(k.branch ||'; '|| X0.name, 1,100);
     oo.nam_b  := substr( l_100, 1,38);
     l_nazn1 := to_char(p_dat, 'dd.mm.yyyy') || '; ' || l_100 || '; ' ;
     l_fl        := null ;
     -------------------------------
     oo.d_rec := '#CBRANCH:'||k.branch|| '#' ;
     -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
     MR.rS_2909 := 0 ;      MR.rK_2909 := 0 ;
     MR.rS_2809 := 0 ;      MR.rk_2809 := 0 ;
     MR.rS_0000 := 0 ;      MR.rk_0000 := 0 ;

     -- 1) дебетовый ВАЛ платеж на 2909 - тело
     If k.S_2909 > 0 and k.rS_2909 is null then

        oo.nlsa := x0.nlsT;
        oo.kv   := k.kv;
        oo.kv2  := k.kv;

        oo.vob  := 2 ;
        oo.S    := k.S_2909;
        oo.S2   := oo.S;
        oo.nlsb := monex.NLSM_ext ( UU.UO, UU.OB22_2909, trim(k.branch) );
        If p_kod_nbu = '99' then oo.nazn := substr(l_nazn1 || 'Списання за купівлю електронних грошей',    1, 160);
        else                     oo.nazn := substr(l_nazn1 || 'Списання вiдправлених переказiв'       ,    1, 160);
        end if;
        oo.dk   := 0 ;
        monex.opl1(oo); MR.rS_2909 := oo.ref ;
     end if;

     -- 2) дебетовый ВАЛ платеж  на 2909 - комиссия
     If k.k_2909 > 0 and k.rk_2909 is null then
        If UU.UO > 0 then -- для субагентов ничего не делать - 23.03.2018 Атнон И. 
           null ;
        else
           oo.nlsa := NVL(k.nlsk, x0.nlsT);--x0.nlsT   373990364;
           oo.kv   := k.c_kv;
           oo.kv2  := k.c_kv;
           oo.vob  := 2 ;
           oo.S    := k.k_2909;
           oo.S2   := oo.S;
           oo.nlsb := monex.NLSM_ext ( UU.UO, UU.OB22_2909,trim(k.branch) );
           oo.nazn := substr(l_nazn1 || 'Списання комiсiї за вiдправленi перекази',  1, 160);
           oo.dk   := 0 ;
           monex.opl1(oo);  MR.rk_2909 := oo.ref ;
        end if;
 

     --2-1)  grishkovmv@oschadbank.ua
     --* При расчете комиссии Банка по системе Юнистрим (KOD_NBU=01) в XML файл в поле <SENTFEE> могут передаваться отрицательные значения (<SENTFEE>-0.52</SENTFEE>).
     --* это значит, что Юнистрим денежному переводу установил акционные условия (уменьшенная комиссия). В таком случае мы должны абсолютное значение
     --* тега <SENTFEE> зачислить в соответствующее ТОБО в виде комиссии за отправленый перевод

     elsif k.k_2909 < 0 and k.KOD_NBU = '01' and k.rk_2909 is null then  -- кредитовый платеж
        --- Эта система уже не работает  на Украине. это Рос ситема
        -- И отриц суммы уже \Профикс убрал
        oo.nlsa := x0.nlsT;
        oo.vob  := 1 ;
        If k.kv  =  gl.baseval then oo.s :=  abs(k.k_2909);  else  oo.s :=  gl.p_icurval( k.kv, abs(k.k_2909), gl.bdate) ;  end if ;
        oo.S2   := oo.S;
        oo.kv   := gl.baseval;
        oo.kv2  := oo.kv ;

        oo.nlsb := monex.NLSM_ext (  UU.UO, UU.ob22_kom, substr(k.branch,1,15) );
        oo.nazn :=  substr( to_char(p_dat, 'dd.mm.yyyy')||';Перерахування комiсiї за вiдправленi перекази Вал='||k.kv||',Сума='||to_char(abs(k.k_2909)/100),1,160);
        oo.dk   := 1 ;
        monex.opl1(oo);  MR.rk_2909 :=  oo.ref ;
        If k.kv <> gl.baseval  then  gl.payv(0, MR.rk_2909, gl.bdate, 'D06', 1, k.kv, X0.nlst, abs(k.k_2909), 980 , X0.nlst, oo.s );
           If nvl(GetGlobalOption('PEDAL_PROFIX'),0)=1 then  gl.pay (2, MR.rk_2909, gl.bDATE);    end if;
        end if;
     end if;

     -- 3) кредитовый платеж  на 2809 - тело
     If k.S_2809 > 0 and k.rs_2809 is null then
         oo.nlsa := x0.nlsT;
         oo.kv   := k.kv;
         oo.kv2  := k.kv;
         oo.vob  := 1 ;
         oo.S    := k.S_2809;
         oo.S2   := oo.S;
         oo.nlsb := monex.NLSM_ext (  UU.UO, UU.OB22_2809,trim(k.branch) );
         If p_kod_nbu = '99' then oo.nazn := substr(l_nazn1 || 'Зарахування за продаж електронних грошей'  , 1, 160);
         else                     oo.nazn := substr(l_nazn1 || 'Перерахування коштiв за виплаченi перекази', 1, 160);
         end if;
         oo.dk   := 1 ;
         monex.opl1( oo) ; MR.rS_2809 := oo.ref ;
     end if;
------------------------------------------------------------------------
     -- 4) кредитовый платеж на 6110 - комиссия
     If k.k_2809 > 0 and k.rk_2809 is null then
        If UU.UO > 0 then -- для субагентов ничего не делать - 23.03.2018 Атнон И. 
           null ;
        else
           --grishkovmv@oschadbank.ua Если k.nlsk is not null - комиссию списываем с отдельного счета
           oo.nlsa := NVL(k.nlsk,X0.nlst);
           oo.vob  := 1 ;
           If k.c_kv = gl.baseval then  oo.s :=  k.k_2809;
           else                         oo.s :=  gl.p_icurval( k.kv, k.k_2809, gl.bdate) ;
           end if;
           oo.S2   := oo.S;
           oo.kv   := gl.baseval;
           oo.kv2  := oo.kv ;
           oo.nlsb := monex.NLSM_ext ( UU.UO, UU.ob22_kom, substr(k.branch,1,15) );
           --grishkovmv@oschadbank.ua Если k.CCLC is not null - код валюты = gl.baseval (конвертировать комиссию не нужно)
           oo.nazn := substr( to_char(p_dat, 'dd.mm.yyyy')  ||  ';Перерахування комiсiї за виплаченi перекази. Вал='||k.c_kv||',Сума='||to_char(k.k_2809/100), 1, 160);
           oo.dk   := 1 ;
           monex.opl1(oo);  MR.rk_2809 :=  oo.ref ;
           --### УТОЧНИТЬ СЧЕТА ########## grishkovmv@oschadbank.ua Если k.CCLC is not null - код валюты -> gl.baseval (конвертировать комиссию не нужно)
           If k.c_kv <> gl.baseval then
              gl.payv(0, MR.rk_2809, gl.bdate, 'D06', 1, k.kv, X0.nlst, k.k_2809, 980 , X0.nlst, oo.s      );
              If nvl(GetGlobalOption('PEDAL_PROFIX'),0)=1 then  gl.pay (2, MR.rk_2809, gl.bDATE);    end if;
           end if;
        end if;
     end if;
---------------------------------------------------------------------------------------------------------------
     -- 5) кредитовый платеж - на 2809 - тело (анул)
     If k.s_0000 > 0 and k.rs_0000 is null then

        oo.nlsa := x0.nlsT;
        oo.vob  := 1 ;
        oo.s    := k.s_0000;
        oo.S2   := oo.S ;
        oo.kv   := k.kv ;
        oo.kv2  := oo.kv ;

        If p_kod_nbu = '96' then  oo.nlsb := monex.NLSM_ext (  UU.UO, UU.OB22_2909, trim(k.branch) );
        else                    oo.nlsb := monex.NLSM_ext (  UU.UO, UU.OB22_2809,  trim(k.branch) );
        end if;
        oo.nazn := substr(l_nazn1 ||  'Перерахування коштiв за анульованi перекази',    1, 160);
        oo.dk   := 1 ;
        monex.opl1(oo);  MR.rs_0000 :=  oo.ref ;

     end if;

     -- 6)кредитовый платеж на 2809 - комиссия по анул
     -- нужно сложную БМ

     If k.k_0000 > 0 and k.rk_0000 is null then
        If UU.UO > 0 then -- для субагентов ничего не делать - 23.03.2018 Атнон И. 
           null ;
        else
           oo.nlsa := NVL(k.nlsk,X0.nlst) ;--X0.nlst;--NVL(k.nlsk,X0.nlst) ;
           oo.vob  := 1 ;
           If p_kod_nbu = '03' then   oo.kv   := gl.baseval ;  oo.kv2  := gl.baseval ;
           else                       oo.kv   := k.kv       ;  oo.kv2  := oo.kv ;
           end if;
           oo.s    := k.K_0000;
           oo.S2   := oo.S ;
           oo.nlsb := monex.NLSM_ext (  UU.UO, UU.OB22_2809, trim(k.branch));
           oo.nazn := substr(to_char(p_dat, 'dd.mm.yyyy')  || ';Перерахування комiсiї за анульованi перекази. Вал='||k.kv||',Сума='||to_char(k.k_0000/100),  1, 160 );
           oo.dk   := 1 ;
           monex.opl1(oo);  MR.rK_0000 :=  oo.ref ;
        end if;
     end if;

     --15.03.2018
     If k.RET_SEND > 0 then
        If UU.UO > 0 then -- для субагентов ничего не делать - 23.03.2018 Атнон И. 
           null ;
        else
           oo.vob  := 6      ;
           oo.nlsa := X0.nlst   ;
           oo.nazn := substr(to_char(p_dat, 'dd.mm.yyyy') || ';RETURNSENDFEE.Стягнення комiсiї для поверн.кл. Вал='||k.kv||',Сума='||to_char(k.RET_SEND/100), 1, 160 );
           oo.dk   := 0 ;
           oo.nlsb := monex.NLSM ( p_nbs => '7509', p_ob22=> '02', p_branch => trim(k.branch) ); -- = 7509*02
           oo.kv   := GL.baseVal;
           oo.kv2  := oo.kv   ;
           oo.s    := gl.p_icurval( k.kv, k.RET_SEND, gl.bdate) ;
           oo.S2   := oo.S    ;
           monex.opl1(oo);  
           If k.kv <> gl.baseval then
              gl.payv(0, oo.ref, gl.bdate, 'D06', 0, k.kv, X0.nlst,  k.RET_SEND,  gl.baseval, X0.nlst, oo.s  );
              If nvl(GetGlobalOption('PEDAL_PROFIX'),0) = 1 then  gl.pay (2, oo.ref, gl.bDATE);    end if;
          end if;
        end if;
     end if;
     --------------------

     If UU.UO > 0 then -- Это не ОБ, а другие ЮЛ. У них есть ТРИ дополнительных поля по комиссии

        oo.nlsa  := X0.nlst ;
        oo.vob   := 6 ;
        oo.kv    := gl.baseval ;
        oo.kv2   := gl.baseval ;

        If k.KOMB1 > 0 and k.k_2909 > 0 then   ------ Деб  2809.задоолж по ЮЛ-грн      Кред Тр  по СТП на сумму вал KOMB1
           -- k.KOMB1 это грн-сумма для расчета с агентом
           oo.dk   := 0 ;
           oo.kv   := k.kv;        oo.s  := gl.p_Ncurval( k.kv, k.KOMB1, gl.bdate) ;   oo.nlsa := x0.nlsT;
           oo.kv2  := gl.baseval;  oo.s2 := k.KOMB1 ;                                  oo.nlsb := monex.NLSM_ext (  UU.UO, UU.OB22_2809, trim(k.branch) );
           oo.nazn := substr(to_char(p_dat, 'dd.mm.yyyy') || ';SENTSYFEE.Стягнення комiсiї оператора СТП. Вал='||k.kv||',Сума='||to_char(oo.s/100),  1, 160 );

           monex.opl1(oo) ;
           --
           oo.S :=   Round( gl.p_Ncurval(k.kv, k.KOMB1, gl.bdate) - k.K_2909, 0 );
           If oo.S <> 0 then
              If oo.s > 0 then oo.dk := 1;  oo.NLSB := NVL( uu.KOMB6, monex.NLS6_AG ) ;
              else             oo.dk := 0;  oo.NLSB := NVL( uu.KOMB7, monex.NLS7_AG ) ;
              end if;
              oo.S  := Abs( oo.S);
              oo.S2 := gl.p_Icurval (k.Kv, oo.S, gl.bdate);

              gl.payv(0, oo.ref, gl.bdate, 'D06', oo.DK , k.kv, X0.nlst,  oo.S,  gl.baseval, oo.NLSB, oo.s2  );
              If nvl(GetGlobalOption('PEDAL_PROFIX'),0) = 1 then  gl.pay (2, oo.ref, gl.bDATE);    end if;
          end if;
        end if ;

        If k.KOMB2 > 0 and k.K_2809 > 0 then   --- Деб Тр  по СТП вал на сумму KOMB2  кред Комм.ЮЛ в грн
           oo.dk   := 1 ;
           oo.kv   := k.kv;        oo.s  := gl.p_Ncurval( k.kv, k.KOMB2, gl.bdate) ;   oo.nlsa := x0.nlsT;
           oo.kv2  := gl.baseval;  oo.s2 := k.KOMB2 ;                                  oo.nlsb := monex.NLSM_ext (  UU.UO, UU.OB22_2809, trim(k.branch) );
           oo.nazn := substr(to_char(p_dat, 'dd.mm.yyyy') || ';RECEIVESAFEE.Перерахування комiсiї Субагенту.Вал='||k.kv||',Сума='||to_char(oo.s/100),  1, 160 );
           monex.opl1(oo) ;
           --
           oo.S :=   Round( gl.p_Ncurval(k.kv, k.KOMB2, gl.bdate) - k.K_2809, 0 );
           If oo.S <> 0 then
              If oo.s > 0 then oo.dk := 0;  oo.NLSB := NVL( uu.KOMB7, monex.NLS7_AG ) ;
              else             oo.dk := 1;  oo.NLSB := NVL( uu.KOMB6, monex.NLS6_AG ) ;
              end if;
              oo.S  := Abs( oo.S);
              oo.S2 := gl.p_Icurval (k.Kv, oo.S, gl.bdate);
              gl.payv(0, oo.ref, gl.bdate, 'D06', oo.DK , k.kv, X0.nlst,  oo.S,  gl.baseval, oo.NLSB, oo.s2  );
              If nvl(GetGlobalOption('PEDAL_PROFIX'),0) = 1 then  gl.pay (2, oo.ref, gl.bDATE);    end if;
          end if;
        end if ;


        If k.KOMB3 > 0 and k.k_0000 > 0  then   --- Деб Тр  по СТП вал на сумму KOMB3  кред кред ЮЛ в грн
           oo.dk   := 1 ;
           oo.kv   := k.kv;        oo.s  := gl.p_Ncurval( k.kv, k.KOMB3, gl.bdate) ;   oo.nlsa := x0.nlsT;
           oo.kv2  := gl.baseval;  oo.s2 := k.KOMB3 ;                                  oo.nlsb := monex.NLSM_ext (  UU.UO, UU.OB22_2809, trim(k.branch) );
           oo.nazn := substr(to_char(p_dat, 'dd.mm.yyyy') || ';RETURNSAFEE.Перерахування комiсiї для відшкодування кл.Вал='||k.kv||',Сума='||to_char(oo.s/100),  1, 160 );
           monex.opl1(oo) ;
           --
           oo.S :=   Round( gl.p_Ncurval(k.kv, k.KOMB3, gl.bdate) - k.K_0000, 0 );
           If oo.S <> 0 then
              If oo.s > 0 then oo.dk := 0;  oo.NLSB := NVL( uu.KOMB7, monex.NLS7_AG ) ;
              else             oo.dk := 1;  oo.NLSB := NVL( uu.KOMB6, monex.NLS6_AG ) ;
              end if;
              oo.S  := Abs( oo.S);
              oo.S2 := gl.p_Icurval (k.Kv, oo.S, gl.bdate);
              gl.payv(0, oo.ref, gl.bdate, 'D06', oo.DK , k.kv, X0.nlst,  oo.S,  gl.baseval, oo.NLSB, oo.s2  );
              If nvl(GetGlobalOption('PEDAL_PROFIX'),0) = 1 then  gl.pay (2, oo.ref, gl.bDATE);    end if;
          end if;
        end if ;

     end if;

     --2017-02-22 grishkovmv@oschadbank восстановил блок из версии пакета от COBUSUPABS-4148
     If MR.rS_2909 is not null and MR.rk_2909 is not null and
        MR.rS_2809 is not null and MR.rk_2809 is not null and
        MR.rS_0000 is not null and MR.rk_0000 is not null then   l_fl := 1;
     end if;
     --2017-02-22
     update monexr set fl = l_fl ,         ob22 = MR.ob22,
                  rS_2909 = MR.rS_2909, rk_2909 = MR.rk_2909,
                  rS_2809 = MR.rS_2809, rk_2809 = MR.rk_2809,
                  rS_0000 = MR.rS_0000, rk_0000 = MR.rk_0000,
                  komb1   = nvl(k.komb1,0),
                  komb2   = nvl(k.komb2,0),
                  komb3   = nvl(k.komb3,0)
            where rowid = k.RI ;

  end loop; -- k

 end monexp;
----------------------

 procedure DEL_FIle (p_fdat MONEXR.fdat%type, p_nbu  MONEXR.kod_nbu%type    )  IS

/*
В норме будет приходить в один день столько файлов, сколько систем.
Для нестандартных ситуаций, а именно, повторного приема файла
за один и тот же день от одной и той же системы, предыдущий надо удалить.
Это можно было бы сделать из табличной формы протокола,
однако, можно промахнуться, и удалить не все .

Потому я предлагаю функцию глобального удаления из протокала необработанного блока по параметру "Дата+Система"
*/
   nTmp_ int;
begin
   If p_fdat is null or p_nbu is null then  raise_application_error(-20100, 'Не заданы параметры для удаления' ); end if;

   begin
     select 1 into nTmp_ from  MONEXR  where FDAT  = p_fdat and kod_nbu = p_nbu   and fl is not null   and rownum  = 1;
     raise_application_error(-20100,
       'Попытка удаления ОБРАБОТАННОГО файла за ' || to_char(p_FDAT, 'dd.mm.yyyy') ||  ', код системи по НБУ = ' || p_nbu );
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;

   delete from MONEXR  where FDAT = p_fdat and kod_nbu = p_nbu ;

end DEL_FIle ;


end monex;
/
alter package bars_login compile;