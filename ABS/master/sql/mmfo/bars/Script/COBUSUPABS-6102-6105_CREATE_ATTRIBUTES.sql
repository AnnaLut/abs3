--заповнюємо довідник  сегменту Поведінковий
begin
  dbms_result_cache.Flush;
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  1, P_ITEM_CODE => 'BEHAVIOR_PENSIONER_MILITARY', P_ITEM_NAME => 'Пенсіонери (військові)');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  2, P_ITEM_CODE => 'BEHAVIOR_PENSIONER_SOCIAL', P_ITEM_NAME => 'Пенсіонери (соціальні)');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  3, P_ITEM_CODE => 'BEHAVIOR_SALARY_COMMERCIAL', P_ITEM_NAME => 'Зарплатні клієнти (комерційні)');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  4, P_ITEM_CODE => 'BEHAVIOR_SALARY_BUDGET', P_ITEM_NAME => 'Зарплатні клієнти (бюджетні)');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  5, P_ITEM_CODE => 'BEHAVIOR_SALARY_BANK', P_ITEM_NAME => 'Зарплатні клієнти (співробітники банку)');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  6, P_ITEM_CODE => 'BEHAVIOR_SOCIAL_PAYMENTS', P_ITEM_NAME => 'Соціальні виплати');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  7, P_ITEM_CODE => 'BEHAVIOR_STUDENT', P_ITEM_NAME => 'Студенти');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  8, P_ITEM_CODE => 'BEHAVIOR_NOTARIES', P_ITEM_NAME => 'Нотаріуси / Адвокати');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID =>  9, P_ITEM_CODE => 'BEHAVIOR_SAILOR', P_ITEM_NAME => 'Моряки');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 10, P_ITEM_CODE => 'BEHAVIOR_BORROWER', P_ITEM_NAME => 'Позичальники');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 11, P_ITEM_CODE => 'BEHAVIOR_DEPOSITOR', P_ITEM_NAME => 'Вкладники');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 12, P_ITEM_CODE => 'BEHAVIOR_NATIONAL_CARD', P_ITEM_NAME => 'Національна карта');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 13, P_ITEM_CODE => 'BEHAVIOR_CARD_ACCOUNTS', P_ITEM_NAME => 'Власники карткових рахунків');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 14, P_ITEM_CODE => 'BEHAVIOR_CURRENT_ACCOUNTS', P_ITEM_NAME => 'Власники поточних рахунків');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 15, P_ITEM_CODE => 'BEHAVIOR_INDEFINED', P_ITEM_NAME => 'Не визначений');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 16, P_ITEM_CODE => 'BEHAVIOR_DEPOSITORY_SAFES', P_ITEM_NAME => 'Користувачі індивідуальних сейфів');
  BARS.LIST_UTL.COR_LIST_ITEM(P_LIST_CODE => 'CUSTOMER_SEGMENT_BEHAVIOR', P_ITEM_ID => 17, P_ITEM_CODE => 'BEHAVIOR_INSURANTS', P_ITEM_NAME => 'Страхувальники');
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
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE     => 'CUSTOMER_SEGMENT_CASHCREDIT_GIVEN',
                                                           P_ATTRIBUTE_NAME     => 'Сума наданого кеш-кредиту',
                                                           P_OBJECT_TYPE_CODE   => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID      => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_VALUE_BY_DATE_FLAG => 'Y',
                                                           P_SAVE_HISTORY_FLAG  => 'Y');
  end if;

  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE     => 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA',
                                                           P_ATTRIBUTE_NAME     => 'Страхування «Автоцивілка»',
                                                           P_OBJECT_TYPE_CODE   => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID      => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_VALUE_BY_DATE_FLAG => 'N',
                                                           P_SAVE_HISTORY_FLAG  => 'N');
  end if;

  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA+', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE     => 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA+',
                                                           P_ATTRIBUTE_NAME     => 'Страхування «Автоцивілка+»',
                                                           P_OBJECT_TYPE_CODE   => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID      => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_VALUE_BY_DATE_FLAG => 'N',
                                                           P_SAVE_HISTORY_FLAG  => 'N');
  end if;

  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INSURANCE_OBERIG', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE     => 'CUSTOMER_PRDCT_AMNT_INSURANCE_OBERIG',
                                                           P_ATTRIBUTE_NAME     => 'Страхування «Оберіг»',
                                                           P_OBJECT_TYPE_CODE   => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID      => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_VALUE_BY_DATE_FLAG => 'N',
                                                           P_SAVE_HISTORY_FLAG  => 'N');
  end if;

  if attribute_utl.read_attribute('CUSTOMER_PRDCT_AMNT_INSURANCE_CASH', false).id is null then
    :result := BARS.ATTRIBUTE_UTL.CREATE_DYNAMIC_ATTRIBUTE(P_ATTRIBUTE_CODE     => 'CUSTOMER_PRDCT_AMNT_INSURANCE_CASH',
                                                           P_ATTRIBUTE_NAME     => 'Страхування життя (Кеш)',
                                                           P_OBJECT_TYPE_CODE   => 'CUSTOMER',
                                                           P_VALUE_TYPE_ID      => BARS.ATTRIBUTE_UTL.VALUE_TYPE_NUMBER,
                                                           P_VALUE_BY_DATE_FLAG => 'N',
                                                           P_SAVE_HISTORY_FLAG  => 'N');
  end if;

  commit work;
end;
/
