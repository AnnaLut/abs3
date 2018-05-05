
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cck_app.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCK_APP AS
/******************************************************************************
   NAME:       CCK_APP
   PURPOSE:  Пакет для обслуживающих процедур по КП

    ПАКЕТ  НЕ ДОЛЖДЕН содержать ссылки на специфические таблицы а также
    не желательно сылаться на пакет ССК

******************************************************************************/

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 3 04/08/2014';

 -- ===============================================================================================
 -- Public types declarations
 -- структура платежных инструкций
 type t_pmt_instr is record(
    mfo  oper.mfob%type, -- МФО получателя
    nls  oper.nlsb%type, -- Номер счета получателя
    kv   oper.kv%type  , -- Код валюти
    nam oper.nam_b%type, -- Наименование счета получателя
    okpo oper.id_b%type, -- ИПН получателя
    nazn oper.nazn%type  -- Назначение платежа
    );
 -- ===============================================================================================

----------------------------------------------------------------------------------------------

 -- to_number2
 --
 -- Функция преобразующая текст в число

  function to_number2(p varchar2) return number;

----------------------------------------------------------------------------------------------

 -- CorrectDate2
 --
 -- Корректировка даты погашения для случаев когда дата погашения приходиться на выходной день
 -- Возвращает откоректированную дату
 -- p_KV   - валюта (обычно гривна)
 -- p_OldDate - дата погашения
 -- p_Direct -- как производить корректировку
 -- null - не производить
 --    0  - сдвигать назад
 --    1  - сдвигать вперед
 --   -1 - сдвигать назад не выходя за тек месяц
 --    2  - сдвигать вперед не выходя за тек месяц

 FUNCTION CorrectDate2( p_KV int, p_OldDate date, p_Direct number:=1) RETURN DATE;

