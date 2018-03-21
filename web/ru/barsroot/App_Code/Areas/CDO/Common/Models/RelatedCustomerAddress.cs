using System.Text;

namespace BarsWeb.Areas.CDO.Common.Models
{
    public class RelatedCustomerAddress
    {
        public RelatedCustomerAddress()
        {
        }

        public decimal? RegionId { get; set; }
        public string RegionName { get; set; }
        public string City { get; set; }
        public string Street { get; set; }
        public string HouseNumber { get; set; }
        public string Addition { get; set; }


        public string ToXmlString()
        {
            var result = new StringBuilder();

            result.Append("<address>");

            result.Append("<region>");
            result.Append(RegionName);
            result.Append("</region>");

            result.Append("<city>");
            result.Append(City);
            result.Append("</city>");

            result.Append("<street>");
            result.Append(Street);
            result.Append("</street>");

            result.Append("<houseNumber>");
            result.Append(HouseNumber);
            result.Append("</houseNumber>");

            result.Append("<addition>");
            result.Append(Addition);
            result.Append("</addition>");

            result.Append("</address>");

            return result.ToString();
        }
    }
}
