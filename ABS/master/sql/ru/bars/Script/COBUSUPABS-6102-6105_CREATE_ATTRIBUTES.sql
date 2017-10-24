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
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 17, P_ITEM_CODE => 'BEHAVIOR_INSURANTS', P_ITEM_NAME =>'Страхувальники', P_PARENT_ITEM_CODE =>null );
  commit work;
exception
  when others then
    rollback;
    raise;
end;
/

variable result number

begin

  if bars.attribute_utl.read_attribute('CUSTOMER_SEGMENT_CASHCREDIT_GIVEN', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE       => 'CUSTOMER_SEGMENT_CASHCREDIT_GIVEN',
                                                         P_ATTRIBUTE_NAME         => 'Сума наданого кеш-кредиту',
                                                         P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                         P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                         P_REGULAR_EXPRESSION     => null,
                                                         P_LIST_TYPE_CODE         => null,
                                                         P_MULTY_VALUE_FLAG       => 'N',
                                                         P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_VALUES_BY_DATE,
                                                         P_SET_VALUE_PROCEDURE    => null,
                                                         P_DEL_VALUE_PROCEDURE    => null);
  end if;

  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE       => 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA',
                                                         P_ATTRIBUTE_NAME         => 'Страхування «Автоцивілка»',
                                                         P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                         P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                         P_REGULAR_EXPRESSION     => null,
                                                         P_LIST_TYPE_CODE         => null,
                                                         P_MULTY_VALUE_FLAG       => 'N',
                                                         P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_NO_HISTORY,
                                                         P_SET_VALUE_PROCEDURE    => null,
                                                         P_DEL_VALUE_PROCEDURE    => null);
  end if;

  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA+', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE       => 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA+',
                                                         P_ATTRIBUTE_NAME         => 'Страхування «Автоцивілка+»',
                                                         P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                         P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                         P_REGULAR_EXPRESSION     => null,
                                                         P_LIST_TYPE_CODE         => null,
                                                         P_MULTY_VALUE_FLAG       => 'N',
                                                         P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_NO_HISTORY,
                                                         P_SET_VALUE_PROCEDURE    => null,
                                                         P_DEL_VALUE_PROCEDURE    => null);
  end if;

  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INSURANCE_OBERIG', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE       => 'CUSTOMER_PRDCT_AMNT_INSURANCE_OBERIG',
                                                         P_ATTRIBUTE_NAME         => 'Страхування «Оберіг»',
                                                         P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                         P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                         P_REGULAR_EXPRESSION     => null,
                                                         P_LIST_TYPE_CODE         => null,
                                                         P_MULTY_VALUE_FLAG       => 'N',
                                                         P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_NO_HISTORY,
                                                         P_SET_VALUE_PROCEDURE    => null,
                                                         P_DEL_VALUE_PROCEDURE    => null);
  end if;

  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INSURANCE_CASH', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE       => 'CUSTOMER_PRDCT_AMNT_INSURANCE_CASH',
                                                         P_ATTRIBUTE_NAME         => 'Страхування життя (Кеш)',
                                                         P_OBJECT_TYPE_CODE       => 'CUSTOMER',
                                                         P_VALUE_TYPE_ID          => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                         P_REGULAR_EXPRESSION     => null,
                                                         P_LIST_TYPE_CODE         => null,
                                                         P_MULTY_VALUE_FLAG       => 'N',
                                                         P_HISTORY_SAVING_MODE_ID => BARS.ATTRIBUTE_UTL.HISTORY_MODE_NO_HISTORY,
                                                         P_SET_VALUE_PROCEDURE    => null,
                                                         P_DEL_VALUE_PROCEDURE    => null);
  end if;

  commit work;
end;
/
