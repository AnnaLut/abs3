﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.InsUi.Models.Transport;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using Oracle.DataAccess.Client;
using System.Data;
using System.Data.Objects;
using System.IO;
using System.Text;
using System.Drawing;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Bars.Classes;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation
{
    public class RegNewCardRepository: IRegNewCardRepository
    {
		[Ninject.Inject]
        public Core.Logger.IDbLogger Logger { get; set; }
        private readonly IInsRepository _insRepo;
        public RegNewCardRepository(IInsRepository insRepo)
        {
            _insRepo = insRepo;
        }

        public RegNewValue GetCardValue(decimal rnk, decimal proectId, string cardCode, bool isIns)
        {
            RegNewValue card = new RegNewValue { ERROR_MSG = "" };
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select c.rnk, --0
                                           c.okpo, --1
                                           c.ctype, --2
                                           c.nmk, --3
                                           c.adr, --4
                                           trim(c.doc || ' ' || c.issuer) doc, --5
                                           c.bdayplace, --6
                                           c.nmkv_first nmkv_first, --7
                                           c.nmkv_last, --8
                                           p.card_code, --9
                                           p.sub_name, --10
                                           p.product_name, --11
                                           decode(p.proect_id, -1, null, p.proect_id) proect_id, --12
                                           p.proect_name, --13
                                           p.sh_name, --14
                                           p.nbs, --15
                                           p.ob22, --16
                                           p.kv, --17
                                           p.acc_rate, --18
                                           p.mobi_rate, --19
                                           p.cred_rate, --20
                                           p.ovr_rate, --21
                                           p.mm_max, --22
                                           p.proect_name as work, --23
                                           (case
                                             when t.current_branch like '/______/______%' then
                                              1
                                             else
                                              0
                                           end) as is_mfo, --24
                                           t.current_branch, --25
                                           t.name --26
                                      from v_bpk_customer c, 
                                           v_w4_product p, 
                                           person pr,
                                           (select SYS_CONTEXT('bars_context', 'user_branch') current_branch,
                                                   --branch,
                                                   name
                                              from branch
                                             where branch = SYS_CONTEXT('bars_context', 'user_branch')) t
                                     where c.rnk = :rnk
                                       and p.proect_id = :proect_id
                                       and p.card_code = :card_code
                                       and c.rnk = pr.rnk";
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                cmd.Parameters.Add("proect_id", OracleDbType.Decimal, proectId, ParameterDirection.Input);
                cmd.Parameters.Add("card_code", OracleDbType.Varchar2, cardCode, ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    card.RNK = reader.IsDBNull(0) ? (decimal?)null : reader.GetDecimal(0);
                    card.OKPO = reader.IsDBNull(1) ? String.Empty : reader.GetString(1);
                    card.CTYPE = reader.IsDBNull(2) ? String.Empty : reader.GetString(2);
                    card.NMK = reader.IsDBNull(3) ? String.Empty : reader.GetString(3);
                    card.ADR = reader.IsDBNull(4) ? String.Empty : reader.GetString(4);
                    card.DOC = reader.IsDBNull(5) ? String.Empty : reader.GetString(5);
                    card.BDAYPLACE = reader.IsDBNull(6) ? String.Empty : reader.GetString(6);
                    card.NMKV_FIRST = reader.IsDBNull(7) ? String.Empty : reader.GetString(7);
                    card.NMKV_LAST = reader.IsDBNull(8) ? String.Empty : reader.GetString(8);
                    card.CARD_CODE = reader.IsDBNull(9) ? String.Empty : reader.GetString(9);
                    card.SUB_NAME = reader.IsDBNull(10) ? String.Empty : reader.GetString(10);
                    card.PRODUCT_NAME = reader.IsDBNull(11) ? String.Empty : reader.GetString(11);
                    card.PROECT_ID = reader.IsDBNull(12) ? (decimal?)null : decimal.Parse(reader.GetValue(12).ToString());
                    card.PROECT_NAME = reader.IsDBNull(13) ? String.Empty : reader.GetString(13);
                    card.SH_NAME = reader.IsDBNull(14) ? String.Empty : reader.GetString(14);
                    card.NBS = reader.IsDBNull(15) ? String.Empty : reader.GetString(15);
                    card.OB22 = reader.IsDBNull(16) ? String.Empty : reader.GetString(16);
                    card.KV = reader.IsDBNull(17) ? (decimal?)null : reader.GetDecimal(17);
                    card.ACC_RATE = reader.IsDBNull(18) ? (decimal?)null : reader.GetDecimal(18);
                    card.MOBI_RATE = reader.IsDBNull(19) ? (decimal?)null : reader.GetDecimal(19);
                    card.CRED_RATE = reader.IsDBNull(20) ? (decimal?)null : reader.GetDecimal(20);
                    card.OVR_RATE = reader.IsDBNull(21) ? (decimal?)null : reader.GetDecimal(21);
                    card.MM_MAX = reader.IsDBNull(22) ? (decimal?)null : reader.GetDecimal(22);
                    card.WORK = reader.IsDBNull(23) ? String.Empty : reader.GetString(23);
                    card.ISMFO = reader.IsDBNull(24) ? false : reader.GetDecimal(24) == 1 ? true : false;
                    card.CURRENTBRANCH = reader.IsDBNull(25) ? String.Empty : reader.GetString(25);
                    card.CURBRANCHNAME = reader.IsDBNull(26) ? String.Empty : reader.GetString(26);
                    card.CHBOXSMS = true;
                    if (isIns)
                        card.TYPE_INS = 1;
                    else
                        card.TYPE_INS = (decimal?)null;
                    //card.IS_EXT = reader.IsDBNull(24) ? (bool?)null : (reader.GetDecimal(24) == 1 ? true : false);
                }
            }
            catch (Exception e)
            {
                string err = e.InnerException != null ? e.InnerException.Message : e.Message;
                err += e.StackTrace;
                card.ERROR_MSG = err;
                return card;
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return card;
        }

        public RegExternal GetExternal(decimal rnk)
        {
            RegExternal passp = new RegExternal();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select (case
                                             when decode(pr.passp, 11, 1, 0) = 0 then
                                              (case
                                                when (select count(1)
                                                        from customerw w
                                                       where regexp_like(w.value, '[А-ЯA-Z]{2}$')
                                                         and w.tag = 'PC_Z1'
                                                         and w.rnk = c.rnk) > 0 and
                                                     (select count(1)
                                                        from customerw w
                                                       where regexp_like(w.value, '[0-9]{6}$')
                                                         and w.tag = 'PC_Z2'
                                                         and w.rnk = c.rnk) > 0 and
                                                     (select count(1)
                                                        from customerw w
                                                       where to_date(w.value, 'dd/mm/yyyy') > trunc(sysdate)
                                                         and w.tag = 'PC_Z4'
                                                         and w.rnk = c.rnk) > 0 then
                                                 1
                                                else
                                                 0
                                              end)
                                             else
                                              1
                                           end) as is_ext
                                      from v_bpk_customer c, person pr
                                     where c.RNK = pr.rnk
                                       and c.RNK = :rnk";
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, rnk, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    passp.IS_EXT = reader.IsDBNull(0) ? (bool?)null : (reader.GetDecimal(0) == 1 ? true : false);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return passp;
        }

        public RespOpenCard OpenCard(RegNewValue par)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            RespOpenCard resp = new RespOpenCard();
            resp.ND = -1;

            OracleTransaction tx = connection.BeginTransaction();
            bool txCommited = false;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars_ow.open_card";
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, par.RNK, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, par.NLS, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_cardcode", OracleDbType.Varchar2, par.CARD_CODE, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, par.BRANCH, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_embfirstname", OracleDbType.Varchar2, par.NMKV_FIRST, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_emblastname", OracleDbType.Varchar2, par.NMKV_LAST, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_secname", OracleDbType.Varchar2, par.SEC_NAME, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_work", OracleDbType.Varchar2, par.WORK, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_office", OracleDbType.Varchar2, par.OFFICE, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_wdate", OracleDbType.Date, par.WDATE, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_salaryproect", OracleDbType.Decimal, par.PROECT_ID, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_term", OracleDbType.Decimal, Convert.ToDecimal(par.MM_MAX), System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_branchissue", OracleDbType.Varchar2, par.DELIVERY_BRANCH, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_barcode", OracleDbType.Varchar2, par.BARCOD, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_cobrandid", OracleDbType.Varchar2, par.COBRANDID, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_sendsms", OracleDbType.Decimal, par.CHBOXSMS ? 1 : 0, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
                cmd.Parameters.Add("p_recid", OracleDbType.Decimal, System.Data.ParameterDirection.Output);

                cmd.ExecuteNonQuery();
                //tx.Commit();
                
                resp.ND = Convert.ToDecimal(cmd.Parameters["p_nd"].Value.ToString());

                if (!String.IsNullOrEmpty(par.TYPE_INS.ToString()))
                {
                    cmd.CommandText = "ins_pack.set_w4_deal";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_nd", OracleDbType.Decimal, resp.ND, System.Data.ParameterDirection.Input);

                    cmd.ExecuteNonQuery();

                    //string doc = (convert.toint16(par.type_ins.tostring()) == 1 ?
                    //                           @"'passport' as doctype, --15
                    //                           p.ser as docseries, --16
                    //                           p.numdoc as docnumber, --17
                    //                           to_char(p.pdate, 'yyyy-mm-dd') as docdate, /*18*/" :
                    //                           @"'external_passport' as doctype, --15
                    //                           (select value
                    //                              from customerw
                    //                             where rnk = c.rnk
                    //                               and tag = 'pc_z1') as docseries, --16
                    //                           (select value
                    //                              from customerw
                    //                             where rnk = c.rnk
                    //                               and tag = 'pc_z2') as docnumber, --17
                    //                           to_char(to_date((select value
                    //                              from customerw
                    //                             where rnk = c.rnk
                    //                               and tag = 'pc_z5'), 'dd-mm-yyyy'), 'yyyy-mm-dd') as docdate, /*18*/");

                    ParamsEwa p = new ParamsEwa();
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = @"select dw.nd, --0
                                               dw.branch, --1
                                               (case when wp.ins_ukr_id is not null and wp.ins_wrd_id is null then 'custom' else 'tourism' end) as type, --2
                                               to_char(sysdate, 'yyyy-mm-dd') as date_, --3
                                               to_char(a.dat_begin - 1 , 'YYYY-MM-DD')||
                                                              'T'||case sessiontimezone when '+03:00' then '21' when '+02:00' then '22' else '00' end||':00:00.000+0000' as dateFrom, --4
                                               to_char(a.dat_begin, 'yyyy-mm-dd') as dateTo, --5
                                               c.okpo as code, --6
                                               (case
                                                 when c.okpo = '0000000000' or c.okpo = '9999999999' then
                                                  'true'
                                                 else
                                                  'false'
                                               end) as dontHaveCode, --7
                                               initcap(c.nmk) as name, --8
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'SN_LN') as nameLast, --9
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'SN_FN') as nameFirst, --10
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'SN_MN') as nameMiddle, --11
                                               nvl(c.adr,(select locality||', '||address from customer_address where rnk = c.rnk and type_id = 1)) as address, --12
                                               nvl((select case
                                                         when regexp_like(substr(trim(regexp_replace(upper(value),
                                                                                                     '[ -]',
                                                                                                     '')),
                                                                                 -9),
                                                                          '[0-9]') then
                                                          '+380' ||
                                                          substr(trim(regexp_replace(upper(value), '[ -]', '')), -9)
                                                         else
                                                          '+380000000000'
                                                       end
                                                  from customerw
                                                 where tag = 'MPNO' and rnk = c.rnk), '+380000000000') as phone, --13
                                               to_char(p.bday, 'yyyy-mm-dd') as birthDate, /*14*/ 
                                               'PASSPORT' as docType, --15
                                               p.ser as docSeries, --16
                                               p.numdoc as docNumber, --17
                                               to_char(p.pdate, 'yyyy-mm-dd') as docDate, --18
                                               'person' as insType, --19
                                               decode(c.custtype, 3, 'false', 'true') as legal, --20
                                               'DRAFT' as state, --21
                                               wp.ins_ukr_id as tariffUkr, --22
                                               wp.ins_wrd_id as tariffWrd, --23
                                               dw.acc_nls as card_number, --24
                                               'БПК_' || dw.nd as card_doc, --25
                                               wp.haveins, --26
                                               trim(substr(c.nmkv,0,instr(c.nmkv, ' '))) as f, --27
                                               trim(substr(c.nmkv,instr(c.nmkv, ' '),instr(c.nmkv, ' ',1,1))) as n, --28
                                               a.dat_end - a.dat_begin as coverage_days, --29
                                          case when cr.rezid=1 then 'rez' when cr.rezid=2 then   'notrez' end resident, --30
                                                substr(case when cc.name is null then 'Україна' else  c.country||' '||cc.name  end,1,400) citizenship, --31
                                               'EXTERNAL_PASSPORT' as docType_e, --32
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'PC_Z1') as docSeries_e, --33
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'PC_Z2') as docNumber_e, --34
                                               to_char(to_date((select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'PC_Z5'), 'dd-mm-yyyy'), 'yyyy-mm-dd') as docDate_e --35
                                          from w4_deal_web dw, w4_acc a, customer c, person p, w4_card wp, country cc, codcagent cr
                                         where dw.nd = a.nd
                                           and dw.cust_rnk = c.rnk
                                           and c.rnk = p.rnk
                                           and dw.card_code = wp.code
										   and c.country = cc.country
                                           and c.codcagent = cr.codcagent
                                           and dw.nd = :p_nd";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_nd", OracleDbType.Decimal, resp.ND, System.Data.ParameterDirection.Input);
                    //cmd.Parameters.Add("p_count_month", OracleDbType.Decimal, Convert.ToDecimal(par.MM_MAX), System.Data.ParameterDirection.Input);

                    OracleDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        p.nd = reader.GetDecimal(0);
                        p.branch = reader.IsDBNull(1) ? String.Empty : reader.GetString(1);
                        DealEwa param = new DealEwa();
                        param.type = reader.IsDBNull(2) ? String.Empty : reader.GetString(2);
                        param.date = reader.IsDBNull(3) ? String.Empty : reader.GetString(3);
                        param.dateFrom = reader.IsDBNull(4) ? String.Empty : reader.GetString(4);

                        if (Convert.ToDateTime(param.dateFrom) < Convert.ToDateTime(param.date)) 
                        {
                            resp.ERR_CODE = -99;
                            resp.ERR_MSG = "Дата вступу в дію договору меньша за поточну банківську дату!";
                            if (!txCommited) tx.Rollback();
                            return resp;
                        }

                        param.dateTo = reader.IsDBNull(5) ? String.Empty : reader.GetString(5);

			            if (param.dateTo != String.Empty)
                        {
                            DateTime myDate = new DateTime();
                            try
                            {
                                myDate = DateTime.ParseExact(param.dateTo, "yyyy-MM-dd", null);
                            }
                            catch
                            {
                                myDate = DateTime.ParseExact(param.dateTo, "yyyy-dd-MM", null);
                            }
                            if (par.MM_MAX > 36)
                            {
                                myDate = myDate.AddMonths(36);
                            }
                            else
                            {
                                myDate = myDate.AddMonths((int)par.MM_MAX);
                            }
                            myDate = myDate.AddDays(-1);
                            param.dateTo = myDate.ToString("yyyy-MM-dd");
                        }

                        CustomerEwa customer = new CustomerEwa();
                        customer.code = reader.IsDBNull(6) ? String.Empty : reader.GetString(6);
                        customer.dontHaveCode = reader.GetString(7) == "true" ? true : false;
                        customer.name = reader.IsDBNull(8) ? String.Empty : reader.GetString(8);
                        //customer.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(9);
                        //customer.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(10);
                        //customer.nameMiddle = reader.IsDBNull(11)? String.Empty : reader.GetString(11);
                        if (Convert.ToInt16(par.TYPE_INS.ToString()) == 1)
                        {
                        customer.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(9);
                        customer.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(10);
                        customer.nameMiddle = reader.IsDBNull(11) ? String.Empty : reader.GetString(11);
                        }
                        else
                        {
                            customer.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(27);
                            customer.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(28);
                            customer.nameMiddle = String.Empty;
                        }
                        customer.address = reader.IsDBNull(12) ? String.Empty : reader.GetString(12);
                        customer.phone = reader.IsDBNull(13) ? String.Empty : reader.GetString(13);
                        customer.birthDate = reader.IsDBNull(14) ? String.Empty : reader.GetString(14);
                        DocumentEwa document = new DocumentEwa();

                        document.type = reader.IsDBNull(15) ? String.Empty : reader.GetString(15);
                        document.series = reader.IsDBNull(16) ? String.Empty : reader.GetString(16);
                        document.number = reader.IsDBNull(17) ? String.Empty : reader.GetString(17);
                        document.date = reader.IsDBNull(18) ? String.Empty : reader.GetString(18);
                        
                        customer.legal = reader.GetString(20) == "true" ? true : false;
                        customer.document = document;
                        param.customer = customer;
                        InsuranceObjEwa insuranceObject = new InsuranceObjEwa();
                        insuranceObject.type = reader.IsDBNull(19) ? String.Empty : reader.GetString(19);
                        if (Convert.ToInt16(par.TYPE_INS.ToString()) == 0 && !String.IsNullOrEmpty(reader.GetValue(34).ToString()))
                        {
                            if (reader.IsDBNull(35))
                            {
                                resp.ERR_CODE = -99;
                                resp.ERR_MSG = "Дата видачі закордонного паспорта не заповнена в картці клієнта!";
                                if (!txCommited) tx.Rollback();
                                return resp;
                            }

                            DocumentEwa insuranceDocument = new DocumentEwa();
                            insuranceDocument.type = reader.IsDBNull(32)? String.Empty : reader.GetString(32);
                            insuranceDocument.series = reader.IsDBNull(33) ? String.Empty : reader.GetString(33);
                            insuranceDocument.number = reader.IsDBNull(34) ? String.Empty : reader.GetString(34);
                            insuranceDocument.date = reader.GetString(35);
                            insuranceObject.document = insuranceDocument;
                        }
                        else
                        {
                            insuranceObject.document = document;
                        }
                            
                        insuranceObject.code = reader.IsDBNull(6) ? String.Empty : reader.GetString(6);
                        insuranceObject.phone = reader.IsDBNull(13) ? String.Empty : reader.GetString(13);
                        insuranceObject.birthDate = reader.IsDBNull(14) ? String.Empty : reader.GetString(14);
                        if (Convert.ToInt16(par.TYPE_INS.ToString()) == 1)
                        {
                            insuranceObject.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(9);
                            insuranceObject.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(10);
                            insuranceObject.nameMiddle = reader.IsDBNull(11) ? String.Empty : reader.GetString(11);
                        }
                        else
                        {
                            insuranceObject.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(27);
                            insuranceObject.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(28);
                            insuranceObject.nameMiddle = String.Empty;
                        }
                        insuranceObject.dontHaveCode = reader.GetString(7) == "true" ? true : false;
                        insuranceObject.name = reader.IsDBNull(8) ? String.Empty : reader.GetString(8);
                        insuranceObject.address = reader.IsDBNull(12) ? String.Empty : reader.GetString(12);
                        param.insuranceObject = insuranceObject;
                        param.state = reader.IsDBNull(21) ? String.Empty : reader.GetString(21);
                        UserEwa user = new UserEwa();
                        user.id = Convert.ToDecimal(_insRepo.GetParameter("EWAID"));
                        param.user = user;
                        TariffEwa tariff = new TariffEwa();
                        tariff.type = reader.IsDBNull(2) ? String.Empty : reader.GetString(2);
                        tariff.id = Convert.ToInt16(par.TYPE_INS.ToString()) == 1 ? reader.GetDecimal(22) : reader.GetDecimal(23);
                        param.tariff = tariff;
                        List<CustomFields> customFields = new List<CustomFields>();
                        CustomFields customField = new CustomFields();
                        if (Convert.ToInt16(par.TYPE_INS.ToString()) == 1 && reader.IsDBNull(23))
                        {
                            customField.code = "card_doc";
                            customField.value = reader.IsDBNull(8) ? String.Empty : reader.GetString(25);
                            customFields.Add(customField);
                            customField = new CustomFields();
                            customField.code = "card_number";
                            customField.value = reader.IsDBNull(8) ? String.Empty : reader.GetString(24);
                            customFields.Add(customField);
                        }
                        else if (Convert.ToInt16(par.TYPE_INS.ToString()) == 1 && !reader.IsDBNull(23))
                        {
                            param.coverageDays = reader.IsDBNull(29) ? (decimal?)null : reader.GetDecimal(29);
                        }

                        if (reader.GetValue(2).ToString() == "custom")
                        {
                            customField = new CustomFields();
                            customField.code = "resident";
                            customField.value = reader.IsDBNull(30) ? String.Empty : reader.GetString(30);
                            customFields.Add(customField);
                            customField = new CustomFields();
                            customField.code = "citizenship";
                            customField.value = reader.IsDBNull(31) ? "Україна" : reader.GetString(31);
                            customFields.Add(customField);
                        }
                        param.customFields = customFields;
                        p.param = param;
                    }

                    var result = _insRepo.CreateDealEWA(p, connection);
                    if (result != "Ok")
                    {
                        resp.ERR_CODE = -99;
                        resp.ERR_MSG = result;
                        throw new Exception(resp.ERR_MSG);
                    }
                }
            }
            catch (WebException ex)
            {
                resp.ERR_CODE = -99;
                if (ex.Response != null)
                {
                    var tmp = ex;
                    using (var rdr = new StreamReader(ex.Response.GetResponseStream()))
                    {
                        resp.ERR_MSG = rdr.ReadToEnd();
                    }
                }
                else
                {
                    resp.ERR_MSG = ex.Message;
                }
                if (!txCommited) tx.Rollback();
            }
            catch (Exception e)
            {
				string o = Newtonsoft.Json.JsonConvert.SerializeObject(par);
                Logger.Error(o, "OpenCard");

                resp.ERR_CODE = -99;
                resp.ERR_MSG = e.Message.Substring(11, e.Message.Length - 11);
                resp.ERR_MSG = resp.ERR_MSG.IndexOf("ORA") > 0 ? resp.ERR_MSG.Substring(0, resp.ERR_MSG.IndexOf("ORA")) : resp.ERR_MSG;
                if (!txCommited) tx.Rollback();
            }
            finally
            {
                if (resp.ND != -1 && resp.ERR_CODE != -99)
                {
                    tx.Commit();
                }
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return resp;
        }

        public decimal GetInsType(decimal nd, string code)
        {
            decimal insType = 1; //1 = ukr, 0 - zakordon
            string request = String.Empty;
            decimal insWrdId=0, insUkrId=0;

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand com = con.CreateCommand())
                {
                    com.CommandType = System.Data.CommandType.Text;
                    com.CommandText = "select request from ins_w4_deals where nd=:p_nd";
                    com.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);

                    using (OracleDataReader reader = com.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            request = reader.IsDBNull(0) ? String.Empty : reader.GetString(0);
                        }
                    }
                }

                if (request != String.Empty)
                {
                    JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
                    ParamsEwa paramsEwa = jsonSerializer.Deserialize<ParamsEwa>(request);

                    using (OracleCommand com = con.CreateCommand())
                    {
                        com.CommandType = System.Data.CommandType.Text;
                        com.CommandText = "select ins_wrd_id, ins_ukr_id from w4_card where code=:p_code";
                        com.Parameters.Add("p_code", OracleDbType.Varchar2, code, ParameterDirection.Input);

                        using (OracleDataReader reader = com.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                insWrdId = reader.IsDBNull(0) ? 0 : reader.GetDecimal(0);
                                insUkrId = reader.IsDBNull(1) ? 0 : reader.GetDecimal(1);
                            }
                        }
                    }
                    if (paramsEwa.param.tariff.id == insWrdId)
                        insType = 0; // zakordonne strahuvannya
                }
                else
                {
                    throw new Exception("Не знайдено об'єкт попереднього запиту за даним параметром nd = " + nd);
                }
            }
            return insType;
        }

        public ParamsEwa GetParamsEwa(decimal nd, decimal typeIns, OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                string doc = (typeIns == 1 ?
                                           @"'PASSPORT' as docType, --15
                                               p.ser as docSeries, --16
                                               p.numdoc as docNumber, --17
                                               to_char(p.pdate, 'yyyy-mm-dd') as docDate, /*18*/" :
                                           @"'EXTERNAL_PASSPORT' as docType, --15
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'PC_Z1') as docSeries, --16
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'PC_Z2') as docNumber, --17
                                               to_char(to_date((select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'PC_Z5')), 'yyyy-mm-dd') as docDate, /*18*/");

                ParamsEwa p = new ParamsEwa();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select dw.nd, --0
                                               dw.branch, --1
                                               (case when wp.ins_ukr_id is not null and wp.ins_wrd_id is null then 'custom' else 'tourism' end) as type, --2
                                               to_char(sysdate, 'yyyy-mm-dd') as date_, --3
                                               to_char(a.dat_begin, 'yyyy-mm-dd') || 'T' ||
                                               to_char(SYSTIMESTAMP, 'hh24:mi:ss') || '.000' ||
                                               to_char(SYSTIMESTAMP, 'TZHTZM') as dateFrom, --4
                                               to_char(a.dat_end, 'yyyy-mm-dd') as dateTo, --5
                                               c.okpo as code, --6
                                               (case
                                                 when c.okpo = '0000000000' or c.okpo = '9999999999' then
                                                  'true'
                                                 else
                                                  'false'
                                               end) as dontHaveCode, --7
                                               initcap(c.nmk) as name, --8
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'SN_LN') as nameLast, --9
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'SN_FN') as nameFirst, --10
                                               (select value
                                                  from customerw
                                                 where rnk = c.rnk
                                                   and tag = 'SN_MN') as nameMiddle, --11
                                               nvl(c.adr,(select locality||', '||address from customer_address where rnk = c.rnk and type_id = 1)) as address, --12
                                               nvl((select case
                                                         when regexp_like(substr(trim(regexp_replace(upper(value),
                                                                                                     '[ -]',
                                                                                                     '')),
                                                                                 -9),
                                                                          '[0-9]') then
                                                          '+380' ||
                                                          substr(trim(regexp_replace(upper(value), '[ -]', '')), -9)
                                                         else
                                                          '+380000000000'
                                                       end
                                                  from customerw
                                                 where tag = 'MPNO' and rnk = c.rnk), '+380000000000') as phone, --13
                                               to_char(p.bday, 'yyyy-mm-dd') as birthDate, /*14*/ " + doc +
                                           @" 'person' as insType, --19
                                               decode(c.custtype, 3, 'false', 'true') as legal, --20
                                               'DRAFT' as state, --21
                                               wp.ins_ukr_id as tariffUkr, --22
                                               wp.ins_wrd_id as tariffWrd, --23
                                               dw.acc_nls as card_number, --24
                                               'БПК_' || dw.nd as card_doc, --25
                                               wp.haveins, --26
                                               trim(substr(c.nmkv,0,instr(c.nmkv, ' '))) as f, --27
                                               trim(substr(c.nmkv,instr(c.nmkv, ' '),instr(c.nmkv, ' ',1,1))) as n, --28
                                               a.dat_end - a.dat_begin as coverage_days --29
                                          from w4_deal_web dw, w4_acc a, customer c, person p, w4_card wp
                                         where dw.nd = a.nd
                                           and dw.cust_rnk = c.rnk
                                           and c.rnk = p.rnk
                                           and dw.card_code = wp.code
                                           and dw.nd = :p_nd";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);

                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        p.nd = reader.GetDecimal(0);
                        p.branch = reader.IsDBNull(1) ? String.Empty : reader.GetString(1);
                        DealEwa param = new DealEwa();
                        param.type = reader.IsDBNull(2) ? String.Empty : reader.GetString(2);
                        param.date = reader.IsDBNull(3) ? String.Empty : reader.GetString(3);
                        param.dateFrom = reader.IsDBNull(4) ? String.Empty : reader.GetString(4);

                        /*if (Convert.ToDateTime(param.dateFrom) < Convert.ToDateTime(param.date))
                        {
                            resp.ERR_CODE = -99;
                            resp.ERR_MSG = "Дата вступу в дію договору меньша за поточну банківську дату!";
                            if (!txCommited) tx.Rollback();
                            return resp;
                        }*/

                        param.dateTo = reader.IsDBNull(5) ? String.Empty : reader.GetString(5);
                        CustomerEwa customer = new CustomerEwa();
                        customer.code = reader.IsDBNull(6) ? String.Empty : reader.GetString(6);
                        customer.dontHaveCode = reader.GetString(7) == "true" ? true : false;
                        customer.name = reader.IsDBNull(8) ? String.Empty : reader.GetString(8);
                        //customer.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(9);
                        //customer.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(10);
                        //customer.nameMiddle = reader.IsDBNull(11) ? String.Empty : reader.GetString(11);
                        if (typeIns == 1)
                        {
                           customer.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(9);
                           customer.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(10);
                           customer.nameMiddle = reader.IsDBNull(11) ? String.Empty : reader.GetString(11);
                        } 
                        else
                        {
                           customer.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(27);
                           customer.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(28);
                           customer.nameMiddle = String.Empty;
                        }
                        customer.address = reader.IsDBNull(12) ? String.Empty : reader.GetString(12);
                        customer.phone = reader.IsDBNull(13) ? String.Empty : reader.GetString(13);
                        customer.birthDate = reader.IsDBNull(14) ? String.Empty : reader.GetString(14);
                        DocumentEwa document = new DocumentEwa();
                        document.type = reader.IsDBNull(15) ? String.Empty : reader.GetString(15);
                        document.series = reader.IsDBNull(16) ? String.Empty : reader.GetString(16);
                        document.number = reader.IsDBNull(17) ? String.Empty : reader.GetString(17);
                        document.date = reader.IsDBNull(18) ? String.Empty : reader.GetString(18);
                        customer.legal = reader.GetString(20) == "true" ? true : false;
                        customer.document = document;
                        param.customer = customer;
                        InsuranceObjEwa insuranceObject = new InsuranceObjEwa();
                        insuranceObject.type = reader.IsDBNull(19) ? String.Empty : reader.GetString(19);
                        insuranceObject.document = document;
                        insuranceObject.code = reader.IsDBNull(6) ? String.Empty : reader.GetString(6);
                        insuranceObject.phone = reader.IsDBNull(13) ? String.Empty : reader.GetString(13);
                        insuranceObject.birthDate = reader.IsDBNull(14) ? String.Empty : reader.GetString(14);
                        if (typeIns == 1)
                        {
                            insuranceObject.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(9);
                            insuranceObject.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(10);
                            insuranceObject.nameMiddle = reader.IsDBNull(11) ? String.Empty : reader.GetString(11);
                        }
                        else
                        {
                            insuranceObject.nameLast = reader.IsDBNull(9) ? String.Empty : reader.GetString(27);
                            insuranceObject.nameFirst = reader.IsDBNull(10) ? String.Empty : reader.GetString(28);
                            insuranceObject.nameMiddle = String.Empty;
                        }
                        insuranceObject.dontHaveCode = reader.GetString(7) == "true" ? true : false;
                        insuranceObject.name = reader.IsDBNull(8) ? String.Empty : reader.GetString(8);
                        insuranceObject.address = reader.IsDBNull(12) ? String.Empty : reader.GetString(12);
                        param.insuranceObject = insuranceObject;
                        param.state = reader.IsDBNull(21) ? String.Empty : reader.GetString(21);
                        UserEwa user = new UserEwa();
                        user.id = Convert.ToDecimal(_insRepo.GetParameter("EWAID"));
                        param.user = user;
                        TariffEwa tariff = new TariffEwa();
                        tariff.type = reader.IsDBNull(2) ? String.Empty : reader.GetString(2);
                        tariff.id = typeIns == 1 ? reader.GetDecimal(22) : reader.GetDecimal(23);
                        param.tariff = tariff;
                        if (typeIns == 1 && reader.IsDBNull(23))
                        {
                            List<CustomFields> customFields = new List<CustomFields>();
                            CustomFields customField = new CustomFields();
                            customField.code = "card_doc";
                            customField.value = reader.IsDBNull(8) ? String.Empty : reader.GetString(25);
                            customFields.Add(customField);
                            customField = new CustomFields();
                            customField.code = "card_number";
                            customField.value = reader.IsDBNull(8) ? String.Empty : reader.GetString(24);
                            customFields.Add(customField);
                            param.customFields = customFields;

                        }
                        else if (typeIns == 1 && !reader.IsDBNull(23))
                        {
                            param.coverageDays = reader.IsDBNull(29) ? (decimal?)null : reader.GetDecimal(29);
                        }
                        p.param = param;
                    }
                }
                return p;
            }
        }

        public ParamsIns GetIsIns(string cardCode)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            ParamsIns res = new ParamsIns();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select tt.haveins,
                                           tt.ins_ukr_id,
                                           tt.ins_wrd_id,
                                           tt.tmp_id_ukr,
                                           tt.tmp_id_wrd
                                      from w4_card tt
                                     where tt.code = :p_card_code";
                cmd.Parameters.Add("p_card_code", OracleDbType.Varchar2, cardCode, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    res.haveins = reader.IsDBNull(0) ? false : (reader.GetDecimal(0) == 1 ? true : false);
                    res.insUkrId = reader.IsDBNull(1) ? (decimal?)null : reader.GetDecimal(1);
                    res.insWrdId = reader.IsDBNull(2) ? (decimal?)null : reader.GetDecimal(2);
                    res.tmpUkrId = reader.IsDBNull(3) ? (decimal?)null : reader.GetDecimal(3);
                    res.tmpWrdId = reader.IsDBNull(4) ? (decimal?)null : reader.GetDecimal(4);
                }
            }
            catch (Exception ex)
            {
                res.ERROR_MSG = ex.Message;
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return res;
        }

        public void SetInsId(decimal nd, decimal ins_id, decimal tmp_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            ParamsIns res = new ParamsIns();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"bars.ins_pack.set_w4_ins_id";
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_ins_id", OracleDbType.Decimal, ins_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_tmp_id", OracleDbType.Decimal, tmp_id, System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public ParamsBpkIns GetBpkInsParams(decimal nd, string deal_id, string table)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            ParamsBpkIns res = new ParamsBpkIns();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = String.Format(@"select nd, request, response, ins_ext_id, ins_ext_tmp from {0} where nd = :p_nd", table);
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                if (deal_id != "")
                {
                    cmd.CommandText += " and deal_id = :pdeal_id";
                    cmd.Parameters.Add("pdeal_id", OracleDbType.Varchar2, 100, deal_id, System.Data.ParameterDirection.Input);
                }

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    res.nd = reader.IsDBNull(0) ? (decimal?)null : reader.GetDecimal(0);
                    res.request = reader.IsDBNull(1) ? String.Empty : reader.GetString(1);
                    res.response = reader.IsDBNull(2) ? String.Empty : reader.GetString(2);
                    res.insextid = reader.IsDBNull(3) ? (decimal?)null : reader.GetDecimal(3);
                    res.insexttmp = reader.IsDBNull(4) ? (decimal?)null : reader.GetDecimal(4);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return res;
        }
    }
}
