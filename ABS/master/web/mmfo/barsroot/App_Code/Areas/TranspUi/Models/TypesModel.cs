using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OutTypesModel
/// </summary>
/// 
namespace Areas.TranspUi.Models
{
    public class TypesModel
    {
        public int Id { get; set; }
        public string TypeName { get; set; }
        public string TypeDesc { get; set; }
        public string SessType { get; set; }
        public string WebMethod { get; set; }
        public string HttpMethod { get; set; }
        public string OutputDataType { get; set; }
        public string InputDataType { get; set; }
        public decimal? ContType { get; set; }
        public int? IsParallel { get; set; }
        public string SendType { get; set; }
        public string UriGroup { get; set; }
        public string UriSuf { get; set; }
        public int? Priority { get; set; }
        public string DoneAcction { get; set; }
        public decimal? MainTimeout { get; set; }
        public int? SendTrys { get; set; }
        public int? SendPause { get; set; }
        public int? ChkPause { get; set; }
        public int? Xml2json { get; set; }
        public int? Json2xml { get; set; }
        public string CompressType { get; set; }
        public int? InputDecompress { get; set; }
        public int? OutputCompress { get; set; }
        public int? InputBase64 { get; set; }
        public int? OutputBase64 { get; set; }
        public string CheckSum { get; set; }
        public int? StoreHead { get; set; }
        public decimal? AccContType { get; set; }
        public decimal? Loging { get; set; }
        public int? AddHead { get; set; }
        public int? ExecTimeout { get; set; }
        public string AccType { get; set; }

    }
}