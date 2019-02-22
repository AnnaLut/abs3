using System;
using System.Collections.Generic;

namespace Areas.Finmom.Models
{
    public class ExcelExportModel
    {
        public ExcelExportModel()
        {
            Fields = new Dictionary<string, string>();

            Fields.Add("Ref", "Референс");
            Fields.Add("TT", "Операція");
            Fields.Add("StatusName", "Статус");
            Fields.Add("ND", "Номер док.");
            Fields.Add("DateD", "Дата док.");
            Fields.Add("NlsA", "Рахунок-А");
            Fields.Add("MfoA", "МФО-А");
            Fields.Add("NlsB", "Рахунок-Б");
            Fields.Add("MfoB", "МФО-Б");

            Fields.Add("Sum", "Сума");
            Fields.Add("SumEquivalent", "Сума док. (екв.)");
            Fields.Add("Sum2", "Сума-Б");
            Fields.Add("SumEquivalent2", "Сума-Б (екв.)");

            Fields.Add("Lcv", "Вал.-А");
            Fields.Add("Lcv2", "Вал.-Б");
            Fields.Add("OprVid2", "Ознака ОМ");
            Fields.Add("NameA", "Клієнт-А");
            Fields.Add("NameB", "Клієнт-Б");
            Fields.Add("OTM", "№ особи в переліку осіб");

            Fields.Add("Comments", "Коментар");
            Fields.Add("Dk", "Д/К");
            Fields.Add("Sk", "СКП");
            Fields.Add("VDate", "Дата валют.");
            Fields.Add("Nazn", "Призначення");
            Fields.Add("Tobo", "Відділення");
            Fields.Add("OprVid3", "Ознака ВМ");
            Fields.Add("Fio", "Повідомив");

            Fields.Add("InDate", "Дата реєстрації");
            Fields.Add("Fv2Agg", "Додаткові коди ОМ");

            Fields.Add("Rules", "Правила ФМ");            

        }
        public Dictionary<string, string> Fields { get; set; }
        //DataTable ds = view.ToTable(true, "REF", "TT", "ND", "DATD", "NLSA", "Sum", "SumEquivalent", "LCV", "MFOA", "DK", "NLSB", "Sum2", "SumEquivalent2", "LCV2", "MFOB", "SK", "VDAT", "NAZN", "STATUS",
        //    "OTM", "TOBO", "OprVid2", "OprVid3", "FIO", "IN_DATE", "COMMENTS", "STATUS_NAME", "NameA", "NameB", "SOS", "Fv2Agg");
    }
}