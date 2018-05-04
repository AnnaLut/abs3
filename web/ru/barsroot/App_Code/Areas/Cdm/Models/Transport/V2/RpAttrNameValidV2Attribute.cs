using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class RpAttrNameValidV2Attribute : ValidationAttribute
    {
        private readonly string[] _validRpAttrNames =
        {
            "DOC_ORGAN",
            "DOC_SER",
            "K014",
            "DOC_ISSUE_DATE",
            "ACTUAL_DATE",
            "BIRTH_DATE",
            "DOC_NUMBER",
            "EDDR_ID",
            "REL_SIGN",
            "NAME",
            "K040",
            "SEX",
            "EMAIL",
            "DOC_TYPE",
            "OKPO",
            "K080",
            "K110",
            "K070",
            "K051"
        };

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var attrName = Convert.ToString(value);
            if (Array.IndexOf(_validRpAttrNames, attrName) < 0)
            {
                return new ValidationResult("Attribute name '" + attrName + "' is not valid.");
            }
            return null;
        }
    }
}