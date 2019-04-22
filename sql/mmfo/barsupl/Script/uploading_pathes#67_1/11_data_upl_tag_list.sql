-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

-- ======================================================================================
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
--     Выгружать только два TAG для таблицы SMB_ATTRIBUTE :
--     SMB_DEPOSIT_TRANCHE_INTEREST_RATE
--     SMB_DEPOSIT_ON_DEMAND_INTEREST_RATE
-- ======================================================================================

delete
  from barsupl.upl_tag_lists 
 where trim(tag_table) in ('SMB_TRANCHE', 'SMB_ON_DEMAND');

--delete
--  from barsupl.upl_tag_ref 
-- where ref_id in (5, 6);

--регистрация нового справочника 
--Insert into barsupl.upl_tag_ref  (REF_ID, FILE_ID, DESCRIPTION) Values (5, 000, 'Справочник продуктов ММСБ (номера пока нет)');
--Insert into barsupl.upl_tag_ref  (REF_ID, FILE_ID, DESCRIPTION) Values (6, 000, 'Стан угоди ММСБ (номера пока нет)');

-- параметры траншевых депозитов
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_NUMBER', 0, 0, 'Номер угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_CUSTOMER', 0, 0, 'Ідентифікатор контрагента за угодою');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_PRODUCT', 0, 0, 'Ідентифікатор продукта угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_START_DATE', 0, 0, 'Дата початку дії угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_EXPIRY_DATE', 0, 0, 'Дата завершення дії угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_CLOSE_DATE', 0, 0, 'Дата закриття угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'OBJECT_STATE', 0, 0, 'Стан угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_BRANCH', 0, 0, 'Філіал банку, де обліковується угода');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_CURATOR', 0, 0, 'Співробітник банку, який веде угоду');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_VNCRP', 0, 0, 'Первинний внутрішній кредитний рейтинг');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_VNCRR', 0, 0, 'Поточний внутрішній кредитний рейтинг');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_FIN_CONDITION', 0, 0, 'Клас позичальника (фін.стан)');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_OVERDUE_DAYS', 0, 0, 'Кількість днів прострочки за угодою');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_PORTFOL_RESERVE_FLAG', 0, 0, 'Ознака портфельного методу резервування');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_PORTFOL_RESERVE_GRP', 0, 0, 'Група активу портфельного методу резервування');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_FIN_CONDITION_23', 0, 0, 'Клас позичальника згідно Постанови НБУ №23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_DEBT_SERV_CLASS_23', 0, 0, 'Стан обслуговування боргу згідно Постанови НБУ №23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_FIN_QUALITY_CATEGORY_23', 0, 0, 'Категорiя якостi за кредитом згідно Постанови НБУ №23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_RISK_RATE_23', 0, 0, 'Коефіцієнт ризику згідно Постанови НБУ №23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_BALANCE_GROUP', 0, 0, 'Група угод в плані рахунків НБУ');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_NAME', 0, 0, 'Найменування продукту');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_SEGMENT_OF_BUSINESS', 0, 0, 'Сегмент');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_VALID_FROM', 0, 0, 'Дата початку дії');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_VALID_THROUGH', 0, 0, 'Дата закінчення дії');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_PARENT_PRODUCT', 0, 0, 'ID батьківського продукту');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEPOSIT_PRIMARY_ACCOUNT', 0, 0, 'Рахунок обліку суми депозиту');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEPOSIT_INTEREST_ACCOUNT', 0, 0, 'Рахунок нарахованих відсотків по депозитах');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT', 0, 0, 'Рахунок витрат нарахованих відсотків');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT', 0, 0, 'Рахунок витрат для перерахунку сум (штраф)');
insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'SMB_DEPOSIT_TRANCHE_INTEREST_RATE', 1, 0, 'Процентна ставка по депозитних траншах ММСБ');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'SMB_DEPOSIT_TRANCHE_PENALTY_INTEREST_RATE', 0, 0, 'Штрафна процентна ставка по депозитних траншах ММСБ');

-- параметры депозитов до востребования
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_NUMBER', 0, 0, 'Номер угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_CUSTOMER', 0, 0, 'Ідентифікатор контрагента за угодою');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_PRODUCT', 0, 0, 'Ідентифікатор продукта угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_START_DATE', 0, 0, 'Дата початку дії угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_EXPIRY_DATE', 0, 0, 'Дата завершення дії угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_CLOSE_DATE', 0, 0, 'Дата закриття угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'OBJECT_STATE', 0, 0, 'Стан угоди');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_BRANCH', 0, 0, 'Філіал банку, де обліковується угода');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_CURATOR', 0, 0, 'Співробітник банку, який веде угоду');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_VNCRP', 0, 0, 'Первинний внутрішній кредитний рейтинг');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_VNCRR', 0, 0, 'Поточний внутрішній кредитний рейтинг');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_FIN_CONDITION', 0, 0, 'Клас позичальника (фін.стан)');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_OVERDUE_DAYS', 0, 0, 'Кількість днів прострочки за угодою');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_PORTFOL_RESERVE_FLAG', 0, 0, 'Ознака портфельного методу резервування');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_PORTFOL_RESERVE_GRP', 0, 0, 'Група активу портфельного методу резервування');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_FIN_CONDITION_23', 0, 0, 'Клас позичальника згідно Постанови НБУ №23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_DEBT_SERV_CLASS_23', 0, 0, 'Стан обслуговування боргу згідно Постанови НБУ №23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_FIN_QUALITY_CATEGORY_23', 0, 0, 'Категорiя якостi за кредитом згідно Постанови НБУ №23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_RISK_RATE_23', 0, 0, 'Коефіцієнт ризику згідно Постанови НБУ №23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_BALANCE_GROUP', 0, 0, 'Група угод в плані рахунків НБУ');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_NAME', 0, 0, 'Найменування продукту');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_SEGMENT_OF_BUSINESS', 0, 0, 'Сегмент');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_VALID_FROM', 0, 0, 'Дата початку дії');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_VALID_THROUGH', 0, 0, 'Дата закінчення дії');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_PARENT_PRODUCT', 0, 0, 'ID батьківського продукту');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEPOSIT_PRIMARY_ACCOUNT', 0, 0, 'Рахунок обліку суми депозиту');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEPOSIT_INTEREST_ACCOUNT', 0, 0, 'Рахунок нарахованих відсотків по депозитах');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT', 0, 0, 'Рахунок витрат нарахованих відсотків');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT', 0, 0, 'Рахунок витрат для перерахунку сум (штраф)');
insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'SMB_DEPOSIT_ON_DEMAND_INTEREST_RATE', 1, 0, 'Процентна ставка по депозитнам на вимогу ММСБ');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'SMB_DEPOSIT_ON_DEMAND_CALCULATION_TYPE', 0, 0, 'Тип нарахування % по депозитнам на вимогу ММСБ');


