
/// <summary>
/// Summary description for InputTypes
/// </summary>

namespace BarsWeb.Areas.Transp.Models.ApiModels
{
    public class InputTypes
    {
        public string type_name { get; set; }
        public string type_desc { get; set; }
        public string sess_type { get; set; }
        public string act_type { get; set; }
        public string output_data_type { get; set; }
        public string input_data_type { get; set; }
        public int priority { get; set; }
        public string cont_type { get; set; }
        public int json2xml { get; set; }
        public int xml2json { get; set; }
        public string compress_type { get; set; }
        public int input_decompress { get; set; }
        public int output_compress { get; set; }
        public int input_base_64 { get; set; }
        public int output_base_64 { get; set; }
        public int store_head { get; set; }
        public int add_head { get; set; }
        public string check_sum { get; set; }
        public int loging { get; set; }

    }
}