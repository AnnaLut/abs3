/*
    AUTOGENERATED! Do not modify this code.
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using Bars.Classes;

namespace credit
{
    public partial class VWcsAdmBids
    {
        public List<VWcsAdmBidsRecord> SelectAdmBids(
                //String SRV_HIERARCHY,
                String Type,
                String PersonalInn,
                String PersonalFio,
                DateTime? PersonalBDay,
                String PersonalWorkInn,
                String PersonalWorkName,
                Decimal? BidId,
                DateTime? BidDateFrom,
                DateTime? BidDateTo,
                String BidState,
                String PersonalBranch,
                String PersonalMgrFio,
                String CreditSubproduct,
                Decimal? CreditPropertyCost,
                Decimal? CreditOwmFounds,
                Decimal? CreditSum,
                Decimal? CreditTerm,
                String CreditGuarantee,
                DateTime? CHECK_DAT,
                String CHECK_BRANCH,
                String CHECK_USER_FIO,
                String SortExpression, int maximumRows, int startRowIndex
            )
        {
            //this.Filter.SRV_HIERARCHY.Equal(SRV_HIERARCHY.ToUpper());

            switch (Type)
            {
                case "user":
                    OracleCommand cmd1 = new OracleCommand("select user_id from dual", OraConnector.Handler.IOraConnection.GetUserConnection());
                    Decimal? user_id = Convert.ToDecimal(cmd1.ExecuteScalar());
                    this.Filter.CHECKOUT_USER_ID.Equal(user_id);
                    break;
                case "branch":
                    OracleCommand cmd2 = new OracleCommand("select sys_context('bars_context', 'user_branch_mask') from dual", OraConnector.Handler.IOraConnection.GetUserConnection());
                    String user_branch_mask = Convert.ToString(cmd2.ExecuteScalar());
                    this.Filter.CHECKOUT_USER_BRANCH.LikeRight(user_branch_mask);
                    break;
                case "all":
                    // без ограничений
                    break;
            }

            // Ідентифікаційний код клієнта
            if (!String.IsNullOrEmpty(PersonalInn))
            {
                this.Filter.INN.Equal(PersonalInn.Trim());
            }
            // Прізвище клієнта
            if (!String.IsNullOrEmpty(PersonalFio))
            {
                this.Filter.FIO.LikeBoth(PersonalFio.Trim().ToUpper(), CaseFlags.UpperCase);
            }
            // Дата народження клієнта
            if (PersonalBDay.HasValue)
            {
                this.Filter.BDATE.Equal(PersonalBDay);
            }
            // ЄДРПОУ основного места работы
            if (!String.IsNullOrEmpty(PersonalWorkInn))
            {
                this.Filter.WORK_MAIN_INN.Equal(PersonalWorkInn.Trim());
            }
            // Наименование основного места работы
            if (!String.IsNullOrEmpty(PersonalWorkName))
            {
                this.Filter.WORK_MAIN_NAME.LikeBoth(PersonalWorkName.Trim().ToUpper(), CaseFlags.UpperCase);
            }

            // № заявки
            if (BidId.HasValue)
            {
                this.Filter.BID_ID.Equal(BidId);
            }
            // Дата створення заявки
            if (BidDateFrom.HasValue && BidDateTo.HasValue)
            {
                this.Filter.CRT_DATE.Between(BidDateFrom, BidDateTo.Value);
            }
            // Статус
            if (!String.IsNullOrEmpty(BidState))
            {
                this.Filter.STATUS.In(new List<String>(BidState.Split(';')));
            }
            // № відділення
            if (!String.IsNullOrEmpty(PersonalBranch))
            {
                this.Filter.BRANCH.Equal(PersonalBranch.Trim());
            }
            // Прізвище менеджера
            if (!String.IsNullOrEmpty(PersonalMgrFio))
            {
                this.Filter.MGR_FIO.LikeBoth(PersonalMgrFio.Trim().ToUpper(), CaseFlags.UpperCase);
            }
            // Субпродукт
            if (!String.IsNullOrEmpty(CreditSubproduct))
            {
                this.Filter.SUBPRODUCT_ID.Equal(CreditSubproduct.Trim());
            }

            // Стоимость имущества
            if (CreditPropertyCost.HasValue)
            {
                this.Filter.PROPERTY_COST.Equal(CreditPropertyCost);
            }
            // Сумма собственных стредств
            if (CreditOwmFounds.HasValue)
            {
                this.Filter.OWN_FUNDS.Equal(CreditOwmFounds);
            }
            // Сумма кредита
            if (CreditSum.HasValue)
            {
                this.Filter.SUMM.Equal(CreditSum);
            }
            // Термін кредиту (згідно заявки)
            if (CreditTerm.HasValue)
            {
                this.Filter.TERM.Equal(Convert.ToString(CreditTerm));
            }

            // Обеспечение !!! доделать
            // String CreditGuarantee,

            // Дата
            if (CHECK_DAT.HasValue)
            {
                this.Filter.CHECKOUT_DAT.LessEqual(CHECK_DAT.Value.AddDays(1).AddMilliseconds(-1));
            }
            // Код отделения
            if (!String.IsNullOrEmpty(CHECK_BRANCH))
            {
                this.Filter.CHECKOUT_USER_BRANCH.Equal(CHECK_BRANCH.Trim());
            }

            // ФИО співробітника (маска %)
            if (!String.IsNullOrEmpty(CHECK_USER_FIO))
            {
                this.Filter.CHECKOUT_USER_FIO.LikeBoth(CHECK_USER_FIO.Trim().ToUpper(), CaseFlags.UpperCase);
            }

            return Select(SortExpression, maximumRows, startRowIndex);
        }
    }
}