using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AttrNameValidAttribute : ValidationAttribute
    {
        private readonly string[] _validAttrNames = {
              "UR_STREET_TYPE", 
              "UR_LOCALITY_TYPE",
              "UR_HOMEPART_TYPE",
              "UR_ROOM_TYPE",
              "MPNO",
              "CELLPHONE",
              "TELD",
              "EMAIL",
              "ISE",
              "FS",
              "VED",
              "K050",
              "SAMZ",
              "CHORN",
              "SPMRK",
              "VIP_K",
              "WORKB",
              "DATE_ON",
              "NMK",
              "SN_LN",
              "SN_FN",
              "SN_MN",
              "SN_GC",
              "CODCAGENT",
              "K013",
              "COUNTRY",
              "PRINSIDER",
              "TGR",
              "OKPO",
              "PASSP",
              "SER",
              "NUMDOC",
              "ORGAN",
              "PDATE",
              "DATE_PHOTO",
              "BDAY",
              "SEX",
              "BRANCH",
              "ADR",
              "LAST_CHANGE_DT",
              "UR_LOCALITY",
              "UR_ADDRESS",
              "UR_HOME_TYPE",
              "OKPO_EXCLUSION",
              "UR_STREET",
              "UR_HOME",
              "UR_HOMEPART",
              "UR_ROOM",
              "FGADR",
              "FGDST",
              "FGOBL",
              "FGTWN",
              "TELW",
              "PC_Z2",
              "PC_Z1",
              "PC_Z5",
              "PC_Z3",
              "PC_Z4",
              "WORK_PLACE",
              "PUBLP",
              "CIGPO",
              "KF",
              "RNK",
              "DATE_OFF",
              "NMKV",
              "BPLACE",
              "UR_ZIP",
              "UR_DOMAIN",
              "UR_REGION",
              "UR_TERRITORY_ID",
              "RELATED_PERSONS",
              "CREDIT",
              "DEPOSIT",
              "BANK_CARD",
              "CURRENT_ACCOUNT",
              "OTHER"};
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var attrName = Convert.ToString(value);
            if (Array.IndexOf(_validAttrNames, attrName) < 0)
            {
                return new ValidationResult("Attribute name '" + attrName + "' is not valid.");
            }
            return null;
        }
    }
}