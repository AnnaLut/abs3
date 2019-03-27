﻿using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AttrNameValidV2Attribute : ValidationAttribute
    {
        private readonly string[] _validAttrNames =
        {
            #region ipAttrs
            "UR_TERRITORY_ID",
            "SAMZ",
            "SPMRK",
            "NMKV",
            "K013",
            "SEX",
            "FS",
            "KF",
            "DEPOSIT",
            "SER",
            "EMAIL",
            "LAST_CHANGE_DT",
            "BRANCH",
            "UR_ROOM_TYPE",
            "TELW",
            "SN_GC",
            "UR_DOMAIN",
            "SN_MN",
            "ISE",
            "VIP_K",
            "BPLACE",
            "CELLPHONE",
            "BDAY",
            "RNK",
            "UR_LOCALITY_TYPE",
            "DATE_OFF",
            "PC_Z1",
            "NUMDOC",
            "RELATED_PERSONS",
            "UR_ADDRESS",
            "OKPO",
            "UR_LOCALITY",
            "UR_STREET",
            "PASSP",
            "UR_HOMEPART",
            "FGDST",
            "UR_ROOM",
            "COUNTRY",
            "EDDR_ID",
            "PC_Z4",
            "NMK",
            "OKPO_EXCLUSION",
            "SN_FN",
            "K050",
            "PC_Z3",
            "CREDIT",
            "BANK_CARD",
            "ORGAN",
            "UR_HOME",
            "ADR",
            "CIGPO",
            "WORKB",
            "CHORN",
            "PC_Z5",
            "PDATE",
            "FGADR",
            "UR_HOME_TYPE",
            "UR_STREET_TYPE",
            "PUBLP",
            "DATE_PHOTO",
            "MPNO",
            "HAS_DUPLICATE",
            "CODCAGENT",
            "FGOBL",
            "GCIF",
            "SN_LN",
            "PC_Z2",
            "UR_HOMEPART_TYPE",
            "WORK_PLACE",
            "TGR",
            "UR_ZIP",
            "OTHER",
            "TELD",
            "CURRENT_ACCOUNT",
            "UR_REGION",
            "DATE_ON",
            "ACTUAL_DATE",
            "FGTWN",
            "VED",
            "PRINSIDER",

            #endregion ipAttrs
            #region lpAttrs
            "K070",
            "K110",
            "AA_K040",
            "VAT_DATA",
            "K030",
            "AA_SETTLEMENT",
            "OKPO",
            "BORROWER_CLASS",
            "VAT_CERT_NUMBER",
            "FULL_NAME_ABBREVIATED",
            "ESSENCE_CHARACTER",
            "LA_AREA",
            "LA_REGION",
            "K060",
            "K050",
            "K040",
            "DPI_REG_DATE",
            "FULL_NAME",
            "VIP_SIGN",
            "REGIONAL_PI",
            "K013",
            "AA_REGION",
            "DATE_OFF",
            "REGIONAL_HOLDING_NUMBER",
            "SEPARATE_DIV_CORP_CODE",
            "AA_AREA",
            "FIRST_ACC_DATE",
            "AUTHORIZED_CAPITAL_SIZE",
            "LAST_CHANGE_DT",
            "INITIAL_FORM_FILL_DATE",
            "AA_FULL_ADDRESS",
            "RCIF",
            "DPA_REG_NUMBER",
            "LA_FULL_ADDRESS",
            "INCOME_TAX_PAYER_REG_DATE",
            "LA_TERRITORY_CODE",
            "OFF_BALANCE_DEP_NAME",
            "AREA_PI",
            "ECONOMIC_ACTIVITY_TYPE",
            "NAME_BY_STATUS",
            "K051",
            "K080",
            "NO_TAXPAYER_SIGN",
            "ADM_REG_AUTHORITY",
            "EVALUATION_REPUTATION",
            "GROUP_AFFILIATION",
            "DATE_ON",
            "ADM_REG_DATE",
            "RNK",
            "K014",
            "LA_SETTLEMENT",
            "RISK_LEVEL",
            "LA_INDEX",
            "NATIONAL_PROPERTY",
            "FULL_NAME_INTERNATIONAL",
            "AA_TERRITORY_CODE",
            "BUILD_STATE_REGISTER",
            "LA_K040",
            "PI_REG_DATE",
            "REVENUE_SOURCES_CHARACTER",
            "OFF_BALANCE_DEP_CODE",
            "AA_INDEX",
            "GCIF",
            "KF",
            #endregion lpAttrs
            #region peAttrs
            "K110",
            "K051",
            "LA_NOTES",
            "ADM_REG_DATE",
            "K010",
            "AA_STREET",
            "OKPO",
            "PI_REG_NUMBER",
            "PI_REG_DATE",
            "FULL_NAME_ABBREVIATED",
            "SMALL_BUSINESS_BELONGING",
            "LA_SECTION_NUMBER",
            "LA_HOUSE_NUMBER",
            "K060",
            "LA_INDEX",
            "K040",
            "ADM_REG_AUTHORITY",
            "FULL_NAME",
            "GROUP_AFFILIATION",
            "AA_HOUSE_NUMBER",
            "DOC_SER",
            "AA_AREA",
            "DATE_OFF",
            "DOC_TYPE",
            "DOC_ISSUE_DATE",
            "AA_SETTLEMENT",
            "EDDR_ID",
            "SEX",
            "LAST_CHANGE_DT",
            "BIRTH_DATE",
            "AA_INDEX",
            "RCIF",
            "AREA_PI",
            "LA_AREA",
            "DOC_ORGAN",
            "LA_STREET",
            "K080",
            "EMPLOYMENT_STATUS",
            "AA_SECTION_NUMBER",
            "ACTUAL_DATE",
            "ADM_REG_NUMBER",
            "LA_TERRITORY_CODE",
            "K050",
            "EMAIL",
            "AA_APARTMENTS_NUMBER",
            "BIRTH_PLACE",
            "DOC_NUMBER",
            "DATE_ON",
            "AA_NOTES",
            "RNK",
            "K014",
            "LA_APARTMENTS_NUMBER",
            "MOBILE_PHONE",
            "LA_SETTLEMENT",
            "K013",
            "FULL_NAME_INTERNATIONAL",
            "AA_REGION",
            "BUILD_STATE_REGISTER",
            "LA_REGION",
            "REGIONAL_PI",
            "BORROWER_CLASS",
            "K070",
            "AA_TERRITORY_CODE",
            "GCIF",
            "KF"
            #endregion peAttrs
        };

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