----------------------------------------------------------------------------------------------

 -- check_max_day()
 --
 -- Функция для определения корректности даты при совмещении дня  с месяцем
 -- Функция необходима когда есть день например 30 и совместить с месяцем  30+ 2 месяц= 28(29)
 -- + возможность кор-ки по банковским дням (см. функц. CorrectDate2()  )
 -- p_FDAT - дата с которой необходимо совместить день (банковская)
 -- p_DAY  - день  (день погашения)
 --         Для кор-ки по банк-м дням
 -- p_DAYN - (см. функц. CorrectDate2() для откл. кор-ки необходимо передавать = NULL
 -- p_KV   - (см. функц. CorrectDate2()

  FUNCTION check_max_day (p_FDAT date,p_DAY number, p_DAYNP number:=cck.CC_DAYNP,p_KV number :=gl.baseval) return DATE;

-----------------------------------------------------------------------------------------------

 -- valid_date
 -- Упрощенная функция относительно check_max_day()
 -- Преобразовывает дату типа char в тип data и корректно выдает последний день месяца
 -- например передаем '31/02/2011' на выходе '28/02/2011'
 --          передаем '31/09/2011' на выходе '30/09/2011'
 --          передаем '04/07/2011' на выходе '04/07/2011'

  FUNCTION valid_date (p_chrc in varchar2 ) return date ;

-----------------------------------------------------------------------------------------------

 -- sum_body_for_repayment_gpk
 --
 -- Сумма платежей ТЕЛА ПО ГПК   (ПО ПЛАНУ)
 -- p_nd    - Номер договора
 -- p_dat   - Дата договора (пусто банк день)  принимаються только будущие даты платежей
 -- p_col   - кол-во платежей которые необходимо включать в сумму платежа

  FUNCTION sum_body_for_repayment_gpk (p_nd number, p_dat date,p_col int:=1) return number;

-----------------------------------------------------------------------------------------------

 -- repayment_day_ir
 --
 -- Функция возвращает банковскую ДАТУ погашения процентного долга по КД .
 -- то есть возвращает дату следующую после заданной  p_dat
 -- либо текущую если день оплаты совпал
 --  p_nd   - Реф кредитного договора
 --  p_dat  - дата (скорее всего банковская )
 -- Писалась для вызова функции "КП S43: Нарахування %%  по поточним платіж. датам у КП ФЛ"

  FUNCTION repayment_date_ir (p_nd number, p_dat date:=gl.bd ) RETURN DATE;

-----------------------------------------------------------------------------------------------

 -- Pay_Day_SN_to_ND
 --
 -- Возвращает день погашения процентного долга в формате  - '02'

 FUNCTION Pay_Day_SN_to_ND (p_nd number) RETURN varchar2;

-----------------------------------------------------------------------------------------------

 -- SAVE_RATN()  - полное сохранение проц карточки
 --
 --     p_ACC        int, Номер счета
 --     p_ID      number,
 --     p_METR    number, Метод начисления
 --     p_BASEY   number, Базовый год
 --     p_FREQ    number, Переодичность
 --     p_STP_DAT   date, Дата окончания
 --     p_ACR_DAT   date, Дата последнего начисления
 --     p_APL_DAT   date, Дата последней выплаты
 --     p_TT        char, Тип операции начисления процентов
 --     p_ACRA       int, Счет нач.%%
 --     p_ACRB       int, Контрсчет 6-7 класса
 --     p_S       NUMBER, Сумма документа
 --     p_IO         int, Тип остатка (из спр-ка int_ion)
 --     p_BDAT      DATE,
 --     p_IR      NUMBER,
 --     p_BR         INT,
 --     p_OP      NUMBER,
 --     p_type    number:=   0 -  перезаписывать счета (int_accn)
 --                          1  - дозаполнять карточку со счетами
 --     p_del    NUMBER: =   null - изменить ставку за тек день
 --                          -1     то же но при передачи пустых знач не удалять ранее
 --                                 сохраненный вариант
 --                                (вариант для сохран напр только int_accn)
 --                          0 - удалять все проц ставки сохр до этого
 --                          1 - удалять будущие проц ставки относит-но данной
 --
 --     p_IDU     number:=null,
 --     p_IDR        int:=null

  PROCEDURE save_ratn (p_ACC        int,
                      p_ID      NUMBER,
                      p_METR    NUMBER,
                      p_BASEY   NUMBER,
                      p_FREQ    NUMBER,
                      p_STP_DAT   DATE,
                      p_ACR_DAT   DATE,
                      p_APL_DAT   DATE,
                      p_TT        char,
                      p_ACRA       int,
                      p_ACRB       int,
                      p_S       NUMBER,
                      p_IO         int,
                      p_BDAT      DATE,
                      p_IR      NUMBER,
                      p_BR         INT,
                      p_OP      NUMBER,
                      p_type    NUMBER:=null,
                      p_del     NUMBER:=0,
                      p_IDU     number:=null,
                      p_IDR        int:=null
                    );

-----------------------------------------------------------------------------------------------

 -- Set_ND_TXT - Простановка доп. параметра в табл  nd_txt  (При p_TXT=null параметр удаляется)
 --
 --        p_ND number     - Реф договора
 --        p_TAG varchar2  - Тег доп.реквизита
 --        p_TXT varchar2  - Значение доп.реквизита

 procedure Set_ND_TXT (p_ND number ,p_TAG varchar2 ,p_TXT varchar2);

-----------------------------------------------------------------------------------------------
procedure Set_ND_TXT_CHECK (p_ND number);

-----------------------------------------------------------------------------------------------

 --  Get_ND_TXT
 --
 --  Возвращает значение доп.параметра КД

 function Get_ND_TXT (p_ND number ,p_TAG varchar2) return varchar2;

-----------------------------------------------------------------------------------------------

 --  Get_ND_TXT_ex
 --
 --  Возвращает значение доп.параметра КД за дату (с историей)

 function Get_ND_TXT_ex ( p_nd   in nd_txt_update.nd%type, -- номер договора
                          p_tag  in nd_txt_update.tag%type, -- тег реквизита
                          p_date in nd_txt_update.chgdate%type default sysdate -- дата для получения исторического значения (null или sysdate - текущее)
                         )
   return nd_txt_update.txt%type;

-----------------------------------------------------------------------------------------------

 --  sum_current_repayment_gpk
 --
 -- Функция возвращает ПЛАНОВУЮ сумму очередного платежа

 function sum_current_repayment_gpk (p_nd number, p_dat date) return number;

-----------------------------------------------------------------------------------------------

 -- header_version - возвращает версию заголовка пакета

 function header_version return varchar2;

-----------------------------------------------------------------------------------------------

 -- body_version - возвращает версию тела пакета

 function body_version return varchar2;

-----------------------------------------------------------------------------------------------

END CCK_APP;
/
CREATE OR REPLACE PACKAGE BODY BARS.CCK_APP AS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 8 30/03/2018';

--------------------------------------------------------------

  g_pack_name varchar2(20) := 'CCK_APP.';

--------------------------------------------------------------

  function to_number2(p varchar2) return number IS
  begin
      return TO_number(trim(p),
                     '999999999999999D99999',
                     'NLS_NUMERIC_CHARACTERS = ''. ''');
   exception when others then
     --EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';
      return TO_number(trim(p),
                     '999999999999999D99999',
                     'NLS_NUMERIC_CHARACTERS = '', ''');
  end;

--------------------------------------------------------------

 -- FUNCTION CorrectDate2
 --
 -- Корректировка даты погашения для случаев когда дата погашения приходиться на выходной день
 -- Возвращает откоректированную дату
 -- p_KV   - валюта (обычно гривна)
 -- p_OldDate - дата погашения
 -- p_Direct -- как производить корректировку
 --  null - не производить
 --   -2  - Не виконувати кориктування
 --    0  - сдвигать назад
 --    1  - сдвигать вперед
 --    -1 - сдвигать назад не выходя за тек месяц
 --    2  - сдвигать вперед не выходя за тек месяц

FUNCTION CorrectDate2( p_KV int, p_OldDate date, p_Direct number:=1) RETURN DATE is
  l_dDat date    ;
  l_n1 Number    ;
  l_nn Number    := 1;
  l_ed Number    ;
  l_Direct number;

 begin

   l_Direct := NVL ( nvl( p_Direct, CCK.CC_DAYNP ), 1) ;

   if l_Direct = -2 then Return p_OldDate; end if;

   l_dDat   := p_OldDate;

   If l_Direct in (1,2) then  l_ed :=  1 ;
   else                       l_ed := -1 ;
   end if ;
   ----------------------------------------------------------
   While l_nn = 1
   loop
      begin
         SELECT count(kv) INTO l_nn FROM holiday
         WHERE kv = NVL(p_KV,gl.baseval) and holiday=l_dDat;
         l_dDat  := l_dDat + l_ed*l_nn;
      end;
   end loop;

   if l_Direct in (-1,2) and to_char(p_OldDate,'mmyyyy') != to_char(l_dDat,'mmyyyy') then

      l_nn    := 1;
      l_dDat  := p_OldDate;

       While l_nn = 1
       loop
             SELECT count(kv) INTO l_nn FROM holiday
             WHERE kv= NVL(p_KV,gl.baseval) and holiday=l_dDat;
             l_dDat:= l_dDat - l_ed*l_nn;
       end loop;

   end if;


  Return l_dDat;

 end CorrectDate2;

--------------------------------------------------------------

FUNCTION check_max_day
        (p_FDAT date,
         p_DAY number,
         p_DAYNP number := cck.CC_DAYNP,
         p_KV number    :=gl.baseval
         )
          return DATE
 is

 l_DS varchar2(4);
 l_dat date;
 l_DAYNP number;
begin

-- Расчет по ДД (и коррекция) даты

  l_DAYNP := NVL( p_DAYNP , cck.CC_DAYNP) ;


-- подбор даты
 if p_day=32  and l_DAYNP in (0,-1) then
    return trunc( cck_app.correctdate2(p_kv,  cck_app.correctdate2(p_kv,last_day(p_FDAT),0)-1  ,0));
 end if;

 -- НЕлогичные комбинации
 if p_day >= 28 then

    l_DS:=to_char(p_FDAT,'mm')||to_char(p_DAY);


    If    l_DS in ('0229','0230','0231')    and
          trunc(to_number(to_char(p_fdat,'yyyy'))/4) !=
          to_number(to_char(p_fdat,'yyyy')) / 4          then
          -- февраль обычный
          l_DAT:=to_date('0228'||to_char(p_FDAT,'yyyy'),'mmddyyyy');

    elsif l_DS in ('0229','0230','0231') and
          trunc(to_number(to_char(p_fdat,'yyyy'))/4) =
          to_number(to_char(p_fdat,'yyyy'))/4         then
          -- февраль обычный высокостный
          l_DAT:= to_date('0229'||to_char(p_FDAT,'yyyy'),'mmddyyyy');

    elsIf l_DS in ('0431','0631','0931','1131')       then

          -- типа "31 июня "
          l_DAT:= to_date(substr(l_DS,1,3)||'0'||to_char(p_FDAT,'yyyy'),'mmddyyyy');

    else  -- for 31
          l_DAT:= to_date(lpad(to_char(p_DAY),2,0)||to_char(p_FDAT,'MMYYYY'),'ddmmyyyy');
    end if;
 else
   l_DAT:= to_date(lpad(to_char(p_DAY),2,0)||to_char(p_FDAT,'MMYYYY'),'ddmmyyyy');
 end if;

 if l_DAYNP is NOT null then
    l_DAT := trunc(cck_app.CorrectDate2(p_KV,l_DAT,l_DAYNP) );
 end if;

 return l_DAT;

end;

--------------------------------------------------------------

 /*
  Преобразовывает char в data с корректировкой последнего дня месяца
 */

 /* FUNCTION valid_date (p_chrc in Varchar2 ) return date is
 l_dat  date;
  begin
    l_dat := to_date(p_chrc,'dd/mm/yyyy') ;
    return l_dat;
  -- date not valid for month specified
  EXCEPTION WHEN others
      begin
      dDat_:=Last_day(to_date('01'||substr(p_chrc,3,8),'dd/mm/yyyy'));
      exception when others then
         raise_application_error(-20203,'\ CCK_APP.valid_date: Передана некоректная дата = '||p_chrc,TRUE);
      end;
      Return dDat_;
  end;     */

 FUNCTION valid_date (p_chrc in Varchar2 ) return date is
 l_dat  date;
  begin
    l_dat := to_date(p_chrc,'dd/mm/yyyy') ;
    return l_dat;
  -- date not valid for month specified
  EXCEPTION WHEN others
    then return last_day(to_date('01'||substr(p_chrc,3,8),'dd/mm/yyyy'));
  end;

--------------------------------------------------------------

 /*
  Возвращает день погашения процентов  в формате двухзначного числа  Например - '02', '31'
 */

FUNCTION pay_day_sn_to_nd (p_nd number) RETURN varchar2 is
 l_day varchar2 (2):=null;
 begin

  begin
  select lpad(nvl( (select trim(txt)
                      from nd_txt
                     where nd=n.nd and tag='DAYSN')
                   ,to_char(i.s)
                 )
              ,2,'0')
    into l_day
    from accounts a,nd_acc n, int_accn i
   where n.nd=p_nd
   and n.acc=a.acc and a.acc=i.acc and i.id=0 and a.tip='LIM';

   --if  trim(l_day) is null then

   exception when no_data_found then
   l_day := nvl(GetGlobalOption('CC_PAY_D'),'31');
   --end if;
   end;

 return l_day ;
 end;

--------------------------------------------------------------

  -- Функция возвращает банковскую ДАТУ погашения процентного долга по КД .
  -- то есть возвращает дату следующую после заданной  p_dat
  -- либо текущую если день оплаты совпал
  --  p_nd   - Реф кредитного договора
  --  p_dat  - дата (скорее всего банковская )
  -- Писалась для вызова функции "КП S43: Нарахування %%  по поточним платіж. датам у КП ФЛ"

  FUNCTION repayment_date_ir (p_nd number, p_dat date:=gl.bd ) RETURN DATE is
  l_dat date;
  begin
  null;
  -- exec tuda  cc_tag

    l_dat:=check_max_day(p_dat, pay_day_sn_to_nd (p_nd),nvl(get_nd_txt(p_nd,'DAYNP'),cck.CC_DAYNP),gl.baseval);

    return l_dat;

  end;


--------------------------------------------------------------
      /* save_ratn:

      p_ACC        int, Номер счета
      p_ID      number,
      p_METR    number, Метод начисления
      p_BASEY   number, Базовый год
      p_FREQ    number, Переодичность
      p_STP_DAT   date, Дата окончания
      p_ACR_DAT   date, Дата последнего начисления
      p_APL_DAT   date, Дата последней выплаты
      p_TT        char, Тип операции начисления процентов
      p_ACRA       int, Счет нач.%%
      p_ACRB       int, Контрсчет 6-7 класса
      p_S       NUMBER, Сумма документа
      p_IO         int, Тип остатка (из спр-ка int_ion)
      p_BDAT      DATE,
      p_IR      NUMBER,
      p_BR         INT,
      p_OP      NUMBER,
      p_type    number:=   0 -  перезаписывать счета (int_accn)
                           1  - дозаполнять карточку со счетами
      p_del    NUMBER: =   null - изменить ставку за тек день
                           -1     то же но при передачи пустых знач не удалять ранее
                                  сохраненный вариант
                                 (вариант для сохран напр только int_accn)
                           0 - удалять все проц ставки сохр до этого
                           1 - удалять будущие проц ставки относит-но данной

      p_IDU     number:=null,
      p_IDR        int:=null
      */

 PROCEDURE save_ratn (p_ACC        int,
                     p_ID      NUMBER,
                     p_METR    NUMBER,
                     p_BASEY   NUMBER,
                     p_FREQ    NUMBER,
                     p_STP_DAT   DATE,
                     p_ACR_DAT   DATE,
                     p_APL_DAT   DATE,
                     p_TT        char,
                     p_ACRA       int,
                     p_ACRB       int,
                     p_S       NUMBER,
                     p_IO         int,
                     p_BDAT      DATE,
                     p_IR      NUMBER,
                     p_BR         INT,
                     p_OP      NUMBER,
                     p_type    NUMBER:=null,
                     p_del     NUMBER:=0,
                     p_IDU     number:=null,
                     p_IDR        int:=null
                   ) is
 l_n int:=0;
 l_nr int:=0;
 begin

 logger.trace ('CCK_APP.SAVE_RATN START1 ACC='||p_acc||' ID='||to_char(p_ID)||' METR='||to_char(p_METR)||' BASEY='||to_char(p_BASEY)||' FREQ='||to_char(p_FREQ)||' STP_DAT='||to_char(p_STP_DAT)||' ACR_DAT='||to_char(p_ACR_DAT)||' APL_DAT='||to_char(p_APL_DAT));
 logger.trace ('CCK_APP.SAVE_RATN START2  TT='||p_TT||' ACRA='||to_char(p_ACRA)||' ACRB'||to_char(p_ACRB)||' S='||to_char(p_S)||' IDU='||to_char(p_IDU)||' IDR='||to_char(p_IDR));
 logger.trace ('CCK_APP.SAVE_RATN START3 bdat='||to_char(p_bdat)||' ir='||to_char(p_ir)||' op='||to_char(p_op)||' br='||to_char(p_br));
 logger.trace ('CCK_APP.SAVE_RATN START4 p_type='||to_char(p_type)||' del='||to_char(p_del));
  if nvl(p_type,0)=0 then   -- жесткое изменение
     update int_accn set METR   = p_METR,
                         BASEY  = p_BASEY,
                         FREQ   = p_FREQ,
                         STP_DAT= p_STP_DAT,
                         ACR_DAT= nvl(p_ACR_DAT,to_date('01011900','ddmmyyyy')),
                         APL_DAT= p_APL_DAT,
                         TT     = nvl(p_TT,'%%1'),
                         ACRA   = p_ACRA,
                         ACRB   = p_ACRB,
                         S      = nvl(p_S,0),
                         IO     = nvl(p_IO,0),
                         IDU    = p_IDU,
                         IDR    = p_IDR
      where acc=p_acc and id=p_id
      returning count(acc) into l_n;
      logger.trace ('CCK_APP.SAVE_RATN update type=0  l_n='||to_char(l_n));
  else                                -- дозаполнение
      update int_accn set METR  = nvl(p_METR   ,METR),
                         BASEY  = nvl(p_BASEY  ,BASEY),
                         FREQ   = nvl(p_FREQ   ,FREQ),
                         STP_DAT= nvl(p_STP_DAT,STP_DAT),
                         ACR_DAT= coalesce(p_ACR_DAT,ACR_DAT,to_date('01011900','ddmmyyyy')),
                         APL_DAT= nvl(p_APL_DAT,APL_DAT),
                         TT     = coalesce(p_TT     ,TT   ,'%%1'  ),
                         ACRA   = nvl(p_ACRA   ,ACRA   ),
                         ACRB   = nvl(p_ACRB   ,ACRB   ),
                         S      = coalesce(p_S      ,S  ,0    ),
                         IO     = coalesce(p_IO     ,IO ,0    ),
                         IDU    = nvl(p_IDU    ,IDU    ),
                         IDR    = nvl(p_IDR    ,IDR    )
      where acc=p_acc and id=p_id
      returning count(acc) into l_n;
          logger.trace ('CCK_APP.SAVE_RATN update type=1  l_n='||to_char(l_n));
    end if;
   if l_n=0 then
      insert into int_accn
             (ACC,ID,METR,BASEY,FREQ,STP_DAT,ACR_DAT,APL_DAT,TT,ACRA,ACRB,S,IDU,IDR)
      values (p_ACC,p_ID,p_METR,p_BASEY,p_FREQ,p_STP_DAT,nvl(p_ACR_DAT,to_date('01011900','ddmmyyyy')),p_APL_DAT,nvl(p_TT,'%%1'),p_ACRA,p_ACRB,nvl(p_S,0),p_IDU,p_IDR);
   end if;

   if (p_del=-1 or l_n=0) and p_br is null and p_ir is null then return;
   end if;

   if l_n>0 then

      if p_del is null and p_ir is null and p_br is null then -- удал тек ставку
         delete from int_ratn where acc=p_acc and id=p_id and bdat=p_bdat;
         logger.trace ('CCK_APP.SAVE_RATN delete=0 ');
         return;
      end if;

      if p_del=0 and p_ir is null and p_br is null then -- Удаляем ВСЕ %
         delete from int_ratn where acc=p_acc and id=p_id;
         logger.trace ('CCK_APP.SAVE_RATN delete=1 ');
         return;
      end if;

      if p_del=1 and p_ir is null and p_br is null then -- Удаляем будущие %
         delete from int_ratn where acc=p_acc and id=p_id and bdat>=p_bdat;
         logger.trace ('CCK_APP.SAVE_RATN delete=2 ');
         return;
      end if;



      if p_del=0  then
         delete from int_ratn where acc=p_acc and id=p_id and bdat!=p_bdat ;
         logger.trace ('CCK_APP.SAVE_RATN delete=3 ');
      end if;


      if p_del=1  then
         delete from int_ratn where acc=p_acc and id=p_id and bdat>p_bdat;
         logger.trace ('CCK_APP.SAVE_RATN delete=4 ');
      end if;


      update int_ratn set IR=p_IR,
                          BR=p_BR,
                          OP=p_OP,
                          IDU=p_IDU
       where acc=p_acc and id=p_id and  bdat=p_BDAT
       returning count(acc) into l_nr;
       logger.trace ('CCK_APP.SAVE_RATN update ratn  l_nr='||to_char(l_nr));
   end if;

   if l_nr=0 then
     insert into int_ratn (acc,id,bdat,ir,op,br,idu)
                    values(p_acc,p_id,p_bdat,p_ir,p_op,p_br,p_idu);
   end if;

 end;

--------------------------------------------------------------

 /*
   Set_ND_TXT - Простановка доп. параметра в табл  nd_txt
                При p_TXT=null параметр удаляеться
          p_ND number     - Реф договора
          p_TAG varchar2  - Таг договора
          p_TXT varchar2  - Значення дог.
 */

procedure Set_ND_TXT (p_ND number ,p_TAG varchar2 ,p_TXT varchar2)
is
 l_col number:=-1;
 l_proc_name varchar2(40) := 'Set_nd_txt ';
 l_cc_deal cc_deal%rowtype;
 l_cprod nd_txt.txt%type;
 l_eibis fm_yesno.id%type;
 l_nd_txt nd_txt.nd%type;
 l_tag nd_txt.tag%type;
begin
  bars_audit.trace(g_pack_name || l_proc_name ||
                   'Start. Params: ND=%s, tag=%s, TXT=%s',
                                to_char(p_ND), p_tag, p_txt
                  );

  if p_ND is null then
    raise_application_error(-20203,'\    CCK_APP.Set_ND_TXT :Не вказан реф договору! TAG='||p_TAG||' Значення='||p_txt,TRUE);
  end if;
  if p_TAG is null then
    raise_application_error(-20203,'\    CCK_APP.Set_ND_TXT :Для договору Реф='||p_ND||' Значення='||p_txt||' Не вказан TAG' ,TRUE);
  end if;

  if p_tag in ('ES084','ES236', 'ES374') and p_txt = '3' and gl.bDATE > to_date('01.04.2018','dd.mm.yyyy') then
    raise_application_error(-20201,'\   CCK_APP.Set_ND_TXT : Відповідно до вимог з 01.04.2018 заборонено видавати енергокредити для багатоквартирних будинків',TRUE);
  end if;


  if p_txt is null then
    delete from nd_txt where nd=p_nd and tag=p_tag;
  else
    update nd_txt set txt=p_txt where nd=p_nd and tag=p_tag returning count(nd) into l_col;
    if l_col=0 then
       insert into nd_txt (nd, tag, txt) values (p_nd, p_tag, p_txt);
    end if;
  end if;

  bars_audit.trace(g_pack_name || l_proc_name || ' TYPE_change='||to_char(l_col)||'Finish.');
end;

---------------------------------------------------

 /*
   Set_ND_TXT_CHECK - Додаткова перевірка параметрів після додання всіх параметрів
          p_ND number     - Реф договора
 */
procedure Set_ND_TXT_CHECK (p_ND number)
is
 l_col number:=-1;
 l_proc_name varchar2(40) := 'Set_nd_txt_check ';
 l_eibis fm_yesno.id%type;
 l_cprod nd_txt.txt%type;
 l_tag nd_txt.tag%type;
 l_type number;
 l_cusstype customer.custtype%type;
begin
  bars_audit.trace(g_pack_name || l_proc_name ||
                   'Start. Params: ND=%s',
                                to_char(p_ND)
                  );
  select c.custtype into l_cusstype from customer c, cc_deal cc where c.rnk = cc.rnk and cc.nd = p_ND;

  if l_cusstype = 2 then
    begin
      select 1 into l_type from dual where F_Get_Params('MFOP') = '300465' or F_Get_Params('GLB-MFO') = '300465';

      begin
        select txt into l_cprod from nd_txt where nd = p_ND and tag = 'CPROD';
      exception
        when no_data_found then
          bars_error.raise_nerror('CCK', 'NOT_FILLED_PARAM ', 'CPROD', 'Кредитний продукт');
      end;

      begin
        select fyn.id into l_eibis from nd_txt nt, fm_yesno fyn where nt.txt = fyn.name and nd = p_ND and tag = 'EIBIS';
      exception
        when no_data_found then
          bars_error.raise_nerror('CCK', 'NOT_FILLED_PARAM ', 'EIBIS', 'ЄІБ: Приналежність до ЄІБ');
      end;

      if l_eibis = 'YES' then
        for c in (select * from cc_tag where tag in ('EIBCW','EIBTV','EIBCR','EIBCE','EIBND','EIBNE','EIBIE','EIBCS','EIBSF','EIBPF','EIBCB'))
          loop
            begin
              select tag into l_tag from nd_txt where nd = p_ND and tag = c.tag;
            exception
              when no_data_found then
                bars_error.raise_nerror('CCK', 'NOT_FILLED_PARAM ', c.tag, c.name);
            end;
          end loop;
      end if;

      if l_eibis = 'NO' then
        execute immediate 'delete from nd_txt where nd = '||p_ND||' and tag in (''EIBCW'',''EIBTV'',''EIBCR'',''EIBCE'',''EIBND'',''EIBNE'',''EIBIE'',''EIBCS'',''EIBSF'',''EIBPF'',''EIBCB'')';
      end if;
    exception
      when no_data_found then
        null;
    end;
  end if;
  bars_audit.trace(g_pack_name || l_proc_name || ' TYPE_change='||to_char(l_col)||'Finish.');
end;

--------------------------------------------------------------

 function Get_ND_TXT (p_ND number ,p_TAG varchar2) return varchar2
 is
  l_txt nd_txt.txt%type;
 begin

   select cck_app.get_nd_txt_ex(p_nd, p_tag, null) into l_txt from dual;

 return l_txt;
 end;


--------------------------------------------------------------

 function Get_ND_TXT_ex (p_nd   in nd_txt_update.nd%type, -- номер договора
                         p_tag  in nd_txt_update.tag%type, -- тег реквизита
                         p_date in nd_txt_update.chgdate%type default sysdate -- дата для получения исторического значения (null или sysdate - текущее)
                         )
 return nd_txt_update.txt%type
 is
  l_txt nd_txt_update.txt%type := null;
 begin

  if nvl(p_date,trunc(sysdate))<trunc(sysdate) then
   -- из истории

    select min(ntu.txt)
      into l_txt
      from nd_txt_update ntu
     where ntu.idupd = (
                        select max(ntu.idupd)
                          from nd_txt_update ntu
                         where ntu.nd = p_nd
                           and ntu.tag = p_tag
                           and trunc(ntu.chgdate) <= p_date
                       );
  end if;

  IF l_txt is null then
    -- берем текущее состояние
    select min(nt.txt)
      into l_txt
      from nd_txt nt
     where nt.nd  = p_nd
       and nt.tag = p_tag;

  end if;

  return l_txt;
 end;

--------------------------------------------------------------

 function sum_current_repayment_gpk (p_nd number, p_dat date) return number
 is
  l_typ_gpk number;
  l_sum    number;
 begin

    select a.vid into l_typ_gpk from accounts a, nd_acc n where a.acc=n.acc and a.tip='LIM' and n.nd=p_nd;

    select decode (l_typ_gpk,4,l.sumo,l.sumg)
      into l_sum
      from cc_lim l
     where l.nd=p_ND and (l.nd,l.fdat)=
          (select nd,min(fdat) from cc_lim
           where nd=p_ND and fdat >= p_dat and sumg>0
           group by nd
          );

 return l_sum;
  exception when no_data_found then
   return 0;
 end;

--------------------------------------------------------------

 /*
  Сумма платежей ТЕЛА ПО ГПК   (ПО ПЛАНУ)
  p_nd    - Номер договора
  p_dat   - Дата договора (пусто банк день)  принимаються только будущие даты платежей
  p_col   - кол-во платежей которые необходимо включать в сумму платежа
 */

 function sum_body_for_repayment_gpk (p_nd number, p_dat date,p_col int:=1) return number
 is
  l_typ_gpk number;
  l_sum    number;
 begin

     select sum(sumg)
       into l_sum
       from
       (
       select l.sumg
         from cc_lim l
        where l.nd=p_ND and l.sumg>0 and
              l.fdat>= (select min(fdat) from cc_lim
                         where nd=p_ND and fdat >coalesce(p_dat,gl.bdate,sysdate) and sumg>0
                         group by nd
                       )
        order by fdat
       ) where rownum<=nvl(p_col,1)
    ;

 return l_sum;
  exception when no_data_found then
   return 0;
 end;


--------------------------------------------------------------
 /*
  header_version - возвращает версию заголовка пакета CCK
 */

function header_version return varchar2 is
begin
  return 'Package header CCK '||G_HEADER_VERSION;
end header_version;

--------------------------------------------------------------

 /*
  body_version - возвращает версию тела пакета CCK
 */
function body_version return varchar2 is
begin
  return 'Package body CCK '||G_BODY_VERSION;
end body_version;

--------------------------------------------------------------


END CCK_APP;
/
 show err;
 
PROMPT *** Create  grants  CCK_APP ***
grant EXECUTE                                                                on CCK_APP         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_APP         to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cck_app.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 