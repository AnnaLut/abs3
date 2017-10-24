using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using Dapper;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Implementation
{
    public class DoposProfileRepository : IDoposProfileRepository
    {
        public DepositProfile GetProfile(decimal id)
        {

            var sql = @"select ID, FIO, NSC, OST, CLIENTBDATE, 
                        STATUS, DATO, DATL, DOCDATE, BRANCH, RNK,
                        IDA, REGISTRYDATE, KV_SHORT, OB22, KKNAME, 
                        PERCENT, REASON_CHANGE_STATUS, STATE_ID,
                        DOCTYPE, DOCSERIAL, DOCNUMBER, DOCORG, RNK_BUR, FIO_RECEIVER
                        from v_crca_portfolio
                        where ID = :id";
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                var profile = connection.Query<DepositProfile>(sql, new { id }).FirstOrDefault();
                return profile;
            }
        }


        public List<TrustedPerson> GetTrustedPersons(decimal ID_COMPEN)
        {
            List<TrustedPerson> persons;
            var sql = @"select FIOB, p.NSC, FULLADDRESSB, ICODB, 
                               DOCTYPEB, DOCSERIALB, DOCNUMBERB, 
                               DOCORGB, DOCDATEB, CLIENTBDATEB, 
                               CLIENTPHONEB  
                        from v_crca_heir c
                        join v_crca_portfolio p on c.ID_COMPEN = p.ID
                        where c.ID_COMPEN = :ID_COMPEN";
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                persons = connection.Query<TrustedPerson>(sql, new {ID_COMPEN}).ToList();
            }
            return persons;
        }

        public List<TrustedPerson> GetHeirsPersons(decimal ID_COMPEN)
        {
            List<TrustedPerson> heirs;
            var sql = @"select FIOB, p.NSC, FULLADDRESSB, ICODB, 
                            DOCTYPEB, DOCSERIALB, DOCNUMBERB, 
                            DOCORGB, DOCDATEB, CLIENTBDATEB, 
                            CLIENTPHONEB  
                       from v_crca_confidant c
                       join v_crca_portfolio p on c.ID_COMPEN = p.ID
                       where c.ID_COMPEN = :ID_COMPEN";
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                heirs = connection.Query<TrustedPerson>(sql, new {ID_COMPEN}).ToList();
            }
            return heirs;
        }

        public List<History> GetHistories(decimal ID_COMPEN)
        {
            var query = @" select IDM, SUMOP, OST, ZPR, DATP, PREA, OI, OL, DATL, TYPO, MARK, VER, STAT, 
                           TXT, REF, ID_COMPEN_BOUND, USER_LOGIN, MSG, USER_LOGIN_VIZA, USER_VISA_DATE
                           from v_crca_pays 
                           where ID_COMPEN = :ID_COMPEN";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<History>(query, new { ID_COMPEN }).ToList();
            }
        }

        public ClientProfile ClientInfo(string rnk)
        {
            var connection = OraConnector.Handler.UserConnection;
            var cmd = connection.CreateCommand();
            var cp = new ClientProfile();
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = @"select name, inn, sex, ser, numdoc,
                                    tel, tel_mob, notes, zip, domain, 
                                    region, locality, ID_SEX, ID_REZID, 
                                    ID_DOC_TYPE, branch, address, mfo, nls,
                                    birth_date, date_of_issue,
                                    date_registry, dbcode, organ, okpo, secondary,
                                    date_val_reg, eddr_id, actual_date, bplace, country, edit
                                    from v_customer_crkr where rnk = :rnk";
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);

                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    if (!reader.IsDBNull(0))
                        cp.FullName = Convert.ToString(reader[0]);
                    if (!reader.IsDBNull(1))
                        cp.INN = Convert.ToString(reader[1]);
                    if (!reader.IsDBNull(2))
                        cp.Sex = Convert.ToString(reader[2]);
                    if (!reader.IsDBNull(3))
                        cp.Ser = Convert.ToString(reader[3]);
                    if (!reader.IsDBNull(4))
                        cp.NumDoc = Convert.ToString(reader[4]);
                    if (!reader.IsDBNull(5))
                        cp.PhoneNumber = Convert.ToString(reader[5]);
                    if (!reader.IsDBNull(6))
                        cp.MobileNumber = Convert.ToString(reader[6]);
                    if (!reader.IsDBNull(7))
                        cp.SourceDownload = Convert.ToString(reader[7]);
                    if (!reader.IsDBNull(8))
                        cp.Postindex = Convert.ToString(reader[8]);
                    if (!reader.IsDBNull(9))
                        cp.Region = Convert.ToString(reader[9]);//в базі область це DOMAIN
                    if (!reader.IsDBNull(10))
                        cp.Area = Convert.ToString(reader[10]);
                    if (!reader.IsDBNull(11))
                        cp.City = Convert.ToString(reader[11]);
                    if (!reader.IsDBNull(12))
                        cp.ID_SEX = Convert.ToString(reader[12]);
                    if (!reader.IsDBNull(13))
                        cp.ID_REZID = Convert.ToString(reader[13]);
                    if (!reader.IsDBNull(14))
                        cp.ID_DOC_TYPE = Convert.ToString(reader[14]);
                    if (!reader.IsDBNull(15))
                        cp.DepartmentCode = Convert.ToString(reader[15]);
                    if (!reader.IsDBNull(16))
                        cp.Address = Convert.ToString(reader[16]);
                    if (!reader.IsDBNull(17))
                        cp.Mfo = Convert.ToString(reader[17]);
                    if (!reader.IsDBNull(18))
                        cp.Nls = Convert.ToString(reader[18]);
                    if (!reader.IsDBNull(19))
                        cp.Birthday = Convert.ToDateTime(reader[19]);
                    if (!reader.IsDBNull(20))
                        cp.IssueDate = Convert.ToDateTime(reader[20]);
                    if (!reader.IsDBNull(21))
                        cp.RegisterDate= Convert.ToDateTime(reader[21]);
                    if (!reader.IsDBNull(22))
                        cp.DBCODE = Convert.ToString(reader[22]);
                    if (!reader.IsDBNull(23))
                        cp.Organ = Convert.ToString(reader[23]);
                    if (!reader.IsDBNull(24))
                        cp.Okpo = Convert.ToString(reader[24]);
                    if (!reader.IsDBNull(25))
                        cp.Secondary = Convert.ToString(reader[25]);
                    if (!reader.IsDBNull(26))
                        cp.DateVal = Convert.ToDateTime(reader[26]);
                    if (!reader.IsDBNull(27))
                        cp.EddrId = Convert.ToString(reader[27]);
                    if (!reader.IsDBNull(28))
                        cp.ActualDateTime = Convert.ToDateTime(reader[28]);
                    if (!reader.IsDBNull(29))
                        cp.Bplace = Convert.ToString(reader[29]);
                    if (!reader.IsDBNull(30))
                        cp.CountryId = Convert.ToDecimal(reader[30]);
                    if (!reader.IsDBNull(31))
                        cp.IsEdit = Convert.ToDecimal(reader[31]);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return cp;
        }
    }
}