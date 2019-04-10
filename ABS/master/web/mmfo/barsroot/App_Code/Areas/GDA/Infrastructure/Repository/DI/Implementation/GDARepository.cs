using Areas.GDA.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.GDA.Infrastructure.DI.Abstract;
//using BarsWeb.Core.Models;
using BarsWeb.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Xml.Serialization;
using System.IO;
using System.Text;
using Xml2CSharp;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Dapper;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Data;
using Oracle.DataAccess.Types;
using BarsWeb.Areas.GDA.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.GDA.Infrastructure.DI.Implementation
{

    public class GDARepository : IGDARepository
    {
        readonly GDAModel _GDA;
        public BarsSql _getSql;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;



        public string GetOption()
        {
            string sql_query = @"select smb_deposit_ui.get_data_xml() data from dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql_query).SingleOrDefault();
            }
        }
        public string GetOptionDemand()
        {
            string sql_query = @"select smb_deposit_ui.get_data_on_demand_xml() from dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql_query).SingleOrDefault();
            }
        }
        public List<Option> GetList()
        {

            //string XmlFile = File.ReadAllText(@"D:\tranche_Test.xml");
            //ROOT obj = _repo.Deserialize<ROOT>(XmlFile);

            ROOT obj = Deserialize<ROOT>(GetOption());

            List<Option> GenOpt = new List<Option>();


            var option = obj.General.Kinds.Kind.OPTIONS.Option;

            //if (option != null)
            //{
            foreach (var item in option)
            {
                Option opt = new Option();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                GenOpt.Add(opt);
            }

            return GenOpt;

        }
        public List<ActionOption> GetActionList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<ActionOption> ActOpt = new List<ActionOption>();


            var option = obj.BONUS.KINDS.Kind.OPTIONS.Option;

            //if (option != null)
            //{
            foreach (var item in option)
            {
                ActionOption opt = new ActionOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;
                opt.OptionDescription = item.OptionDescription != null ? item.OptionDescription : null;

                ActOpt.Add(opt);
            }

            return ActOpt;

        }
        public List<PaymentOption> GetPaymentList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<PaymentOption> PayOpt = new List<PaymentOption>();


            var option = obj.PAYMENT.KINDS.Kind.OPTIONS.Option;

            //if (option != null)
            //{
            foreach (var item in option)
            {
                PaymentOption opt = new PaymentOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                PayOpt.Add(opt);
            }

            return PayOpt;

        }
        public List<CapitalizationOption> GetCapitalizationList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<CapitalizationOption> CapOpt = new List<CapitalizationOption>();


            var option = obj.CAPITALIZATION.KINDS.Kind.OPTIONS.Option;

            //if (option != null)
            //{
            foreach (var item in option)
            {
                CapitalizationOption opt = new CapitalizationOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                CapOpt.Add(opt);
            }

            return CapOpt;

        }
        public List<ProlongationOption> GetProlongationList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<ProlongationOption> ProOpt = new List<ProlongationOption>();


            var option = obj.PROLONGATION.KINDS.Kind.OPTIONS.Option;

            //if (option != null)
            //{
            foreach (var item in option)
            {
                ProlongationOption opt = new ProlongationOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                ProOpt.Add(opt);
            }

            return ProOpt;

        }
        public List<PenaltyOption> GetPenaltyList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<PenaltyOption> PenOpt = new List<PenaltyOption>();


            var option = obj.PENALTY_RATE.KINDS.Kind.OPTIONS.Option;

            //if (option != null)
            //{
            foreach (var item in option)
            {
                PenaltyOption opt = new PenaltyOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                PenOpt.Add(opt);
            }

            return PenOpt;

        }
        public List<SumOption> GetSumTrancheList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<SumOption> sumOptions = new List<SumOption>();

            var option = obj.TRANCHE_AMOUNT_SETTING.KINDS.Kind.OPTIONS.Option;

            foreach (var item in option)
            {
                SumOption opt = new SumOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                sumOptions.Add(opt);
            }

            return sumOptions;

        }
        public List<TimeAddTranchesOption> GetTimeAddTrancheList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<TimeAddTranchesOption> options = new List<TimeAddTranchesOption>();

            var option = obj.REPLENISHMENT_TRANCHE.KINDS.Kind.OPTIONS.Option;

            foreach (var item in option)
            {
                TimeAddTranchesOption opt = new TimeAddTranchesOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                options.Add(opt);
            }

            return options;

        }
        public List<DepositDemandOption> GetDepositDemandList()
        {
            ROOT obj = Deserialize<ROOT>(GetOptionDemand());

            List<DepositDemandOption> options = new List<DepositDemandOption>();

            var option = obj.DEPOSIT_ON_DEMAND.KINDS.Kind.OPTIONS.Option;

            foreach (var item in option)
            {
                DepositDemandOption opt = new DepositDemandOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                options.Add(opt);
            }

            return options;

        }

        public List<DepositOnDemandType> GetDepositOnDemandCalcTypeList()
        {
            ROOT obj = Deserialize<ROOT>(GetOptionDemand());

            List<DepositOnDemandType> options = new List<DepositOnDemandType>();

            var option = obj.DEPOSIT_ON_DEMAND_CALC.KINDS.Kind.OPTIONS.Option;

            foreach (var item in option)
            {
                DepositOnDemandType opt = new DepositOnDemandType();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;
                opt.Id_ = item.Id_;
                opt.CalculationTypeId = item.CalculationTypeId;

                options.Add(opt);
            }
            return options;
        }

        public List<ReplenishmentOption> GetReplenishmentList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<ReplenishmentOption> options = new List<ReplenishmentOption>();

            var option = obj.REPLENISHMENT.KINDS.Kind.OPTIONS.Option;

            foreach (var item in option)
            {
                ReplenishmentOption opt = new ReplenishmentOption();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                options.Add(opt);
            }

            return options;
        }
        public List<Option> GetBlockRateList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<Option> options = new List<Option>();

            var option = obj.RATE_FOR_BLOCKED_TRANCHE.KINDS.Kind.OPTIONS.Option;

            foreach (var item in option)
            {
                Option opt = new Option();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                options.Add(opt);
            }

            return options;
        }

        public List<Option> GetBonusProlongationList()
        {
            ROOT obj = Deserialize<ROOT>(GetOption());

            List<Option> options = new List<Option>();

            var option = obj.PROLONGATION_BONUS.KINDS.Kind.OPTIONS.Option;

            foreach (var item in option)
            {
                Option opt = new Option();

                opt.ValidFrom = item.ValidFrom != null ? item.ValidFrom : null;
                opt.ValidThough = item.ValidThrough != null ? item.ValidThrough : null;
                opt.IsActive = item.IsActive != null ? item.IsActive : null;
                opt.Conditions = item.Conditions != null ? item.Conditions.Condition : null;
                opt.Id = item.Id;

                options.Add(opt);
            }

            return options;
        }
        public GDARepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _GDA = new GDAModel(EntitiesConnection.ConnectionString("GDAModel", "GDA"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }
        public string SetOptionToDB(string xml)
        {
            var SqlParams = new object[]
            {
                new OracleParameter("p_data",OracleDbType.Clob) {Value = xml},
                new OracleParameter("p_type",OracleDbType.Varchar2) { Value = null},
                new OracleParameter("p_error", OracleDbType.Varchar2){Direction = ParameterDirection.Output,Size=4000},
                new OracleParameter("p_option_id",OracleDbType.Int32){Direction = ParameterDirection.Output}
            };

            _GDA.Connection.Open();
            var t = _GDA.Connection.BeginTransaction();
            string sql = @"begin smb_deposit_ui.set_data(:p_data,:p_type,:p_error, :p_option_id); end;";

            try
            {
                _GDA.ExecuteStoreCommand(sql, SqlParams);
                OracleString errMsg = ((OracleString)((OracleParameter)SqlParams[2]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();

            return Convert.ToString(((OracleParameter)SqlParams[3]).Value);
        }
        public string SetOptionToDBDemand(string xml)
        {
            var SqlParams = new object[]
            {
                new OracleParameter("p_data",OracleDbType.Clob) {Value = xml},
                new OracleParameter("p_error", OracleDbType.Varchar2){Direction = ParameterDirection.Output,Size=4000},
                new OracleParameter("p_id",OracleDbType.Int32){Direction = ParameterDirection.Output}
            };

            _GDA.Connection.Open();
            var t = _GDA.Connection.BeginTransaction();
            string sql = @"begin smb_deposit_ui.set_data_deposit_on_demand(:p_data,:p_error, :p_id); end;";

            try
            {
                _GDA.ExecuteStoreCommand(sql, SqlParams);
                OracleString errMsg = ((OracleString)((OracleParameter)SqlParams[1]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();
            _GDA.Connection.Close();
            return Convert.ToString(((OracleParameter)SqlParams[2]).Value);
        }

        public Option SetOption(Option option)
        {
            DateTime dateNow = DateTime.Now; //текущая дата
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");
            

            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {

                    string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                    throw new Exception(text);

            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                //insert into obj new option
                var xmlOptions = obj.General.Kinds.Kind.OPTIONS;
                //check if options already exists
                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.General.Kinds.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,

                    });
                }


                //serialize
                string doc = Serialize<ROOT>(obj);


                //save xml to DB - get new id -> newOptionId
                option.Id = SetOptionToDB(doc);

                return option;
            }
        }
        public CONDITION SetCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.AmountFrom == null || condition.TermFrom == null || condition.InterestRate == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.General.Kinds.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.AmountFrom = condition.AmountFrom;
                    target.TermFrom = condition.TermFrom;
                    target.InterestRate = condition.InterestRate;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        TermUnit = "1",
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        Currency = condition.Currency,
                        AmountFrom = condition.AmountFrom,
                        TermFrom = condition.TermFrom,
                        InterestRate = condition.InterestRate
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }


        public ActionOption SetActionOption(ActionOption option)
        {

            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");

            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(dateStringNow) || DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                //insert into obj new option
                var xmlOptions = obj.BONUS.KINDS.Kind.OPTIONS;
                //check if options already exists
                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.BONUS.KINDS.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                    xmlOption.OptionDescription = option.OptionDescription;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        OptionDescription = option.OptionDescription,
                        Conditions = null
                    });
                }

                //serialize
                string doc = Serialize<ROOT>(obj);


                //save xml to DB - get new id -> newOptionId
                option.Id = SetOptionToDB(doc);

                return option;
            }
        }
        public CONDITION SetActionCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.AmountFrom == null || condition.TermFrom == null || condition.InterestRate == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.BONUS.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.AmountFrom = condition.AmountFrom;
                    target.TermFrom = condition.TermFrom;
                    target.InterestRate = condition.InterestRate;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        TermUnit = "1",
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        AmountFrom = condition.AmountFrom,
                        TermFrom = condition.TermFrom,
                        InterestRate = condition.InterestRate
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }


        public PaymentOption SetPaymentOption(PaymentOption option)
        {
            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                //insert into obj new option
                var xmlOptions = obj.PAYMENT.KINDS.Kind.OPTIONS;
                //check if options already exists
                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.PAYMENT.KINDS.Kind.OPTIONS = xmlOptions;
                }
                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,
                    });
                }

                //serialize
                string doc = Serialize<ROOT>(obj);


                //save xml to DB - get new id -> newOptionId
                option.Id = SetOptionToDB(doc);

                return option;
            }
        }
        public CONDITION SetPaymentCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.PaymentTermId == null || condition.InterestRate == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.PAYMENT.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.PaymentTermId = condition.PaymentTermId;
                    target.InterestRate = condition.InterestRate;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        TermUnit = "1",
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        PaymentTermId = condition.PaymentTermId,
                        //PaymentTerm = condition.PaymentTerm,
                        InterestRate = condition.InterestRate
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }

        public CapitalizationOption SetCapitalizationOption(CapitalizationOption option)
        {
            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                //insert into obj new option
                var xmlOptions = obj.CAPITALIZATION.KINDS.Kind.OPTIONS;
                //check if options already exists
                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.CAPITALIZATION.KINDS.Kind.OPTIONS = xmlOptions;
                }
                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,
                    });
                }

                //serialize
                string doc = Serialize<ROOT>(obj);


                //save xml to DB - get new id -> newOptionId
                option.Id = SetOptionToDB(doc);

                return option;
            }
        }
        public CONDITION SetCapitalizationCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.PaymentTermId == null || condition.InterestRate == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.CAPITALIZATION.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.PaymentTermId = condition.PaymentTermId;
                    target.InterestRate = condition.InterestRate;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        TermUnit = "1",
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        PaymentTermId = condition.PaymentTermId,
                        //PaymentTerm = condition.PaymentTerm,
                        InterestRate = condition.InterestRate
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }

        public ProlongationOption SetProlongationOption(ProlongationOption option)
        {
            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                //insert into obj new option
                var xmlOptions = obj.PROLONGATION.KINDS.Kind.OPTIONS;
                //check if options already exists
                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.PROLONGATION.KINDS.Kind.OPTIONS = xmlOptions;
                }
                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,
                    });
                }

                //serialize
                string doc = Serialize<ROOT>(obj);


                //save xml to DB - get new id -> newOptionId
                option.Id = SetOptionToDB(doc);

                return option;
            }
        }
        public CONDITION SetProlongationCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.AmountFrom == null || condition.InterestRate == null || condition.ApplyToFirst == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.PROLONGATION.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.AmountFrom = condition.AmountFrom;
                    target.InterestRate = condition.InterestRate;
                    target.ApplyToFirst = condition.ApplyToFirst;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        TermUnit = "1",
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        AmountFrom = condition.AmountFrom,
                        InterestRate = condition.InterestRate,
                        ApplyToFirst = condition.ApplyToFirst
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }

        public PenaltyOption SetPenaltyOption(PenaltyOption option)
        {
            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                //insert into obj new option
                var xmlOptions = obj.PENALTY_RATE.KINDS.Kind.OPTIONS;
                //check if options already exists
                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.PENALTY_RATE.KINDS.Kind.OPTIONS = xmlOptions;
                }
                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,
                    });
                }

                //serialize
                string doc = Serialize<ROOT>(obj);


                //save xml to DB - get new id -> newOptionId
                option.Id = SetOptionToDB(doc);

                return option;
            }
        }
        public CONDITION SetPenaltyCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.RateFrom == null || condition.PenaltyRate == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.PENALTY_RATE.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.RateFrom = condition.RateFrom;
                    target.PenaltyRate = condition.PenaltyRate;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        TermUnit = "1",
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        RateFrom = condition.RateFrom,
                        PenaltyRate = condition.PenaltyRate
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }

        public SumOption SetSumTrancheOption(SumOption option)
        {

            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.TRANCHE_AMOUNT_SETTING.KINDS.Kind.OPTIONS;


                //var optionTarget = xmlOptions.Option.FirstOrDefault();

                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.TRANCHE_AMOUNT_SETTING.KINDS.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,
                    });
                }

                string doc = Serialize<ROOT>(obj);

                option.Id = SetOptionToDB(doc);

                return option;
            }
        }

        public CONDITION SetSumTrancheCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null ||
                condition.MinSumTranche == null ||
                condition.MinReplenishmentAmount == null ||
                condition.MaxReplenishmentAmount == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.TRANCHE_AMOUNT_SETTING.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.MinSumTranche = condition.MinSumTranche;
                    target.MaxSumTranche = condition.MaxSumTranche;
                    target.MinReplenishmentAmount = condition.MinReplenishmentAmount;
                    target.MaxReplenishmentAmount = condition.MaxReplenishmentAmount;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        MinSumTranche = condition.MinSumTranche,
                        MaxSumTranche = condition.MaxSumTranche,
                        MinReplenishmentAmount = condition.MinReplenishmentAmount,
                        MaxReplenishmentAmount = condition.MaxReplenishmentAmount
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }



        public TimeAddTranchesOption SetTimeAddTrancheOption(TimeAddTranchesOption option)
        {
            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null)
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {

                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.REPLENISHMENT_TRANCHE.KINDS.Kind.OPTIONS;


                //var optionTarget = xmlOptions.Option.FirstOrDefault();

                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.TRANCHE_AMOUNT_SETTING.KINDS.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,
                    });
                }

                string doc = Serialize<ROOT>(obj);

                option.Id = SetOptionToDB(doc);

                return option;
            }
        }

        public CONDITION SetTimeAddTrancheCondition(CONDITION condition)
        {
            if (condition.TranchTerm == null || condition.DaysToCloseReplenish == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.REPLENISHMENT_TRANCHE.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.TranchTerm = condition.TranchTerm;
                    target.DaysToCloseReplenish = condition.DaysToCloseReplenish;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        InterestOptionId = condition.InterestOptionId,
                        TranchTerm = condition.TranchTerm,
                        DaysToCloseReplenish = condition.DaysToCloseReplenish
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }

        public DepositDemandOption SetDepositDemandOption(DepositDemandOption option)
        {

            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOptionDemand());

                var xmlOptions = obj.DEPOSIT_ON_DEMAND.KINDS.Kind.OPTIONS;

                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.DEPOSIT_ON_DEMAND.KINDS.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,
                    });
                }

                string doc = Serialize<ROOT>(obj);

                option.Id = SetOptionToDBDemand(doc);

                return option;
            }

        }

        public CONDITION SetDepositDemandCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.CurrencyId == "0"
                || condition.AmountFrom == null
                || condition.InterestRate == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOptionDemand());


                var xmlOptions = obj.DEPOSIT_ON_DEMAND.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.AmountFrom = condition.AmountFrom;
                    target.InterestRate = condition.InterestRate;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        AmountFrom = condition.AmountFrom,
                        InterestRate = condition.InterestRate
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDBDemand(doc);

                return condition;
            }
        }

        public DepositOnDemandType SetDepositOnDemandCalcType(DepositOnDemandType option)
        {
            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOptionDemand());

                var xmlOptions = obj.DEPOSIT_ON_DEMAND_CALC.KINDS.Kind.OPTIONS;

                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.DEPOSIT_ON_DEMAND_CALC.KINDS.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.IsActive = option.IsActive;
                    xmlOption.CalculationTypeId = option.CalculationTypeId;
                    xmlOption.Id_ = option.Id_;
                    xmlOption.Id = option.Id;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Id_ = option.Id_,
                        CalculationTypeId = option.CalculationTypeId,
                        Conditions = null,
                    });
                }

                string doc = Serialize<ROOT>(obj);


                option.Id = SetOptionToDBDemand(doc);
                //  option.Id_ = SetOptionToDBDemand(doc);

                return option;
            }
        }


        public ReplenishmentOption SetReplenishmentOption(ReplenishmentOption option)
        {

            DateTime dateNow = DateTime.Now;
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {
                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());

                var xmlOptions = obj.REPLENISHMENT.KINDS.Kind.OPTIONS;

                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.REPLENISHMENT.KINDS.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,
                    });
                }

                string doc = Serialize<ROOT>(obj);

                option.Id = SetOptionToDB(doc);

                return option;

            }
        }

        public CONDITION SetReplenishmentCondition(CONDITION condition)
        {

            if (condition.CurrencyId == null || condition.InterestRate == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.REPLENISHMENT.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.InterestRate = condition.InterestRate;
                    target.IsReplenishment = condition.IsReplenishment;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        InterestRate = condition.InterestRate,
                        IsReplenishment = condition.IsReplenishment
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;

            }
        }


        public Option SetBlockRateOption(Option option)
        {
            DateTime dateNow = DateTime.Now; //текущая дата
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {

                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);

            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                //insert into obj new option
                var xmlOptions = obj.RATE_FOR_BLOCKED_TRANCHE.KINDS.Kind.OPTIONS;
                //check if options already exists
                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.RATE_FOR_BLOCKED_TRANCHE.KINDS.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,

                    });
                }


                //serialize
                string doc = Serialize<ROOT>(obj);


                //save xml to DB - get new id -> newOptionId
                option.Id = SetOptionToDB(doc);

                return option;
            }
        }
        public CONDITION SetBlockRateCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.InterestRate == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.RATE_FOR_BLOCKED_TRANCHE.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.InterestRate = condition.InterestRate;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        TermUnit = "1",
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        Currency = condition.Currency,
                        InterestRate = condition.InterestRate
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }

        public Option SetBonusProlongationOption(Option option)
        {
            DateTime dateNow = DateTime.Now; //текущая дата
            string dateStringNow = dateNow.ToString("yyyy-MM-dd");
            DateTime dateMinusDays = dateNow.AddDays(-4); // по заявке COBUDPUMMSB-317 будем проверять по диапазону текущая_дата минус 4 дня
            string dateStringMinus = dateMinusDays.ToString("yyyy-MM-dd");


            if (option.ValidFrom == null || option.ValidThough != null && (DateTime.Parse(option.ValidFrom) > DateTime.Parse(option.ValidThough) || DateTime.Parse(option.ValidFrom) == DateTime.Parse(option.ValidThough)))
            {
                string text = "Дати вказані невірно";

                throw new Exception(text);
            }
            else if (DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringNow) && DateTime.Parse(option.ValidFrom) != DateTime.Parse(dateStringMinus) && (DateTime.Parse(option.ValidFrom) < DateTime.Parse(dateStringMinus)))
            {

                string text = "Дата початку не повинна бути раніше, ніж 4 дні від поточної дати";

                throw new Exception(text);

            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                //insert into obj new option
                var xmlOptions = obj.PROLONGATION_BONUS.KINDS.Kind.OPTIONS;
                //check if options already exists
                if (xmlOptions == null)
                {
                    xmlOptions = new OPTIONS();
                    obj.PROLONGATION_BONUS.KINDS.Kind.OPTIONS = xmlOptions;
                }

                if (!string.IsNullOrEmpty(option.Id))
                {
                    var xmlOption = xmlOptions.Option.FirstOrDefault(c => c.Id == option.Id);
                    xmlOption.ValidFrom = option.ValidFrom;
                    xmlOption.ValidThrough = option.ValidThough;
                    xmlOption.IsActive = option.IsActive;
                }
                else
                {
                    xmlOptions.Option.Add(new OPTION()
                    {
                        ValidFrom = option.ValidFrom,
                        ValidThrough = option.ValidThough,
                        IsActive = option.IsActive,
                        SysTime = option.SysTime,
                        UserId = option.UserId,
                        Id = option.Id,
                        Conditions = null,

                    });
                }


                //serialize
                string doc = Serialize<ROOT>(obj);


                //save xml to DB - get new id -> newOptionId
                option.Id = SetOptionToDB(doc);

                return option;
            }
        }
        public CONDITION SetBonusProlongationCondition(CONDITION condition)
        {
            if (condition.CurrencyId == null || condition.InterestRate == null || condition.IsProlongation == null)
            {
                string text = "Умови дії вказані невірно";

                throw new Exception(text);
            }
            else
            {
                ROOT obj = Deserialize<ROOT>(GetOption());


                var xmlOptions = obj.PROLONGATION_BONUS.KINDS.Kind.OPTIONS;


                var optionTarget = xmlOptions.Option.Where(opt => opt.Id == condition.InterestOptionId).FirstOrDefault();


                if (optionTarget.Conditions == null)
                {
                    optionTarget.Conditions = new CONDITIONS();
                    optionTarget.Conditions.Condition = new List<CONDITION>();
                }

                if (!string.IsNullOrEmpty(condition.Id))
                {
                    var target = optionTarget.Conditions.Condition.FirstOrDefault(c => c.Id == condition.Id);
                    target.CurrencyId = condition.CurrencyId;
                    target.InterestRate = condition.InterestRate;
                    target.IsProlongation = condition.IsProlongation;
                }
                else
                {
                    optionTarget.Conditions.Condition.Add(new CONDITION
                    {
                        Id = condition.Id,
                        TermUnit = "1",
                        InterestOptionId = condition.InterestOptionId,
                        CurrencyId = condition.CurrencyId,
                        Currency = condition.Currency,
                        InterestRate = condition.InterestRate,
                        IsProlongation = condition.IsProlongation                   
                    });
                }

                string doc = Serialize<ROOT>(obj);

                SetOptionToDB(doc);

                return condition;
            }
        }
        public string Serialize<T>(object details)
        {
            XmlSerializer serializer = new XmlSerializer(typeof(T));
            using (StringWriter writer = new StringWriter())
            {
                serializer.Serialize(writer, details);
                return writer.ToString();
            }
        }

        public T Deserialize<T>(string str)
        {
            XmlSerializer serializer = new XmlSerializer(typeof(T));

            using (MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(str)))
            using (StreamReader reader = new StreamReader(ms))
            {
                return (T)serializer.Deserialize(reader);
            }
        }

        public string GetNewTranche()
        {
            string sql_query = @"select smb_deposit_ui.get_tanche_xml_data(null) xml_tranche from dual";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql_query).SingleOrDefault();
            }

        }

        public string GetTrancheFromDB(string processId)
        {
            string sql_query = @"select smb_deposit_ui.get_tanche_xml_data(:procces_id) xml_tranche from dual";

            var sqlParams = new object[]
               {
                    new OracleParameter("procces_id", OracleDbType.Decimal){ Value = processId },
               };
            return _GDA.ExecuteStoreQuery<string>(sql_query, sqlParams).FirstOrDefault();
        }

        //public SMBDepositTranche GetReplacementTrancheR(SMBDepositTranche o,string processId)
        //{
        //    SMBDepositTranche tran = Deserialize<SMBDepositTranche>(GetTrancheFromDB(processId));

        //    o.ProcessId = processId;
        //    o.AmountTranche = tran.AmountTranche;
        //    o.Branch = tran.Branch;
        //    o.Comment = tran.Comment;
        //    o.CurrencyId = tran.CurrencyId;
        //    o.CustomerId = tran.CustomerId;
        //    o.DebitAccount = tran.DebitAccount;
        //    o.ExpiryDate = tran.ExpiryDate;
        //    o.FrequencyPayment = tran.FrequencyPayment;
        //    o.IndividualInterestRate = tran.IndividualInterestRate;
        //    o.InterestAccount = tran.InterestAccount;
        //    o.InterestRate = tran.InterestRate;
        //    o.InterestRateProlongation = tran.InterestRateProlongation;
        //    o.IsCapitalization = tran.IsCapitalization;
        //    o.IsIndividualRate = tran.IsIndividualRate;
        //    o.IsProlongation = tran.IsProlongation;
        //    o.IsReplenishmentTranche = tran.IsReplenishmentTranche;
        //    o.LastReplenishmentDate = tran.LastReplenishmentDate;
        //    o.MaxSumTranche = tran.MaxSumTranche;
        //    o.MinReplenishmentAmount = tran.MinReplenishmentAmount;
        //    o.NumberProlongation = tran.NumberProlongation;
        //    o.NumberTrancheDays = tran.NumberTrancheDays;
        //    o.ObjectId = tran.ObjectId;
        //    o.PrimaryAccount = tran.PrimaryAccount;
        //    o.ProcessId = tran.ProcessId;
        //    o.ReturnAccount = tran.ReturnAccount;
        //    o.StartDate = tran.StartDate;

        //    return o;
        //}

        public SMBDepositTranche SetReplacementTranche(SMBDepositTranche o)
        {

            string doc = Serialize<SMBDepositTranche>(o);
            SetTrancheToDB(o.ProcessId, doc);
            return o;
        }


        public SMBDepositTranche SetNewTranche(SMBDepositTranche o)
        {

            SMBDepositTranche tran = Deserialize<SMBDepositTranche>(GetNewTranche());

            tran.AmountTranche = o.AmountTranche;
            tran.Branch = o.Branch;
            tran.Comment = o.Comment;
            tran.CurrencyId = o.CurrencyId;
            tran.CustomerId = o.CustomerId;
            tran.DebitAccount = o.DebitAccount;
            tran.ExpiryDate = o.ExpiryDate;
            tran.FrequencyPayment = o.FrequencyPayment;
            tran.IndividualInterestRate = o.IndividualInterestRate;
            tran.InterestAccount = o.InterestAccount;
            tran.InterestRate = o.InterestRate;
            tran.InterestRateProlongation = o.InterestRateProlongation;
            tran.IsCapitalization = o.IsCapitalization;
            tran.IsIndividualRate = o.IsIndividualRate;
            tran.IsProlongation = o.IsProlongation;
            tran.IsReplenishmentTranche = o.IsReplenishmentTranche;
            tran.LastReplenishmentDate = o.LastReplenishmentDate;
            tran.MaxSumTranche = o.MaxSumTranche;
            tran.MinReplenishmentAmount = o.MinReplenishmentAmount;
            tran.NumberProlongation = o.NumberProlongation;
            tran.NumberTrancheDays = o.NumberTrancheDays;
            tran.ObjectId = o.ObjectId;
            tran.PrimaryAccount = o.PrimaryAccount;
            tran.ProcessId = o.ProcessId;
            tran.ReturnAccount = o.ReturnAccount;
            tran.StartDate = o.StartDate;



            string doc = Serialize<SMBDepositTranche>(tran);
            tran.ProcessId = SetTrancheToDB(o.ProcessId, doc);
            return o;
        }

        public string SetTrancheToDB(string processId, string xml)
        {

            var SqlParams = new object[]
            {
                new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,},
                new OracleParameter("p_data",OracleDbType.Clob) {Value = xml,Direction=ParameterDirection.Input}
            };

            _GDA.Connection.Open();
            var t = _GDA.Connection.BeginTransaction();

            string SqlText = @"begin
                            smb_deposit_ui.cor_tranche(:p_process_id,:p_data);
                            end;";
            try
            {
                _GDA.ExecuteStoreCommand(SqlText, SqlParams);
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();

            return Convert.ToString(((OracleParameter)SqlParams[0]).Value);
        }


        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _GDA.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _GDA.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _GDA.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _GDA.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }

        #endregion

        public IQueryable<BackProcessTrancheInfo> GetBackProcessTrancheList(DataSourceRequest request)
        {
            _getSql = new BarsSql()
            {
                SqlText = @"select * from v_smb_deposit_process where process_state_code in ('RUNNING', 'DONE', 'FAILED') order by SYS_TIME desc",
                SqlParams = new object[] { }
            };
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            IQueryable<BackProcessTrancheInfo> result = _GDA.ExecuteStoreQuery<BackProcessTrancheInfo>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public decimal GetBackProcessTrancheCount(DataSourceRequest request)
        {
            _getSql = new BarsSql()
            {
                SqlText = @"select * from v_smb_deposit_process where process_state_code in ('RUNNING', 'DONE', 'FAILED') order by SYS_TIME desc",
                SqlParams = new object[] { }
            };
            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            decimal result = _GDA.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        public List<BackHistoryTrancheInfo> GetBackHistory()
        {
            string sql_query = @"select * from v_smb_process_detail order by sys_time desc";
            List<BackHistoryTrancheInfo> list = new List<BackHistoryTrancheInfo>();

            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<BackHistoryTrancheInfo>(sql_query).ToList();
            }
            return list;
        }

        public List<BackHistoryTrancheInfo> GetBackTrancheHistory(string trancheId)
        {
            string sql_query = @"select * from v_smb_process_detail where deposit_id = " + trancheId + " order by sys_time desc";
            List<BackHistoryTrancheInfo> list = new List<BackHistoryTrancheInfo>();

            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<BackHistoryTrancheInfo>(sql_query).ToList();
            }
            return list;
        }

        public string GetKf()
        {
            string Kf = string.Empty;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.Parameters.Clear();
                    cmd.CommandText = "SELECT sys_context('bars_context', 'user_mfo') FROM dual";
                    cmd.CommandType = System.Data.CommandType.Text;
                    return Convert.ToString(cmd.ExecuteScalar());
                }
            }
        }

    }
}
