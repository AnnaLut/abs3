using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Globalization;
using System.Linq;
using System.Text;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using System.Data;
using System.IO;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepRequestipsRepository: ISepRequestipsRepository 
    {
        private readonly SepFiles _entities;
        private bool _isWhereAdded = false;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        private readonly IBankDatesRepository _bankDateRepository;
       
        private BarsSql _baseSepDocsSql;

        public SepRequestipsRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IBankDatesRepository bankDateRepository)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _bankDateRepository = bankDateRepository;
        }

        public IQueryable<IPS_RRP> GetRequestips(SepRequestipsFilterParams fp, DataSourceRequest request)
        {
            var result = (from r in _entities.IPS_RRP
                          orderby r.DAT_QB, r.FN_QB, r.REC_QB
                          select r).AsQueryable();
            //var result = _entities.IPS_RRP.OrderBy(x => x.DAT_QB).
            //ThenBy(x => x.FN_QB).ThenBy(x => x.REC_QB).AsQueryable();
            return result;
        }

        public string GetGlobalOptionParam()
        {
            var result =  
            _entities.ExecuteStoreQuery<string>(@" select GetGlobalOption('Name') from dual", null).FirstOrDefault();
            return result.ToString();
        }

        public StreamWriter WriteFile(SepRequestipsFilterParams fp, StreamWriter writer)
        {
            string FN_QB = fp.FN_QB;
            string bankName = GetGlobalOptionParam();
            var requestips = GetRequestips(fp, null)
                .Where(x => x.FN_QA == fp.FN_QA && x.FN_QB == fp.FN_QB
                       && x.NLSA == fp.NLSA && x.NLSB == fp.NLSB).First();
            var IPS_RRP = _entities.IPS_RRP.Where(x => x.FN_QB == FN_QB).ToList();

                writer.WriteLine("|------------------------------------------------------------------------------------------------|");
                writer.WriteLine("| ЦРП                                           " + bankName);
                writer.WriteLine("| Дата відповіді  " + requestips.DAT_QB.Value.ToString(" dd.MM.yy ").Replace(".", "/") + " (ДД/ММ/РР ) "
                                   + "                                       МФО " + requestips.MFOA + "      |");
                writer.WriteLine("|------------------------------------------------------------------------------------------------|");
                writer.WriteLine("| На Ваш запит, надісланий у файлі " + fp.FN_QA + ", надаємо інформацію");
                writer.WriteLine("| щодо проходження електронного платіжного документу в СЕП НБУ: ");
                writer.WriteLine("|                                                                                                |");
                writer.WriteLine("|   Дата        МФО           Рахунок         МФО           Рахунок       Д     Сума платежу");
                writer.WriteLine("|   платежу    банку А       в банку А       банку Б       в банку Б      К      в копійках");
                writer.WriteLine("  " + requestips.DAT_SEP.ToString("dd/MM/yy").Replace(".", "/") + "     " +
                                      requestips.MFOA + "        " +
                                      requestips.NLSA + "   " +
                                      requestips.MFOB + "      " +
                                      requestips.NLSB + "  " +
                                      requestips.DK + "        " +
                                      requestips.S + "");

                writer.WriteLine("|------------------------------------------------------------------------------------------------|");
                writer.WriteLine("| Ім'я          Час            Час             Ім'я                Час            Час зараху- ");
                writer.WriteLine("| файлу         виготовлення   отримання       файлу               виготовлення   вання на    ");
                writer.WriteLine("| джерела       файлу          файлу           одержувача          файлу          коррахунок  ");
                writer.WriteLine("|                                                                                                |");
                int j = 1;
                foreach (var i in IPS_RRP)
                {
                    writer.WriteLine(
                        "" + j.ToString() + "."
                        + i.FN_A + " "
                        + (i.DAT_A.HasValue ? i.DAT_A.Value.ToString("HH:mm") +" "+ i.DAT_A.Value.ToString("dd/MM/yy").Replace(".", "/") : "              ") + "  "

                        + (i.DAT_PA.HasValue ? i.DAT_PA.Value.ToString("HH:mm") + " " + i.DAT_PA.Value.ToString("dd/MM/yy").Replace(".", "/") : "              ") + "  "

                        + i.FN_B + "     "
                        + (i.DAT_B.HasValue ? i.DAT_B.Value.ToString("HH:mm") + " " + i.DAT_B.Value.ToString("dd/MM/yy").Replace(".", "/") : "              ") + "  "

                        + (i.DAT_PB.HasValue ? i.DAT_PB.Value.ToString("HH:mm") + " " + i.DAT_PB.Value.ToString("dd/MM/yy").Replace(".", "/") : "              ") + "  ");
                    j++;
                }
                writer.WriteLine("|                                                                                                |");
                writer.WriteLine("|                                                                                                |");
                writer.WriteLine("-------------------------------------------------------------------------------------------------");

                return writer;
        }

        public FileInfo GetFileContent(SepRequestipsFilterParams fp)
        {
            
            string FN_QB = fp.FN_QB;
            string bankName = GetGlobalOptionParam();
            var requestips = GetRequestips(fp, null).Where(x=>x.FN_QA == fp.FN_QA).First();
            var IPS_RRP = _entities.IPS_RRP.Where(x => x.FN_QB == FN_QB).ToList();
            FileInfo info = new FileInfo(@"C:\Windows\System32\inetsrv\" + fp.FN_QA.Replace("$", "Р").Replace(".", ""));
             
            if (info.Exists)
            {
               
                using (StreamWriter writer = info.CreateText())
                {
                    writer.WriteLine("-----------------------------------------------------------------------------------------");
                    writer.WriteLine("| ЦРП                                           " + bankName);
                    writer.WriteLine("| Дата відповіді  "+ requestips.DAT_QB.Value.ToString(" dd.MM.yy ").Replace(".", "/") + " (ДД/ММ/РР ) "
                                       + "                                       МФО " + requestips.MFOA+ "|");
                    writer.WriteLine("|---------------------------------------------------------------------------------------|");
                    writer.WriteLine("| На Ваш запит, надісланий у файлі " + fp.FN_QA + ", надаємо інформацію");
                    writer.WriteLine("| щодо проходження електронного платіжного документу в СЕП НБУ: ");
                    writer.WriteLine("|                                                                                       |");
                    writer.WriteLine("|   Дата        МФО           Рахунок     МФО           Рахунок    Д     Сума платежу");
                    writer.WriteLine("|   платежу    банку А       в банку А   банку Б       в банку Б   К      в копійках");
                    writer.WriteLine("    " + requestips.DAT_SEP.ToString("dd/MM/yy").Replace(".", "/") + "     " +
                                          requestips.MFOA + "        " +
                                          requestips.NLSA + "  " +
                                          requestips.MFOB + "  " +
                                          requestips.NLSB + "  " +
                                          requestips.DK + "        " +
                                          requestips.S    +"");

                    writer.WriteLine("|---------------------------------------------------------------------------------------|");
                    writer.WriteLine("| Ім'я          Час            Час             Ім'я                Час            Час зараху- ");
                    writer.WriteLine("| файлу         виготовлення   отримання       файлу               виготовлення   вання на    ");
                    writer.WriteLine("| джерела       файлу          файлу           одержувача          файлу          коррахунок  ");
                    writer.WriteLine("|                                                                                       |");
                    int j = 1;
                    foreach (var i in IPS_RRP)
                    {
                        writer.WriteLine(
                            "" + j.ToString() + "."
                            + i.FN_A + " "
                            + (i.DAT_A.HasValue ? i.DAT_A.Value.ToString("HH:MM dd/MM/yy").Replace(".", "/") : "              ") + "  "

                            + (i.DAT_PA.HasValue ? i.DAT_PA.Value.ToString("HH:MM dd/MM/yy").Replace(".", "/") : "              ") + "  "

                            + i.FN_B + "     "
                            + (i.DAT_B.HasValue ? i.DAT_B.Value.ToString("HH:MM dd/MM/yy").Replace(".", "/") : "              ") + "  "

                            + (i.DAT_PB.HasValue ? i.DAT_PB.Value.ToString("HH:MM dd/MM/yy").Replace(".", "/") : "              ") + "  ");
                        j++;
                    }
                    writer.WriteLine("|                                                                                       |");
                    writer.WriteLine("|                                                                                       |");
                    writer.WriteLine("-----------------------------------------------------------------------------------------");
               
                }
            } 
            return info;
        }
 
    }
}