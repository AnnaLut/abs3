using System;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Web;
using BarsWeb.Core.Logger;
using Bars.WebServices.XRM.Services.Customer.Models;

namespace Bars.WebServices.XRM.Services.Customer
{
    public static class CustomerWorker
    {
        public static SetVerifiedClient SetVirified(SetVerifiedClient VCust, OracleConnection con)
        {
            HttpContext ctx = HttpContext.Current;
            using (OracleCommand cmdVer = con.CreateCommand())
            {
                try
                {
                    cmdVer.CommandType = CommandType.StoredProcedure;
                    cmdVer.CommandText = "XRM_INTEGRATION_OE.SET_VERIFIED_STATE";
                    cmdVer.BindByName = true;

                    cmdVer.Parameters.Clear();
                    cmdVer.Parameters.Add("p_RNK", OracleDbType.Decimal, VCust.RNK, ParameterDirection.Input);
                    cmdVer.Parameters.Add("p_code", OracleDbType.Decimal, VCust.StatusCode, ParameterDirection.Output);
                    cmdVer.Parameters.Add("p_errmsg", OracleDbType.Varchar2, 5000, VCust.ErrorCode, ParameterDirection.Output);
                    cmdVer.ExecuteNonQuery();
                    VCust.StatusCode = ((OracleDecimal)cmdVer.Parameters["p_code"].Value).Value;
                    VCust.ErrorCode = ((OracleString)cmdVer.Parameters["p_errmsg"].Value).Value;
                    return VCust;
                }
                catch (System.Exception e)
                {
                    DbLoggerConstruct.NewDbLogger().Info(e.StackTrace + e.Message, "XRMIntegrationCustomer");
                    return VCust;
                }
            }
        }
        public static String SetClientAtr(Decimal RNK, String TAG, String VAL, Decimal OTD, OracleConnection connect)
        {
            int str = 200;
            String retVAL = String.Empty;
            using (OracleCommand cmdAttrCustomer = connect.CreateCommand())
            {
                try
                {
                    cmdAttrCustomer.CommandType = CommandType.StoredProcedure;
                    cmdAttrCustomer.CommandText = "xrm_integration_oe.AttrCustomer";
                    cmdAttrCustomer.BindByName = true;

                    cmdAttrCustomer.Parameters.Clear();
                    cmdAttrCustomer.Parameters.Add("Rnk_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                    cmdAttrCustomer.Parameters.Add("Tag_", OracleDbType.Varchar2, str, TAG, ParameterDirection.Input);
                    cmdAttrCustomer.Parameters.Add("Val_", OracleDbType.Varchar2, str, VAL, ParameterDirection.InputOutput);
                    cmdAttrCustomer.Parameters.Add("Otd_", OracleDbType.Decimal, OTD, ParameterDirection.Input);
                    cmdAttrCustomer.ExecuteNonQuery();
                    retVAL = ((OracleString)cmdAttrCustomer.Parameters["Val_"].Value) == null ? "" : ((OracleString)cmdAttrCustomer.Parameters["Val_"].Value).Value;
                }
                catch (System.Exception e)
                {
                    DbLoggerConstruct.NewDbLogger().Info(e.StackTrace, "XRMIntegrationCustomer");
                }
            }
            return retVAL;
        }
        public static SetCustomerRisk SetClientRisk(Decimal RNK, SetCustomerRisk CustomerRisk, OracleConnection connect)
        {
            SetCustomerRisk retVAL = new SetCustomerRisk();
            using (OracleCommand cmdRiskCustomer = connect.CreateCommand())
            {
                try
                {
                    cmdRiskCustomer.CommandType = CommandType.StoredProcedure;
                    cmdRiskCustomer.CommandText = "xrm_integration_oe.set_risk";
                    cmdRiskCustomer.BindByName = true;

                    cmdRiskCustomer.Parameters.Clear();
                    cmdRiskCustomer.BindByName = true;
                    cmdRiskCustomer.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                    cmdRiskCustomer.Parameters.Add("p_riskid", OracleDbType.Decimal, CustomerRisk.RiskId, ParameterDirection.Input);
                    cmdRiskCustomer.Parameters.Add("p_riskvalue", OracleDbType.Decimal, CustomerRisk.Value, ParameterDirection.Input);
                    cmdRiskCustomer.Parameters.Add("p_errormessage", OracleDbType.Varchar2, 4000, retVAL.ErrorCode, ParameterDirection.Output);
                    cmdRiskCustomer.ExecuteNonQuery();
                    retVAL.RiskId = CustomerRisk.RiskId;
                    retVAL.Value = CustomerRisk.Value;
                    retVAL.ErrorCode = ((OracleString)cmdRiskCustomer.Parameters["p_errormessage"].Value) == null ? "" : ((OracleString)cmdRiskCustomer.Parameters["p_errormessage"].Value).Value;

                }
                catch (System.Exception e)
                {
                    DbLoggerConstruct.NewDbLogger().Info(e.StackTrace, "XRMIntegrationCustomer.SetClientRisk");
                }
            }
            return retVAL;
        }

        public static CustomerRisk[] GetClientRisks(Decimal RNK, OracleConnection connect)
        {
            CustomerRisk[] CustomerRiskSet = new CustomerRisk[100];

            using (OracleCommand cmdGetRiskCustomer = new OracleCommand())
            {
                cmdGetRiskCustomer.Connection = connect;

                cmdGetRiskCustomer.BindByName = true;
                cmdGetRiskCustomer.CommandText = "select riskid, to_char(dat_begin,'yyyy-mm-dd') dat_begin, to_char(dat_end,'yyyy-mm-dd') dat_end from table(xrm_integration_oe.get_risklist(:p_rnk))";
                cmdGetRiskCustomer.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);

                using (OracleDataReader reader = cmdGetRiskCustomer.ExecuteReader())
                {
                    int rowCounter = 0;
                    if (reader.HasRows)
                    {
                        int idRisk = reader.GetOrdinal("riskid");
                        int iddatebegin = reader.GetOrdinal("dat_begin");
                        int iddateend = reader.GetOrdinal("dat_end");

                        while (reader.Read())
                        {
                            CustomerRisk CustomerRisk = new CustomerRisk();
                            CustomerRisk.RiskId = Convert.ToDecimal(OracleHelper.GetDecimalString(reader, idRisk, "0"));
                            CustomerRisk.Dat_Begin = OracleHelper.GetString(reader, iddatebegin);
                            CustomerRisk.Dat_End = OracleHelper.GetString(reader, iddateend);
                            CustomerRiskSet[rowCounter++] = CustomerRisk;
                            if (rowCounter % 100 == 0)
                                Array.Resize(ref CustomerRiskSet, rowCounter + 100);
                        }
                    }
                    Array.Resize(ref CustomerRiskSet, rowCounter++);
                }
            }
            return CustomerRiskSet;
        }
        public static SetClient CreateCustomer(SetClient ClientReq, OracleConnection connect)
        {
            HttpContext ctx = HttpContext.Current;
            Int16 str = 50;
            Int16 longstr = 400;
            Int16 hugestr = 4000;

            ClientCommonReq _ClientCommonReq = new ClientCommonReq(); if (ClientReq.ClientRequisites != null) { _ClientCommonReq = ClientReq.ClientRequisites; }
            AdditionalInfo _AdditionalInfo = new AdditionalInfo(); if (_ClientCommonReq.AdditionalInfo != null) { _AdditionalInfo = _ClientCommonReq.AdditionalInfo; }
            EconomicIndicators _EconomicIndicators = new EconomicIndicators(); if (_ClientCommonReq.EconomicIndicators != null) { _EconomicIndicators = _ClientCommonReq.EconomicIndicators; }
            TaxIndicators _TaxIndicators = new TaxIndicators(); if (_ClientCommonReq.TaxIndicators != null) { _TaxIndicators = _ClientCommonReq.TaxIndicators; }

            Person _ClientPerson = new Person();
            if (_ClientCommonReq.ClientPerson != null)
            {
                _ClientPerson = _ClientCommonReq.ClientPerson;
            }

            NMK _NMKSplit = new NMK(); if (_ClientCommonReq.NMKSplit != null) { _NMKSplit = _ClientCommonReq.NMKSplit; }

            CustAddress _ClientAddressLegal = new CustAddress(); if (_ClientCommonReq.ClientAddressLegal != null) { _ClientAddressLegal = _ClientCommonReq.ClientAddressLegal; }
            CustAddress _ClientAddressActual = new CustAddress(); if (_ClientCommonReq.ClientAddressActual != null) { _ClientAddressActual = _ClientCommonReq.ClientAddressActual; }
            CustAddress _ClientAddressPostal = new CustAddress(); if (_ClientCommonReq.ClientAddressPostal != null) { _ClientAddressPostal = _ClientCommonReq.ClientAddressPostal; }

            AdditionalReq _AdditionalReq = new AdditionalReq(); if (_ClientCommonReq.AdditionalReq != null) { _AdditionalReq = _ClientCommonReq.AdditionalReq; }
            AdditionalCommon _AdditionalCommon = new AdditionalCommon(); if (_AdditionalReq.AdditionalCommon != null) { _AdditionalCommon = _ClientCommonReq.AdditionalReq.AdditionalCommon; }
            AdditionalFM _AdditionalFM = new AdditionalFM(); if (_AdditionalReq.AdditionalFM != null) { _AdditionalFM = _AdditionalReq.AdditionalFM; }
            AdditionalDeposit _AdditionalDeposit = new AdditionalDeposit(); if (_AdditionalReq.AdditionalDeposit != null) { _AdditionalDeposit = _AdditionalReq.AdditionalDeposit; }
            AdditionalBPK _AdditionalBPK = new AdditionalBPK(); if (_AdditionalReq.AdditionalBPK != null) { _AdditionalBPK = _AdditionalReq.AdditionalBPK; }
            AdditionalMisc _AdditionalMisc = new AdditionalMisc(); if (_AdditionalReq.AdditionalMisc != null) { _AdditionalMisc = _AdditionalReq.AdditionalMisc; }
            CheckClient checkClient = new CheckClient(); if (_ClientCommonReq.CheckClient != null) { checkClient = _ClientCommonReq.CheckClient; }

            using (OracleCommand cmdSearchCustomer = connect.CreateCommand())
            {
                try
                {
                    switch (ClientReq.OperationType)
                    {
                        case 0:
                            DbLoggerConstruct.NewDbLogger().Info("Пользователь начал чтение о клиенте с OKPO = " + _ClientCommonReq.OKPO, "XRMIntegrationCustomer");
                            break;
                        case 1:
                            DbLoggerConstruct.NewDbLogger().Info("Пользователь начал регистрацию клиента с OKPO = " + _ClientCommonReq.OKPO, "XRMIntegrationCustomer");
                            break;
                        case 2:
                            DbLoggerConstruct.NewDbLogger().Info("Пользователь начал обновление реквизитов клиента с OKPO = " + _ClientCommonReq.OKPO, "XRMIntegrationCustomer");
                            break;
                        case 3:
                            DbLoggerConstruct.NewDbLogger().Info("Пользователь начал процедуру закрытия клиента с OKPO = " + _ClientCommonReq.OKPO, "XRMIntegrationCustomer");
                            break;
                    }

                    cmdSearchCustomer.CommandType = CommandType.StoredProcedure;
                    cmdSearchCustomer.CommandText = "xrm_integration_oe.open_customer";
                    cmdSearchCustomer.BindByName = true;
                    #region add params
                    cmdSearchCustomer.Parameters.Add("p_TransactionId", OracleDbType.Decimal, ClientReq.TransactionId, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_UserLogin", OracleDbType.Varchar2, str, ClientReq.UserLogin, ParameterDirection.InputOutput);

                    cmdSearchCustomer.Parameters.Add("p_OperationType", OracleDbType.Int16, str, ClientReq.OperationType, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_ClientType", OracleDbType.Int16, ClientReq.ClientType, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_FormType", OracleDbType.Int16, ClientReq.FormType, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_KF", OracleDbType.Varchar2, str, _ClientCommonReq.KF, ParameterDirection.InputOutput);

                    cmdSearchCustomer.Parameters.Add("p_client_name", OracleDbType.Varchar2, str, _NMKSplit.LastName, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_client_surname", OracleDbType.Varchar2, str, _NMKSplit.FirstName, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_client_patr", OracleDbType.Varchar2, str, _NMKSplit.ThirdName, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Custtype_", OracleDbType.Decimal, _ClientCommonReq.CUSTTYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Nd_", OracleDbType.Varchar2, str, _AdditionalInfo.ND, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Nmk_", OracleDbType.Varchar2, longstr, _ClientCommonReq.NMK, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Nmkv_", OracleDbType.Varchar2, longstr, _ClientCommonReq.NMKV, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Nmkk_", OracleDbType.Varchar2, longstr, _ClientCommonReq.NMKK, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Adr_", OracleDbType.Varchar2, longstr, _ClientCommonReq.ADDR, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Codcagent_", OracleDbType.Decimal, _ClientCommonReq.CODCAGENT, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Country_", OracleDbType.Decimal, _EconomicIndicators.COUNTRY, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Prinsider_", OracleDbType.Decimal, _EconomicIndicators.PRINSIDER, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Tgr_", OracleDbType.Decimal, _EconomicIndicators.TGR, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Okpo_", OracleDbType.Varchar2, str, _ClientCommonReq.OKPO, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Stmt_", OracleDbType.Varchar2, str, null, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Sab_", OracleDbType.Varchar2, str, _EconomicIndicators.SAB, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("DateOn_", OracleDbType.Date, XrmHelper.GmtToLocal(_ClientCommonReq.DATE_ON), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_DateOff", OracleDbType.Date, XrmHelper.GmtToLocal(_ClientCommonReq.DATE_OFF), ParameterDirection.InputOutput).IsNullable = true;
                    cmdSearchCustomer.Parameters.Add("Taxf_", OracleDbType.Varchar2, str, _TaxIndicators.TAXF, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("CReg_", OracleDbType.Decimal, _TaxIndicators.C_REG, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("CDst_", OracleDbType.Decimal, _TaxIndicators.C_DST, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Adm_", OracleDbType.Varchar2, longstr, _TaxIndicators.ADM, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("RgTax_", OracleDbType.Varchar2, str, _TaxIndicators.RGTAX, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("RgAdm_", OracleDbType.Varchar2, str, _TaxIndicators.RGADM, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("DateT_", OracleDbType.Date, XrmHelper.GmtToLocal(_TaxIndicators.DPIDate), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("DateA_", OracleDbType.Date, XrmHelper.GmtToLocal(_TaxIndicators.RGADMDate), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Ise_", OracleDbType.Varchar2, str, _EconomicIndicators.ISE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Fs_", OracleDbType.Varchar2, str, _EconomicIndicators.FS, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Oe_", OracleDbType.Varchar2, str, _EconomicIndicators.OE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Ved_", OracleDbType.Varchar2, str, _EconomicIndicators.VED, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Sed_", OracleDbType.Varchar2, str, _EconomicIndicators.SED, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("K050_", OracleDbType.Varchar2, str, _EconomicIndicators.K050, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Notes_", OracleDbType.Varchar2, longstr, _AdditionalInfo.Notes, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Notesec_", OracleDbType.Varchar2, longstr, _AdditionalInfo.SecurityNotes, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("CRisk_", OracleDbType.Varchar2, str, _EconomicIndicators.CRISK, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Pincode_", OracleDbType.Varchar2, str, _EconomicIndicators.PINCODE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("RnkP_", OracleDbType.Decimal, _AdditionalInfo.Holding, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Lim_", OracleDbType.Decimal, _AdditionalInfo.ActLimit, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("NomPDV_", OracleDbType.Varchar2, str, _TaxIndicators.nomPDV, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("MB_", OracleDbType.Varchar2, str, _EconomicIndicators.MB, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("BC_", OracleDbType.Varchar2, str, _EconomicIndicators.BC, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Tobo_", OracleDbType.Varchar2, str, _ClientCommonReq.TOBO, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Isp_", OracleDbType.Decimal, ClientReq.ClientManager, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_nrezid_code", OracleDbType.Varchar2, str, "", ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_flag_visa", OracleDbType.Decimal, 0, ParameterDirection.Input);

                    /**/
                    cmdSearchCustomer.Parameters.Add("Sex_", OracleDbType.Decimal, _ClientPerson.SEX, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Passp_", OracleDbType.Decimal, _ClientPerson.PASSP, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Ser_", OracleDbType.Varchar2, str, _ClientPerson.SER, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Numdoc_", OracleDbType.Varchar2, str, _ClientPerson.DOCNUM, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Pdate_", OracleDbType.Date, XrmHelper.GmtToLocal(_ClientPerson.PasspFrom), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Organ_", OracleDbType.Varchar2, longstr, _ClientPerson.OrganMain, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Fdate_", OracleDbType.Date, XrmHelper.GmtToLocal(_ClientPerson.PasspPhoto), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Bday_", OracleDbType.Date, XrmHelper.GmtToLocal(_ClientPerson.Birthday), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Bplace_", OracleDbType.Varchar2, longstr, _ClientPerson.Birthplace, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Teld_", OracleDbType.Varchar2, str, _ClientPerson.HomePhone, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Telw_", OracleDbType.Varchar2, str, _ClientPerson.WorkPhone, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("Telm_", OracleDbType.Varchar2, str, _ClientPerson.MobPhone, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("actual_date_", OracleDbType.Date, XrmHelper.GmtToLocal(_ClientPerson.PasspFrom), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("eddr_id_", OracleDbType.Varchar2, str, _ClientPerson.EDDR_ID, ParameterDirection.InputOutput);

                    cmdSearchCustomer.Parameters.Add("LimKass_", OracleDbType.Decimal, _AdditionalInfo.CashLimit, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("AdrAlt_", OracleDbType.Varchar2, longstr, _AdditionalInfo.OtherADDRESS, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("NomDog_", OracleDbType.Varchar2, str, _AdditionalInfo.ND, ParameterDirection.InputOutput);

                    cmdSearchCustomer.Parameters.Add("p_clientname_gc", OracleDbType.Varchar2, hugestr, _ClientCommonReq.NMKR, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_clientid", OracleDbType.Decimal, _ClientCommonReq.RNK, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_status", OracleDbType.Decimal, ClientReq.Status, ParameterDirection.Output);
                    cmdSearchCustomer.Parameters.Add("p_status_code", OracleDbType.Varchar2, hugestr, ClientReq.StatusCode, ParameterDirection.Output);
                    cmdSearchCustomer.Parameters.Add("p_error_code", OracleDbType.Varchar2, hugestr, ClientReq.ErrorCode, ParameterDirection.Output);

                    cmdSearchCustomer.Parameters.Add("p_1country", OracleDbType.Decimal, _ClientAddressLegal.COUNTRY, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1zip", OracleDbType.Varchar2, str, _ClientAddressLegal.ZIP, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1domain", OracleDbType.Varchar2, longstr, _ClientAddressLegal.DOMAIN, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1region", OracleDbType.Varchar2, longstr, _ClientAddressLegal.REGION, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1locality", OracleDbType.Varchar2, hugestr, _ClientAddressLegal.LOCALITY, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1address", OracleDbType.Varchar2, hugestr, _ClientAddressLegal.ADDRESS, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1territoryId", OracleDbType.Decimal, _ClientAddressLegal.TERRITORY_ID, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1locality_type", OracleDbType.Decimal, _ClientAddressLegal.LOCALITY_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1street_type", OracleDbType.Decimal, _ClientAddressLegal.STREET_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1street", OracleDbType.Varchar2, longstr, _ClientAddressLegal.STREET, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1home_type", OracleDbType.Decimal, _ClientAddressLegal.HOME_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1home", OracleDbType.Varchar2, str, _ClientAddressLegal.HOME, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1homepart_type", OracleDbType.Decimal, _ClientAddressLegal.HOMEPART_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1homepart", OracleDbType.Varchar2, str, _ClientAddressLegal.HOMEPART, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1room_type", OracleDbType.Decimal, _ClientAddressLegal.ROOM_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1room", OracleDbType.Varchar2, str, _ClientAddressLegal.ROOM, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_1comment", OracleDbType.Varchar2, str, _ClientAddressLegal.COMM, ParameterDirection.InputOutput);
                    //cmdSearchCustomer.Parameters.Add("p_1region_id", OracleDbType.Varchar2, str, _ClientAddressLegal.REGION, ParameterDirection.InputOutput);
                    //cmdSearchCustomer.Parameters.Add("p_1area_id", OracleDbType.Varchar2, str, _ClientAddressLegal.AREA, ParameterDirection.InputOutput);
                    //cmdSearchCustomer.Parameters.Add("p_1settlement_id", OracleDbType.Varchar2, str, _ClientAddressLegal.SETTLEMENT, ParameterDirection.InputOutput);
                    //cmdSearchCustomer.Parameters.Add("p_1street_id", OracleDbType.Varchar2, str, _ClientAddressLegal.STREET_ID, ParameterDirection.InputOutput);

                    cmdSearchCustomer.Parameters.Add("p_2country", OracleDbType.Decimal, _ClientAddressActual.COUNTRY, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2zip", OracleDbType.Varchar2, str, _ClientAddressActual.ZIP, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2domain", OracleDbType.Varchar2, longstr, _ClientAddressActual.DOMAIN, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2region", OracleDbType.Varchar2, longstr, _ClientAddressActual.REGION, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2locality", OracleDbType.Varchar2, hugestr, _ClientAddressActual.LOCALITY, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2address", OracleDbType.Varchar2, hugestr, _ClientAddressActual.ADDRESS, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2territoryId", OracleDbType.Decimal, _ClientAddressActual.TERRITORY_ID, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2locality_type", OracleDbType.Decimal, _ClientAddressActual.LOCALITY_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2street_type", OracleDbType.Decimal, _ClientAddressActual.STREET_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2street", OracleDbType.Varchar2, longstr, _ClientAddressActual.STREET, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2home_type", OracleDbType.Decimal, _ClientAddressActual.HOME_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2home", OracleDbType.Varchar2, str, _ClientAddressActual.HOME, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2homepart_type", OracleDbType.Decimal, _ClientAddressActual.HOMEPART_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2homepart", OracleDbType.Varchar2, str, _ClientAddressActual.HOMEPART, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2room_type", OracleDbType.Decimal, _ClientAddressActual.ROOM_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2room", OracleDbType.Varchar2, str, _ClientAddressActual.ROOM, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_2comment", OracleDbType.Varchar2, str, _ClientAddressActual.COMM, ParameterDirection.InputOutput);
                    //cmdSearchCustomer.Parameters.Add("p_2region_id", OracleDbType.Varchar2, str, _ClientAddressActual.REGION, ParameterDirection.InputOutput);
                    //cmdSearchCustomer.Parameters.Add("p_2area_id", OracleDbType.Varchar2, str, _ClientAddressActual.AREA, ParameterDirection.InputOutput);
                    //cmdSearchCustomer.Parameters.Add("p_2settlement_id", OracleDbType.Varchar2, str, _ClientAddressActual.SETTLEMENT, ParameterDirection.InputOutput);
                    //cmdSearchCustomer.Parameters.Add("p_2street_id", OracleDbType.Varchar2, str, _ClientAddressActual.STREET_ID, ParameterDirection.InputOutput);

                    cmdSearchCustomer.Parameters.Add("p_3country", OracleDbType.Decimal, _ClientAddressPostal.COUNTRY, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3zip", OracleDbType.Varchar2, str, _ClientAddressPostal.ZIP, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3domain", OracleDbType.Varchar2, longstr, _ClientAddressPostal.DOMAIN, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3region", OracleDbType.Varchar2, longstr, _ClientAddressPostal.REGION, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3locality", OracleDbType.Varchar2, hugestr, _ClientAddressPostal.LOCALITY, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3address", OracleDbType.Varchar2, hugestr, _ClientAddressPostal.ADDRESS, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3territoryId", OracleDbType.Decimal, _ClientAddressPostal.TERRITORY_ID, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3locality_type", OracleDbType.Decimal, _ClientAddressPostal.LOCALITY_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3street_type", OracleDbType.Decimal, _ClientAddressPostal.STREET_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3street", OracleDbType.Varchar2, longstr, _ClientAddressPostal.STREET, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3home_type", OracleDbType.Decimal, _ClientAddressPostal.HOME_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3home", OracleDbType.Varchar2, str, _ClientAddressPostal.HOME, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3homepart_type", OracleDbType.Decimal, _ClientAddressPostal.HOMEPART_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3homepart", OracleDbType.Varchar2, str, _ClientAddressPostal.HOMEPART, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3room_type", OracleDbType.Decimal, _ClientAddressPostal.ROOM_TYPE, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3room", OracleDbType.Varchar2, str, _ClientAddressPostal.ROOM, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_3comment", OracleDbType.Varchar2, str, _ClientAddressPostal.COMM, ParameterDirection.InputOutput);
                    // cmdSearchCustomer.Parameters.Add("p_3region_id", OracleDbType.Varchar2, str, _ClientAddressPostal.REGION, ParameterDirection.InputOutput);
                    // cmdSearchCustomer.Parameters.Add("p_3area_id", OracleDbType.Varchar2, str, _ClientAddressPostal.AREA, ParameterDirection.InputOutput);
                    // cmdSearchCustomer.Parameters.Add("p_3settlement_id", OracleDbType.Varchar2, str, _ClientAddressPostal.SETTLEMENT, ParameterDirection.InputOutput);
                    // cmdSearchCustomer.Parameters.Add("p_3street_id", OracleDbType.Varchar2, str, _ClientAddressPostal.STREET_ID, ParameterDirection.InputOutput);

                    //check terrorists,insiders
                    cmdSearchCustomer.Parameters.Add("p_relid", OracleDbType.Decimal, checkClient.RelId, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_relrnk", OracleDbType.Decimal, checkClient.RelRnk, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_relintext", OracleDbType.Decimal, checkClient.Relintext, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_vaga1", OracleDbType.Decimal, checkClient.Vaga1, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_vaga2", OracleDbType.Decimal, checkClient.Vaga2, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_typeid", OracleDbType.Decimal, checkClient.TypeId, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_position", OracleDbType.Varchar2, checkClient.Position, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_position_r", OracleDbType.Varchar2, checkClient.Position_r, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_firstname", OracleDbType.Varchar2, checkClient.FirstName, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_middlename", OracleDbType.Varchar2, checkClient.MiddleName, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_lastname", OracleDbType.Varchar2, checkClient.LastName, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_documenttypeid", OracleDbType.Decimal, checkClient.DocumentTypeId, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_document", OracleDbType.Varchar2, checkClient.Document, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_trustregnum", OracleDbType.Varchar2, checkClient.TrustRegNum, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_trustregdat", OracleDbType.Date, XrmHelper.GmtToLocal(checkClient.TrustRegDat), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_bdate", OracleDbType.Date, XrmHelper.GmtToLocal(checkClient.BDate), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_edate", OracleDbType.Date, XrmHelper.GmtToLocal(checkClient.EDate), ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_notaryname", OracleDbType.Varchar2, checkClient.NotaryName, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_notaryregion", OracleDbType.Varchar2, checkClient.NotaryRegion, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_signprivs", OracleDbType.Decimal, checkClient.SignPrivs, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_signid", OracleDbType.Decimal, checkClient.SignId, ParameterDirection.InputOutput);
                    cmdSearchCustomer.Parameters.Add("p_namer", OracleDbType.Varchar2, checkClient.Namer, ParameterDirection.InputOutput);
                    #endregion

                    cmdSearchCustomer.ExecuteNonQuery();

                    ClientReq.RNK = ((OracleDecimal)cmdSearchCustomer.Parameters["p_clientid"].Value) == null ? -1 : ((OracleDecimal)cmdSearchCustomer.Parameters["p_clientid"].Value).Value;
                    ClientReq.Status = ((OracleDecimal)cmdSearchCustomer.Parameters["p_status"].Value) == null ? -1 : ((OracleDecimal)cmdSearchCustomer.Parameters["p_status"].Value).Value;
                    ClientReq.NMKR = ((OracleString)cmdSearchCustomer.Parameters["p_clientname_gc"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_clientname_gc"].Value).Value;
                    ClientReq.StatusCode = ((OracleString)cmdSearchCustomer.Parameters["p_status_code"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_status_code"].Value).Value;
                    ClientReq.ErrorCode = ((OracleString)cmdSearchCustomer.Parameters["p_error_code"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_error_code"].Value).Value;

                    if (ClientReq.Status == 0)
                    {
                        #region hell...
                        Decimal _RNK = ClientReq.RNK;
                        _ClientCommonReq.RNK = ClientReq.RNK;
                        _ClientCommonReq.CUSTTYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["Custtype_"].Value) == null ? -1 : ((OracleDecimal)cmdSearchCustomer.Parameters["Custtype_"].Value).Value;
                        _ClientCommonReq.NMK = ((OracleString)cmdSearchCustomer.Parameters["Nmk_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Nmk_"].Value).Value;
                        _ClientCommonReq.NMKV = ((OracleString)cmdSearchCustomer.Parameters["Nmkv_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Nmkv_"].Value).Value;
                        _ClientCommonReq.NMKK = ((OracleString)cmdSearchCustomer.Parameters["Nmkk_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Nmkk_"].Value).Value;
                        _ClientCommonReq.ADDR = ((OracleString)cmdSearchCustomer.Parameters["Adr_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Adr_"].Value).Value;

                        _ClientCommonReq.CODCAGENT = ((OracleDecimal)cmdSearchCustomer.Parameters["Codcagent_"].Value).Value;
                        _ClientCommonReq.DATE_ON = ((OracleDate)cmdSearchCustomer.Parameters["DateOn_"].Value).Value;
                        if (!((OracleDate)cmdSearchCustomer.Parameters["p_DateOff"].Value).IsNull)
                        { _ClientCommonReq.DATE_OFF = Convert.ToDateTime(((OracleDate)cmdSearchCustomer.Parameters["p_DateOff"].Value).Value); }
                        else
                        { _ClientCommonReq.DATE_OFF = null; }
                        _ClientCommonReq.TOBO = ((OracleString)cmdSearchCustomer.Parameters["Tobo_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Tobo_"].Value).Value;

                        _EconomicIndicators.COUNTRY = ((OracleDecimal)cmdSearchCustomer.Parameters["Country_"].Value).Value;
                        _EconomicIndicators.PRINSIDER = ((OracleDecimal)cmdSearchCustomer.Parameters["Prinsider_"].Value).Value;
                        _EconomicIndicators.TGR = ((OracleDecimal)cmdSearchCustomer.Parameters["Tgr_"].Value) == null ? 0 : ((OracleDecimal)cmdSearchCustomer.Parameters["Tgr_"].Value).Value;
                        _EconomicIndicators.SAB = ((OracleString)cmdSearchCustomer.Parameters["Sab_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Sab_"].Value).Value;
                        _EconomicIndicators.ISE = ((OracleString)cmdSearchCustomer.Parameters["Ise_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Ise_"].Value).Value;
                        _EconomicIndicators.FS = ((OracleString)cmdSearchCustomer.Parameters["Fs_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Fs_"].Value).Value;
                        _EconomicIndicators.OE = ((OracleString)cmdSearchCustomer.Parameters["Oe_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Oe_"].Value).Value;
                        _EconomicIndicators.VED = ((OracleString)cmdSearchCustomer.Parameters["Ved_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Ved_"].Value).Value;
                        _EconomicIndicators.SED = ((OracleString)cmdSearchCustomer.Parameters["Sed_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Sed_"].Value).Value;
                        _EconomicIndicators.PINCODE = ((OracleString)cmdSearchCustomer.Parameters["Pincode_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Pincode_"].Value).Value;
                        _EconomicIndicators.CRISK = ((OracleString)cmdSearchCustomer.Parameters["CRisk_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["CRisk_"].Value).Value;
                        _EconomicIndicators.RnkP = ((OracleDecimal)cmdSearchCustomer.Parameters["RnkP_"].Value) == null ? 0 : ((OracleDecimal)cmdSearchCustomer.Parameters["RnkP_"].Value).Value;

                        _EconomicIndicators.MB = ((OracleString)cmdSearchCustomer.Parameters["MB_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["MB_"].Value).Value;
                        _EconomicIndicators.BC = ((OracleString)cmdSearchCustomer.Parameters["BC_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["BC_"].Value).Value;
                        _EconomicIndicators.NREZID_CODE = ((OracleString)cmdSearchCustomer.Parameters["p_nrezid_code"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_nrezid_code"].Value).Value;

                        _AdditionalInfo.ND = ((OracleString)cmdSearchCustomer.Parameters["Nd_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Nd_"].Value).Value;
                        _AdditionalInfo.Notes = ((OracleString)cmdSearchCustomer.Parameters["Notes_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Notes_"].Value).Value;
                        _AdditionalInfo.SecurityNotes = ((OracleString)cmdSearchCustomer.Parameters["Notesec_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Notesec_"].Value).Value;
                        _AdditionalInfo.ActLimit = ((OracleDecimal)cmdSearchCustomer.Parameters["Lim_"].Value) == null ? 0 : ((OracleDecimal)cmdSearchCustomer.Parameters["Lim_"].Value).Value;
                        ClientReq.ClientManager = ((OracleDecimal)cmdSearchCustomer.Parameters["Isp_"].Value) == null ? 0 : ((OracleDecimal)cmdSearchCustomer.Parameters["Isp_"].Value).Value;

                        _TaxIndicators.TAXF = ((OracleString)cmdSearchCustomer.Parameters["Taxf_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Taxf_"].Value).Value;
                        _TaxIndicators.C_REG = ((OracleDecimal)cmdSearchCustomer.Parameters["CReg_"].Value) == null ? -1 : ((OracleDecimal)cmdSearchCustomer.Parameters["CReg_"].Value).Value;
                        _TaxIndicators.C_DST = ((OracleDecimal)cmdSearchCustomer.Parameters["CDst_"].Value) == null ? -1 : ((OracleDecimal)cmdSearchCustomer.Parameters["CDst_"].Value).Value;
                        _TaxIndicators.ADM = ((OracleString)cmdSearchCustomer.Parameters["Adm_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Adm_"].Value).Value;
                        _TaxIndicators.RGTAX = ((OracleString)cmdSearchCustomer.Parameters["RgTax_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["RgTax_"].Value).Value;
                        _TaxIndicators.RGADM = ((OracleString)cmdSearchCustomer.Parameters["RgAdm_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["RgAdm_"].Value).Value;

                        if (!((OracleDate)cmdSearchCustomer.Parameters["DateT_"].Value).IsNull) { _TaxIndicators.DPIDate = ((OracleDate)cmdSearchCustomer.Parameters["DateT_"].Value).Value; } else { _TaxIndicators.DPIDate = null; }
                        if (!((OracleDate)cmdSearchCustomer.Parameters["DateA_"].Value).IsNull) { _TaxIndicators.RGADMDate = ((OracleDate)cmdSearchCustomer.Parameters["DateA_"].Value).Value; } else { _TaxIndicators.RGADMDate = null; }
                        _TaxIndicators.nomPDV = ((OracleString)cmdSearchCustomer.Parameters["NomPDV_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["NomPDV_"].Value).Value;

                        _ClientAddressLegal.TYPE_ID = 1;
                        _ClientAddressActual.TYPE_ID = 2;
                        _ClientAddressPostal.TYPE_ID = 3;

                        _ClientAddressLegal.COUNTRY = ((OracleDecimal)cmdSearchCustomer.Parameters["p_1country"].Value).Value;
                        _ClientAddressPostal.COUNTRY = ((OracleDecimal)cmdSearchCustomer.Parameters["p_3country"].Value).Value;
                        _ClientAddressActual.COUNTRY = ((OracleDecimal)cmdSearchCustomer.Parameters["p_2country"].Value).Value;

                        _ClientAddressLegal.ZIP = ((OracleString)cmdSearchCustomer.Parameters["p_1zip"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1zip"].Value).Value;
                        _ClientAddressPostal.ZIP = ((OracleString)cmdSearchCustomer.Parameters["p_3zip"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3zip"].Value).Value;
                        _ClientAddressActual.ZIP = ((OracleString)cmdSearchCustomer.Parameters["p_2zip"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2zip"].Value).Value;

                        _ClientAddressLegal.DOMAIN = ((OracleString)cmdSearchCustomer.Parameters["p_1domain"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1domain"].Value).Value;
                        _ClientAddressPostal.DOMAIN = ((OracleString)cmdSearchCustomer.Parameters["p_3domain"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3domain"].Value).Value;
                        _ClientAddressActual.DOMAIN = ((OracleString)cmdSearchCustomer.Parameters["p_2domain"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2domain"].Value).Value;

                        _ClientAddressLegal.REGION = ((OracleString)cmdSearchCustomer.Parameters["p_1region"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1region"].Value).Value;
                        _ClientAddressPostal.REGION = ((OracleString)cmdSearchCustomer.Parameters["p_3region"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3region"].Value).Value;
                        _ClientAddressActual.REGION = ((OracleString)cmdSearchCustomer.Parameters["p_2region"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2region"].Value).Value;

                        _ClientAddressLegal.LOCALITY = ((OracleString)cmdSearchCustomer.Parameters["p_1locality"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1locality"].Value).Value;
                        _ClientAddressPostal.LOCALITY = ((OracleString)cmdSearchCustomer.Parameters["p_3locality"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3locality"].Value).Value;
                        _ClientAddressActual.LOCALITY = ((OracleString)cmdSearchCustomer.Parameters["p_2locality"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2locality"].Value).Value;

                        _ClientAddressLegal.ADDRESS = ((OracleString)cmdSearchCustomer.Parameters["p_1address"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1address"].Value).Value;
                        _ClientAddressPostal.ADDRESS = ((OracleString)cmdSearchCustomer.Parameters["p_3address"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3address"].Value).Value;
                        _ClientAddressActual.ADDRESS = ((OracleString)cmdSearchCustomer.Parameters["p_2address"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2address"].Value).Value;

                        _ClientAddressLegal.TERRITORY_ID = ((OracleDecimal)cmdSearchCustomer.Parameters["p_1territoryId"].Value) == null ? 0 : ((OracleDecimal)cmdSearchCustomer.Parameters["p_1territoryId"].Value).Value;
                        _ClientAddressPostal.TERRITORY_ID = ((OracleDecimal)cmdSearchCustomer.Parameters["p_3territoryId"].Value) == null ? 0 : ((OracleDecimal)cmdSearchCustomer.Parameters["p_3territoryId"].Value).Value;
                        _ClientAddressActual.TERRITORY_ID = ((OracleDecimal)cmdSearchCustomer.Parameters["p_2territoryId"].Value) == null ? 0 : ((OracleDecimal)cmdSearchCustomer.Parameters["p_2territoryId"].Value).Value;

                        _ClientAddressLegal.LOCALITY_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_1locality_type"].Value).Value;
                        _ClientAddressPostal.LOCALITY_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_3locality_type"].Value).Value;
                        _ClientAddressActual.LOCALITY_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_2locality_type"].Value).Value;

                        _ClientAddressLegal.STREET_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_1street_type"].Value).Value;
                        _ClientAddressPostal.STREET_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_3street_type"].Value).Value;
                        _ClientAddressActual.STREET_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_2street_type"].Value).Value;

                        _ClientAddressLegal.STREET = ((OracleString)cmdSearchCustomer.Parameters["p_1street"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1street"].Value).Value;
                        _ClientAddressPostal.STREET = ((OracleString)cmdSearchCustomer.Parameters["p_3street"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3street"].Value).Value;
                        _ClientAddressActual.STREET = ((OracleString)cmdSearchCustomer.Parameters["p_2street"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2street"].Value).Value;

                        _ClientAddressLegal.HOME_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_1home_type"].Value).Value;
                        _ClientAddressPostal.HOME_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_3home_type"].Value).Value;
                        _ClientAddressActual.HOME_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_2home_type"].Value).Value;

                        _ClientAddressLegal.HOME = ((OracleString)cmdSearchCustomer.Parameters["p_1home"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1home"].Value).Value;
                        _ClientAddressPostal.HOME = ((OracleString)cmdSearchCustomer.Parameters["p_3home"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3home"].Value).Value;
                        _ClientAddressActual.HOME = ((OracleString)cmdSearchCustomer.Parameters["p_2home"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2home"].Value).Value;

                        _ClientAddressLegal.HOMEPART_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_1homepart_type"].Value).Value;
                        _ClientAddressPostal.HOMEPART_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_3homepart_type"].Value).Value;
                        _ClientAddressActual.HOMEPART_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_2homepart_type"].Value).Value;

                        _ClientAddressLegal.HOMEPART = ((OracleString)cmdSearchCustomer.Parameters["p_1homepart"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1homepart"].Value).Value;
                        _ClientAddressPostal.HOMEPART = ((OracleString)cmdSearchCustomer.Parameters["p_3homepart"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3homepart"].Value).Value;
                        _ClientAddressActual.HOMEPART = ((OracleString)cmdSearchCustomer.Parameters["p_2homepart"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2homepart"].Value).Value;

                        _ClientAddressLegal.ROOM_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_1room_type"].Value).Value;
                        _ClientAddressPostal.ROOM_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_3room_type"].Value).Value;
                        _ClientAddressActual.ROOM_TYPE = ((OracleDecimal)cmdSearchCustomer.Parameters["p_2room_type"].Value).Value;

                        _ClientAddressLegal.ROOM = ((OracleString)cmdSearchCustomer.Parameters["p_1room"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1room"].Value).Value;
                        _ClientAddressPostal.ROOM = ((OracleString)cmdSearchCustomer.Parameters["p_3room"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3room"].Value).Value;
                        _ClientAddressActual.ROOM = ((OracleString)cmdSearchCustomer.Parameters["p_2room"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2room"].Value).Value;
                        _ClientAddressLegal.COMM = ((OracleString)cmdSearchCustomer.Parameters["p_1comment"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_1comment"].Value).Value;
                        _ClientAddressPostal.COMM = ((OracleString)cmdSearchCustomer.Parameters["p_3comment"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_3comment"].Value).Value;
                        _ClientAddressActual.COMM = ((OracleString)cmdSearchCustomer.Parameters["p_2comment"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["p_2comment"].Value).Value;

                        _ClientPerson.PASSP = ((OracleDecimal)cmdSearchCustomer.Parameters["Passp_"].Value) == null ? 1 : ((OracleDecimal)cmdSearchCustomer.Parameters["Passp_"].Value).Value;
                        _ClientPerson.SER = ((OracleString)cmdSearchCustomer.Parameters["Ser_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Ser_"].Value).Value;
                        _ClientPerson.DOCNUM = ((OracleString)cmdSearchCustomer.Parameters["Numdoc_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Numdoc_"].Value).Value;
                        if (!((OracleDate)cmdSearchCustomer.Parameters["Pdate_"].Value).IsNull) { _ClientPerson.PasspFrom = ((OracleDate)cmdSearchCustomer.Parameters["Pdate_"].Value).Value; } else { _ClientPerson.PasspFrom = null; }
                        if (!((OracleDate)cmdSearchCustomer.Parameters["Fdate_"].Value).IsNull) { _ClientPerson.PasspPhoto = ((OracleDate)cmdSearchCustomer.Parameters["Fdate_"].Value).Value; } else { _ClientPerson.PasspPhoto = null; }
                        _ClientPerson.OrganMain = ((OracleString)cmdSearchCustomer.Parameters["Organ_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Organ_"].Value).Value;
                        if (!((OracleDate)cmdSearchCustomer.Parameters["Bday_"].Value).IsNull) { _ClientPerson.Birthday = ((OracleDate)cmdSearchCustomer.Parameters["Bday_"].Value).Value; } else { _ClientPerson.Birthday = null; }
                        _ClientPerson.Birthplace = ((OracleString)cmdSearchCustomer.Parameters["Bplace_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Bplace_"].Value).Value;
                        _ClientPerson.HomePhone = ((OracleString)cmdSearchCustomer.Parameters["Teld_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Teld_"].Value).Value;
                        _ClientPerson.WorkPhone = ((OracleString)cmdSearchCustomer.Parameters["Telw_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Telw_"].Value).Value;
                        _ClientPerson.MobPhone = ((OracleString)cmdSearchCustomer.Parameters["Telm_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["Telm_"].Value).Value;
                        if (!((OracleDate)cmdSearchCustomer.Parameters["actual_date_"].Value).IsNull) { _ClientPerson.PASSP_EXPIRES = ((OracleDate)cmdSearchCustomer.Parameters["actual_date_"].Value).Value; } else { _ClientPerson.PASSP_EXPIRES = null; }
                        _ClientPerson.EDDR_ID = ((OracleString)cmdSearchCustomer.Parameters["eddr_id_"].Value) == null ? "" : ((OracleString)cmdSearchCustomer.Parameters["eddr_id_"].Value).Value;
                        _ClientPerson.SEX = ((OracleDecimal)cmdSearchCustomer.Parameters["Sex_"].Value).Value;

                        checkClient.RelId = ((OracleDecimal)cmdSearchCustomer.Parameters["p_relid"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_relid"].Value).Value;
                        checkClient.RelRnk = ((OracleDecimal)cmdSearchCustomer.Parameters["p_relrnk"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_relrnk"].Value).Value;
                        checkClient.Relintext = ((OracleDecimal)cmdSearchCustomer.Parameters["p_relintext"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_relintext"].Value).Value;
                        checkClient.Vaga1 = ((OracleDecimal)cmdSearchCustomer.Parameters["p_vaga1"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_vaga1"].Value).Value;
                        checkClient.Vaga2 = ((OracleDecimal)cmdSearchCustomer.Parameters["p_vaga2"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_vaga2"].Value).Value;
                        checkClient.TypeId = ((OracleDecimal)cmdSearchCustomer.Parameters["p_typeid"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_typeid"].Value).Value;
                        checkClient.Position = ((OracleString)cmdSearchCustomer.Parameters["p_position"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_position"].Value).Value;
                        checkClient.Position_r = ((OracleString)cmdSearchCustomer.Parameters["p_position_r"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_position_r"].Value).Value;
                        checkClient.FirstName = ((OracleString)cmdSearchCustomer.Parameters["p_firstname"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_firstname"].Value).Value;
                        checkClient.MiddleName = ((OracleString)cmdSearchCustomer.Parameters["p_middlename"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_middlename"].Value).Value;
                        checkClient.LastName = ((OracleString)cmdSearchCustomer.Parameters["p_lastname"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_lastname"].Value).Value;
                        checkClient.DocumentTypeId = ((OracleDecimal)cmdSearchCustomer.Parameters["p_documenttypeid"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_documenttypeid"].Value).Value;
                        checkClient.Document = ((OracleString)cmdSearchCustomer.Parameters["p_document"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_document"].Value).Value;
                        checkClient.TrustRegNum = ((OracleString)cmdSearchCustomer.Parameters["p_trustregnum"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_trustregnum"].Value).Value;
                        checkClient.TrustRegDat = ((OracleDate)cmdSearchCustomer.Parameters["p_trustregdat"].Value).IsNull ? (DateTime?)null : ((OracleDate)cmdSearchCustomer.Parameters["p_trustregdat"].Value).Value;
                        checkClient.BDate = ((OracleDate)cmdSearchCustomer.Parameters["p_bdate"].Value).IsNull ? (DateTime?)null : ((OracleDate)cmdSearchCustomer.Parameters["p_bdate"].Value).Value;
                        checkClient.EDate = ((OracleDate)cmdSearchCustomer.Parameters["p_edate"].Value).IsNull ? (DateTime?)null : ((OracleDate)cmdSearchCustomer.Parameters["p_edate"].Value).Value;
                        checkClient.NotaryName = ((OracleString)cmdSearchCustomer.Parameters["p_notaryname"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_notaryname"].Value).Value;
                        checkClient.NotaryRegion = ((OracleString)cmdSearchCustomer.Parameters["p_notaryregion"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_notaryregion"].Value).Value;
                        checkClient.SignPrivs = ((OracleDecimal)cmdSearchCustomer.Parameters["p_signprivs"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_signprivs"].Value).Value;
                        checkClient.SignId = ((OracleDecimal)cmdSearchCustomer.Parameters["p_signid"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmdSearchCustomer.Parameters["p_signid"].Value).Value;
                        checkClient.Namer = ((OracleString)cmdSearchCustomer.Parameters["p_namer"].Value).IsNull ? null : ((OracleString)cmdSearchCustomer.Parameters["p_namer"].Value).Value;

                        DbLoggerConstruct.NewDbLogger().Info("Ok_point", "XRMIntegrationCustomer");
                        // а теперь доп реквизиты...

                        _NMKSplit.FirstName = SetClientAtr(_RNK, "SN_FN", _NMKSplit.FirstName, 0, connect);
                        _NMKSplit.LastName = SetClientAtr(_RNK, "SN_LN", _NMKSplit.LastName, 0, connect);
                        _NMKSplit.ThirdName = SetClientAtr(_RNK, "SN_MN", _NMKSplit.ThirdName, 0, connect);

                        _AdditionalCommon.BUSSS = SetClientAtr(_RNK, "BUSSS", _AdditionalCommon.BUSSS, 0, connect);
                        _AdditionalCommon.INSFO = SetClientAtr(_RNK, "INSFO", _AdditionalCommon.INSFO, 0, connect);

                        _AdditionalFM.AF1_9 = SetClientAtr(_RNK, "AF1_9", _AdditionalFM.AF1_9, 0, connect);
                        _AdditionalFM.AINAB = SetClientAtr(_RNK, "AINAB", _AdditionalFM.AINAB, 0, connect);
                        _AdditionalFM.CCVED = SetClientAtr(_RNK, "CCVED", _AdditionalFM.CCVED, 0, connect);
                        _AdditionalFM.DATVR = SetClientAtr(_RNK, "DATVR", _AdditionalFM.DATVR, 0, connect);
                        _AdditionalFM.DATZ = SetClientAtr(_RNK, "DATZ", _AdditionalFM.DATZ, 0, connect);
                        _AdditionalFM.DJ_CP = SetClientAtr(_RNK, "DJ_CP", _AdditionalFM.DJ_CP, 0, connect);
                        _AdditionalFM.DJER = SetClientAtr(_RNK, "DJER", _AdditionalFM.DJER, 0, connect);
                        _AdditionalFM.EMAIL = SetClientAtr(_RNK, "EMAIL", _AdditionalFM.EMAIL, 0, connect);
                        _AdditionalFM.FADR = SetClientAtr(_RNK, "FADR", _AdditionalFM.FADR, 0, connect);
                        _AdditionalFM.FSKRK = SetClientAtr(_RNK, "FSKRK", _AdditionalFM.FSKRK, 0, connect);
                        _AdditionalFM.FSOMD = SetClientAtr(_RNK, "FSOMD", _AdditionalFM.FSOMD, 0, connect);
                        _AdditionalFM.FSSOD = SetClientAtr(_RNK, "FSSOD", _AdditionalFM.FSSOD, 0, connect);
                        _AdditionalFM.FSSST = SetClientAtr(_RNK, "FSSST", _AdditionalFM.FSSST, 0, connect);
                        _AdditionalFM.FSVLA = SetClientAtr(_RNK, "FSVLA", _AdditionalFM.FSVLA, 0, connect);
                        _AdditionalFM.FSVLN = SetClientAtr(_RNK, "FSVLN", _AdditionalFM.FSVLN, 0, connect);
                        _AdditionalFM.FSVLZ = SetClientAtr(_RNK, "FSVLZ", _AdditionalFM.FSVLZ, 0, connect);
                        _AdditionalFM.FSVSN = SetClientAtr(_RNK, "FSVSN", _AdditionalFM.FSVSN, 0, connect);
                        _AdditionalFM.FSZPD = SetClientAtr(_RNK, "FSZPD", _AdditionalFM.FSZPD, 0, connect);
                        _AdditionalFM.ID_YN = SetClientAtr(_RNK, "ID_YN", _AdditionalFM.ID_YN, 0, connect);
                        _AdditionalFM.IDDPD = SetClientAtr(_RNK, "IDDPD", _AdditionalFM.IDDPD, 0, connect);
                        _AdditionalFM.IDDPL = SetClientAtr(_RNK, "IDDPL", _AdditionalFM.IDDPL, 0, connect);
                        _AdditionalFM.IDPIB = SetClientAtr(_RNK, "IDPIB", _AdditionalFM.IDPIB, 0, connect);
                        _AdditionalFM.LICO = SetClientAtr(_RNK, "LICO", _AdditionalFM.LICO, 0, connect);
                        _AdditionalFM.O_REP = SetClientAtr(_RNK, "O_REP", _AdditionalFM.O_REP, 0, connect);
                        _AdditionalFM.OBSLU = SetClientAtr(_RNK, "OBSLU", _AdditionalFM.OBSLU, 0, connect);
                        _AdditionalFM.OVIDP = SetClientAtr(_RNK, "OVIDP", _AdditionalFM.OVIDP, 0, connect);
                        _AdditionalFM.OVIFS = SetClientAtr(_RNK, "OVIFS", _AdditionalFM.OVIFS, 0, connect);
                        _AdditionalFM.PHKLI = SetClientAtr(_RNK, "PHKLI", _AdditionalFM.PHKLI, 0, connect);
                        _AdditionalFM.PUBLP = SetClientAtr(_RNK, "PUBLP", _AdditionalFM.PUBLP, 0, connect);
                        _AdditionalFM.RIZIK = SetClientAtr(_RNK, "RIZIK", _AdditionalFM.RIZIK, 0, connect);
                        _AdditionalFM.SNSDR = SetClientAtr(_RNK, "SNSDR", _AdditionalFM.SNSDR, 0, connect);
                        _AdditionalFM.SUTD = SetClientAtr(_RNK, "SUTD", _AdditionalFM.SUTD, 0, connect);
                        _AdditionalFM.IDDPR = SetClientAtr(_RNK, "IDDPR", _AdditionalFM.IDDPR, 0, connect);
                        _AdditionalFM.VPD = SetClientAtr(_RNK, "VPD", _AdditionalFM.VPD, 0, connect);
                        _AdditionalFM.WORK = SetClientAtr(_RNK, "WORK", _AdditionalFM.WORK, 0, connect);

                        _AdditionalDeposit.DOV_A = SetClientAtr(_RNK, "DOV_A", _AdditionalDeposit.DOV_A, 0, connect);
                        _AdditionalDeposit.DOV_F = SetClientAtr(_RNK, "DOV_F", _AdditionalDeposit.DOV_F, 0, connect);
                        _AdditionalDeposit.DOV_P = SetClientAtr(_RNK, "DOV_P", _AdditionalDeposit.DOV_P, 0, connect);

                        _AdditionalBPK.AGENT = SetClientAtr(_RNK, "AGENT", _AdditionalBPK.AGENT, 0, connect);
                        _AdditionalBPK.PC_MF = SetClientAtr(_RNK, "PC_MF", _AdditionalBPK.PC_MF, 0, connect);
                        _AdditionalBPK.PC_SS = SetClientAtr(_RNK, "PC_SS", _AdditionalBPK.PC_SS, 0, connect);
                        _AdditionalBPK.PC_Z1 = SetClientAtr(_RNK, "PC_Z1", _AdditionalBPK.PC_Z1, 0, connect);
                        _AdditionalBPK.PC_Z2 = SetClientAtr(_RNK, "PC_Z2", _AdditionalBPK.PC_Z2, 0, connect);
                        _AdditionalBPK.PC_Z3 = SetClientAtr(_RNK, "PC_Z3", _AdditionalBPK.PC_Z3, 0, connect);
                        _AdditionalBPK.PC_Z4 = SetClientAtr(_RNK, "PC_Z4", _AdditionalBPK.PC_Z4, 0, connect);
                        _AdditionalBPK.PC_Z5 = SetClientAtr(_RNK, "PC_Z5", _AdditionalBPK.PC_Z5, 0, connect);
                        _AdditionalBPK.PENSN = SetClientAtr(_RNK, "PENSN", _AdditionalBPK.PENSN, 0, connect);

                        _AdditionalMisc.ADRP = SetClientAtr(_RNK, "ADRP", _AdditionalMisc.ADRP, 0, connect);
                        _AdditionalMisc.CHORN = SetClientAtr(_RNK, "CHORN", _AdditionalMisc.CHORN, 0, connect);
                        _AdditionalMisc.CIGPO = SetClientAtr(_RNK, "CIGPO", _AdditionalMisc.CIGPO, 0, connect);
                        _AdditionalMisc.CRSRC = SetClientAtr(_RNK, "CRSRC", _AdditionalMisc.CRSRC, 0, connect);
                        _AdditionalMisc.ELT_D = SetClientAtr(_RNK, "ELT_D", _AdditionalMisc.ELT_D, 0, connect);
                        _AdditionalMisc.ELT_N = SetClientAtr(_RNK, "ELT_N", _AdditionalMisc.ELT_N, 0, connect);
                        _AdditionalMisc.K013 = SetClientAtr(_RNK, "K013", _AdditionalMisc.K013, 0, connect);
                        _AdditionalMisc.KODID = SetClientAtr(_RNK, "KODID", _AdditionalMisc.KODID, 0, connect);
                        _AdditionalMisc.MOB01 = SetClientAtr(_RNK, "MOB01", _AdditionalMisc.MOB01, 0, connect);
                        _AdditionalMisc.MOB02 = SetClientAtr(_RNK, "MOB02", _AdditionalMisc.MOB02, 0, connect);
                        _AdditionalMisc.MOB03 = SetClientAtr(_RNK, "MOB03", _AdditionalMisc.MOB03, 0, connect);
                        _AdditionalMisc.MPNO = SetClientAtr(_RNK, "MPNO", _AdditionalMisc.MPNO, 0, connect);
                        _AdditionalMisc.MS_FS = SetClientAtr(_RNK, "MS_FS", _AdditionalMisc.MS_FS, 0, connect);
                        _AdditionalMisc.MS_GR = SetClientAtr(_RNK, "MS_GR", _AdditionalMisc.MS_GR, 0, connect);
                        _AdditionalMisc.MS_VD = SetClientAtr(_RNK, "MS_VD", _AdditionalMisc.MS_VD, 0, connect);
                        _AdditionalMisc.NSMCC = SetClientAtr(_RNK, "NSMCC", _AdditionalMisc.NSMCC, 0, connect);
                        _AdditionalMisc.NSMCT = SetClientAtr(_RNK, "NSMCT", _AdditionalMisc.NSMCT, 0, connect);
                        _AdditionalMisc.NSMCV = SetClientAtr(_RNK, "NSMCV", _AdditionalMisc.NSMCV, 0, connect);
                        _AdditionalMisc.SAMZ = SetClientAtr(_RNK, "SAMZ", _AdditionalMisc.SAMZ, 0, connect);
                        _AdditionalMisc.SPMRK = SetClientAtr(_RNK, "SPMRK", _AdditionalMisc.SPMRK, 0, connect);
                        _AdditionalMisc.SUBS = SetClientAtr(_RNK, "SUBS", _AdditionalMisc.SUBS, 0, connect);
                        _AdditionalMisc.SUBSD = SetClientAtr(_RNK, "SUBSD", _AdditionalMisc.SUBSD, 0, connect);
                        _AdditionalMisc.SUBSN = SetClientAtr(_RNK, "SUBSN", _AdditionalMisc.SUBSN, 0, connect);
                        _AdditionalMisc.SW_RN = SetClientAtr(_RNK, "SW_RN", _AdditionalMisc.SW_RN, 0, connect);
                        _AdditionalMisc.TARIF = SetClientAtr(_RNK, "TARIF", _AdditionalMisc.TARIF, 0, connect);
                        _AdditionalMisc.UADR = SetClientAtr(_RNK, "UADR", _AdditionalMisc.UADR, 0, connect);
                        _AdditionalMisc.VIDKL = SetClientAtr(_RNK, "VIDKL", _AdditionalMisc.VIDKL, 0, connect);
                        _AdditionalMisc.Y_ELT = SetClientAtr(_RNK, "Y_ELT", _AdditionalMisc.Y_ELT, 0, connect);
                        // и установка всех рисков
                        if (ClientReq.OperationType == 1 || ClientReq.OperationType == 2)
                        {
                            if (_ClientCommonReq.SetCustomerRisks != null)
                            {
                                int rid = 0;
                                foreach (SetCustomerRisk cr in _ClientCommonReq.SetCustomerRisks)
                                {
                                    SetCustomerRisk r = new SetCustomerRisk();
                                    r = SetClientRisk(_RNK, cr, connect);
                                    _ClientCommonReq.SetCustomerRisks[rid].ErrorCode = r.ErrorCode;
                                    rid++;
                                }
                            }
                        }
                        // и вычитка всех рисков с датами с-по, установленных на клиенте
                        _ClientCommonReq.CustomerRisk = GetClientRisks(_RNK, connect);

                        // сборка всех реквизитов в класс обратно 
                        if (_AdditionalInfo != null || _AdditionalInfo != new AdditionalInfo()) _ClientCommonReq.AdditionalInfo = _AdditionalInfo;
                        if (_EconomicIndicators != null || _EconomicIndicators != new EconomicIndicators()) _ClientCommonReq.EconomicIndicators = _EconomicIndicators;
                        if (_TaxIndicators != null || _TaxIndicators != new TaxIndicators()) _ClientCommonReq.TaxIndicators = _TaxIndicators;
                        if (_ClientPerson != null || _ClientPerson != new Person()) _ClientCommonReq.ClientPerson = _ClientPerson;
                        if (_ClientAddressActual != null || _ClientAddressActual != new CustAddress()) _ClientCommonReq.ClientAddressActual = _ClientAddressActual;
                        if (_ClientAddressLegal != null || _ClientAddressLegal != new CustAddress()) _ClientCommonReq.ClientAddressLegal = _ClientAddressLegal;
                        if (_ClientAddressPostal != null || _ClientAddressPostal != new CustAddress()) _ClientCommonReq.ClientAddressPostal = _ClientAddressPostal;

                        if (_AdditionalCommon != new AdditionalCommon()) { _AdditionalReq.AdditionalCommon = _AdditionalCommon; }
                        if (_AdditionalFM != new AdditionalFM()) { _AdditionalReq.AdditionalFM = _AdditionalFM; }
                        if (_AdditionalDeposit != new AdditionalDeposit()) { _AdditionalReq.AdditionalDeposit = _AdditionalDeposit; }
                        if (_AdditionalBPK != new AdditionalBPK()) { _AdditionalReq.AdditionalBPK = _AdditionalBPK; }
                        if (_AdditionalMisc != new AdditionalMisc()) { _AdditionalReq.AdditionalMisc = _AdditionalMisc; }
                        if (_AdditionalReq != new AdditionalReq()) { _ClientCommonReq.AdditionalReq = _AdditionalReq; }

                        _ClientCommonReq.CheckClient = checkClient;

                        if (_ClientCommonReq != null || _ClientCommonReq != new ClientCommonReq()) ClientReq.ClientRequisites = _ClientCommonReq;
                        DbLoggerConstruct.NewDbLogger().Info("Сервис закончил обработку" + ". Регистрационный номер клиента rnk=" + ClientReq.RNK.ToString(), "XRMIntegrationCustomer");
                        #endregion
                    }
                    else
                    {
                        DbLoggerConstruct.NewDbLogger().Info("Сервис закончил обработку c ошибкой" + ClientReq.ErrorCode.ToString(), "XRMIntegrationCustomer");
                    }
                    return ClientReq;
                }
                catch (System.Exception e)
                {
                    ClientReq.Status = -1;
                    switch (ClientReq.OperationType)
                    {
                        case 0:
                            ClientReq.ErrorCode = String.Format("Помилка пошуку клієнта: {0} {1} {2}", e.Message, e.StackTrace, e.Source);
                            break;
                        case 1:
                            ClientReq.ErrorCode = String.Format("Помилка при створенні клієнта: {0} {1} {2}", e.Message, e.StackTrace, e.Source);
                            break;
                        case 2:
                            ClientReq.ErrorCode = String.Format("Помилка при оновленні клієнта: {0} {1} {2}", e.Message, e.StackTrace, e.Source);
                            break;
                        case 3:
                            ClientReq.ErrorCode = String.Format("Помилка при закритті клієнта: {0} {1} {2}", e.Message, e.StackTrace, e.Source);
                            break;
                    }
                    return ClientReq;
                }
            }
        }
    }
}
