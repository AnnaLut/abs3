﻿using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.Clients.Infrastructure
{
    public class Utils : IUtils
    {
        public SqlRequest CreateSearchSql(SearchParams parameters, string baseSql)
        {
            var result = new SqlRequest
            {
                SqlText = @"select a.* from (" + baseSql + ") a ",
                SqlParams = new object[] { }
            };

            if (!string.IsNullOrEmpty(parameters.CustomerCode))
            {
                result.SqlText += " where Code = :p_okpo ";
                result.SqlParams = new object[]
                {
                    parameters.CustomerCode
                };
            }
            else if (!string.IsNullOrEmpty(parameters.Gcif))
            {
                result.SqlText += @", ebk_gcif b 
                                    where a.id=b.rnk 
                                            and b.gcif = :p_gcif ";
                result.SqlParams = new object[]
                {
                    parameters.Gcif
                };
            }
            else if (!string.IsNullOrEmpty(parameters.DocumentSerial)
                && !string.IsNullOrEmpty(parameters.DocumentNumber))
            {
                result.SqlText += @", person b 
                                    where a.id=b.rnk 
                                            and b.ser = :p_ser
                                            and b.numdoc = :p_numdoc ";
                result.SqlParams = new object[]
                {
                    parameters.DocumentSerial,
                    parameters.DocumentNumber
                };
            }
            else if (!string.IsNullOrEmpty(parameters.FirstName)
                && !string.IsNullOrEmpty(parameters.LastName)
                && parameters.BirthDate != null)
            {
                result.SqlText =
                @"select  s.* from
                    ( select a.*, 
                        (select d.value from customerw d where d.tag = 'SN_FN' and D.RNK = a.id) as firstName,
                        (select d.value from customerw d where d.tag = 'SN_LN' and D.RNK = a.id) as lastName,
                        b.bday
                    from 
                        (" + baseSql + @") a, 
                        person b 
                    where a.id = b.rnk) s
                where
                    s.bday = trunc(:p_bday)
                    and upper(s.firstName) = upper(:p_first_name)
                    and upper(s.lastName) = upper(:p_last_name)";

                result.SqlParams = new object[]
                {
                    parameters.BirthDate,
                    parameters.FirstName,
                    parameters.LastName
                };
            }
            else if (!string.IsNullOrEmpty(parameters.FirstName)
                && !string.IsNullOrEmpty(parameters.LastName))
            {
                result.SqlText += @" where 
                                        upper(a.name) like upper('%'||:p_name1 ||'%')
                                        or upper(a.name) like upper('%'||:p_name2 ||'%') ";

                var name1 = parameters.FirstName + " " + parameters.LastName;
                var name2 = parameters.LastName + " " + parameters.FirstName;
                result.SqlParams = new object[]
                {
                    name1,
                    name2
                };
            }

            return result;
        }
    }

    public interface IUtils
    {
        SqlRequest CreateSearchSql(SearchParams parameters, string baseSql);
    }
}
