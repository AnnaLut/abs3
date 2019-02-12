using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace Areas.Finmom.Models
{
    /// <summary>
    /// Класс для роботи з 15-тизначним кодом виду фінансової операції
    /// </summary>
    public class CodeType
    {
        public CodeType()
        {
            Calculation = new Code("a");
            Asset = new Code("b");
            Location = new Code("c");
            Object = new Code("d");
            OpenCloseAcc = new OpenCloseAcc("e");
        }

        /// <param name="strData">15-тизначний код виду фінансової операції</param>
        public CodeType(string strData)
        {
            if (string.IsNullOrWhiteSpace(strData) || strData.Length != 15 || !IsDigitsOnly(strData))
                throw new ArgumentException("Parameter strData has some wrond value (15 digit string is expected)");

            Calculation = new Code(strData.Substring(0, 1), strData.Substring(1, 1), "a");
            Asset = new Code(strData.Substring(2, 1), strData.Substring(3, 1), "b");
            Location = new Code(strData.Substring(4, 1), strData.Substring(5, 1), "c");
            Object = new Code(strData.Substring(6, 4), strData.Substring(10, 4), "d");
            OpenCloseAcc = new OpenCloseAcc(strData.Substring(14, 1), "e");

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                Calculation.SetName(con);
                Asset.SetName(con);
                Location.SetName(con);
                Object.SetName(con);
                OpenCloseAcc.SetName(con);
            }
        }

        public OpenCloseAcc OpenCloseAcc { get; set; }
        public Code Calculation { get; set; }
        public Code Asset { get; set; }
        public Code Location { get; set; }
        public Code Object { get; set; }

        private bool IsDigitsOnly(string str)
        {
            foreach (char c in str)
            {
                if (c < '0' || c > '9')
                    return false;
            }

            return true;
        }
    }

    public class Code
    {
        /// <param name="symbol">Параметри зберігаються в довідниках k_dfm01 + symbol</param>
        public Code(string symbol)
        {
            dictSymbol = symbol;
        }
        public Code(string provided, string received, string symbol) : this(symbol)
        {
            Provided = new CodeValue();
            Received = new CodeValue();

            Provided.Code = provided;
            Received.Code = received;
        }
        public CodeValue Provided { get; set; }
        public CodeValue Received { get; set; }
        private string dictSymbol { get; set; }

        /// <summary>
        /// Отримуєм назву параметру з бази даних і в інстансі поточного об'єкта проставляємо ім'я
        /// </summary>
        public void SetName(OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                object res;
                cmd.CommandText = string.Format("select name from k_dfm01{0} where (d_close is null or d_close > sysdate) and code = :p_code", dictSymbol);
                cmd.Parameters.Add(new OracleParameter("p_code", OracleDbType.Decimal, Provided.Code, ParameterDirection.Input));
                res = cmd.ExecuteScalar();
                Provided.Name = Convert.ToString(res);

                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("p_code", OracleDbType.Decimal, Received.Code, ParameterDirection.Input));
                res = cmd.ExecuteScalar();
                Received.Name = Convert.ToString(res);
            }
        }
    }

    /// <summary>
    /// Класс для параметра "Відкриття або закриття рахунку"
    /// </summary>
    public class OpenCloseAcc : CodeValue
    {
        /// <param name="symbol">Параметри зберігаються в довідниках k_dfm01 + symbol</param>
        public OpenCloseAcc(string symbol)
        {
            dictSymbol = symbol;
        }
        public OpenCloseAcc(string value, string symbol) : this(symbol)
        {
            Code = value;
        }
        private string dictSymbol { get; set; }

        /// <summary>
        /// Отримуєм назву параметру з бази даних і в інстансі поточного об'єкта проставляємо ім'я
        /// </summary>
        public void SetName(OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = string.Format("select name from k_dfm01{0} where (d_close is null or d_close > sysdate) and code = :p_code", dictSymbol);
                cmd.Parameters.Add(new OracleParameter("p_code", OracleDbType.Decimal, Code, ParameterDirection.Input));

                object res = cmd.ExecuteScalar();
                Name = Convert.ToString(res);
            }
        }
    }

    public class CodeValue
    {
        public string Code { get; set; }
        public string Name { get; set; }
    }
}