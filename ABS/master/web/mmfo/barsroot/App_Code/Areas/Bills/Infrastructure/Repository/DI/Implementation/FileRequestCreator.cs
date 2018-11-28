using Bars.Classes;
using BarsWeb.Areas.FastReport.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Infrastructure.DI.Implementation
{
    /// <summary>
    /// Объявление моделей для формирования файлов
    /// </summary>
    public class FileRequestCreator
    {
        public static FastReportModel SwitchReportModel(String reportType, Int32 id)
        {
            switch (reportType.ToLower())
            {
                case "acceptancereceiverfrombank":
                    return GetAcceptanceReceiverFromBank(id);
                case "registerpayments":
                    return GetRegisterPayments(id);
                case "act":
                    return GetAct(id);
                case "paymentinfo":
                    return GetPayBillInfo(id);
                case "billscount":
                    return GetBillsCount(id);
                case "actexchveks":
                    return GetActDksu();
                case "actexchveks_161":
                    return GetActCa();
                case "agentact":
                    return GetBillAgentAct(id);
                case "veks_collktr_bag_162":
                    return GetBagActCa();
                case "veks_collktr_bag_160":
                    return GetBagActDksu();
                case "extractpreview":
                    return GetExtractPreView();
                default:
                    return null;
            }
        }

        /// <summary>
        /// Акт приема передачи векселей (от банка к взыскателю)
        /// </summary>
        /// <param name="id">ExpectedId - ИД ожидаемого векселедержателя</param>
        /// <returns></returns>
        public static FastReportModel GetAcceptanceReceiverFromBank(Int32 id)
        {
            return new FastReportModel()
            {
                FileName = "akt_6_9.frx",
                Parameters = new FrxParameters { new FrxParameter("exp_id", TypeCode.Int32, id) },
                ResponseFileType = FrxExportTypes.Pdf
            };
        }

        /// <summary>
        /// Заявление на выплату векселей
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static FastReportModel GetAct(Int32 id)
        {
            return new FastReportModel()
            {
                FileName = "rep_6_17.frx",
                Parameters = new FrxParameters { new FrxParameter("exp_id", TypeCode.Int32, id) },
                ResponseFileType = FrxExportTypes.Pdf
            };
        }

        /// <summary>
        /// Інформація про строки та обсяги сплати за фінансовими казначейськими векселями
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static FastReportModel GetPayBillInfo(Int32 id)
        {
            return new FastReportModel
            {
                FileName = "PayVeks.frx",
                Parameters = new FrxParameters { new FrxParameter("extract_number_id", TypeCode.Int32, id) },
                ResponseFileType = FrxExportTypes.Pdf
            };
        }

        /// <summary>
        /// Реєстр виплат за рішеннями судів
        /// </summary>
        /// <param name="id">ИД выдержки (витягу)</param>
        /// <returns></returns>
        public static FastReportModel GetRegisterPayments(Int32 id)
        {
            return new FastReportModel
            {
                FileName = "rep_6_1.frx",
                ResponseFileType = FrxExportTypes.Pdf,
                Parameters = new FrxParameters { new FrxParameter("extract_number_id", TypeCode.Int32, id) }
            };
        }

        /// <summary>
        /// Звіт про кількість виданих фінансових казначейських векселів
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static FastReportModel GetBillsCount(Int32 id)
        {
            return new FastReportModel
            {
                FileName = "GivVeksCount.frx",
                ResponseFileType = FrxExportTypes.Pdf,
                Parameters = new FrxParameters { new FrxParameter("extract_number_id", TypeCode.Int32, id) }
            };
        }

        /// <summary>
        /// АКТ приймання – передачі наданих послуг з виконання функцій генерального агента
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static FastReportModel GetBillAgentAct(Int32 id)
        {
            return new FastReportModel
            {
                FileName = "BillAgentACT.frx",
                ResponseFileType = FrxExportTypes.Pdf,
                Parameters = new FrxParameters { new FrxParameter("extract_number_id", TypeCode.Int32, id) }
            };
        }

        /// <summary>
        /// Предпоказ отправки выдержки
        /// </summary>
        /// <returns></returns>
        public static FastReportModel GetExtractPreView()
        {
            return new FastReportModel
            {
                FileName = "veks_before_transfer.frx",
                ResponseFileType = FrxExportTypes.Pdf,
                Parameters = new FrxParameters { }
            };
        }

        /// <summary>
        /// Акт приема-передачи от дксу
        /// </summary>
        /// <returns></returns>
        public static FastReportModel GetActDksu()
        {
            return new FastReportModel()
            {
                FileName = "ActExchVeks.frx",
                ResponseFileType = FrxExportTypes.Pdf
            };
        }

        /// <summary>
        /// Акт приема-передачи от ца
        /// </summary>
        /// <returns></returns>
        public static FastReportModel GetActCa()
        {
            return new FastReportModel()
            {
                FileName = "ActExchVeks_161.frx",
                ResponseFileType = FrxExportTypes.Pdf
            };
        }

        /// <summary>
        /// Акт приймання-здавання опломбованих інкасаторських сумок від ЦА
        /// </summary>
        /// <returns></returns>
        public static FastReportModel GetBagActCa()
        {
            string mfo = "";
            int branch = 0;
            using (var connection = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = connection.CreateCommand())
            {
                cmd.CommandText = "select sys_context('bars_context','user_mfo') as NAME from dual";
                mfo = Convert.ToString(cmd.ExecuteScalar());
                branch = Convert.ToInt32(mfo);
                Int32.TryParse(mfo, out branch);
            }

            return new FastReportModel()
            {
                FileName = "veks_collktr_bag_162.frx",
                ResponseFileType = FrxExportTypes.Pdf,
                Parameters = new FrxParameters { new FrxParameter("branch", TypeCode.Int32, branch) }
            };
        }

        /// <summary>
        /// Акт приймання-здавання опломбованих інкасаторських сумок від ДКСУ
        /// </summary>
        /// <returns></returns>
        public static FastReportModel GetBagActDksu()
        {
            return new FastReportModel()
            {
                FileName = "veks_collktr_bag_160.frx",
                ResponseFileType = FrxExportTypes.Pdf
            };
        }

        /// <summary>
        /// для формы "передача векселей на регіони"
        /// </summary>
        /// <param name="branch"></param>
        /// <param name="reportType">
        /// acttransfer - Акт приема-передачи векселей,
        /// actbags - Акт опломбированных сумок
        /// </param>
        /// <returns></returns>
        public static FastReportModel GetActTtansferToRegion(String branch, String reportType)
        {
            String filename = reportType.ToLower() == "acttransfer" ? "Veks_fomCA_toReg_.frx" : "collktr_bag_before_region.frx";
            return new FastReportModel
            {
                FileName = filename,
                Parameters = new FrxParameters { new FrxParameter("branch", TypeCode.String, branch) },
                ResponseFileType = FrxExportTypes.Pdf
            };
        }
    }
}