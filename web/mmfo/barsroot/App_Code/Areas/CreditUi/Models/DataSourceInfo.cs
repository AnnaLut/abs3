using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

/// <summary>
/// Summary description for DataSourceInfo
/// </summary>
namespace BarsWeb.Areas.CreditUi.Models
{
    public class DataSourceInfo
    {
        public List<KeyValuePair<int, string>> Currency { get; set; }
        public List<KeyValuePair<int, string>> FinStan { get; set; }
        public List<KeyValuePair<int, string>> StanObs { get; set; }
        public List<KeyValuePair<int, string>> Sour { get; set; }
        public List<KeyValuePair<int, string>> Basey { get; set; }
        public List<KeyValuePair<int, string>> Freq { get; set; }
        public List<KeyValuePair<int, string>> Metr { get; set; }
        public List<KeyValuePair<int, string>> Daynp { get; set; }
        public List<KeyValuePair<int, string>> Poci { get; set; }
        public List<KeyValuePair<int, string>> Sppi { get; set; }
        public List<CRiskList> Crisk { get; set; }

        public DataSourceInfo()
        {
            Currency = new List<KeyValuePair<int, string>>();
            FinStan = new List<KeyValuePair<int, string>>();
            StanObs = new List<KeyValuePair<int, string>>();
            Sour = new List<KeyValuePair<int, string>>();
            Basey = new List<KeyValuePair<int, string>>();
            Freq = new List<KeyValuePair<int, string>>();
            Metr = new List<KeyValuePair<int, string>>();
            Daynp = new List<KeyValuePair<int, string>>();
            Poci = new List<KeyValuePair<int, string>>();
            Sppi = new List<KeyValuePair<int, string>>();

            Crisk = new List<CRiskList>();
        }

        public void SetObjectProperty(string propertyName, Dictionary<int, string> value)
        {
            PropertyInfo propertyInfo = this.GetType().GetProperty(propertyName);
            if (propertyInfo != null)
                propertyInfo.SetValue(this, value.ToList(), null);
        }

        public static string GetMemberName<TValue>(Expression<Func<TValue>> memberAccess)
        {
            return ((MemberExpression)memberAccess.Body).Member.Name;
        }
    }
}