using System;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using Bars.Classes;

namespace Bars.WebServices.XRM.Services
{
    public static class RuTailExts
    {
        #region mmfo
        private static Dictionary<string, int> _kfru = null;
        private static int Kfru(string _mfo)
        {
            if (_kfru == null)
                _kfru = new Dictionary<string, int>();

            if (_kfru.Count == 0)
            {
                using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
                using (OracleCommand command = con.CreateCommand())
                {
                    command.CommandText = "select kf, to_number(ru) ru from kf_ru";
                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            int kfIndex = reader.GetOrdinal("KF");
                            int ruIndex = reader.GetOrdinal("RU");

                            while (reader.Read())
                                _kfru[reader.GetString(kfIndex)] = reader.GetInt32(ruIndex);
                        }
                    }
                }
            }

            if (_kfru.ContainsKey(_mfo))
                return _kfru[_mfo];

            return 0;
        }

        #region add tail
        public static long? AddRuTail(this long? val, string mfo)
        {
            if (null == val) return null;
            return val * 100 + Kfru(mfo);
        }
        public static long AddRuTail(this long val, string mfo)
        {
            return val * 100 + Kfru(mfo);
        }
        public static decimal? AddRuTail(this decimal? val, string mfo)
        {
            if (null == val) return null;
            return val * 100 + Kfru(mfo);
        }
        public static decimal AddRuTail(this decimal val, string mfo)
        {
            return val * 100 + Kfru(mfo);
        }
        public static int? AddRuTail(this int? val, string mfo)
        {
            if (null == val) return null;
            return val * 100 + Kfru(mfo);
        }
        public static int AddRuTail(this int val, string mfo)
        {
            return val * 100 + Kfru(mfo);
        }
        public static string AddRuTail(this string val, string mfo)
        {
            if (string.IsNullOrWhiteSpace(val)) return val;
            return val + Kfru(mfo).ToString();
        }
        #endregion

        #region cut tail
        private static decimal CutTail(object val)
        {
            if (val == null) return 0;
            return Math.Truncate((decimal)val / 100);
        }

        public static decimal CutRuTail(this decimal? val)
        {
            return CutTail(val);
        }
        public static decimal CutRuTail(this decimal val)
        {
            return CutTail(val);
        }
        public static long CutRuTail(this long? val)
        {
            return (long)CutTail(val);
        }
        public static long CutRuTail(this long val)
        {
            return (long)CutTail(val);
        }
        public static int CutRuTail(this int? val)
        {
            return (int)CutTail(val);
        }
        public static int CutRuTail(this int val)
        {
            return (int)CutTail(val);
        }
        public static string CutRuTail(this string val)
        {
            if (string.IsNullOrWhiteSpace(val) || val.Length <= 2) return val;
            return val.Substring(0, val.Length - 2);
        }
        #endregion
        #endregion

        #region ru
        //#region add tail
        //public static long AddRuTail(this long? val, string mfo)
        //{
        //    return null == val ? 0 : (long)val;
        //}
        //public static long AddRuTail(this long val, string mfo)
        //{
        //    return val;
        //}
        //public static decimal AddRuTail(this decimal? val, string mfo)
        //{
        //    return null == val ? 0 : (decimal)val;
        //}
        //public static decimal AddRuTail(this decimal val, string mfo)
        //{
        //    return val;
        //}
        //public static int AddRuTail(this int? val, string mfo)
        //{
        //    return null == val ? 0 : (int)val;
        //}
        //public static int AddRuTail(this int val, string mfo)
        //{
        //    return val;
        //}
        //public static string AddRuTail(this string val, string mfo)
        //{
        //    return null == val ? "" : val;
        //}
        //#endregion

        //#region cut tail
        //public static decimal CutRuTail(this decimal? val)
        //{
        //    return null == val ? 0 : (decimal)val;
        //}
        //public static decimal CutRuTail(this decimal val)
        //{
        //    return val;
        //}
        //public static long CutRuTail(this long? val)
        //{
        //    return null == val ? 0 : (long)val;
        //}
        //public static long CutRuTail(this long val)
        //{
        //    return val;
        //}
        //public static int CutRuTail(this int? val)
        //{
        //    return null == val ? 0 : (int)val;
        //}
        //public static int CutRuTail(this int val)
        //{
        //    return val;
        //}
        //public static string CutRuTail(this string val)
        //{
        //    return val;
        //}
        //#endregion
        #endregion
    }
}


