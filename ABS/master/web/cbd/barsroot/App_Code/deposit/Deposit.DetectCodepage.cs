using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using MultiLanguage;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public enum RET_RESULT : uint
{
    S_OK = 0x00000000,
    S_FALSE = 0x00000001,
    E_FAIL = 0x80004005
}

/// <summary>
/// Specify the type of the incoming data. 
/// </summary>
public enum MLDETECTCP
{
    //Default setting will be used.
    MLDETECTCP_NONE = 0,

    //Input stream consists of 7-bit data.
    MLDETECTCP_7BIT = 1,

    //Input stream consists of 8-bit data.
    MLDETECTCP_8BIT = 2,

    //Input stream consists of double-byte data.
    MLDETECTCP_DBCS = 4,

    //Input stream is an HTML page. 
    MLDETECTCP_HTML = 8
}

public class DetectCodepage
{
    private sbyte[] pSrcStr;
    private int WindowsCodePage = 0;
    private string encName = String.Empty;
    private MLDETECTCP bit;
    public int WinCodePage
    {
        get { return WindowsCodePage; }
    }

    public string EncodingName
    {
        get { return encName; }
    }

    public DetectCodepage(sbyte[] sbyts, MLDETECTCP mbit)
    {
        bit = mbit;
        pSrcStr = new sbyte[sbyts.Length];
        for (int i = 0; i < sbyts.Length; i++)
        {
            this.pSrcStr[i] = sbyts[i];
        }
        GetEncodingInfo(out WindowsCodePage, out encName);
    }

    private uint GetCodePage()
    {
        uint codePage = 0;
        int pcSrcSize = this.pSrcStr.Length;
        int pnScores = 10;

        MultiLanguage.IMultiLanguage2 ml = new MultiLanguage.CMultiLanguageClass();
        MultiLanguage.tagDetectEncodingInfo[] dei = new MultiLanguage.tagDetectEncodingInfo[pnScores];

        try
        {
            ml.DetectInputCodepage((uint)bit,
                                    0,
                                    ref pSrcStr[0],
                                    ref pcSrcSize,
                                    ref dei[0],
                                    ref pnScores
                                    );

            codePage = dei[0].nCodePage;
        }
        catch (Exception ex)
        {
            throw ex;
            codePage = 0;
        }
        return codePage;
    }

    private void GetEncodingInfo(out int WindowsCodePage, out string encName)
    {
        int codePage = (int)GetCodePage();
        if (codePage != 0)
        {
            Encoding enc = Encoding.GetEncoding(codePage);
            //encName = enc.EncodingName;
            encName = enc.WebName;
            WindowsCodePage = enc.WindowsCodePage;
        }
        else
        {
            encName = String.Empty;
            WindowsCodePage = 0;
        }
    }
}
