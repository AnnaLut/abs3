--заповнюємо довідник  сегменту Поведінковий
begin
  dbms_result_cache.Flush;
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  1, P_ITEM_CODE => 'BEHAVIOR_PENSIONER_MILITARY', P_ITEM_NAME =>'Пенсіонери (військові)', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  2, P_ITEM_CODE => 'BEHAVIOR_PENSIONER_SOCIAL', P_ITEM_NAME =>'Пенсіонери (соціальні)', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  3, P_ITEM_CODE => 'BEHAVIOR_SALARY_COMMERCIAL', P_ITEM_NAME =>'Зарплатні клієнти (комерційні)', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  4, P_ITEM_CODE => 'BEHAVIOR_SALARY_BUDGET', P_ITEM_NAME =>'Зарплатні клієнти (бюджетні)', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  5, P_ITEM_CODE => 'BEHAVIOR_SALARY_BANK', P_ITEM_NAME =>'Зарплатні клієнти (співробітники банку)', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  6, P_ITEM_CODE => 'BEHAVIOR_SOCIAL_PAYMENTS', P_ITEM_NAME =>'Соціальні виплати', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  7, P_ITEM_CODE => 'BEHAVIOR_STUDENT', P_ITEM_NAME =>'Студенти', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  8, P_ITEM_CODE => 'BEHAVIOR_NOTARIES', P_ITEM_NAME =>'Нотаріуси / Адвокати', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  9, P_ITEM_CODE => 'BEHAVIOR_SAILOR', P_ITEM_NAME =>'Моряки', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 10, P_ITEM_CODE => 'BEHAVIOR_BORROWER', P_ITEM_NAME =>'Позичальники', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 11, P_ITEM_CODE => 'BEHAVIOR_DEPOSITOR', P_ITEM_NAME =>'Вкладники', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 12, P_ITEM_CODE => 'BEHAVIOR_NATIONAL_CARD', P_ITEM_NAME =>'Національна карта', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 13, P_ITEM_CODE => 'BEHAVIOR_CARD_ACCOUNTS', P_ITEM_NAME =>'Власники карткових рахунків', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 14, P_ITEM_CODE => 'BEHAVIOR_CURRENT_ACCOUNTS', P_ITEM_NAME =>'Власники поточних рахунків', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 15, P_ITEM_CODE => 'BEHAVIOR_INDEFINED', P_ITEM_NAME =>'Не визначений', P_PARENT_ITEM_CODE =>null );
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 16, P_ITEM_CODE => 'BEHAVIOR_DEPOSITORY_SAFES', P_ITEM_NAME =>'Користувачі індивідуальних сейфів', P_PARENT_ITEM_CODE =>null );
  commit work;
exception
  when others then
    rollback;
    raise;
end;
/

variable result number

begin
  update bars.attribute_kind set attribute_name = 'Кредити під поруку' where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRD_GARANT';
  update bars.attribute_kind set attribute_name = 'Кредити Енергоефективність' where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRDENERGY';
  update bars.attribute_kind set attribute_name = 'Кредити с БПК' where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRDCARDS';

  if attribute_utl.read_attribute('CUSTOMER_SEGMENT_ATM', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE         => 'CUSTOMER_SEGMENT_ATM',
                                                           P_ATTRIBUTE_NAME         => 'Кількість операцій зняття готівки в АТМ',
                                                           P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_REGULAR_EXPRESSION     => null,
                                                           P_LIST_TYPE_CODE         => null,
                                                           P_MULTY_VALUE_FLAG       => 'N',
                                                           P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_VALUES_BY_DATE,
                                                           P_SET_VALUE_PROCEDURE    => null,
                                                           P_DEL_VALUE_PROCEDURE    => null);
  end if;

  if attribute_utl.read_attribute('CUSTOMER_SEGMENT_BPK_CREDITLINE', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE         => 'CUSTOMER_SEGMENT_BPK_CREDITLINE',
                                                           P_ATTRIBUTE_NAME         => 'Сума встановленої кредитної лінії на БПК',
                                                           P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_REGULAR_EXPRESSION     => null,
                                                           P_LIST_TYPE_CODE         => null,
                                                           P_MULTY_VALUE_FLAG       => 'N',
                                                           P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_VALUES_BY_DATE,
                                                           P_SET_VALUE_PROCEDURE    => null,
                                                           P_DEL_VALUE_PROCEDURE    => null);
  end if;

  -- змінюємо атрибут CUSTOMER_PRDCT_AMNT_TRANSFERS (грошові перекази) за невикористанням на CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES (Індивідуальні сейфи)
  --прив'язуємо до об'єкту контрагент банку атрибуту к-ті Індивідуальні сейфи в сегменті проднавантаження
  select count(*) into :result from bars.attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_TRANSFERS';
  if :result > 0 then
    update bars.attribute_kind
       set attribute_code = 'CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES', attribute_name = 'Індивідуальні сейфи'
     where attribute_code = 'CUSTOMER_PRDCT_AMNT_TRANSFERS';
  elsif attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE         => 'CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES',
                                                           P_ATTRIBUTE_NAME         => 'Індивідуальні сейфи',
                                                           P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_REGULAR_EXPRESSION     => null,
                                                           P_LIST_TYPE_CODE         => null,
                                                           P_MULTY_VALUE_FLAG       => 'N',
                                                           P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_NO_HISTORY,
                                                           P_SET_VALUE_PROCEDURE    => null,
                                                           P_DEL_VALUE_PROCEDURE    => null);
  end if;
  
  --прив'язуємо до об'єкту контрагент банку атрибуту к-ті Кеш-кредити в сегменті проднавантаження
  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_CASHLOANS', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE         => 'CUSTOMER_PRDCT_AMNT_CASHLOANS',
                                                           P_ATTRIBUTE_NAME         => 'Кеш-кредити',
                                                           P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_REGULAR_EXPRESSION     => null,
                                                           P_LIST_TYPE_CODE         => null,
                                                           P_MULTY_VALUE_FLAG       => 'N',
                                                           P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_NO_HISTORY,
                                                           P_SET_VALUE_PROCEDURE    => null,
                                                           P_DEL_VALUE_PROCEDURE    => null);
  end if;
  
  --прив'язуємо до об'єкту контрагент банку атрибуту к-ті Встановлена кредитна лінія в сегменті проднавантаження
  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_BPK_CREDITLINE', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE         => 'CUSTOMER_PRDCT_AMNT_BPK_CREDITLINE',
                                                           P_ATTRIBUTE_NAME         => 'Встановлені кредитні лінії на БПК',
                                                           P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_REGULAR_EXPRESSION     => null,
                                                           P_LIST_TYPE_CODE         => null,
                                                           P_MULTY_VALUE_FLAG       => 'N',
                                                           P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_NO_HISTORY,
                                                           P_SET_VALUE_PROCEDURE    => null,
                                                           P_DEL_VALUE_PROCEDURE    => null);
  end if;

	-- UPD 26.07.2017 - змінюємо раніше створені з BARS.ATTRIBUTE_UTL.HISTORY_MODE_VALUES_BY_DATE на BARS.ATTRIBUTE_UTL.HISTORY_MODE_NO_HISTORY
  update bars.attribute_kind set history_saving_mode_id = 1 where attribute_code in ('CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES', 'CUSTOMER_PRDCT_AMNT_CASHLOANS', 'CUSTOMER_PRDCT_AMNT_BPK_CREDITLINE');
  commit work;
end;
/
