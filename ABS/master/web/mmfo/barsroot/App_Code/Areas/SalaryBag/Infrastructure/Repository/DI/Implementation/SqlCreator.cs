using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace BarsWeb.Areas.SalaryBag.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        #region Salary Bag
        public static BarsSql SearchMain(List<int> sos)
        {
            string sql = @"select 
                                id,             
                                deal_id,        
                                start_date,     
                                close_date,     
                                rnk,            
                                nmk,            
                                deal_name,      
                                fs_name,        
                                fs,
                                sos,            
                                sos_name,       
                                deal_premium,   
                                central,         
                                nls_2909,       
                                ostc_2909,      
                                nls_3570,       
                                ostc_3570,      
                                branch,         
                                fio,            
                                corp2,          
                                kod_tarif,      
                                tarif_name,     
                                tar,            
                                max_tarif,      
                                ind_acc_tarif,  
                                comm_reject,
                                tip,
                                okpo,
                                acc_2909,
                                acc_3570                         
                            from v_zp_deals where sos in ({0})";

            List<string> paramsNamesList = new List<string>();
            List<object> oraParamsList = new List<object>();

            for (int i = 0; i < sos.Count; i++)
            {
                paramsNamesList.Add(":p_sos_" + i);
                oraParamsList.Add(new OracleParameter(":p_sos_" + i, OracleDbType.Decimal, sos[i], ParameterDirection.Input));
            }

            return new BarsSql()
            {
                SqlText = string.Format(sql, string.Join(", ", paramsNamesList.ToArray())),
                SqlParams = oraParamsList.ToArray()
            };
        }
        public static BarsSql SearchDealChangesById(string id)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                deal_id,
                                rnk,
                                branch,
                                upd_user_fio,
                                upd_date,
                                fs_name,
                                sos_name,
                                deal_premium,
                                central, 
                                kod_tarif,
                                nls_2909,
                                nls_3570
                            from v_zp_deals_update
                            where 
                                id = :p_id
                            order by idupd",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input)
                }
            };
        }
        public static BarsSql SearchTarifs()
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                a.kod,
                                a.kv,
                                a.name,
                                a.tar / 100 as tar,
                                case when a.tip = 0 then a.pr else (select max(pr) from tarif_scale s where s.kod = a.kod) end pr,
                                a.tip
                            from v_tarif a , zp_tarif z
                            where a.kod = z.kod",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql GetTarifByCode(string code)
        {
            return new BarsSql()
            {
                SqlText = @"select a.kod,
                                a.kv,
                                a.name,
                                a.tar / 100 as tar,
                                a.pr,
                                a.tip  
                            from v_tarif a, zp_tarif z 
                            where a.kod = z.kod and a.kod = :p_kod",
                SqlParams = new object[] {
                    new OracleParameter("p_kod", OracleDbType.Decimal, code, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetTarifDetails(string code)
        {
            return new BarsSql()
            {
                SqlText = @"select
                                kod,
                                sum_limit / 100 sum_limit,
                                sum_tarif / 100 sum_tarif,
                                pr,
                                smin / 100 smin,
                                smax / 100 smax 
                            from tarif_scale ts 
                            where 
                                TS.KOD = :p_kod
                            order by ts.sum_limit",
                SqlParams = new object[] {
                    new OracleParameter("p_kod", OracleDbType.Decimal, code, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchCustomers(string rnk, string okpo, string name)
        {
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.Append(@"select 
                                    rnk,
                                    nmk,
                                    okpo,
                                    branch,
                                    adr 
                                from customer 
                                where 
                                    date_off is null
                                    and (custtype in (1,2) or sed = '91')");
            List<object> queryParams = new List<object>();

            if (!string.IsNullOrWhiteSpace(rnk))
            {
                sqlBuilder.Append(" and rnk = :p_rnk");
                queryParams.Add(new OracleParameter("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input));
            }
            if (!string.IsNullOrWhiteSpace(okpo))
            {
                sqlBuilder.Append(" and okpo = :p_okpo");
                queryParams.Add(new OracleParameter("p_okpo", OracleDbType.Varchar2, 4000, okpo, ParameterDirection.Input));
            }
            if (!string.IsNullOrWhiteSpace(name))
            {
                sqlBuilder.Append(" and upper(nmk) like :p_name");
                queryParams.Add(new OracleParameter("p_name", OracleDbType.Varchar2, 4000, "%" + name.ToUpper() + "%", ParameterDirection.Input));
            }

            return new BarsSql()
            {
                SqlText = sqlBuilder.ToString(),
                SqlParams = queryParams.ToArray()
            };
        }

        public static BarsSql GetAccountsByRnk(string rnk)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                acc,
                                nls,
                                kv,
                                nms,
                                ostc / 100 ostc
                            from accounts
                            where 
                                nbs = '2909'
                                and ob22 = '11'
                                and dazs is null
                                and kv = 980
                                and rnk = :p_rnk",
                SqlParams = new object[] {
                    new OracleParameter("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetFs()
        {
            return new BarsSql()
            {
                SqlText = "select id, name from v_zp_deals_fs",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql GetAcc3570byRnk(string rnk)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                acc,
                                nms,
                                nls 
                            from accounts a
                            where 
                                nbs = '3570'
                                and ob22 = '29'
                                and dazs is null
                                and kv = 980
                                and rnk = :p_rnk",
                SqlParams = new object[] {
                     new OracleParameter("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input)
                }
            };
        }
        #endregion

        #region accounts 2625
        public static BarsSql Search2625(string dealId)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                acc,
                                rnk,
                                id,
                                okpo, 
                                nmk,  
                                nls,  
                                kv,   
                                code, 
                                name, 
                                ost,             
                                id_bpk_proect,
                                status 
                            from v_zp_acc_pk
                            where 
                                id = :p_id
                                and status >= 0 ",
                SqlParams = new object[] {
                     new OracleParameter("p_id", OracleDbType.Decimal, dealId, ParameterDirection.Input)
                }
            };
        }
        #endregion

        #region SalaryProcessing and SalaryPayroll
        public static BarsSql SearchDeals(string okpo, string nmk, string dealId)
        {
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.Append(@"select 
                                id,
                                deal_id,
                                deal_name,
                                okpo,
                                nmk
                            from v_zp_deals
                            where 
                                sos = 5");
            List<object> sqlParams = new List<object>();

            if (!string.IsNullOrWhiteSpace(okpo))
            {
                sqlBuilder.Append(" and okpo = :p_okpo");
                sqlParams.Add(new OracleParameter("p_okpo", OracleDbType.Varchar2, 4000, okpo, ParameterDirection.Input));
            }
            if (!string.IsNullOrWhiteSpace(nmk))
            {
                sqlBuilder.Append(" and upper(nmk) like :p_nmk");
                sqlParams.Add(new OracleParameter("p_nmk", OracleDbType.Varchar2, 4000, "%" + nmk.ToUpper() + "%", ParameterDirection.Input));
            }
            if (!string.IsNullOrWhiteSpace(dealId))
            {
                sqlBuilder.Append("and deal_id like :p_deal_id");
                sqlParams.Add(new OracleParameter("p_deal_id", OracleDbType.Varchar2, 4000, dealId + "%", ParameterDirection.Input));
            }

            return new BarsSql()
            {
                SqlText = sqlBuilder.ToString(),
                SqlParams = sqlParams.ToArray()
            };
        }

        public static BarsSql GetDealAndPayRollInfoByPId(string id)
        {
            return new BarsSql()
            {
                SqlText = @"select
                                z.okpo,
                                z.nmk,
                                z.deal_id,
                                z.deal_premium,
                                z.ostc_2909,
                                z.nls_2909,
                                z.kod_tarif,
                                z.deal_name,
                                P.PR_DATE,
                                P.PAYROLL_NUM,
                                case when p.nazn is null then 'Зарахування заробітної плати за <місяць> ' || to_char(sysdate,'YYYY') || ' р.' else p.nazn end nazn,
                                z.ostc_3570,
                                p.signed,
                                s.fio signed_fio,
                                s2.fio reject_fio,
                                p.comm_reject
                            from  v_zp_deals z, zp_payroll p, staff$base s, staff$base s2
                            where 
                                z.id=p.zp_id
                                and p.signed_user = s.id(+)
                                and p.reject_user = s2.id(+)
                                and p.id = :p_id",
                SqlParams = new object[] {
                    new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql CalcComissionSql(string tarifCode, string nls2909, decimal sum)
        {
            return new BarsSql()
            {
                SqlText = "select NVL (f_tarif (:p_tarif_code, 980, :p_nls, :p_sum )/100,0) from dual",
                SqlParams = new object[] {
                    new OracleParameter("p_tarif_code", OracleDbType.Decimal, tarifCode, ParameterDirection.Input),
                    new OracleParameter("p_nls", OracleDbType.Varchar2, 4000, nls2909, ParameterDirection.Input),
                    new OracleParameter("p_sum", OracleDbType.Decimal, sum, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchPayroll()
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                id,                 
                                zp_id,              
                                zp_deal_id,         
                                rnk,                
                                deal_name,          
                                pr_date,            
                                cnt,                
                                s,                  
                                cms,                
                                sos_name,           
                                src_name,
                                sos,
                                comm_reject,
                                not_enogh_money,
                                not_enogh_sum,
                                payroll_num,
                                nmk,
                                fio,
                                signed,
                                signed_fio,
                                ostc_2909,
                                src,
                                imp_date
                            from v_zp_payroll ",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql GetPayRollItems(string pId)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                z.id,
                                rownum,
                                z.namb, 
                                z.okpob,
                                z.mfob,
                                z.nlsb,
                                z.s / 100 s,
                                z.nazn,
                                case 
                                    when source = 1
                                        then
                                           'Ручне введення'
                                    when source = 2
                                        then
                                           'Імпорт файлу'
                                    when source = 3
                                        then
                                           'Клонування відомості'
                                    when source = 5 
                                        then 'Інтернет банк'       
                                end source,
                                z.ref doc_ref, 
                                o.sos,
                                z.signed,
                                case when s.fio is null and z.corp2_id is not null then 'Корпоративний клієнт' else s.fio end signed_fio,
                                z.doc_comment,
                                z.passp_serial,
                                z.passp_num,
                                z.idcard_num
                            from zp_payroll_doc z, oper o, staff$base s
                            where 
                                o.ref(+) = z.ref 
                                and z.signed_user = s.id(+)
                                and id_pr = :p_id_pr
                            order by rownum",
                SqlParams = new object[] {
                    new OracleParameter("p_id_pr", OracleDbType.Decimal, pId, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchClientsByZpDeal(string zpDealId)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                okpo,
                                nmk,
                                nls,
                                mfo,
                                pass_serial as PassportSerial,
                                pass_num as PassportNumber,
                                pass_card as PassportIdCardNum,
                                actual_date as ActualDate
                            from v_zp_acc_pk
                            where 
                                id = :p_id",
                SqlParams = new object[]
                {
                     new OracleParameter("p_id", OracleDbType.Decimal, zpDealId, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetHistory(string zpDealId)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                id,
                                pr_date,
                                deal_name,
                                cnt,
                                s,
                                cms,
                                src_name,
                                payroll_num
                            from v_zp_payroll
                            where 
                                sos = 5
                                and pr_date > trunc(sysdate)-90
                                and zp_id = :p_id
                            order by pr_date desc",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal, zpDealId, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetClientInfo(string nls)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                c.okpo, 
                                c.nmk
                            from accounts a, customer c
                            where 
                                a.rnk = c.rnk 
                                and a.kv = 980 
                                and nls = :p_nls ",
                SqlParams = new object[]
                {
                    new OracleParameter("p_nls", OracleDbType.Varchar2, 4000, nls, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql ChechAccSql(string mfo, string acc)
        {
            return new BarsSql()
            {
                SqlText = "select vkrzn( substr(:p_mfo, 1, 5) , :p_acc ) from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("p_mfo", OracleDbType.Varchar2, 4000, mfo.Substring(0, 5), ParameterDirection.Input),
                    new OracleParameter("p_acc", OracleDbType.Varchar2, 4000, acc, ParameterDirection.Input)
                }
            };
        }
        #endregion

        #region File Import
        public static BarsSql GetImportedFilesHistory(string payrollId)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                id,
                                id_pr,                                          --Ід відомості
                                imp_date,                                       --Дата іморту(с часом)
                                file_name,                                      --Назва файлу
                                sos, 
                                case when sos=1 then 'Імпортований успішно'
                                     when sos=2 then 'Помилка імпорту'
                                     when sos=3 then 'Видалений' end sos_text,  --Статус
                                err_text,                                       --Текст помилки
                                cnt_doc+cnt_doc_reject cnt_total,               --Всього документів
                                cnt_doc,                                        --Документів імпортовано
                                cnt_doc_reject                                  --Імпортовано з помилками
                            from zp_payroll_imp_files
                            where 
                                id_pr = :p_id
                            order by imp_date desc",
                SqlParams = new object[]
                {
                    new OracleParameter("p_nls", OracleDbType.Decimal, payrollId, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetDbfData()
        {
            return new BarsSql()
            {
                SqlText = @"select * from TMP_ZP_DBF_IMP_PREV 
                            where rownum <= 5",
                SqlParams = new object[] { }
            };
        }
        public static BarsSql GetImportErrorList(string fileId)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                okpob,          --ІПН
                                namb,           --ФІО клієнта
                                mfob,           --ФМО 
                                nlsb,           --Номер рахунку 
                                err_text        --Текст помилки
                            from zp_payroll_imp_doc_err
                            where 
                                id_file = :p_file_id",
                SqlParams = new object[]
                {
                    new OracleParameter("p_file_id", OracleDbType.Decimal, fileId, ParameterDirection.Input)
                }
            };
        }
        public static BarsSql GetImportConfigs()
        {
            return new BarsSql()
            {
                SqlText = @"select 2 as w, id, name from v_zp_payroll_imp_dbf
                            union all
                            select 1 as w, null, 'Використати конструктор' as name from dual
                            order by w, id",
                SqlParams = new object[] { }
            };
        }
        #endregion

        #region EA
        public static BarsSql GetStructCodes()
        {
            return new BarsSql()
            {
                SqlText = "select id, name from EAD_STRUCT_CODES where substr(id, 1, 3) = '001'",
                SqlParams = new object[] { }
            };
        }
        #endregion

        #region Electronic digital signature
        public static BarsSql GetSignDataForDocs(string payrollId)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                id , 
                                doc_buffer buffer 
                            from 
                                table(zp.get_docs_buffer(:p_id))",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal, payrollId, ParameterDirection.Input)
                }
            };
        }
        public static BarsSql GetSignDataForPayroll(string payrollId)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                :p_id id, 
                                zp.get_payroll_buffer(:p_id) buffer 
                            from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal, payrollId, ParameterDirection.Input)
                }
            };
        }
        #endregion

        public static BarsSql OurMfoSql()
        {
            return new BarsSql()
            {
                SqlText = "select f_ourmfo() from dual",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql BranchesList()
        {
            return new BarsSql
            {
                SqlParams = new object[] { },
                SqlText = "select * from v_branch_own order by branch"
            };
        }
    }
}
