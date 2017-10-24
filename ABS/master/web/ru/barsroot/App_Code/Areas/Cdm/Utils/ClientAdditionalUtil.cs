using System;
using System.Collections.Generic;
using clientregister;

namespace BarsWeb.Areas.Cdm.Utils
{

    /// <summary>
    /// Class create additional details of client.
    /// </summary>
    public class ClientAdditionalUtil
    {
        public void AddDopRekv<T>(clientregister.Client client, List<AdditionalСlientInformation> dopRekvList, T ebkClient)
        {
            client.DopRekvFromEbk = new List<CustAttrRecord>();

            foreach (AdditionalСlientInformation addClientInfo in dopRekvList)
            {
                Type ebkClientData = ebkClient.GetType();
                var pi = ebkClientData.GetProperty(addClientInfo.PropertyName);

                object value;
                if (addClientInfo.ChildPropertyName != null)
                {
                    var property = pi;
                    ebkClientData = pi.PropertyType;
                    pi = ebkClientData.GetProperty(addClientInfo.ChildPropertyName.PropertyName);
                    value = pi.GetValue(property.GetValue(ebkClient, null), null);

                    if (addClientInfo.NeedToConvertToDate && !string.IsNullOrEmpty((string)value))
                    {
                        string dateTime = (string)value;
                        DateTime dateTimeValue = Convert.ToDateTime(dateTime);
                        value = dateTimeValue.ToString("dd.MM.yyyy");
                    }
                }
                else
                {
                    value = pi.GetValue(ebkClient, null);
                }

                var result = "";

                if (value != null && pi.PropertyType.Name == "Boolean" && value.GetType().Name == "Boolean")
                {
                    result = (bool)value ? "1" : "0";
                }
                else if (value != null && pi.PropertyType.Name == "String" && value.GetType().Name == "String")
                {
                    result = (string)value;
                }
                if (!string.IsNullOrEmpty(result))
                    client.DopRekvFromEbk.Add(new CustAttrRecord() { Tag = addClientInfo.Tag, Isp = "0", Value = result });
            }
        }

        public List<AdditionalСlientInformation> GetAdditionalClientInformationListPerson()
        {
            return new List<AdditionalСlientInformation>()
            {
                 new AdditionalСlientInformation() { Tag  = "EXCLN", PropertyName = "IsOkpoExclusion" },
                 new AdditionalСlientInformation() { Tag  = "PUBLP", PropertyName = "AddInfo", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "Publp"}},
                 new AdditionalСlientInformation() { Tag  = "CIGPO", PropertyName = "AddInfo", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "Cigpo"}},
                 new AdditionalСlientInformation() { Tag  = "SAMZ",  PropertyName = "AddInfo", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "Samz"}},
                 new AdditionalСlientInformation() { Tag  = "CHORN", PropertyName = "AddInfo", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "Chorn"}},
                 new AdditionalСlientInformation() { Tag  = "SPMRK", PropertyName = "AddInfo", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "Spmrk"}},
                 new AdditionalСlientInformation() { Tag  = "VIP_K", PropertyName = "AddInfo", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "VipK"}},
                 new AdditionalСlientInformation() { Tag  = "WORKB", PropertyName = "AddInfo", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "Workb"}},
                 new AdditionalСlientInformation() { Tag  = "WORK ",  PropertyName = "AddInfo", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "WorkPlace"}},
                 new AdditionalСlientInformation() { Tag  = "K013 ",  PropertyName = "K013"},
                 new AdditionalСlientInformation() { Tag  = "EMAIL", PropertyName = "Contact", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "Email"}},
                 new AdditionalСlientInformation() { Tag  = "PC_Z2", PropertyName = "Document", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "PcZ2"}},
                 new AdditionalСlientInformation() { Tag  = "PC_Z1", PropertyName = "Document", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "PcZ1"}},
                 new AdditionalСlientInformation() { Tag  = "PC_Z5", PropertyName = "Document", NeedToConvertToDate = true , ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "PcZ5"}},
                 new AdditionalСlientInformation() { Tag  = "PC_Z3", PropertyName = "Document", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "PcZ3"}},
                 new AdditionalСlientInformation() { Tag  = "PC_Z4", PropertyName = "Document", NeedToConvertToDate = true , ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "PcZ4"}}
            };
        }

        public List<AdditionalСlientInformation> GetAdditionalClientInformationListPrivateEn()
        {
            return new List<AdditionalСlientInformation>()
            {
                 new AdditionalСlientInformation() { Tag  = "EXCLN", PropertyName = "IsOkpoExclusion" },
                 new AdditionalСlientInformation() { Tag  = "K013 ", PropertyName = "additionalDetails", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "K013"}},
                 new AdditionalСlientInformation() { Tag  = "MS_GR", PropertyName = "additionalDetails", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "GroupAffiliation"}},
                 new AdditionalСlientInformation() { Tag  = "EMAIL", PropertyName = "additionalDetails", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "Email"}},
                 new AdditionalСlientInformation() { Tag  = "CIGPO", PropertyName = "additionalDetails", ChildPropertyName = new AdditionalСlientInformation() { PropertyName = "EmploymentStatus"}}
            };
        }

        public List<AdditionalСlientInformation> GetAdditionalClientInformationListLegal()
        {
            return new List<AdditionalСlientInformation>()
            {
                new AdditionalСlientInformation() {Tag = "K013 ", PropertyName = "K013"},
                new AdditionalСlientInformation() {Tag = "MS_GR", PropertyName = "GroupAffiliation"},
                new AdditionalСlientInformation() {Tag = "N_RPD", PropertyName = "IncomeTaxPayerRegDate"},
                new AdditionalСlientInformation() {Tag = "KVPKK", PropertyName = "SeparateDivCorpCode"},
                new AdditionalСlientInformation() {Tag = "CCVED", PropertyName = "EconomicActivityType"},
                new AdditionalСlientInformation() {Tag = "DATVR", PropertyName = "FirstAccDate"},
                new AdditionalСlientInformation() {Tag = "DATZ ", PropertyName = "InitialFormFillDate"},
                new AdditionalСlientInformation() {Tag = "O_REP", PropertyName = "EvaluationReputation"},
                new AdditionalСlientInformation() {Tag = "FSRSK", PropertyName = "AuthorizedCapitalSize"},
                new AdditionalСlientInformation() {Tag = "RIZIK", PropertyName = "RiskLevel"},
                new AdditionalСlientInformation() {Tag = "DJER ", PropertyName = "RevenueSourcesCharacter"},
                new AdditionalСlientInformation() {Tag = "SUTD ", PropertyName = "EssenceCharacter"},
                new AdditionalСlientInformation() {Tag = "UUDV ", PropertyName = "NationalProperty"},
                new AdditionalСlientInformation() {Tag = "VIP_K", PropertyName = "VipSign"},
                new AdditionalСlientInformation() {Tag = "NOTAX", PropertyName = "NoTaxpayerSign"}
            };
        }
    }
}
