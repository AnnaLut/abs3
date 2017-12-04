using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GetMetadataModel
/// </summary>
public class GetMetadataModel
{
	public GetMetadataModel()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int tableId;
    public int? codeOper;
    public int? sParColumn;
    public int? nativeTabelId;
    public int? nsiTableId;
    public int? nsiFuncId;
    public string base64jsonSqlProcParams = "";
}